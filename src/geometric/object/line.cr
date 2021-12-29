require "../real"
require "./vec2"

module Geometric
  private module LineBase
    getter begin : Vec2, end : Vec2

    def initialize(@begin, @end)
    end

    def initialize(begin_x, begin_y, end_x, end_y)
      @begin = Vec2.new(begin_x, begin_y)
      @end = Vec2.new(end_x, end_y)
    end

    def +(v : Vec2)
      self.class.new(@begin + v, @end + v)
    end

    def -(v : Vec2)
      self.class.new(@begin - v, @end - v)
    end

    def vec
      @end - @begin
    end

    def counter_vec
      @begin - @end
    end

    def parallel?(other : LineBase)
      vec.cross(other.vec).sign == 0
    end

    def orthogonal?(other : LineBase)
      vec.dot(other.vec).sign == 0
    end

    def to_tuple
      {@begin, @end}
    end

    def inspect(io : IO) : Nil
      io << '(' << @begin << ", " << @end << ')'
    end
  end

  struct Line
    include LineBase
  end

  struct Segment
    include LineBase
  end
end
