require "../real"

module Geometric
  struct Vec2
    include Comparable(Vec2)

    property x : Real, y : Real

    def self.zero
      Vec2.new(Real.zero, Real.zero)
    end

    def initialize(x, y)
      @x, @y = Real.new(x), Real.new(y)
    end

    def +
      self
    end

    def -
      Vec2.new(-x, -y)
    end

    {% for op in %w[+ - * /] %}
      def {{op.id}}(other : Vec2)
        Vec2.new(x {{op.id}} other.x, y {{op.id}} other.y)
      end

      def {{op.id}}(other)
        Vec2.new(x {{op.id}} other, y {{op.id}} other)
      end
    {% end %}

    def <=>(other : Vec2)
      x_cmp = x <=> other.x
      if x_cmp != 0
        x_cmp
      else
        y <=> other.y
      end
    end

    def [](index : Int)
      return x if index == 0
      return y if index == 1
      raise IndexError.new
    end

    def length : Real
      Math.hypot(x, y)
    end

    def dot(other : Vec2) : Real
      x * other.x + y * other.y
    end

    def cross(other : Vec2) : Real
      x * other.y - y * other.x
    end

    def angle : Real
      Real.new Math.atan2(y, x)
    end

    def rotate(rad : Real) : Vec2
      c, s = Math.cos(rad), Math.sin(rad)
      Vec2.new(x * c - y * s, x * s + y * c)
    end

    def to_tuple
      {x, y}
    end

    def inspect(io : IO)
      io << '(' << x << ", " << y << ')'
    end
  end
end
