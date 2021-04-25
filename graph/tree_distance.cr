require "./graph"

class Graph(T)
  private def tree_distance_dfs(v : Int32, parent : Int32, dist : T, a : Array(T))
    a[v] = dist
    self[v].each do |edge|
      if edge.to != parent
        tree_distance_dfs(edge.to, v, dist + edge.cost, a)
      end
    end
  end

  def tree_distance(root : Int32)
    a = Array(T).new(size, T.zero)
    tree_distance_dfs(root, -1, T.zero, a)
    a
  end
end
