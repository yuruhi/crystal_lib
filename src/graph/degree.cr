require "../graph"

class UnweightedGraph
  def indegree
    result = Array.new(size, 0)
    each_edge do |edge|
      result[edge.to] += 1
    end
    result
  end

  def outdegree
    result = Array.new(size, 0)
    each_edge do |edge|
      result[edge.from] += 1
    end
    result
  end
end
