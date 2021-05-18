struct Point
  include Comparable(Point)
  extend Indexable(Point)

  property y : Int32
  property x : Int32

  Direction4 = [Point.up, Point.left, Point.down, Point.right]
  Direction8 = @@Direction4 + [Point.ul, Point.ur, Point.dl, Point.dr]

  @@height : Int32?
  @@width : Int32?

  def self.set_range(height : Int32, width : Int32)
    raise ArgumentError.new unless 0 < height
    raise ArgumentError.new unless 0 < width
    @@height = height
    @@width = width
  end

  def self.height
    @@height.not_nil!
  end

  def self.width
    @@width.not_nil!
  end

  def self.size
    height * width
  end

  def self.unsafe_fetch(index : Int)
    Point.new(index // Point.width, index % Point.width)
  end

  def initialize
    @y, @x = 0, 0
  end

  def initialize(@y : Int32, @x : Int32)
  end

  def initialize(i : Int32)
    raise ArgumentError.new unless 0 <= i && i < Point.size
    @y, @x = i // Point.width, i % Point.width
  end

  def self.from(array : Array(Int32)) : self
    raise ArgumentError.new unless array.size == 2
    Point.new(array[0], array[1])
  end

  macro define_direction(name, dy, dx)
    def self.{{name}}
      Point.new({{dy}}, {{dx}})
    end

    def {{name}}
      Point.new(y + {{dy}}, x + {{dx}})
    end
  end

  define_direction(zero, 0, 0)
  define_direction(up, -1, 0)
  define_direction(left, 0, -1)
  define_direction(down, 1, 0)
  define_direction(right, 0, 1)
  define_direction(ul, -1, -1)
  define_direction(ur, -1, 1)
  define_direction(dl, 1, -1)
  define_direction(dr, 1, 1)

  {% for op in %w[+ - * // %] %}
    def {{op.id}}(other : Point)
      Point.new(y {{op.id}} other.y, x {{op.id}} other.x)
    end

    def {{op.id}}(other : Int32)
      Point.new(y {{op.id}} other, x {{op.id}} other)
    end
  {% end %}

  def xy
    Point.new(x, y)
  end

  def yx
    self
  end

  def ==(other : Point)
    x == other.x && y == other.y
  end

  def <=>(other : Point)
    to_i <=> other.to_i
  end

  def [](i : Int32)
    return y if i == 0
    return x if i == 1
    raise IndexError.new
  end

  def succ
    raise IndexError.new unless in_range?
    raise IndexError.new unless self == Point.last
    if x < Point.width - 1
      Point.new(y, x + 1)
    else
      Point.new(y + 1, 0)
    end
  end

  def pred
    raise IndexError.new unless in_range?
    raise IndexError.new unless self == Point.zero
    if x > Point.width
      Point.new(y, x - 1)
    else
      Point.new(y - 1, Point.width - 1)
    end
  end

  def in_range?
    (0...Point.height).includes?(y) && (0...Point.width).includes?(x)
  end

  def to_i : Int32
    raise IndexError.new unless in_range?
    y * Point.width + x
  end

  def distance_square(other : Point)
    (y - other.y) ** 2 + (x - other.x) ** 2
  end

  def distance(other : Point)
    Math.sqrt(distance_square)
  end

  def manhattan(other : Point)
    (y - other.y).abs + (x - other.x).abs
  end

  def chebyshev(other : Point)
    {(y - other.y).abs, (x - other.x).abs}.max
  end

  def adjacent4
    @@Direction4.each.map { |p| self + p }
  end

  def adj4_in_range
    adjacent4.select(&.in_range?)
  end

  def adjacent8
    @@Direction8.each.map { |p| self + p }
  end

  def adj8_in_range
    adjacent8.select(&.in_range?)
  end

  def to_s(io : IO)
    io << '(' << y << ", " << x << ')'
  end

  def inspect(io : IO)
    to_s(io)
  end

  def self.to_direction?(c : Char, lrud = "LRUD")
    raise ArgumentError.new unless lrud.size == 4
    lrud.index(c).try { |i| {left, right, up, down}[i] }
  end

  def self.to_direction?(s : String, lrud = "LRUD")
    case s.size
    when 1
      to_direction?(s[0], lrud)
    when 2
      p1 = to_direction?(s[0], lrud) || return nil
      p2 = to_direction?(s[1], lrud) || return nil
      raise ArgumentError.new unless p1.x ^ p2.x != 0 && p1.y ^ p2.y != 0
      p1 + p2
    end
  end

  def self.to_direction(c, lrud = "LRUD")
    to_direction?(c, lrud) || raise ArgumentError.new
  end
end

module Indexable(T)
  private def check_index_out_of_bounds(point : Point)
    check_index_out_of_bounds(point) { raise IndexError.new }
  end

  private def check_index_out_of_bounds(point : Point)
    if 0 <= point.y < size && 0 <= point.x < unsafe_fetch(point.y).size
      point
    else
      yield
    end
  end

  def fetch(point : Point)
    point = check_index_out_of_bounds(point) do
      return yield point
    end
    unsafe_fetch(point.y).unsafe_fetch(point.x)
  end

  def [](point : Point)
    fetch(point) { raise IndexError.new }
  end

  def []?(point : Point)
    fetch(point, nil)
  end
end

class Array(T)
  def []=(point : Point, value)
    index = check_index_out_of_bounds point
    @buffer[index.y][index.x] = value
  end
end
