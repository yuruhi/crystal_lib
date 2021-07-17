require "../../atcoder/src/PriorityQueue"
require "../graph"

module Graph(Edge, Edge2)
  def dijkstra(start : Int32)
    raise ArgumentError.new unless 0 <= start < size
    que = AtCoder::PriorityQueue({Int32, typeof(first.cost)}).new { |(v1, d1), (v2, d2)| d1 > d2 }
    que << {start, typeof(first.cost).zero}
    dist = Array(typeof(first.cost)?).new(size, nil)
    dist[start] = typeof(first.cost).zero

    while vd = que.pop
      v, d = vd
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

  def dijkstra!(start : Int32)
    dijkstra(start).map(&.not_nil!)
  end
end
