require "../datastructure/binary_heap"
require "../graph"

module Graph(Edge, Edge2)
  # Returns the array of distance of each node from *start* or `nil`.
  def dijkstra(start : Int)
    raise ArgumentError.new unless 0 <= start < size
    que = BinaryHeap({Int32, typeof(first.cost)}).new { |(v1, d1), (v2, d2)| d1 <=> d2 }
    que << {start, typeof(first.cost).zero}
    dist = Array(typeof(first.cost)?).new(size, nil)
    dist[start] = typeof(first.cost).zero

    until que.empty?
      v, d = que.pop
      next if dist[v].try { |dist_v| dist_v < d }
      current_dist = dist[v].not_nil!
      graph[v].each do |edge|
        next_dist = current_dist + edge.cost
        if dist[edge.to].nil? || dist[edge.to].not_nil! > next_dist
          dist[edge.to] = next_dist
          que << {edge.to, next_dist}
        end
      end
    end
    dist
  end

  # Returns the array of distance of each node from *start*.
  def dijkstra!(start : Int)
    dijkstra(start).map(&.not_nil!)
  end

  # Returns the distance of *start* to *goal* or `nil`.
  def dijkstra(start : Int, goal : Int)
    raise ArgumentError.new unless 0 <= start < size && 0 <= goal < size
    que = BinaryHeap({Int32, typeof(first.cost)}).new { |(v1, d1), (v2, d2)| d1 <=> d2 }
    que << {start, typeof(first.cost).zero}
    dist = Array(typeof(first.cost)?).new(size, nil)
    dist[start] = typeof(first.cost).zero

    until que.empty?
      v, d = que.pop
      return d if v == goal
      next if dist[v].try { |dist_v| dist_v < d }
      current_dist = dist[v].not_nil!
      graph[v].each do |edge|
        next_dist = current_dist + edge.cost
        if dist[edge.to].nil? || dist[edge.to].not_nil! > next_dist
          dist[edge.to] = next_dist
          que << {edge.to, next_dist}
        end
      end
    end
  end

  # Returns the distance of *start* to *goal*.
  def dijkstra!(start : Int, goal : Int)
    dijkstra(start, goal).not_nil!
  end

  def dijkstra_with_prev(start : Int)
    raise ArgumentError.new unless 0 <= start < size
    que = AtCoder::PriorityQueue({Int32, typeof(first.cost)}).new { |(v1, d1), (v2, d2)| d1 > d2 }
    que << {start, typeof(first.cost).zero}
    dist = Array(typeof(first.cost)?).new(size, nil)
    dist[start] = typeof(first.cost).zero
    prev = Array(Int32?).new(size, nil)

    while vd = que.pop
      v, d = vd
      next if dist[v].try { |dist_v| dist_v < d }
      current_dist = dist[v].not_nil!
      graph[v].each do |edge|
        next_dist = current_dist + edge.cost
        if dist[edge.to].nil? || dist[edge.to].not_nil! > next_dist
          dist[edge.to] = next_dist
          prev[edge.to] = v
          que << {edge.to, next_dist}
        end
      end
    end
    {dist, prev}
  end

  def dijkstra_with_path(start : Int, goal : Int)
    dist, prev = dijkstra_with_prev(start)
    if d = dist[goal]
      {d, Graph.restore_path(prev, goal)}
    end
  end

  def self.restore_path(prev : Array(Int32?), v : Int) : Array(Int32)
    v = v.to_i
    path = [v]
    while v = prev[v]
      path << v
    end
    path.reverse
  end
end
