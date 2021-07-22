require "../graph"
require "./degree"

module Graph(Edge, Edge2)
  def topological_sort : Array(Int32)?
    deg = indegree
    que = Deque(Int32).new
    size.times { |i| que << i if deg[i] == 0 }
    result = Array(Int32).new(size)
    while v = que.shift?
      result << v
      self[v].each do |edge|
        que << edge.to if (deg[edge.to] -= 1) == 0
      end
    end
    deg.any? { |x| x > 0 } ? nil : result
  end
end
