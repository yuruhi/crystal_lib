require "./graph"
require "./tree_distance"

class Graph(T)
  def diameter : {T, Int32, Int32}
    v = tree_distance(0).each_with_index.max[1]
    dist, u = tree_distance(v).each_with_index.max
    {dist, v, u}
  end
end
