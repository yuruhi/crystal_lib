require "../graph"
require "./degree"

module Graph(Edge, Edge2)
  # Returns forest and cycle of the undirected graph with equal number of vertices and edges.
  def namori_decompose : {self, Array(Int32)}
    raise ArgumentError.new unless !self.class.directed?
    raise ArgumentError.new unless size == graph.sum(&.size) // 2

    deg = Array.new(size) { |i| self[i].size }

    que = Deque(Int32).new
    flag = Array.new(size, false)
    (0...size).each do |i|
      if deg[i] == 1
        que << i
        flag[i] = true
      end
    end

    forest = self.class.new(size)
    while v = que.shift?
      self[v].each do |edge|
        next if flag[edge.to]
        deg[edge.to] -= 1
        forest << Edge2.new(v, edge)
        if deg[edge.to] == 1
          que << edge.to
          flag[edge.to] = true
        end
      end
    end

    cycle = [] of Int32
    (0...size).each do |i|
      que << i unless flag[i]
      while v = que.pop?
        next if flag[v]
        cycle << v
        flag[v] = true
        self[v].each do |edge|
          que << edge.to unless flag[edge.to]
        end
      end
    end
    {forest, cycle}
  end
end
