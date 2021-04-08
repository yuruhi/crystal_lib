require "./graph"
require "./../atcoder/PriorityQueue"

class Graph(T)
  def dijkstra(start)
    que = AtCoder::PriorityQueue({Int32, T}).new { |(vertex, dist)| -dist }
    que << {start, T.zero}
    dist = Array.new(size, T::MAX)
    dist[start] = T.zero

    while vd = que.pop
      v, d = vd
      next if dist[v] < d
      graph[v].each do |edge|
        if dist[edge.to] > dist[v] + edge.cost
          dist[edge.to] = dist[v] + edge.cost
          que << {edge.to, dist[edge.to]}
        end
      end
    end
    dist
  end
end
