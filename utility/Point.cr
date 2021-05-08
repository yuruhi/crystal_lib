struct Point
  include Comparable(Point)
  extend Indexable(Point)

  property y : Int32
  property x : Int32

  @@Direction4 : Array(Point) = [Point.up, Point.left, Point.down, Point.right]
  @@Direction8 : Array(Point) = @@Direction4 + [Point.ul, Point.ur, Point.dl, Point.dr]

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

  macro define_direction(name, dy, dx)
		def self.{{name}}
			Point.new({{dy}}, {{dx}})
		end

		def {{name}}
			Point.new(y + {{dy}}, x + {{dx}})
		end
	end

  macro define_operator(op)
		def {{op.id}}(other : Point)
			Point.new(y {{op.id}} other.y, x {{op.id}} other.x)
		end

		def {{op.id}}(other : Int32)
			Point.new(y {{op.id}} other, x {{op.id}} other)
		end
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
    Point.new(array[0], array[1])
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
  define_operator("+")
  define_operator("-")
  define_operator("*")
  define_operator("//")
  define_operator("%")

  def xy
    Point.new(x, y)
  end

  def yx
    self
  end

  def ==(other : Point)
    x == other.x && y == other.y
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

  def <=>(other : Point)
    to_i <=> other.to_i
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
    case c
    when lrud[0]
      left
    when lrud[1]
      right
    when lrud[2]
      up
    when lrud[3]
      down
    end
  end

  def self.to_direction?(s : String, lrud = "LRUD")
    case s.size
    when 1
      to_direction?(s[0], lrud)
    when 2
      p1 = to_direction?(s[0], lrud) || return nil
      p2 = to_direction?(s[1], lrud) || return nil
      raise ArgumentError.new unless p1.x ^ p2.x != 0
      raise ArgumentError.new unless p1.y ^ p2.y != 0
      p1 + p2
    end
  end

  def self.to_direction(c, lrud = "LRUD")
    to_direction?(c, lrud) || raise ArgumentError.new
  end
end

class Array(T)
  def [](point : Point)
    self[point.y][point.x]
  end

  def []=(point : Point, value)
    self[point.y][point.x] = value
  end
end
