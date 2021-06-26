---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "module Enumerable(T)\n  def scan(init : U) forall U\n    scan(init)\
    \ { |a, b| a + b }\n  end\n\n  def scan(init : U, &) forall U\n    result = [init]\n\
    \    each { |v| result << yield(result[-1], v) }\n    result\n  end\nend\n"
  code: "module Enumerable(T)\n  def scan(init : U) forall U\n    scan(init) { |a,\
    \ b| a + b }\n  end\n\n  def scan(init : U, &) forall U\n    result = [init]\n\
    \    each { |v| result << yield(result[-1], v) }\n    result\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: utility/scan.cr
  requiredBy: []
  timestamp: '2021-06-26 13:24:24+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: utility/scan.cr
layout: document
redirect_from:
- /library/utility/scan.cr
- /library/utility/scan.cr.html
title: utility/scan.cr
---
