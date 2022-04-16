---
data:
  _extendedDependsOn: []
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
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "module Geometric\n  class Polygon < Array(Vec2)\n    def initialize(points\
    \ : Array(Vec2))\n      initialize(points.size)\n      concat points\n    end\n\
    \n    def initialize\n      super\n    end\n\n    def initialize(initial_capacity\
    \ : Int)\n      super\n    end\n\n    def initialize(size : Int, &block : Int32\
    \ -> Vec2)\n      initialize(size)\n      size.to_i.times do |i|\n        self\
    \ << yield i\n      end\n    end\n\n    def after(i : Int32) : Vec2\n      self[i\
    \ != size - 1 ? i + 1 : 0]\n    end\n\n    def area : Real\n      (0...size).sum\
    \ { |i|\n        self[i].cross after(i)\n      }.abs / 2\n    end\n\n    def centroid\
    \ : Vec2\n      sum / size\n    end\n\n    def contains?(v : Vec2)\n      (0...size).count\
    \ { |i|\n        p1, p2 = {self[i], after(i)}.minmax_by &.y\n        (p1.y <=>\
    \ v.y) <= 0 && (v.y <=> p2.y) < 0 && (p1 - v).cross(p2 - v).sign == -1\n     \
    \ }.odd?\n    end\n\n    def convex_hull : Polygon\n      result = Polygon.new\n\
    \      points = sort\n      points.each do |point|\n        while result.size\
    \ >= 2 && Geometric.ccw(result[-2], result[-1], point) != -1\n          result.pop\n\
    \        end\n        result << point\n      end\n      t = result.size + 1\n\
    \      (0...points.size - 1).reverse_each do |i|\n        while result.size >=\
    \ t && Geometric.ccw(result[-2], result[-1], points[i]) != -1\n          result.pop\n\
    \        end\n        result << points[i]\n      end\n      result.pop\n     \
    \ result\n    end\n\n    def inspect(io)\n      io << self\n    end\n  end\nend\n"
  code: "module Geometric\n  class Polygon < Array(Vec2)\n    def initialize(points\
    \ : Array(Vec2))\n      initialize(points.size)\n      concat points\n    end\n\
    \n    def initialize\n      super\n    end\n\n    def initialize(initial_capacity\
    \ : Int)\n      super\n    end\n\n    def initialize(size : Int, &block : Int32\
    \ -> Vec2)\n      initialize(size)\n      size.to_i.times do |i|\n        self\
    \ << yield i\n      end\n    end\n\n    def after(i : Int32) : Vec2\n      self[i\
    \ != size - 1 ? i + 1 : 0]\n    end\n\n    def area : Real\n      (0...size).sum\
    \ { |i|\n        self[i].cross after(i)\n      }.abs / 2\n    end\n\n    def centroid\
    \ : Vec2\n      sum / size\n    end\n\n    def contains?(v : Vec2)\n      (0...size).count\
    \ { |i|\n        p1, p2 = {self[i], after(i)}.minmax_by &.y\n        (p1.y <=>\
    \ v.y) <= 0 && (v.y <=> p2.y) < 0 && (p1 - v).cross(p2 - v).sign == -1\n     \
    \ }.odd?\n    end\n\n    def convex_hull : Polygon\n      result = Polygon.new\n\
    \      points = sort\n      points.each do |point|\n        while result.size\
    \ >= 2 && Geometric.ccw(result[-2], result[-1], point) != -1\n          result.pop\n\
    \        end\n        result << point\n      end\n      t = result.size + 1\n\
    \      (0...points.size - 1).reverse_each do |i|\n        while result.size >=\
    \ t && Geometric.ccw(result[-2], result[-1], points[i]) != -1\n          result.pop\n\
    \        end\n        result << points[i]\n      end\n      result.pop\n     \
    \ result\n    end\n\n    def inspect(io)\n      io << self\n    end\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/geometric/object/polygon.cr
  requiredBy:
  - src/geometric.cr
  - src/geometric/distance.cr
  - src/geometric/intersect.cr
  timestamp: '2022-04-16 07:49:21+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/geometric/object/polygon.cr
layout: document
redirect_from:
- /library/src/geometric/object/polygon.cr
- /library/src/geometric/object/polygon.cr.html
title: src/geometric/object/polygon.cr
---
