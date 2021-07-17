require "../graph"

class Graph(T)
  def bfs01(start : Int, &block)
    raise ArgumentError.new unless 0 <= start < size
    queue = Deque{start}
    dist = Array(Int32?).new(size, nil)
    dist[start] = 0
    while v = queue.shift?
      current_dist = dist[v].not_nil!
      graph[v].each do |edge|
        cost = yield(edge)
        raise ArgumentError.new("Unexpected cost: #{cost}") unless cost == 0 || cost == 1
        next_dist = current_dist + cost
        if (d = dist[edge.to]).nil? || next_dist < d.not_nil!
          dist[edge.to] = next_dist
          if cost == 0
            queue.unshift edge.to
          else
            queue.push edge.to
          end
        end
      end
    end
    dist
  end

  def bfs01(start : Int)
    bfs01(start, &.cost)
  end

  def bfs01!(start : Int32, &block)
    bfs01(start) { |edge| yield edge }.map(&.not_nil!)
  end

  def bfs01!(start : Int)
    bfs01!(start, &.cost)
  end

  def bfs01_st(start : Int, goal : Int) : Int32?
    raise ArgumentError.new unless 0 <= start < size
    queue = Deque{start}
    dist = Array(Int32?).new(size, nil)
    dist[start] = 0
    while v = queue.shift?
      current_dist = dist[v].not_nil!
      return current_dist if v == goal
      graph[v].each do |edge|
        cost = yield(edge)
        raise ArgumentError.new("Unexpected cost: #{cost}") unless cost == 0 || cost == 1
        next_dist = current_dist + cost
        if (d = dist[edge.to]).nil? || next_dist < d.not_nil!
          dist[edge.to] = next_dist
          if cost == 0
            queue.unshift edge.to
          else
            queue.push edge.to
          end
        end
      end
    end
    nil
  end
end
