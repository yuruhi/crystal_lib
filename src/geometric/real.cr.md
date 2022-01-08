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
  - icon: ':warning:'
    path: src/geometric/object/line.cr
    title: src/geometric/object/line.cr
  - icon: ':warning:'
    path: src/geometric/object/vec2.cr
    title: src/geometric/object/vec2.cr
  - icon: ':warning:'
    path: src/geometric/utility.cr
    title: src/geometric/utility.cr
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
    \ 1\n      else\n        0\n      end\n    {% end %}\n  end\n\n  def sign : Int32\n\
    \    self < -EPS ? -1 : self > EPS ? 1 : 0\n  end\n\n  def to_radian\n    self\
    \ * Math::PI / 180\n  end\n\n  def to_degree\n    self * 180 / Math::PI\n  end\n\
    \n  def self.scan(scanner, io : IO) : self\n    Real.new scanner.s(io)\n  end\n\
    end\n"
  code: "require \"big\"\n\nalias Real = BigFloat\nEPS = Real.new(1e-12)\n\nstruct\
    \ Real\n  def <=>(other : Real)\n    {% if Real == BigFloat %}\n      if previous_def(other\
    \ - EPS) < 0\n        -1\n      elsif previous_def(other + EPS) > 0\n        1\n\
    \      else\n        0\n      end\n    {% else %}\n      if self < other - EPS\n\
    \        -1\n      elsif self > other + EPS\n        1\n      else\n        0\n\
    \      end\n    {% end %}\n  end\n\n  def sign : Int32\n    self < -EPS ? -1 :\
    \ self > EPS ? 1 : 0\n  end\n\n  def to_radian\n    self * Math::PI / 180\n  end\n\
    \n  def to_degree\n    self * 180 / Math::PI\n  end\n\n  def self.scan(scanner,\
    \ io : IO) : self\n    Real.new scanner.s(io)\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/geometric/real.cr
  requiredBy:
  - src/geometric.cr
  - src/geometric/utility.cr
  - src/geometric/distance.cr
  - src/geometric/object/vec2.cr
  - src/geometric/object/line.cr
  - src/geometric/intersect.cr
  timestamp: '2022-01-08 12:01:15+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/geometric/real.cr
layout: document
redirect_from:
- /library/src/geometric/real.cr
- /library/src/geometric/real.cr.html
title: src/geometric/real.cr
---
