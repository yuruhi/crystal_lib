require "./graph"

class UnweightedGraph
  # TODO: verify
  private def subtree_size_dfs(v : Int32, p : Int32, result : Array(Int32)) : Int32
    result[v] = 1 + self[v].sum do |u|
      subtree_size_dfs(u, v, result) if u != p
    end
  end

  def subtree_size(root : Int32)
    result = Array.new(size, 0)
    subtree_size_dfs(root, -1, result)
    result
  end

  private def tree_depth_dfs(v : Int32, p : Int32, dist : Int32, a : Array(Int32)) : Nil
    a[v] = dist
    self[v].each do |u|
      tree_depth_dfs(u, v, dist + 1, a) if u != p
    end
  end

  def tree_depth(root : Int32)
    a = Array.new(size, 0)
    tree_depth_dfs(root, -1, 0, a)
    a
  end
end

class Graph(T)
  private def tree_distance_dfs(v : Int32, p : Int32, dist : T, a : Array(T))
    a[v] = dist
    self[v].select { |edge| edge.to != p }.each { |edge|
      tree_distance_dfs(edge.to, v, dist + edge.cost, a)
    }
  end

  def tree_distance(root : Int32)
    a = Array(T).new(size, T.zero)
    tree_distance_dfs(root, -1, T.zero, a)
    a
  end

  def diameter : {T, Int32, Int32}
    v = tree_distance(0).each_with_index.max[1]
    dist, u = tree_distance(v).each_with_index.max
    {dist, v, u}
  end
end
