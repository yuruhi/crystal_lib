struct Point
  include Comparable(Point)
  extend Indexable(Point)

  property y : Int32, x : Int32

  Direction4 = [Point.up, Point.left, Point.down, Point.right]
  Direction8 = Direction4 + [Point.ul, Point.ur, Point.dl, Point.dr]

  class_getter! height : Int32, width : Int32

  def self.set_range(height : Int, width : Int)
    raise ArgumentError.new unless 0 < height && 0 < width
    @@height, @@width = height, width
  end

  def self.size
    height * width
  end

  def self.unsafe_fetch(index : Int)
    Point.new(index // Point.width, index % Point.width)
  end

  def self.each(h : Int, w : Int, &block)
    h.times do |y|
      w.times do |x|
        yield Point[y, x]
      end
    end
  end

  def self.each(y : Int, w : Int)
    size.times.map { |i| Point.new(i) }
  end

  def initialize
    @y, @x = 0, 0
  end

  def initialize(y : Int, x : Int)
    @y, @x = y.to_i, x.to_i
  end

  def initialize(i : Int)
    raise ArgumentError.new unless 0 <= i && i < Point.size
    @y, @x = i // Point.width, i % Point.width
  end

  # Creates point fomr given array.
  def self.from(array : Array) : self
    raise ArgumentError.new unless array.size == 2
    Point.new(array.unsafe_fetch(0), array.unsafe_fetch(1))
  end

  # Alias for `.new(y : Int, x : Int)`
  def self.[](y : Int, x : Int) : self
    Point.new(y, x)
  end

  {% for name, d in {
                      :zero => {0, 0},
                      :up => {-1, 0}, :down => {1, 0}, :left => {0, -1}, :right => {0, 1},
                      :ul => {-1, -1}, :ur => {-1, 1}, :dl => {1, -1}, :dr => {1, 1},
                    } %}
    {% dy = d[0]; dx = d[1] %}

    # Returns `Point.new({{dy}}, {{dx}})`
    def self.{{name.id}}
      Point.new({{dy}}, {{dx}})
    end

    # Returns `self + Point.new({{dy}}, {{dx}})`
    def {{name.id}}
      Point.new(y + {{dy}}, x + {{dx}})
    end

    # Adds `Point.new({{dy}}, {{dx}})`
    def {{name.id}}!
      @y += {{dy}}
      @x += {{dx}}
      self
    end
  {% end %}

  {% for op in %w[+ - * // %] %}
    def {{op.id}}(other : Point)
      Point.new(y {{op.id}} other.y, x {{op.id}} other.x)
    end

    def {{op.id}}(other : Int)
      Point.new(y {{op.id}} other, x {{op.id}} other)
    end
  {% end %}

  # Returns `Point.new(x, y)`
  def xy
    Point.new(x, y)
  end

  # Returns `Point.new(y, x)`
  def yx
    self
  end

  def ==(other : Point)
    x == other.x && y == other.y
  end

  def <=>(other : Point)
    {y, x} <=> {other.y, other.x}
  end

  def [](i : Int)
    return y if i == 0
    return x if i == 1
    raise IndexError.new
  end

  def succ
    raise IndexError.new unless in_range? && self != Point.last
    if x < Point.width - 1
      Point.new(y, x + 1)
    else
      Point.new(y + 1, 0)
    end
  end

  def pred
    raise IndexError.new unless in_range? && self != Point.first
    if x > 0
      Point.new(y, x - 1)
    else
      Point.new(y - 1, Point.width - 1)
    end
  end

  def in_range?
    (0...Point.height).includes?(y) && (0...Point.width).includes?(x)
  end

  def to_i
    raise IndexError.new unless in_range?
    y * Point.width + x
  end

  def distance_square(other : Point)
    (y - other.y) ** 2 + (x - other.x) ** 2
  end

  def distance(other : Point)
    Math.sqrt(distance_square(other))
  end

  def manhattan(other : Point)
    (y - other.y).abs + (x - other.x).abs
  end

  def chebyshev(other : Point)
    Math.max((y - other.y).abs, (x - other.x).abs)
  end

  {% for i in [4, 8] %}
    def adjacent{{i}}(&block) : Nil
      Direction{{i}}.each do |d|
        yield self + d
      end
    end

    def adjacent{{i}}
      Direction{{i}}.each.map { |p| self + p }
    end

    def adj{{i}}_in_range(&block) : Nil
      Direction{{i}}.each do |d|
        point = self + d
        yield point if point.in_range?
      end
    end

    def adj{{i}}_in_range
      adjacent{{i}}.select(&.in_range?)
    end
  {% end %}

  # Writes a string representation of the point to *io*.
  #
  # ```
  # Point.new(1, 2).to_s # => "(1, 2)"
  # ```
  def to_s(io : IO) : Nil
    io << '(' << y << ", " << x << ')'
  end

  # Writes a string representation of the point to *io*.
  #
  # ```
  # Point.new(1, 2).inspect # => "(1, 2)"
  # ```
  def inspect(io : IO) : Nil
    to_s(io)
  end

  # Convert `Point` into `Char` representing direction.
  #
  # ```
  # Point.down.to_direction_char? # => 'D'
  # Point.left.to_direction_char? # => 'L'
  # ```
  def to_direction_char?(lrud = "LRUD") : Char?
    if y == 0 && x != 0
      x < 0 ? lrud[0] : lrud[1]
    elsif x == 0 && y != 0
      y < 0 ? lrud[2] : lrud[3]
    end
  end

  # Convert `Char` representing direction into `Point`.
  #
  # ```
  # Point.to_direction?('R') # => Point.new(0, 1)
  # ```
  def self.to_direction?(c : Char, lrud = "LRUD")
    raise ArgumentError.new unless lrud.size == 4
    lrud.index(c).try { |i| {left, right, up, down}[i] }
  end

  # Convert `String` representing direction into `Point`.
  #
  # ```
  # Point.to_direction?("DR") # => Point.new(1, 1)
  # ```
  def self.to_direction?(s : String, lrud = "LRUD")
    case s.size
    when 1
      to_direction?(s[0], lrud)
    when 2
      p1 = to_direction?(s[0], lrud) || return nil
      p2 = to_direction?(s[1], lrud) || return nil
      return nil unless p1.x ^ p2.x != 0 && p1.y ^ p2.y != 0
      p1 + p2
    end
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
    unsafe_fetch(point.y)[point.x]
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
