require "../graph"

module Graph(Edge, Edge2)
  private def topological_sort_dfs(result : Array(Int32), visited : Array(Bool), v : Int32)
    unless visited[v]
      visited[v] = true
      graph[v].each do |edge|
        topological_sort_dfs(result, visited, edge.to)
      end
      result << v
    end
  end

  def topological_sort : Array(Int32)
    result = [] of Int32
    visited = [false] * size
    size.times do |v|
      topological_sort_dfs(result, visited, v)
    end
    result.reverse
  end
end
