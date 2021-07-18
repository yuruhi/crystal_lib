require "../graph"

module Graph(Edge, Edge2)
  def bfs(start : Int) : Array(Int32?)
    raise ArgumentError.new unless 0 <= start < size
    queue = Deque{start}
    dist = Array(Int32?).new(size, nil)
    dist[start] = 0
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

  def bfs!(start : Int) : Array(Int32)
    bfs(start).map(&.not_nil!)
  end

  def bfs_st(start : Int, goal : Int) : Int32?
    raise ArgumentError.new unless 0 <= start < size && 0 <= goal < size
    queue = Deque{start}
    dist = Array(Int32?).new(size, nil)
    dist[start] = 0
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
    nil
  end
end