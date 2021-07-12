struct Edge(T)
  include Comparable(Edge(T))

  property to : Int32, cost : T

  def initialize(@to : Int32, @cost : T)
  end

  def <=>(other : Edge(T))
    {cost, to} <=> {other.cost, other.to}
  end

  def to_s(io) : Nil
    io << '(' << to << ", " << cost << ')'
  end

  def inspect(io) : Nil
    io << "->#{to}(#{cost})"
  end
end

struct Edge2(T)
  include Comparable(Edge2(T))

  property from : Int32, to : Int32, cost : T

  def initialize(@from : Int32, @to : Int32, @cost : T)
  end

  def <=>(other : Edge2(T))
    {cost, from, to} <=> {other.cost, other.from, other.to}
  end

  def reverse
    Edge2(T).new(to, from, cost)
  end

  def sort
    Edge2(T).new(*{to, from}.minmax, cost)
  end

  def to_s(io) : Nil
    io << '(' << from << ", " << to << ", " << cost << ')'
  end

  def inspect(io) : Nil
    io << from << "->" << to << '(' << cost << ')'
  end
end

struct UnweightedEdge2
  property from : Int32
  property to : Int32

  def initialize(@from, @to)
  end

  def reverse
    UnweightedEdge2.new(to, from)
  end

  def sort
    UnweightedEdge2.new(*{to, from}.minmax)
  end

  def to_s(io) : Nil
    io << '(' << from << ", " << to << ')'
  end

  def inspect(io) : Nil
    io << from << "->" << to
  end
end

abstract class Graph(T)
  getter graph : Array(Array(Edge(T)))

  def initialize(size : Int)
    raise ArgumentError.new("Negative graph size: #{size}") unless size >= 0
    @graph = Array.new(size) { Array(Edge(T)).new }
  end

  def add_edge(from : Int, to : Int, cost : T)
    add_edge(Edge2.new(from, to, cost))
  end

  def add_edge(from_to_cost : {Int, Int, T})
    add_edge(Edge2.new(*from_to_cost))
  end

  def add_edges(edges)
    edges.each { |edge| add_edge(edge) }
    self
  end

  delegate size, to: @graph
  delegate :[], to: @graph

  def each_edge : Nil
    (0...size).each do |v|
      graph[v].each do |edge|
        yield Edge2(T).new(v, edge.to, edge.cost)
      end
    end
  end

  def edges
    result = [] of Edge2(T)
    each_edge do |edge|
      result << edge
    end
    result
  end
end

class DirectedGraph(T) < Graph(T)
  def initialize(size : Int)
    super
  end

  def initialize(size : Int, edges : Array(Edge2(T)))
    super(size)
    add_edges(edges)
  end

  def initialize(size : Int, edges : Array({Int, Int, T}))
    super(size)
    add_edges(edges)
  end

  def add_edge(edge : Edge2(T))
    raise IndexError.new unless 0 <= edge.from < size && 0 <= edge.to < size
    @graph[edge.from] << Edge.new(edge.to, edge.cost)
    self
  end
end

class UndirectedGraph(T) < Graph(T)
  def initialize(size : Int)
    super
  end

  def initialize(size : Int, edges : Array(Edge2(T)))
    super(size)
    add_edges(edges)
  end

  def initialize(size : Int, edges : Array({Int, Int, T}))
    super(size)
    add_edges(edges)
  end

  def add_edge(edge : Edge2(T))
    raise IndexError.new unless 0 <= edge.from < size && 0 <= edge.to < size
    @graph[edge.from] << Edge.new(edge.to, edge.cost)
    @graph[edge.to] << Edge.new(edge.from, edge.cost)
    self
  end
end

abstract class UnweightedGraph
  getter graph : Array(Array(Int32))

  def initialize(size : Int)
    raise ArgumentError.new("Negative graph size: #{size}") unless size >= 0
    @graph = Array.new(size) { Array(Int32).new }
  end

  def add_edge(from : Int, to : Int)
    add_edge(UnweightedEdge2.new(from, to))
  end

  def add_edge(from_to : {Int, Int})
    add_edge(*from_to)
  end

  def add_edges(edges : Array)
    edges.each { |edge| add_edge(edge) }
    self
  end

  delegate size, to: @graph
  delegate :[], to: @graph

  def each_edge : Nil
    (0...size).each do |v|
      graph[v].each do |u|
        yield UnweightedEdge2.new(v, u)
      end
    end
  end

  def edges
    result = [] of UnweightedEdge2
    each_edge do |edge|
      result << edge
    end
    result
  end
end

class UnweightedDirectedGraph < UnweightedGraph
  def initialize(size : Int)
    super
  end

  def initialize(size : Int, edges : Array)
    super(size)
    add_edges(edges)
  end

  def add_edge(edge : UnweightedEdge2)
    raise IndexError.new unless 0 <= edge.from < size && 0 <= edge.to < size
    @graph[edge.from] << edge.to
    self
  end
end

class UnweightedUndirectedGraph < UnweightedGraph
  def initialize(size : Int)
    super
  end

  def initialize(size : Int, edges : Array)
    super(size)
    add_edges(edges)
  end

  def add_edge(edge : UnweightedEdge2)
    raise IndexError.new unless 0 <= edge.from < size && 0 <= edge.to < size
    @graph[edge.from] << edge.to
    @graph[edge.to] << edge.from
    self
  end

  def each_child(vertex : Int, parent, &block) : Nil
    graph[vertex].each do |u|
      yield u if u != parent
    end
  end

  def each_child(vertex : Int, parent)
    graph[vertex].each.select { |u| u != parent }
  end
end
