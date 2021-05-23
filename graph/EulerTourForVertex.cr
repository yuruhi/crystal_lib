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

  def dfs(v : Int32, p : Int32) : Nil
    @ls[v] = @k
    @k += 1
    @graph[v].each do |u|
      dfs(u, v) if u != p
    end
    @rs[v] = @k
  end

  def run(root : Int32)
    dfs(root, -1)
    {@ls, @rs}
  end
end
