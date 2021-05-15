require "./graph"

class UnWeightedGraph
  private def subtree_size_dfs(v : Int32, p : Int32, result : Array(Int32)) : Int32
    result[v] = 1 + self[v].select { |u| u != p }.sum { |u|
      subtree_size_dfs(u, v, result)
    }
  end

  def subtree_size(root : Int32)
    result = Array.new(size, 0)
    subtree_size_dfs(root, -1, result)
    result
  end
end

