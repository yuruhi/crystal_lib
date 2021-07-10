require "./graph"

class UnweightedGraph
  def bfs(start : Int32, unreachable : U = nil) forall U
    raise ArgumentError.new unless 0 <= start < size
    queue = Deque{start}
    dist = Array(Int32?).new(size, nil)
    dist[start] = 0
    while v = queue.pop?
      graph[v].each do |edge|
        if dist[edge].nil?
          dist[edge] = dist[v].not_nil! + 1
          queue.unshift edge
        end
      end
    end
    dist.map { |i| i || unreachable }
  end

  def bfs!(start : Int32)
    bfs(start).map(&.not_nil!)
  end

  def bfs_st(start : Int32, goal : Int32, unreachable : U = nil) forall U
    raise ArgumentError.new unless 0 <= start < size
    queue = Deque{start}
    dist = Array(Int32?).new(size, nil)
    dist[start] = 0
    while v = queue.pop?
      d = dist[v].not_nil!
      return d if v == goal
      graph[v].each do |edge|
        if dist[edge].nil?
          dist[edge] = d + 1
          queue.unshift edge
        end
      end
    end
    unreachable
  end
end
