struct Edge(T)
  property to : Int32
  property cost : T

  def initialize(@to : Int32, @cost : T)
  end

  def to_s(io) : Nil
    io << {to, cost}
  end

  def inspect(io) : Nil
    io << "->#{to}(#{cost})"
  end
end

struct Edge2(T)
  property from : Int32
  property to : Int32
  property cost : T

  def initialize(@from : Int32, @to : Int32, @cost : T)
  end

  def reverse
    Edge2(T).new(to, from, cost)
  end

  def to_s(io) : Nil
    io << {from, to, cost}
  end

  def inspect(io) : Nil
    io << "#{from}->#{to}(#{cost})"
  end
end

class Graph(T)
  getter size : Int32
  getter graph : Array(Array(Edge(T)))

  def initialize(@size : Int32)
    raise ArgumentError.new("Negative graph size: #{size}") unless size >= 0
    @graph = Array.new(size) { Array(Edge(T)).new }
  end

  def initialize(@size, edges : Array(Edge2(T)), undirected : Bool)
    raise ArgumentError.new("Negative graph size: #{size}") unless size >= 0
    @graph = Array.new(size) { Array(Edge(T)).new }
    edges.each do |edge|
      @graph[edge.from] << Edge.new(edge.to, edge.cost)
      @graph[edge.to] << Edge.new(edge.from, edge.cost) if undirected
    end
  end

  def add_edge(i : Int32, j : Int32, cost : T)
    raise IndexError.new unless 0 <= i < size
    raise IndexError.new unless 0 <= j < size
    graph[i] << Edge(T).new(j, cost)
    graph[j] << Edge(T).new(i, cost)
  end

  def add_edge_directed(i : Int32, j : Int32, cost : T)
    raise IndexError.new unless 0 <= i < size
    raise IndexError.new unless 0 <= j < size
    graph[i] << Edge(T).new(j, cost)
  end

  def [](i : Int32)
    graph[i]
  end

  def each_edge : Nil
    (0...size).each do |v|
      graph[v].each do |edge|
        yield Edge2(T).new(v, edge.to, edge.cost)
      end
    end
  end

  def edges : Array(Edge2(T))
    result = [] of Edge2(T)
    each_edge do |edge|
      result << edge
    end
    result
  end
end