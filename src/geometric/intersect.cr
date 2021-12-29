require "./real"
require "./object/*"
require "./distance"

module Geometric
  extend self

  def intersect?(c1 : Circle, c2 : Circle)
    (distance(c1.center, c2.center) <=> (c1.radious + c2.radious)) < 0
  end

  def intersect?(l1 : Line, l2 : Line)
    !l1.parallel?(l2)
  end

  def intersect?(s1 : Segment, s2 : Segment)
    ccw(s1.begin, s1.end, s2.begin) * ccw(s1.begin, s1.end, s2.end) <= 0 &&
      ccw(s2.begin, s2.end, s1.begin) * ccw(s2.begin, s2.end, s1.end) <= 0
  end
end
