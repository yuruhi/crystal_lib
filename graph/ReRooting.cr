require "./graph"

class ReRooting(T)
  getter graph : UnWeightedGraph

  def initialize(size : Int32)
    @graph = UnWeightedGraph.new(size)
    @dp = Array(Array(T)).new
    @result = Array(T).new
  end

  delegate size, to: @graph
  delegate add_edge, to: @graph

  private def dfs(v : Int32, p : Int32) : T
    graph[v].each_with_index.select { |(u, i)| u != p }.reduce(T.new) { |acc, (u, i)|
      acc + (@dp[v][i] = dfs(u, v))
    }.add_root(v)
  end

  private def bfs(v : Int32, p : Int32, dp_par : T) : Nil
    graph[v].each_with_index do |u, i|
      @dp[v][i] = dp_par if u == p
    end

    n = graph[v].size
    dp_left = Array.new(n + 1, T.new)
    (0...n).each do |i|
      dp_left[i + 1] = dp_left[i] + @dp[v][i]
    end
    dp_right = Array.new(n + 1, T.new)
    (0...n).reverse_each do |i|
      dp_right[i] = dp_right[i + 1] + @dp[v][i]
    end
    @result[v] = dp_left.last.add_root(v)

    graph[v].each_with_index do |u, i|
      bfs(u, v, (dp_left[i] + dp_right[i + 1]).add_root(v)) if u != p
    end
  end

  def solve : Array(T)
    @dp = Array.new(size) { |i| Array.new(@graph[i].size, T.new) }
    @result = Array.new(size, T.new)
    dfs(0, -1)
    bfs(0, -1, T.new)
    @result
  end
end
