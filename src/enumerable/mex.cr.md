---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/array/mex_spec.cr
    title: spec/array/mex_spec.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "module Enumerable(T)\n  # Returns the minimum value of the complement\
    \ set.\n  def mex_sorted : T\n    reduce(T.zero) do |now, x|\n      next now if\
    \ x < T.zero\n      return now if now < x\n      x.succ\n    end\n  end\n\n  #\
    \ :ditto:\n  def mex : T\n    to_a.sort!.mex_sorted\n  end\nend\n"
  code: "module Enumerable(T)\n  # Returns the minimum value of the complement set.\n\
    \  def mex_sorted : T\n    reduce(T.zero) do |now, x|\n      next now if x < T.zero\n\
    \      return now if now < x\n      x.succ\n    end\n  end\n\n  # :ditto:\n  def\
    \ mex : T\n    to_a.sort!.mex_sorted\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/enumerable/mex.cr
  requiredBy:
  - spec/array/mex_spec.cr
  timestamp: '2021-10-11 18:45:07+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/enumerable/mex.cr
layout: document
redirect_from:
- /library/src/enumerable/mex.cr
- /library/src/enumerable/mex.cr.html
title: src/enumerable/mex.cr
---
