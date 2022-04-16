require "../graph"

module Graph(Edge, Edge2)
  # Returns table of color if the graph is bipartite graph, otherwise returns `nil`
  def bipartite_graph : Array(Bool)?
    color = Array(Bool?).new(size, nil)
    queue = Deque.new (0...size).to_a
    while v = queue.shift?
      c1 = color[v]
      c1 = color[v] = true if c1.nil?
      graph[v].each do |edge|
        if (c2 = color[edge.to]).nil?
          color[edge.to] = !c1
          queue.unshift edge.to
        else
          return nil if c1 == c2
        end
      end
    end
    color.map(&.not_nil!)
  end
end
