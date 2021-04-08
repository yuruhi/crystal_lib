struct Edge(T)
  property to : Int32
  property cost : T

  def initialize(@to, @cost)
  end
end

class Graph(T)
  getter size : Int32
  getter graph : Array(Array(Edge(T)))

  def initialize(@size)
    @graph = Array.new(size) { Array(Edge(T)).new }
  end

  def add_edge(i : Int32, j : Int32, cost : T)
    graph[i] << Edge(T).new(j, cost)
    graph[j] << Edge(T).new(i, cost)
  end
end
