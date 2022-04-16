require "../graph"

module Graph(Edge, Edge2)
  # Returns the array of distance of each node from *start* or `nil`.
  # *block* must return `0` or `1`.
  def bfs01(start : Int, &block) : Array(Int32?)
    raise ArgumentError.new unless 0 <= start < size
    queue = Deque{start}
    dist = Array(Int32?).new(size, nil).tap(&.[start] = 0)
    while v = queue.shift?
      current_dist = dist[v].not_nil!
      graph[v].each do |edge|
        cost = yield edge
        raise ArgumentError.new("Unexpected cost: #{cost}") unless cost == 0 || cost == 1
        next_dist = current_dist + cost
        d = dist[edge.to]
        if d.nil? || next_dist < d
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

  # Returns the array of distance of each node from *start* or `nil`.
  # All of cost of edge must be `0` or `1`.
  def bfs01(start : Int) : Array(Int32?)
    bfs01(start, &.cost)
  end

  # Returns the array of distance of each node from *start*.
  # *block* must return `0` or `1`.
  def bfs01!(start : Int32, &block) : Array(Int32)
    bfs01(start) { |edge| yield edge }.map(&.not_nil!)
  end

  # Returns the array of distance of each node from *start*.
  # All of cost of edge must be `0` or `1`.
  def bfs01!(start : Int) : Array(Int32)
    bfs01!(start, &.cost)
  end

  # Returns the distance from *start* to *goal* if path is present, otherwise returns `nil`.
  # *block* must return `0` or `1`.
  def bfs01_st(start : Int, goal : Int, &block) : Int32?
    raise ArgumentError.new unless 0 <= start < size
    queue = Deque{start}
    dist = Array(Int32?).new(size, nil).tap(&.[start] = 0)
    while v = queue.shift?
      current_dist = dist[v].not_nil!
      return current_dist if v == goal
      graph[v].each do |edge|
        cost = yield edge
        raise ArgumentError.new("Unexpected cost: #{cost}") unless cost == 0 || cost == 1
        next_dist = current_dist + cost
        d = dist[edge.to]
        if d.nil? || next_dist < d
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

  # Returns the distance from *start* to *goal* if path is present, otherwise returns `nil`.
  # All of cost of edge must be `0` or `1`.
  def bfs01_st(start : Int, goal : Int) : Int32?
    bfs01_st(start, goal, &.cost)
  end

  # Returns the distance from *start* to *goal* if path is present, otherwise raises `ArgumentError`.
  # *block* must return `0` or `1`.
  def bfs01_st!(start : Int, goal : Int, &block) : Int32
    bfs01_st(start, goal) { |edge| yield edge } || raise ArgumentError.new
  end

  # Returns the distance from *start* to *goal* if path is present, otherwise raises `ArgumentError`.
  # All of cost of edge must be `0` or `1`.
  def bfs01_st!(start : Int, goal : Int) : Int32
    bfs01_st(start, goal, &.cost) || raise ArgumentError.new
  end
end
