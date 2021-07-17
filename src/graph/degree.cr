require "../graph"

module Graph(Edge, Edge2)
  def indegree
    each_with_object(Array.new(size, 0)) do |edge, cnt|
      cnt[edge.to] += 1
    end
  end

  def outdegree
    each_with_object(Array.new(size, 0)) do |edge, cnt|
      cnt[edge.from] += 1
    end
  end
end
