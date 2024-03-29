module Geometric
  struct Circle
    property center : Vec2, radious : Real

    def initialize(center : Vec2, radious)
      @center, @radious = center, Real.new(radious)
    end

    def initialize(x, y, radious)
      initialize(Vec2.new(x, y), radious)
    end

    def self.scan(s, io : IO) : self
      new Real.scan(s, io), Real.scan(s, io), Real.scan(s, io)
    end

    delegate x, y, to: center

    {% for op in %w[+ - * /] %}
      def {{op.id}}(other : Vec2)
        Circel.new(x {{op.id}} other.x, y {{op.id}} other.y, radious)
      end

      def {{op.id}}(other : Real)
        Circle.new(x {{op.id}} other, y {{op.id}} other, radious)
      end
    {% end %}

    def area : Real
      radious * radious * Math::PI
    end

    def contains?(v : Vec2)
      ((v - center).length <=> radious) < 0
    end

    def inspect(io : IO)
      io << '(' << center << ", " << radious << ')'
    end
  end
end
