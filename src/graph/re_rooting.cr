require "../graph"

# Example of `T`:
# ```
# struct DP
#   getter val : Int64, cnt : Int32
#
#   def initialize
#     @val, @cnt = 0i64, 0
#   end
#
#   def initialize(@val, @cnt)
#   end
#
#   def +(other : self) : self
#     DP.new(val + other.val, cnt + other.cnt)
#   end
#
#   def add_root(v : Int32) : self
#     DP.new(val + cnt, cnt + 1)
#   end
# end
# ```
class ReRooting(T, GraphType)
  getter graph : GraphType

  def initialize(size : Int)
    initialize(GraphType.new(size))
  end

  def initialize(@graph : GraphType)
    @dp = Array(Array(T)).new
    @result = Array(T).new
  end

  def initialize(size : Int, edges : Enumerable)
    initialize(GraphType.new(size, edges))
  end

  delegate size, :<<, add_edges, to: @graph

  private def dfs(v : Int32, p : Int32) : T
    acc = T.new
    graph[v].each_with_index do |edge, i|
      if edge.to != p
        acc += (@dp[v][i] = dfs(edge.to, v))
      end
    end
    acc.add_root(v)
  end

  private def bfs(v : Int32, p : Int32, dp_p : T) : Nil
    graph[v].each_with_index do |edge, i|
      @dp[v][i] = dp_p if edge.to == p
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

    graph[v].each_with_index do |edge, i|
      bfs(edge.to, v, (dp_left[i] + dp_right[i + 1]).add_root(v)) if edge.to != p
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
