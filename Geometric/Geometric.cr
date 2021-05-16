module Geometric
  alias Real = Float64
  EPS = Real.new(1e-12)

  struct Real
    def sgn : Int32
      self < -Geometric::EPS ? -1 : self > Geometric::EPS ? 1 : 0
    end
  end

  extend self

  struct Vec2
    include Comparable(Vec2)

    property x : Real
    property y : Real

    def self.zero
      Vec2.new(Real.zero, Real.zero)
    end

    def initialize(x, y)
      @x, @y = Real.new(x), Real.new(y)
    end

    def <=>(other : Vec2)
      {x, y} <=> {other.x, other.y}
    end

    macro define_operator(op)
      def {{op.id}}(other : Vec2)
        Vec2.new(x {{op.id}} other.x, y {{op.id}} other.y)
      end

      def {{op.id}}(other : Real)
        Vec2.new(x {{op.id}} other, y {{op.id}} other)
      end
    end

    define_operator("+")
    define_operator("-")
    define_operator("*")
    define_operator("/")

    def dot(other : Vec2)
      x * other.y - y * other.x
    end

    def cross(other : Vec2)
      x * other.y - y * other.x
    end

    def inspect(io : IO)
      io << '(' << x << ", " << y << ')'
    end
  end

  struct Circle
    property center : Vec2
    property radious : Real

    def initialize(center : Vec2, radious)
      @center, @radious = center, Real.new(radious)
    end

    def initialize(x, y, radious)
      initialize(Vec2.new(x, y), radious)
    end

    delegate x, to: center
    delegate y, to: center

    macro define_operator(op)
      def {{op.id}}(other : Vec2)
        Circel.new(x {{op.id}} other.x, y {{op.id}} other.y, radious)
      end

      def {{op.id}}(other : Real)
        Circle.new(x {{op.id}} other, y {{op.id}} other, radious)
      end
    end

    define_operator("+")
    define_operator("-")
    define_operator("*")
    define_operator("/")

    def inspect(io : IO)
      io << '(' << center << ", " << radious << ')'
    end
  end

  class Polygon < Array(Vec2)
    def initialize(points : Array(Vec2))
      initialize(points.size)
      concat points
    end

    def initialize
      super
    end

    def initialize(initial_capacity : Int)
      super
    end

    def initialize(size : Int, &block : Int32 -> T)
      super
    end

    def after(i : Int32) : Vec2
      self[i != size - 1 ? i + 1 : 0]
    end

    def area : Real
      (0...size).sum { |i|
        self[i].cross after(i)
      }.abs / 2
    end

    def convex_hull : Polygon
      result = Polygon.new
      points = sort
      points.each do |point|
        while result.size >= 2 && Geometric.iSP(result[-2], result[-1], point) != -1
          result.pop
        end
        result << point
      end
      t = result.size + 1
      (0...points.size - 1).reverse_each do |i|
        while result.size >= t && Geometric.iSP(result[-2], result[-1], points[i]) != -1
          result.pop
        end
        result << points[i]
      end
      result.pop
      result
    end

    def inspect(io) : Nil
      io << self
    end
  end

  # AB から見て BC が左に曲がる   : +1
  # AB から見て BC が右に曲がる   : -1
  # ABC, CBA の順に一直線上に並ぶ : +2
  # ACB, BCA の順に一直線上に並ぶ :  0
  # BAC, CAB の順に一直線上に並ぶ : -2
  def iSP(a : Vec2, b : Vec2, c : Vec2) : Int32
    x = (b - a).cross(c - a).sgn
    if x != 0
      x
    elsif (b - a).dot(c - b).sgn > 0
      2
    elsif (a - b).dot(c - a).sgn > 0
      -2
    else
      0
    end
  end

  def distance(v1 : Vec2, v2 : Vec2)
    Math.hypot(v1.x - v2.x, v1.y - v2.y)
  end

  def distance(v : Vec2, c : Circle)
    (distance(v, c.center) - c.radious).abs
  end

  def distance(c1 : Circle, c2 : Circle)
    d = distance(c1.center, c2.center)
    r = c1.radious + c2.radious
    if d > r
      d - r
    elsif d + c1.radious < c2.radious
      c2.radious - (d + c1.radious)
    elsif d + c2.radious < c1.radious
      c1.radious - (d + c2.radious)
    else
      Real.zero
    end
  end

  macro delegate_method(method, type1, type2)
		def {{method}}(object1 : {{type1}}, object2 : {{type2}})
			{{method}}(object2, object1)
		end
	end

  delegate_method(distance, Circle, Vec2)
end
