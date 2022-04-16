struct WeightedEdge(T)
  include Comparable(WeightedEdge(T))

  property to : Int32, cost : T

  def initialize(@to, @cost : T)
  end

  def <=>(other : WeightedEdge(T))
    {cost, to} <=> {other.cost, other.to}
  end

  def to_s(io) : Nil
    io << '(' << to << ", " << cost << ')'
  end

  def inspect(io) : Nil
    io << "->" << to << '(' << cost << ')'
  end
end

struct WeightedEdge2(T)
  include Comparable(WeightedEdge2(T))

  property from : Int32, to : Int32, cost : T

  def initialize(@from, @to, @cost : T)
  end

  def initialize(@from, edge : WeightedEdge(T))
    @to, @cost = edge.to, edge.cost
  end

  def <=>(other : WeightedEdge2(T))
    {cost, from, to} <=> {other.cost, other.from, other.to}
  end

  def reverse : self
    WeightedEdge2(T).new(to, from, cost)
  end

  def sort : self
    WeightedEdge2(T).new(*{to, from}.minmax, cost)
  end

  def to_s(io) : Nil
    io << '(' << from << ", " << to << ", " << cost << ')'
  end

  def inspect(io) : Nil
    io << from << "->" << to << '(' << cost << ')'
  end
end

struct UnweightedEdge
  property to : Int32

  def initialize(@to)
  end

  def initialize(@to, cost)
  end

  def cost : Int32
    1
  end

  def to_s(io) : Nil
    io << to
  end

  def inspect(io) : Nil
    io << "->" << to
  end
end

struct UnweightedEdge2
  property from : Int32, to : Int32

  def initialize(@from, @to)
  end

  def initialize(@from, @to, cost)
  end

  def initialize(@from, edge : UnweightedEdge)
    @to = edge.to
  end

  def cost : Int32
    1
  end

  def reverse : self
    UnweightedEdge2.new(to, from)
  end

  def sort : self
    UnweightedEdge2.new(*{to, from}.minmax)
  end

  def to_s(io) : Nil
    io << '(' << from << ", " << to << ')'
  end

  def inspect(io) : Nil
    io << from << "->" << to
  end
end
