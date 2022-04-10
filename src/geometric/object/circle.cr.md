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
  bundledCode: "module Geometric\n  struct Circle\n    property center : Vec2, radious\
    \ : Real\n\n    def initialize(center : Vec2, radious)\n      @center, @radious\
    \ = center, Real.new(radious)\n    end\n\n    def initialize(x, y, radious)\n\
    \      initialize(Vec2.new(x, y), radious)\n    end\n\n    def self.scan(s, io\
    \ : IO) : self\n      new Real.scan(s, io), Real.scan(s, io), Real.scan(s, io)\n\
    \    end\n\n    delegate x, y, to: center\n\n    {% for op in %w[+ - * /] %}\n\
    \      def {{op.id}}(other : Vec2)\n        Circel.new(x {{op.id}} other.x, y\
    \ {{op.id}} other.y, radious)\n      end\n\n      def {{op.id}}(other : Real)\n\
    \        Circle.new(x {{op.id}} other, y {{op.id}} other, radious)\n      end\n\
    \    {% end %}\n\n    def area : Real\n      radious * radious * Math::PI\n  \
    \  end\n\n    def contains?(v : Vec2)\n      ((v - center).length <=> radious)\
    \ < 0\n    end\n\n    def inspect(io : IO)\n      io << '(' << center << \", \"\
    \ << radious << ')'\n    end\n  end\nend\n"
  code: "module Geometric\n  struct Circle\n    property center : Vec2, radious :\
    \ Real\n\n    def initialize(center : Vec2, radious)\n      @center, @radious\
    \ = center, Real.new(radious)\n    end\n\n    def initialize(x, y, radious)\n\
    \      initialize(Vec2.new(x, y), radious)\n    end\n\n    def self.scan(s, io\
    \ : IO) : self\n      new Real.scan(s, io), Real.scan(s, io), Real.scan(s, io)\n\
    \    end\n\n    delegate x, y, to: center\n\n    {% for op in %w[+ - * /] %}\n\
    \      def {{op.id}}(other : Vec2)\n        Circel.new(x {{op.id}} other.x, y\
    \ {{op.id}} other.y, radious)\n      end\n\n      def {{op.id}}(other : Real)\n\
    \        Circle.new(x {{op.id}} other, y {{op.id}} other, radious)\n      end\n\
    \    {% end %}\n\n    def area : Real\n      radious * radious * Math::PI\n  \
    \  end\n\n    def contains?(v : Vec2)\n      ((v - center).length <=> radious)\
    \ < 0\n    end\n\n    def inspect(io : IO)\n      io << '(' << center << \", \"\
    \ << radious << ')'\n    end\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/geometric/object/circle.cr
  requiredBy:
  - src/geometric.cr
  - src/geometric/distance.cr
  - src/geometric/intersect.cr
  timestamp: '2022-04-10 01:35:43+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/geometric/object/circle.cr
layout: document
redirect_from:
- /library/src/geometric/object/circle.cr
- /library/src/geometric/object/circle.cr.html
title: src/geometric/object/circle.cr
---
