require "../graph"

class EulerTourForVertex
  getter graph : UnweightedUnGraph

  private def dfs(vertex : Int32, parent : Int32) : Nil
    @in[vertex] = @k
    @k += 1
    @graph[vertex].each do |edge|
      dfs(edge.to, vertex) if edge.to != parent
    end
    @out[vertex] = @k
  end

  def initialize(@graph, root : Int32)
    @in = Array(Int32).new(size, 0)
    @out = Array(Int32).new(size, 0)
    @k = 0
    dfs(root, -1)
  end

  delegate size, :[], to: @graph

  def in : Array(Int32)
    @in
  end

  def out : Array(Int32)
    @out
  end

  def ancestor?(ancestor : Int32, child : Int32) : Bool
    @in[ancestor] <= @in[child] < @out[ancestor]
  end
end
