struct Edge(T)
  property to : Int32
  property cost : T

  def initialize(@to : Int32, @cost : T)
  end
end

struct Edge2(T)
  property from : Int32
  property to : Int32
  property cost : T

  def initialize(@from : Int32, @to : Int32, @cost : T)
  end
end

class Graph(T)
  getter size : Int32
  getter graph : Array(Array(Edge(T)))

  def initialize(@size : Int32)
    @graph = Array.new(size) { Array(Edge(T)).new }
  end

  def initialize(@size, edges : Array(Edge2(T)), undirected : Bool)
    @graph = Array.new(size) { Array(Edge(T)).new }
    edges.each do |edge|
      @graph[edge.from] << Edge.new(edge.to, edge.cost)
      @graph[edge.to] << Edge.new(edge.from, edge.cost) if undirected
    end
  end

  def add_edge(i : Int32, j : Int32, cost : T)
    graph[i] << Edge(T).new(j, cost)
    graph[j] << Edge(T).new(i, cost)
  end
end
