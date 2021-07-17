require "../graph"

module Graph(Edge, Edge2)
  # Returns table of indegree.
  def indegree : Array(Int32)
    each_with_object(Array.new(size, 0)) do |edge, cnt|
      cnt[edge.to] += 1
    end
  end

  # Returns table of outdegree.
  def outdegree : Array(Int32)
    each_with_object(Array.new(size, 0)) do |edge, cnt|
      cnt[edge.from] += 1
    end
  end
end
