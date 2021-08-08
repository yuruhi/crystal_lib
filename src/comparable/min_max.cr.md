---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: src/template.cr
    title: src/template.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "module Comparable(T)\n  def min(x : T)\n    self > x ? x : self\n\
    \  end\n\n  def max(x : T)\n    self < x ? x : self\n  end\nend\n"
  code: "module Comparable(T)\n  def min(x : T)\n    self > x ? x : self\n  end\n\n\
    \  def max(x : T)\n    self < x ? x : self\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/comparable/min_max.cr
  requiredBy:
  - src/template.cr
  timestamp: '2021-08-08 01:27:52+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/comparable/min_max.cr
layout: document
redirect_from:
- /library/src/comparable/min_max.cr
- /library/src/comparable/min_max.cr.html
title: src/comparable/min_max.cr
---
