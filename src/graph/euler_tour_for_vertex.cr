require "../graph"

class EulerTourForVertex
  getter graph : UnweightedUndirectedGraph

  def initialize(@graph)
    @ls = Array(Int32).new(size, 0)
    @rs = Array(Int32).new(size, 0)
    @k = 0
  end

  delegate size, to: @graph
  delegate :[], to: @graph
  delegate add_edge, to: @graph

  def dfs(v : Int, p : Int) : Nil
    @ls[v] = @k
    @k += 1
    @graph[v].each do |edge|
      dfs(edge.to, v) if edge.to != p
    end
    @rs[v] = @k
  end

  def run(root : Int)
    dfs(root, -1)
    {@ls, @rs}
  end
end
