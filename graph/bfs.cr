require "./graph"

class Graph(T)
  def bfs(start : Int32, unreachable : T = nil) forall T
    raise ArgumentError.new unless 0 <= start < size
    queue = Deque(Int32).new
    queue.unshift start
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
    dist.map { |i| i ? i : unreachable }
  end

  def bfs_st(start : Int32, goal : Int32, unreachable : T = nil) forall T
    raise ArgumentError.new unless 0 <= start < size
    queue = Deque(Int32).new
    queue.unshift start
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
    unreachable
  end
end
