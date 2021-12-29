module Geometric
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

    def initialize(size : Int, &block : Int32 -> Vec2)
      initialize(size)
      size.to_i.times do |i|
        self << yield i
      end
    end

    def after(i : Int32) : Vec2
      self[i != size - 1 ? i + 1 : 0]
    end

    def area : Real
      (0...size).sum { |i|
        self[i].cross after(i)
      }.abs / 2
    end

    def centroid : Vec2
      sum / size
    end

    def contains?(v : Vec2)
      (0...size).count { |i|
        p1, p2 = {self[i], after(i)}.minmax_by &.y
        (p1.y <=> v.y) <= 0 && (v.y <=> p2.y) < 0 && (p1 - v).cross(p2 - v).sign == -1
      }.odd?
    end

    def convex_hull : Polygon
      result = Polygon.new
      points = sort
      points.each do |point|
        while result.size >= 2 && Geometric.ccw(result[-2], result[-1], point) != -1
          result.pop
        end
        result << point
      end
      t = result.size + 1
      (0...points.size - 1).reverse_each do |i|
        while result.size >= t && Geometric.ccw(result[-2], result[-1], points[i]) != -1
          result.pop
        end
        result << points[i]
      end
      result.pop
      result
    end

    def inspect(io)
      io << self
    end
  end
end
