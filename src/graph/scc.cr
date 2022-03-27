require "../graph"

class SCC(Edge, Edge2)
  private def dfs(v : Int32) : Nil
    @visited[v] = true
    @graph[v].each do |edge|
      dfs(edge.to) if !@visited[edge.to]
    end
    @topological_order << v
  end

  private def dfs_reverse(v : Int32) : Nil
    @visited[v] = true
    @ids[v] = @now_id
    @rgraph[v].each do |edge|
      dfs_reverse(edge.to) if !@visited[edge.to]
    end
  end

  getter graph
  @rgraph : Graph(Edge, Edge2)

  delegate size, to: @graph

  def initialize(@graph : Graph(Edge, Edge2))
    @rgraph = @graph.reverse
    @topological_order = [] of Int32
    @visited = Array(Bool).new(size, false)
    @ids = Array(Int32).new(size, -1)
    @now_id = 0

    size.times do |v|
      dfs(v) if !@visited[v]
    end
    @visited.fill(false)
    @topological_order.reverse_each do |v|
      if !@visited[v]
        dfs_reverse(v)
        @now_id += 1
      end
    end
  end

  def count_scc : Int32
    @now_id
  end

  def groups : Array(Set(Int32))
    groups = Array.new(count_scc) { Set(Int32).new }
    size.times do |i|
      groups[@ids[i]] << i
    end
    groups
  end

  def dag : UnweightedDirectedGraph
    edges = Set({Int32, Int32}).new
    @graph.each do |edge|
      from, to = @ids[edge.from], @ids[edge.to]
      edges << {from, to} if from != to
    end
    UnweightedDirectedGraph.new count_scc, edges
  end

  def scc : {Int32, Array(Set(Int32)), UnweightedDirectedGraph}
    {count_scc, groups, dag}
  end
end
