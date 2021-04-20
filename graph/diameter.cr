require "./graph"
require "./bfs"

class Graph(T)
  def diameter : {T, Int32, Int32}
    v = bfs!(0).each_with_index.max[1]
    dist, u = bfs!(v).each_with_index.max
    {dist, v, u}
  end
end
