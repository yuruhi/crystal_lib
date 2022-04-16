require "../graph"

module Graph(Edge, Edge2)
  # Returns the array of distance of each node from *start* or `nil`.
  def bfs(start : Int) : Array(Int32?)
    raise ArgumentError.new unless 0 <= start < size
    queue = Deque{start}
    dist = Array(Int32?).new(size, nil).tap(&.[start] = 0)
    while v = queue.pop?
      graph[v].each do |edge|
        if dist[edge.to].nil?
          dist[edge.to] = dist[v].not_nil! + 1
          queue.unshift edge.to
        end
      end
    end
    dist
  end

  # Returns the array of distance of each node from *start*.
  def bfs!(start : Int) : Array(Int32)
    bfs(start).map(&.not_nil!)
  end

  # Returns the distance from *start* to *goal* if path is present, otherwise returns `nil`.
  def bfs_st(start : Int, goal : Int) : Int32?
    raise ArgumentError.new unless 0 <= start < size && 0 <= goal < size
    queue = Deque{start}
    dist = Array(Int32?).new(size, nil).tap(&.[start] = 0)
    while v = queue.pop?
      d = dist[v].not_nil!
      return d if v == goal
      graph[v].each do |edge|
        if dist[edge.to].nil?
          dist[edge.to] = d + 1
          queue.unshift edge.to
        end
      end
    end
  end
end
