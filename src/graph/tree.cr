require "../graph"

module Graph(Edge, Edge2)
  private def subtree_size_dfs(v : Int, p : Int, result : Array(Int32)) : Int32
    result[v] = 1 + self[v].sum { |edge|
      edge.to != p ? subtree_size_dfs(edge.to, v, result) : 0
    }
  end

  def subtree_size(root : Int)
    result = Array.new(size, 0)
    subtree_size_dfs(root, -1, result)
    result
  end

  private def tree_distance_dfs(v : Int, p : Int, dist : Int32, a) : Nil
    a[v] = dist
    self[v].each do |edge|
      tree_distance_dfs(edge.to, v, dist + edge.cost, a) if edge.to != p
    end
  end

  def tree_distance(root : Int)
    a = Array.new(size, typeof(first.cost).zero)
    tree_distance_dfs(root, -1, 0, a)
    a
  end

  def diameter
    _, v = tree_distance(0).each_with_index.max
    dist, u = tree_distance(v).each_with_index.max
    {dist, v, u}
  end
end
