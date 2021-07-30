---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/enumerable/scan_spec.cr
    title: spec/enumerable/scan_spec.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "module Enumerable(T)\n  def scan(init : U) forall U\n    scan(init)\
    \ { |a, b| a + b }\n  end\n\n  def scan\n    scan(T.zero)\n  end\n\n  def scan(init\
    \ : U, &) forall U\n    result = [init]\n    each { |v| result << yield(result.last,\
    \ v) }\n    result\n  end\n\n  def inclusive_scan(&)\n    first = true\n    result\
    \ = [] of T\n    each do |v|\n      if first\n        result << v\n        first\
    \ = false\n      else\n        result << yield(result[-1], v)\n      end\n   \
    \ end\n    result\n  end\n\n  def inclusive_scan\n    inclusive_scan { |x, y|\
    \ x + y }\n  end\nend\n"
  code: "module Enumerable(T)\n  def scan(init : U) forall U\n    scan(init) { |a,\
    \ b| a + b }\n  end\n\n  def scan\n    scan(T.zero)\n  end\n\n  def scan(init\
    \ : U, &) forall U\n    result = [init]\n    each { |v| result << yield(result.last,\
    \ v) }\n    result\n  end\n\n  def inclusive_scan(&)\n    first = true\n    result\
    \ = [] of T\n    each do |v|\n      if first\n        result << v\n        first\
    \ = false\n      else\n        result << yield(result[-1], v)\n      end\n   \
    \ end\n    result\n  end\n\n  def inclusive_scan\n    inclusive_scan { |x, y|\
    \ x + y }\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/enumerable/scan.cr
  requiredBy:
  - spec/enumerable/scan_spec.cr
  timestamp: '2021-07-30 20:19:07+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/enumerable/scan.cr
layout: document
redirect_from:
- /library/src/enumerable/scan.cr
- /library/src/enumerable/scan.cr.html
title: src/enumerable/scan.cr
---
