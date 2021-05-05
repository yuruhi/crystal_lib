module Geometric
  extend self

  struct Vec2
    property x : Float64
    property y : Float64

    def self.zero
      Vec2.new(0.0, 0.0)
    end

    def initialize(@x, @y)
    end

    def inspect(io : IO)
      io << '(' << x << ", " << y << ')'
    end
  end

  struct Circle
    property center : Vec2
    property radious : Float64

    def initialize(@center, @radious)
    end

    def initialize(x : Float64, y : Float64, @radious)
      @center = Vec2.new(x, y)
    end

    def x
      center.x
    end

    def y
      center.y
    end

    def inspect(io : IO)
      io << '(' << center << ", " << radious << ')'
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
      0.0
    end
  end

  macro delegate_method(method, type1, type2)
		def {{method}}(object1 : {{type1}}, object2 : {{type2}})
			{{method}}(object2, object1)
		end
	end

  delegate_method(distance, Circle, Vec2)
end
