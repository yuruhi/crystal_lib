require "../graph"
require "./degree"

module Graph(Edge, Edge2)
  def topological_sort : Array(Int32)?
    deg = indegree
    queue = Deque(Int32).new
    size.times { |i| queue << i if deg[i] == 0 }
    result = Array(Int32).new(size)
    while v = queue.shift?
      result << v
      self[v].each do |edge|
        queue << edge.to if (deg[edge.to] -= 1) == 0
      end
    end
    deg.all?(0) ? result : nil
  end
end
