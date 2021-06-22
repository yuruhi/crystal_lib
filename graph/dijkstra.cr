require "../atcoder/src/PriorityQueue"
require "./graph"

class Graph(T)
  def dijkstra(start : Int32, unreachable : U = nil) forall U
    raise ArgumentError.new unless 0 <= start < size
    que = AtCoder::PriorityQueue({Int32, T}).new { |(v1, d1), (v2, d2)| d1 > d2 }
    que << {start, T.zero}
    dist = Array(T?).new(size, nil)
    dist[start] = T.zero

    while vd = que.pop
      v, d = vd
      next if dist[v].try { |dist_v| dist_v < d }
      dist_v = dist[v].not_nil!
      graph[v].each do |edge|
        if dist[edge.to].nil? || dist[edge.to].not_nil! > dist_v + edge.cost
          dist[edge.to] = dist_v + edge.cost
          que << {edge.to, dist_v + edge.cost}
        end
      end
    end
    dist.map { |i| i || unreachable }
  end

  def dijkstra!(start : Int32)
    dijkstra(start).map(&.not_nil!)
  end
end
