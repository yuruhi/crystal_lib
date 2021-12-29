---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/geometric/object/circle.cr
    title: src/geometric/object/circle.cr
  - icon: ':warning:'
    path: src/geometric/object/line.cr
    title: src/geometric/object/line.cr
  - icon: ':warning:'
    path: src/geometric/object/polygon.cr
    title: src/geometric/object/polygon.cr
  - icon: ':warning:'
    path: src/geometric/object/vec2.cr
    title: src/geometric/object/vec2.cr
  - icon: ':warning:'
    path: src/geometric/real.cr
    title: src/geometric/real.cr
  _extendedRequiredBy:
  - icon: ':warning:'
    path: src/geometric.cr
    title: src/geometric.cr
  - icon: ':warning:'
    path: src/geometric/intersect.cr
    title: src/geometric/intersect.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "# require \"./real\"\nrequire \"big\"\n\nalias Real = BigFloat\nEPS\
    \ = Real.new(1e-12)\n\nstruct Real\n  def <=>(other : Real)\n    {% if Real ==\
    \ BigFloat %}\n      if previous_def(other - EPS) < 0\n        -1\n      elsif\
    \ previous_def(other + EPS) > 0\n        1\n      else\n        0\n      end\n\
    \    {% else %}\n      if self < other - EPS\n        -1\n      elsif self > other\
    \ + EPS\n        1\n      else\n        0\n      end\n    {% end %}\n  end\n\n\
    \  def sign : Int32\n    self < -EPS ? -1 : self > EPS ? 1 : 0\n  end\n\n  def\
    \ to_radian\n    self * Math::PI / 180\n  end\n\n  def to_degree\n    self * 180\
    \ / Math::PI\n  end\nend\n\n# require \"./object/*\"\nmodule Geometric\n  struct\
    \ Circle\n    property center : Vec2, radious : Real\n\n    def initialize(center\
    \ : Vec2, radious)\n      @center, @radious = center, Real.new(radious)\n    end\n\
    \n    def initialize(x, y, radious)\n      initialize(Vec2.new(x, y), radious)\n\
    \    end\n\n    delegate x, y, to: center\n\n    {% for op in %w[+ - * /] %}\n\
    \      def {{op.id}}(other : Vec2)\n        Circel.new(x {{op.id}} other.x, y\
    \ {{op.id}} other.y, radious)\n      end\n\n      def {{op.id}}(other : Real)\n\
    \        Circle.new(x {{op.id}} other, y {{op.id}} other, radious)\n      end\n\
    \    {% end %}\n\n    def area : Real\n      radious * radious * Math::PI\n  \
    \  end\n\n    def contains?(v : Vec2)\n      ((v - center).length <=> radious)\
    \ < 0\n    end\n\n    def inspect(io : IO)\n      io << '(' << center << \", \"\
    \ << radious << ')'\n    end\n  end\nend\n\n# require \"../real\"\n\n# require\
    \ \"./vec2\"\n# require \"../real\"\n\nmodule Geometric\n  struct Vec2\n    include\
    \ Comparable(Vec2)\n\n    property x : Real, y : Real\n\n    def self.zero\n \
    \     Vec2.new(Real.zero, Real.zero)\n    end\n\n    def initialize(x, y)\n  \
    \    @x, @y = Real.new(x), Real.new(y)\n    end\n\n    def +\n      self\n   \
    \ end\n\n    def -\n      Vec2.new(-x, -y)\n    end\n\n    {% for op in %w[+ -\
    \ * /] %}\n      def {{op.id}}(other : Vec2)\n        Vec2.new(x {{op.id}} other.x,\
    \ y {{op.id}} other.y)\n      end\n\n      def {{op.id}}(other)\n        Vec2.new(x\
    \ {{op.id}} other, y {{op.id}} other)\n      end\n    {% end %}\n\n    def <=>(other\
    \ : Vec2)\n      x_cmp = x <=> other.x\n      if x_cmp != 0\n        x_cmp\n \
    \     else\n        y <=> other.y\n      end\n    end\n\n    def [](index : Int)\n\
    \      return x if index == 0\n      return y if index == 1\n      raise IndexError.new\n\
    \    end\n\n    def length : Real\n      Math.hypot(x, y)\n    end\n\n    def\
    \ dot(other : Vec2) : Real\n      x * other.x + y * other.y\n    end\n\n    def\
    \ cross(other : Vec2) : Real\n      x * other.y - y * other.x\n    end\n\n   \
    \ def angle : Real\n      Real.new Math.atan2(y, x)\n    end\n\n    def rotate(rad\
    \ : Real) : Vec2\n      c, s = Math.cos(rad), Math.sin(rad)\n      Vec2.new(x\
    \ * c - y * s, x * s + y * c)\n    end\n\n    def to_tuple\n      {x, y}\n   \
    \ end\n\n    def inspect(io : IO)\n      io << '(' << x << \", \" << y << ')'\n\
    \    end\n\n    def self.scan(scanner) : self\n      Vec2.new(scanner.f, scanner.f)\n\
    \    end\n  end\nend\n\nmodule Geometric\n  private module LineBase\n    getter\
    \ begin : Vec2, end : Vec2\n\n    def initialize(@begin, @end)\n    end\n\n  \
    \  def initialize(begin_x, begin_y, end_x, end_y)\n      @begin = Vec2.new(begin_x,\
    \ begin_y)\n      @end = Vec2.new(end_x, end_y)\n    end\n\n    def +(v : Vec2)\n\
    \      self.class.new(@begin + v, @end + v)\n    end\n\n    def -(v : Vec2)\n\
    \      self.class.new(@begin - v, @end - v)\n    end\n\n    def vec\n      @end\
    \ - @begin\n    end\n\n    def counter_vec\n      @begin - @end\n    end\n\n \
    \   def parallel?(other : LineBase)\n      vec.cross(other.vec).sign == 0\n  \
    \  end\n\n    def orthogonal?(other : LineBase)\n      vec.dot(other.vec).sign\
    \ == 0\n    end\n\n    def to_tuple\n      {@begin, @end}\n    end\n\n    def\
    \ inspect(io : IO) : Nil\n      io << '(' << @begin << \", \" << @end << ')'\n\
    \    end\n  end\n\n  struct Line\n    include LineBase\n  end\n\n  struct Segment\n\
    \    include LineBase\n  end\nend\n\nmodule Geometric\n  class Polygon < Array(Vec2)\n\
    \    def initialize(points : Array(Vec2))\n      initialize(points.size)\n   \
    \   concat points\n    end\n\n    def initialize\n      super\n    end\n\n   \
    \ def initialize(initial_capacity : Int)\n      super\n    end\n\n    def initialize(size\
    \ : Int, &block : Int32 -> Vec2)\n      initialize(size)\n      size.to_i.times\
    \ do |i|\n        self << yield i\n      end\n    end\n\n    def after(i : Int32)\
    \ : Vec2\n      self[i != size - 1 ? i + 1 : 0]\n    end\n\n    def area : Real\n\
    \      (0...size).sum { |i|\n        self[i].cross after(i)\n      }.abs / 2\n\
    \    end\n\n    def centroid : Vec2\n      sum / size\n    end\n\n    def contains?(v\
    \ : Vec2)\n      (0...size).count { |i|\n        p1, p2 = {self[i], after(i)}.minmax_by\
    \ &.y\n        (p1.y <=> v.y) <= 0 && (v.y <=> p2.y) < 0 && (p1 - v).cross(p2\
    \ - v).sign == -1\n      }.odd?\n    end\n\n    def convex_hull : Polygon\n  \
    \    result = Polygon.new\n      points = sort\n      points.each do |point|\n\
    \        while result.size >= 2 && Geometric.ccw(result[-2], result[-1], point)\
    \ != -1\n          result.pop\n        end\n        result << point\n      end\n\
    \      t = result.size + 1\n      (0...points.size - 1).reverse_each do |i|\n\
    \        while result.size >= t && Geometric.ccw(result[-2], result[-1], points[i])\
    \ != -1\n          result.pop\n        end\n        result << points[i]\n    \
    \  end\n      result.pop\n      result\n    end\n\n    def inspect(io)\n     \
    \ io << self\n    end\n  end\nend\n\nmodule Geometric\n  extend self\n\n  def\
    \ distance(v1 : Vec2, v2 : Vec2) : Real\n    Math.hypot(v1.x - v2.x, v1.y - v2.y)\n\
    \  end\n\n  def distance(v : Vec2, c : Circle) : Real\n    (distance(v, c.center)\
    \ - c.radious).abs\n  end\n\n  def distance(v : Vec2, l : Line) : Real\n    (l.vec.cross(v\
    \ - l.begin) / l.vec.length).abs\n  end\n\n  def distance(v : Vec2, s : Segment)\
    \ : Real\n    if s.vec.dot(v - s.begin).sign < 0\n      distance(v, s.begin)\n\
    \    elsif s.counter_vec.dot(v - s.end).sign < 0\n      distance(v, s.end)\n \
    \   else\n      distance(v, Line.new(s.begin, s.end))\n    end\n  end\n\n  def\
    \ distance(c1 : Circle, c2 : Circle) : Real\n    d = distance(c1.center, c2.center)\n\
    \    r = c1.radious + c2.radious\n    if (d <=> r) > 0\n      d - r\n    elsif\
    \ (d + c1.radious <=> c2.radious) < 0\n      c2.radious - (d + c1.radious)\n \
    \   elsif (d + c2.radious <=> c1.radious) < 0\n      c1.radious - (d + c2.radious)\n\
    \    else\n      Real.zero\n    end\n  end\n\n  def distance(obj1, obj2) : Real\n\
    \    distance(obj2, obj1)\n  end\nend\n"
  code: "require \"./real\"\nrequire \"./object/*\"\n\nmodule Geometric\n  extend\
    \ self\n\n  def distance(v1 : Vec2, v2 : Vec2) : Real\n    Math.hypot(v1.x - v2.x,\
    \ v1.y - v2.y)\n  end\n\n  def distance(v : Vec2, c : Circle) : Real\n    (distance(v,\
    \ c.center) - c.radious).abs\n  end\n\n  def distance(v : Vec2, l : Line) : Real\n\
    \    (l.vec.cross(v - l.begin) / l.vec.length).abs\n  end\n\n  def distance(v\
    \ : Vec2, s : Segment) : Real\n    if s.vec.dot(v - s.begin).sign < 0\n      distance(v,\
    \ s.begin)\n    elsif s.counter_vec.dot(v - s.end).sign < 0\n      distance(v,\
    \ s.end)\n    else\n      distance(v, Line.new(s.begin, s.end))\n    end\n  end\n\
    \n  def distance(c1 : Circle, c2 : Circle) : Real\n    d = distance(c1.center,\
    \ c2.center)\n    r = c1.radious + c2.radious\n    if (d <=> r) > 0\n      d -\
    \ r\n    elsif (d + c1.radious <=> c2.radious) < 0\n      c2.radious - (d + c1.radious)\n\
    \    elsif (d + c2.radious <=> c1.radious) < 0\n      c1.radious - (d + c2.radious)\n\
    \    else\n      Real.zero\n    end\n  end\n\n  def distance(obj1, obj2) : Real\n\
    \    distance(obj2, obj1)\n  end\nend\n"
  dependsOn:
  - src/geometric/real.cr
  - src/geometric/object/circle.cr
  - src/geometric/object/line.cr
  - src/geometric/object/vec2.cr
  - src/geometric/object/polygon.cr
  isVerificationFile: false
  path: src/geometric/distance.cr
  requiredBy:
  - src/geometric.cr
  - src/geometric/intersect.cr
  timestamp: '2021-12-29 22:16:01+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/geometric/distance.cr
layout: document
redirect_from:
- /library/src/geometric/distance.cr
- /library/src/geometric/distance.cr.html
title: src/geometric/distance.cr
---
