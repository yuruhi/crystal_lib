require "./graph/edge"

module Graph(Edge, Edge2)
  include Enumerable(Edge2)

  getter graph : Array(Array(Edge))

  def initialize(size : Int)
    @graph = Array(Array(Edge)).new(size) { [] of Edge }
  end

  def initialize(size : Int, edges : Enumerable)
    initialize(size)
    add_edges(edges)
  end

  # Add *edge*.
  abstract def <<(edge : Edge2)

  # :ditto:
  def <<(edge : Tuple) : self
    self << Edge2.new(*edge)
  end

  def add_edges(edges : Enumerable) : self
    edges.each { |edge| self << edge }
    self
  end

  delegate size, :[], to: @graph

  # Yields each edge of the graph, ans returns `nil`.
  def each(&) : Nil
    (0...size).each do |v|
      self[v].each do |edge|
        yield Edge2.new(v, edge)
      end
    end
  end

  def reverse : self
    if self.class.directed?
      each_with_object(self.class.new(size)) do |edge, reversed|
        reversed << edge.reverse
      end
    else
      dup
    end
  end

  def to_undirected : self
    if self.class.directed?
      each_with_object(self.class.new(size)) do |edge, graph|
        graph << edge << edge.reverse
      end
    else
      dup
    end
  end

  def to_s(io : IO) : Nil
    io << '['
    join(", ", io) do |edge, io|
      edge.inspect io
    end
    io << ']'
  end

  def inspect(io : IO) : Nil
    io << "[\n"
    graph.each do |edges|
      io << "  " << edges << ",\n"
    end
    io << ']'
  end
end

class DiGraph(T)
  include Graph(WeightedEdge(T), WeightedEdge2(T))

  def self.weighted?
    true
  end

  def self.directed?
    true
  end

  def initialize(size : Int)
    super
  end

  def initialize(size : Int, edges : Enumerable(WeightedEdge2(T)))
    super
  end

  def initialize(size : Int, edges : Enumerable({Int32, Int32, T}))
    super
  end

  def <<(edge : WeightedEdge2(T)) : self
    raise IndexError.new unless 0 <= edge.from < size && 0 <= edge.to < size
    @graph[edge.from] << WeightedEdge.new(edge.to, edge.cost)
    self
  end
end

class UnGraph(T)
  include Graph(WeightedEdge(T), WeightedEdge2(T))

  def self.weighted?
    true
  end

  def self.directed?
    false
  end

  def initialize(size : Int)
    super
  end

  def initialize(size : Int, edges : Enumerable(WeightedEdge2(T)))
    super
  end

  def initialize(size : Int, edges : Enumerable({Int32, Int32, T}))
    super
  end

  def <<(edge : WeightedEdge2(T)) : self
    raise IndexError.new unless 0 <= edge.from < size && 0 <= edge.to < size
    @graph[edge.from] << WeightedEdge.new(edge.to, edge.cost)
    @graph[edge.to] << WeightedEdge.new(edge.from, edge.cost)
    self
  end

  def each_child(vertex : Int, parent, &block) : Nil
    graph[vertex].each do |edge|
      yield edge if edge.to != parent
    end
  end

  def each_child(vertex : Int, parent)
    graph[vertex].each.reject(&.to.== parent)
  end
end

class UnweightedDiGraph
  include Graph(UnweightedEdge, UnweightedEdge2)

  def self.weighted?
    false
  end

  def self.directed?
    true
  end

  def initialize(size : Int)
    super
  end

  def initialize(size : Int, edges : Enumerable)
    super
  end

  def <<(edge : UnweightedEdge2) : self
    raise IndexError.new unless 0 <= edge.from < size && 0 <= edge.to < size
    @graph[edge.from] << UnweightedEdge.new(edge.to)
    self
  end
end

class UnweightedUnGraph
  include Graph(UnweightedEdge, UnweightedEdge2)

  def self.weighted?
    false
  end

  def self.directed?
    false
  end

  def initialize(size : Int)
    super
  end

  def initialize(size : Int, edges : Enumerable)
    super
  end

  def <<(edge : UnweightedEdge2) : self
    raise IndexError.new unless 0 <= edge.from < size && 0 <= edge.to < size
    @graph[edge.from] << UnweightedEdge.new(edge.to)
    @graph[edge.to] << UnweightedEdge.new(edge.from)
    self
  end

  def each_child(vertex : Int, parent, &block) : Nil
    graph[vertex].each do |edge|
      yield edge if edge.to != parent
    end
  end

  def each_child(vertex : Int, parent)
    graph[vertex].each.reject(&.to.== parent)
  end
end
