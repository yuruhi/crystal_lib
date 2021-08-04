---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"big\"\n\nalias Real = BigFloat\nEPS = Real.new(1e-12)\n\n\
    struct Real\n  def <=>(other : Real)\n    {% if Real == BigFloat %}\n      if\
    \ previous_def(other - EPS) < 0\n        -1\n      elsif previous_def(other +\
    \ EPS) > 0\n        1\n      else\n        0\n      end\n    {% else %}\n    \
    \  if self < other - EPS\n        -1\n      elsif self > other + EPS\n       \
    \ 1\n      else\n        0\n      end\n    {% end %}\n  end\n\n  def sgn : Int32\n\
    \    self < -EPS ? -1 : self > EPS ? 1 : 0\n  end\n\n  def to_radian\n    self\
    \ * Math::PI / 180\n  end\n\n  def to_degree\n    self * 180 / Math::PI\n  end\n\
    end\n\nmodule Geometric\n  extend self\n\n  struct Vec2\n    include Comparable(Vec2)\n\
    \n    property x : Real, y : Real\n\n    def self.zero\n      Vec2.new(Real.zero,\
    \ Real.zero)\n    end\n\n    def initialize(x, y)\n      @x, @y = Real.new(x),\
    \ Real.new(y)\n    end\n\n    def +\n      self\n    end\n\n    def -\n      Vec2.new(-x,\
    \ -y)\n    end\n\n    {% for op in %w[+ - * /] %}\n      def {{op.id}}(other :\
    \ Vec2)\n        Vec2.new(x {{op.id}} other.x, y {{op.id}} other.y)\n      end\n\
    \n      def {{op.id}}(other)\n        Vec2.new(x {{op.id}} other, y {{op.id}}\
    \ other)\n      end\n    {% end %}\n\n    def <=>(other : Vec2)\n      x_cmp =\
    \ x <=> other.x\n      if x_cmp != 0\n        x_cmp\n      else\n        y <=>\
    \ other.y\n      end\n    end\n\n    def [](index : Int)\n      return x if index\
    \ == 0\n      return y if index == 1\n      raise IndexError.new\n    end\n\n\
    \    def dot(other : Vec2)\n      x * other.y - y * other.x\n    end\n\n    def\
    \ cross(other : Vec2)\n      x * other.y - y * other.x\n    end\n\n    def angle\
    \ : Real\n      Real.new Math.atan2(y, x)\n    end\n\n    def rotate(rad : Real)\
    \ : Vec2\n      c, s = Math.cos(rad), Math.sin(rad)\n      Vec2.new(x * c - y\
    \ * s, x * s + y * c)\n    end\n\n    def inspect(io : IO)\n      io << '(' <<\
    \ x << \", \" << y << ')'\n    end\n  end\n\n  struct Circle\n    property center\
    \ : Vec2, radious : Real\n\n    def initialize(center : Vec2, radious)\n     \
    \ @center, @radious = center, Real.new(radious)\n    end\n\n    def initialize(x,\
    \ y, radious)\n      initialize(Vec2.new(x, y), radious)\n    end\n\n    delegate\
    \ x, to: center\n    delegate y, to: center\n\n    {% for op in %w[+ - * /] %}\n\
    \      def {{op.id}}(other : Vec2)\n        Circel.new(x {{op.id}} other.x, y\
    \ {{op.id}} other.y, radious)\n      end\n\n      def {{op.id}}(other : Real)\n\
    \        Circle.new(x {{op.id}} other, y {{op.id}} other, radious)\n      end\n\
    \    {% end %}\n\n    def inspect(io : IO)\n      io << '(' << center << \", \"\
    \ << radious << ')'\n    end\n  end\n\n  class Polygon < Array(Vec2)\n    def\
    \ initialize(points : Array(Vec2))\n      initialize(points.size)\n      concat\
    \ points\n    end\n\n    def initialize\n      super\n    end\n\n    def initialize(initial_capacity\
    \ : Int)\n      super\n    end\n\n    def initialize(size : Int, &block : Int32\
    \ -> Vec2)\n      initialize(size)\n      size.to_i.times do |i|\n        self\
    \ << yield i\n      end\n    end\n\n    def after(i : Int32) : Vec2\n      self[i\
    \ != size - 1 ? i + 1 : 0]\n    end\n\n    def area : Real\n      (0...size).sum\
    \ { |i|\n        self[i].cross after(i)\n      }.abs / 2\n    end\n\n    def centroid\
    \ : Vec2\n      sum / size\n    end\n\n    def convex_hull : Polygon\n      result\
    \ = Polygon.new\n      points = sort\n      points.each do |point|\n        while\
    \ result.size >= 2 && Geometric.ccw(result[-2], result[-1], point) != -1\n   \
    \       result.pop\n        end\n        result << point\n      end\n      t =\
    \ result.size + 1\n      (0...points.size - 1).reverse_each do |i|\n        while\
    \ result.size >= t && Geometric.ccw(result[-2], result[-1], points[i]) != -1\n\
    \          result.pop\n        end\n        result << points[i]\n      end\n \
    \     result.pop\n      result\n    end\n\n    def inspect(io)\n      io << self\n\
    \    end\n  end\n\n  # AB \u304B\u3089\u898B\u3066 BC \u304C\u5DE6\u306B\u66F2\
    \u304C\u308B   : `+1`\n  #\n  # AB \u304B\u3089\u898B\u3066 BC \u304C\u53F3\u306B\
    \u66F2\u304C\u308B   : `-1`\n  #\n  # ABC, CBA \u306E\u9806\u306B\u4E00\u76F4\u7DDA\
    \u4E0A\u306B\u4E26\u3076 : `+2`\n  #\n  # ACB, BCA \u306E\u9806\u306B\u4E00\u76F4\
    \u7DDA\u4E0A\u306B\u4E26\u3076 :  `0`\n  #\n  # BAC, CAB \u306E\u9806\u306B\u4E00\
    \u76F4\u7DDA\u4E0A\u306B\u4E26\u3076 : `-2`\n  def ccw(a : Vec2, b : Vec2, c :\
    \ Vec2) : Int32\n    x = (b - a).cross(c - a).sgn\n    if x != 0\n      x\n  \
    \  elsif (b - a).dot(c - b).sgn > 0\n      2\n    elsif (a - b).dot(c - a).sgn\
    \ > 0\n      -2\n    else\n      0\n    end\n  end\n\n  # Calclates the angle\
    \ of `\u2220abc`\n  def angle(a : Vec2, b : Vec2, c : Vec2)\n    (c - b).rotate(-(a\
    \ - b).angle).angle\n  end\n\n  def distance(v1 : Vec2, v2 : Vec2)\n    Math.hypot(v1.x\
    \ - v2.x, v1.y - v2.y)\n  end\n\n  def distance(v : Vec2, c : Circle)\n    (distance(v,\
    \ c.center) - c.radious).abs\n  end\n\n  def distance(c1 : Circle, c2 : Circle)\n\
    \    d = distance(c1.center, c2.center)\n    r = c1.radious + c2.radious\n   \
    \ if d > r\n      d - r\n    elsif d + c1.radious < c2.radious\n      c2.radious\
    \ - (d + c1.radious)\n    elsif d + c2.radious < c1.radious\n      c1.radious\
    \ - (d + c2.radious)\n    else\n      Real.zero\n    end\n  end\n\n  macro delegate_method(method,\
    \ type1, type2)\n    def {{method}}(object1 : {{type1}}, object2 : {{type2}})\n\
    \      {{method}}(object2, object1)\n    end\n  end\n\n  delegate_method(distance,\
    \ Circle, Vec2)\nend\n"
  code: "require \"big\"\n\nalias Real = BigFloat\nEPS = Real.new(1e-12)\n\nstruct\
    \ Real\n  def <=>(other : Real)\n    {% if Real == BigFloat %}\n      if previous_def(other\
    \ - EPS) < 0\n        -1\n      elsif previous_def(other + EPS) > 0\n        1\n\
    \      else\n        0\n      end\n    {% else %}\n      if self < other - EPS\n\
    \        -1\n      elsif self > other + EPS\n        1\n      else\n        0\n\
    \      end\n    {% end %}\n  end\n\n  def sgn : Int32\n    self < -EPS ? -1 :\
    \ self > EPS ? 1 : 0\n  end\n\n  def to_radian\n    self * Math::PI / 180\n  end\n\
    \n  def to_degree\n    self * 180 / Math::PI\n  end\nend\n\nmodule Geometric\n\
    \  extend self\n\n  struct Vec2\n    include Comparable(Vec2)\n\n    property\
    \ x : Real, y : Real\n\n    def self.zero\n      Vec2.new(Real.zero, Real.zero)\n\
    \    end\n\n    def initialize(x, y)\n      @x, @y = Real.new(x), Real.new(y)\n\
    \    end\n\n    def +\n      self\n    end\n\n    def -\n      Vec2.new(-x, -y)\n\
    \    end\n\n    {% for op in %w[+ - * /] %}\n      def {{op.id}}(other : Vec2)\n\
    \        Vec2.new(x {{op.id}} other.x, y {{op.id}} other.y)\n      end\n\n   \
    \   def {{op.id}}(other)\n        Vec2.new(x {{op.id}} other, y {{op.id}} other)\n\
    \      end\n    {% end %}\n\n    def <=>(other : Vec2)\n      x_cmp = x <=> other.x\n\
    \      if x_cmp != 0\n        x_cmp\n      else\n        y <=> other.y\n     \
    \ end\n    end\n\n    def [](index : Int)\n      return x if index == 0\n    \
    \  return y if index == 1\n      raise IndexError.new\n    end\n\n    def dot(other\
    \ : Vec2)\n      x * other.y - y * other.x\n    end\n\n    def cross(other : Vec2)\n\
    \      x * other.y - y * other.x\n    end\n\n    def angle : Real\n      Real.new\
    \ Math.atan2(y, x)\n    end\n\n    def rotate(rad : Real) : Vec2\n      c, s =\
    \ Math.cos(rad), Math.sin(rad)\n      Vec2.new(x * c - y * s, x * s + y * c)\n\
    \    end\n\n    def inspect(io : IO)\n      io << '(' << x << \", \" << y << ')'\n\
    \    end\n  end\n\n  struct Circle\n    property center : Vec2, radious : Real\n\
    \n    def initialize(center : Vec2, radious)\n      @center, @radious = center,\
    \ Real.new(radious)\n    end\n\n    def initialize(x, y, radious)\n      initialize(Vec2.new(x,\
    \ y), radious)\n    end\n\n    delegate x, to: center\n    delegate y, to: center\n\
    \n    {% for op in %w[+ - * /] %}\n      def {{op.id}}(other : Vec2)\n       \
    \ Circel.new(x {{op.id}} other.x, y {{op.id}} other.y, radious)\n      end\n\n\
    \      def {{op.id}}(other : Real)\n        Circle.new(x {{op.id}} other, y {{op.id}}\
    \ other, radious)\n      end\n    {% end %}\n\n    def inspect(io : IO)\n    \
    \  io << '(' << center << \", \" << radious << ')'\n    end\n  end\n\n  class\
    \ Polygon < Array(Vec2)\n    def initialize(points : Array(Vec2))\n      initialize(points.size)\n\
    \      concat points\n    end\n\n    def initialize\n      super\n    end\n\n\
    \    def initialize(initial_capacity : Int)\n      super\n    end\n\n    def initialize(size\
    \ : Int, &block : Int32 -> Vec2)\n      initialize(size)\n      size.to_i.times\
    \ do |i|\n        self << yield i\n      end\n    end\n\n    def after(i : Int32)\
    \ : Vec2\n      self[i != size - 1 ? i + 1 : 0]\n    end\n\n    def area : Real\n\
    \      (0...size).sum { |i|\n        self[i].cross after(i)\n      }.abs / 2\n\
    \    end\n\n    def centroid : Vec2\n      sum / size\n    end\n\n    def convex_hull\
    \ : Polygon\n      result = Polygon.new\n      points = sort\n      points.each\
    \ do |point|\n        while result.size >= 2 && Geometric.ccw(result[-2], result[-1],\
    \ point) != -1\n          result.pop\n        end\n        result << point\n \
    \     end\n      t = result.size + 1\n      (0...points.size - 1).reverse_each\
    \ do |i|\n        while result.size >= t && Geometric.ccw(result[-2], result[-1],\
    \ points[i]) != -1\n          result.pop\n        end\n        result << points[i]\n\
    \      end\n      result.pop\n      result\n    end\n\n    def inspect(io)\n \
    \     io << self\n    end\n  end\n\n  # AB \u304B\u3089\u898B\u3066 BC \u304C\u5DE6\
    \u306B\u66F2\u304C\u308B   : `+1`\n  #\n  # AB \u304B\u3089\u898B\u3066 BC \u304C\
    \u53F3\u306B\u66F2\u304C\u308B   : `-1`\n  #\n  # ABC, CBA \u306E\u9806\u306B\u4E00\
    \u76F4\u7DDA\u4E0A\u306B\u4E26\u3076 : `+2`\n  #\n  # ACB, BCA \u306E\u9806\u306B\
    \u4E00\u76F4\u7DDA\u4E0A\u306B\u4E26\u3076 :  `0`\n  #\n  # BAC, CAB \u306E\u9806\
    \u306B\u4E00\u76F4\u7DDA\u4E0A\u306B\u4E26\u3076 : `-2`\n  def ccw(a : Vec2, b\
    \ : Vec2, c : Vec2) : Int32\n    x = (b - a).cross(c - a).sgn\n    if x != 0\n\
    \      x\n    elsif (b - a).dot(c - b).sgn > 0\n      2\n    elsif (a - b).dot(c\
    \ - a).sgn > 0\n      -2\n    else\n      0\n    end\n  end\n\n  # Calclates the\
    \ angle of `\u2220abc`\n  def angle(a : Vec2, b : Vec2, c : Vec2)\n    (c - b).rotate(-(a\
    \ - b).angle).angle\n  end\n\n  def distance(v1 : Vec2, v2 : Vec2)\n    Math.hypot(v1.x\
    \ - v2.x, v1.y - v2.y)\n  end\n\n  def distance(v : Vec2, c : Circle)\n    (distance(v,\
    \ c.center) - c.radious).abs\n  end\n\n  def distance(c1 : Circle, c2 : Circle)\n\
    \    d = distance(c1.center, c2.center)\n    r = c1.radious + c2.radious\n   \
    \ if d > r\n      d - r\n    elsif d + c1.radious < c2.radious\n      c2.radious\
    \ - (d + c1.radious)\n    elsif d + c2.radious < c1.radious\n      c1.radious\
    \ - (d + c2.radious)\n    else\n      Real.zero\n    end\n  end\n\n  macro delegate_method(method,\
    \ type1, type2)\n    def {{method}}(object1 : {{type1}}, object2 : {{type2}})\n\
    \      {{method}}(object2, object1)\n    end\n  end\n\n  delegate_method(distance,\
    \ Circle, Vec2)\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/geometric.cr
  requiredBy: []
  timestamp: '2021-08-04 21:18:09+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/geometric.cr
layout: document
redirect_from:
- /library/src/geometric.cr
- /library/src/geometric.cr.html
title: src/geometric.cr
---
