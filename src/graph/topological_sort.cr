require "./graph"

class UnweightedGraph
  private def topological_sort_dfs(result, visited, v)
    unless visited[v]
      visited[v] = true
      graph[v].each do |u|
        topological_sort_dfs(result, visited, u)
      end
      result << v
    end
  end

  def topological_sort : Array(Int32)
    result = [] of Int32
    visited = [false] * size
    (0...size).each do |v|
      topological_sort_dfs(result, visited, v)
    end
    result.reverse
  end
end
