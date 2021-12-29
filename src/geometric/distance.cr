require "./real"
require "./object/*"

module Geometric
  extend self

  def distance(v1 : Vec2, v2 : Vec2) : Real
    Math.hypot(v1.x - v2.x, v1.y - v2.y)
  end

  def distance(v : Vec2, c : Circle) : Real
    (distance(v, c.center) - c.radious).abs
  end

  def distance(v : Vec2, l : Line) : Real
    (l.vec.cross(v - l.begin) / l.vec.length).abs
  end

  def distance(v : Vec2, s : Segment) : Real
    if s.vec.dot(v - s.begin).sign < 0
      distance(v, s.begin)
    elsif s.counter_vec.dot(v - s.end).sign < 0
      distance(v, s.end)
    else
      distance(v, Line.new(s.begin, s.end))
    end
  end

  def distance(c1 : Circle, c2 : Circle) : Real
    d = distance(c1.center, c2.center)
    r = c1.radious + c2.radious
    if (d <=> r) > 0
      d - r
    elsif (d + c1.radious <=> c2.radious) < 0
      c2.radious - (d + c1.radious)
    elsif (d + c2.radious <=> c1.radious) < 0
      c1.radious - (d + c2.radious)
    else
      Real.zero
    end
  end

  def distance(obj1, obj2) : Real
    distance(obj2, obj1)
  end
end
