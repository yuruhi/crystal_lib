---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/geometric/real.cr
    title: src/geometric/real.cr
  _extendedRequiredBy:
  - icon: ':warning:'
    path: src/geometric.cr
    title: src/geometric.cr
  - icon: ':warning:'
    path: src/geometric/distance.cr
    title: src/geometric/distance.cr
  - icon: ':warning:'
    path: src/geometric/intersect.cr
    title: src/geometric/intersect.cr
  - icon: ':warning:'
    path: src/geometric/object/line.cr
    title: src/geometric/object/line.cr
  - icon: ':warning:'
    path: src/geometric/utility.cr
    title: src/geometric/utility.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "# require \"../real\"\nrequire \"big\"\n\nalias Real = BigFloat\n\
    EPS = Real.new(1e-12)\n\nstruct Real\n  def <=>(other : Real)\n    {% if Real\
    \ == BigFloat %}\n      if previous_def(other - EPS) < 0\n        -1\n      elsif\
    \ previous_def(other + EPS) > 0\n        1\n      else\n        0\n      end\n\
    \    {% else %}\n      if self < other - EPS\n        -1\n      elsif self > other\
    \ + EPS\n        1\n      else\n        0\n      end\n    {% end %}\n  end\n\n\
    \  def sign : Int32\n    self < -EPS ? -1 : self > EPS ? 1 : 0\n  end\n\n  def\
    \ to_radian\n    self * Math::PI / 180\n  end\n\n  def to_degree\n    self * 180\
    \ / Math::PI\n  end\n\n  def self.scan(scanner, io : IO) : self\n    Real.new\
    \ scanner.s(io)\n  end\nend\n\nmodule Geometric\n  struct Vec2\n    include Comparable(Vec2)\n\
    \n    property x : Real, y : Real\n\n    def self.zero\n      Vec2.new(Real.zero,\
    \ Real.zero)\n    end\n\n    def initialize(x, y)\n      @x, @y = Real.new(x),\
    \ Real.new(y)\n    end\n\n    def self.scan(scanner, io : IO) : self\n      Vec2.new(scanner.f(io),\
    \ scanner.f(io))\n    end\n\n    def +\n      self\n    end\n\n    def -\n   \
    \   Vec2.new(-x, -y)\n    end\n\n    {% for op in %w[+ - * /] %}\n      def {{op.id}}(other\
    \ : Vec2)\n        Vec2.new(x {{op.id}} other.x, y {{op.id}} other.y)\n      end\n\
    \n      def {{op.id}}(other)\n        Vec2.new(x {{op.id}} other, y {{op.id}}\
    \ other)\n      end\n    {% end %}\n\n    def <=>(other : Vec2)\n      x_cmp =\
    \ x <=> other.x\n      if x_cmp != 0\n        x_cmp\n      else\n        y <=>\
    \ other.y\n      end\n    end\n\n    def [](index : Int)\n      return x if index\
    \ == 0\n      return y if index == 1\n      raise IndexError.new\n    end\n\n\
    \    def length : Real\n      Math.hypot(x, y)\n    end\n\n    def dot(other :\
    \ Vec2) : Real\n      x * other.x + y * other.y\n    end\n\n    def cross(other\
    \ : Vec2) : Real\n      x * other.y - y * other.x\n    end\n\n    def angle :\
    \ Real\n      Real.new Math.atan2(y, x)\n    end\n\n    def rotate(rad : Real)\
    \ : Vec2\n      c, s = Math.cos(rad), Math.sin(rad)\n      Vec2.new(x * c - y\
    \ * s, x * s + y * c)\n    end\n\n    def to_tuple\n      {x, y}\n    end\n\n\
    \    def inspect(io : IO)\n      io << '(' << x << \", \" << y << ')'\n    end\n\
    \  end\nend\n"
  code: "require \"../real\"\n\nmodule Geometric\n  struct Vec2\n    include Comparable(Vec2)\n\
    \n    property x : Real, y : Real\n\n    def self.zero\n      Vec2.new(Real.zero,\
    \ Real.zero)\n    end\n\n    def initialize(x, y)\n      @x, @y = Real.new(x),\
    \ Real.new(y)\n    end\n\n    def self.scan(scanner, io : IO) : self\n      Vec2.new(scanner.f(io),\
    \ scanner.f(io))\n    end\n\n    def +\n      self\n    end\n\n    def -\n   \
    \   Vec2.new(-x, -y)\n    end\n\n    {% for op in %w[+ - * /] %}\n      def {{op.id}}(other\
    \ : Vec2)\n        Vec2.new(x {{op.id}} other.x, y {{op.id}} other.y)\n      end\n\
    \n      def {{op.id}}(other)\n        Vec2.new(x {{op.id}} other, y {{op.id}}\
    \ other)\n      end\n    {% end %}\n\n    def <=>(other : Vec2)\n      x_cmp =\
    \ x <=> other.x\n      if x_cmp != 0\n        x_cmp\n      else\n        y <=>\
    \ other.y\n      end\n    end\n\n    def [](index : Int)\n      return x if index\
    \ == 0\n      return y if index == 1\n      raise IndexError.new\n    end\n\n\
    \    def length : Real\n      Math.hypot(x, y)\n    end\n\n    def dot(other :\
    \ Vec2) : Real\n      x * other.x + y * other.y\n    end\n\n    def cross(other\
    \ : Vec2) : Real\n      x * other.y - y * other.x\n    end\n\n    def angle :\
    \ Real\n      Real.new Math.atan2(y, x)\n    end\n\n    def rotate(rad : Real)\
    \ : Vec2\n      c, s = Math.cos(rad), Math.sin(rad)\n      Vec2.new(x * c - y\
    \ * s, x * s + y * c)\n    end\n\n    def to_tuple\n      {x, y}\n    end\n\n\
    \    def inspect(io : IO)\n      io << '(' << x << \", \" << y << ')'\n    end\n\
    \  end\nend\n"
  dependsOn:
  - src/geometric/real.cr
  isVerificationFile: false
  path: src/geometric/object/vec2.cr
  requiredBy:
  - src/geometric.cr
  - src/geometric/object/line.cr
  - src/geometric/distance.cr
  - src/geometric/intersect.cr
  - src/geometric/utility.cr
  timestamp: '2022-01-08 20:40:08+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/geometric/object/vec2.cr
layout: document
redirect_from:
- /library/src/geometric/object/vec2.cr
- /library/src/geometric/object/vec2.cr.html
title: src/geometric/object/vec2.cr
---
