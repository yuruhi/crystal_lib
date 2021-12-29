require "./object/vec2"

module Geometric
  extend self

  #
  #        C [+1]
  #       /
  # A -- B
  #       \
  #        C [-1]
  #
  # A -- B -- C [+2]
  # A -- C -- B [ 0]
  # B -- A -- C [-2]
  #
  def ccw(a : Vec2, b : Vec2, c : Vec2) : Int32
    if (x = (b - a).cross(c - a).sign) != 0
      x
    elsif (b - a).dot(c - b).sign > 0
      2
    elsif (a - b).dot(c - a).sign > 0
      -2
    else
      0
    end
  end

  # Calclates the angle of `∠abc`
  def angle(a : Vec2, b : Vec2, c : Vec2)
    (c - b).rotate(-(a - b).angle).angle
  end
end
