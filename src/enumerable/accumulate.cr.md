---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/enumerable/accumulate_spec.cr
    title: spec/enumerable/accumulate_spec.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "module Enumerable(T)\n  def accumulate(init : U) : Array(U) forall\
    \ U\n    accumulate(init) { |a, b| a + b }\n  end\n\n  def accumulate : Array(T)\n\
    \    accumulate { |x, y| x + y }\n  end\n\n  def accumulate(init : U, &block :\
    \ U, T -> U) : Array(U) forall U\n    result = [init]\n    each { |v| result <<\
    \ yield(result.last, v) }\n    result\n  end\n\n  def accumulate(&block : T, T\
    \ -> T) : Array(T)\n    result = [] of T\n    memo = uninitialized T\n    each\
    \ do |v|\n      memo = result.empty? ? v : yield(memo, v)\n      result << memo\n\
    \    end\n    result\n  end\nend\n"
  code: "module Enumerable(T)\n  def accumulate(init : U) : Array(U) forall U\n  \
    \  accumulate(init) { |a, b| a + b }\n  end\n\n  def accumulate : Array(T)\n \
    \   accumulate { |x, y| x + y }\n  end\n\n  def accumulate(init : U, &block :\
    \ U, T -> U) : Array(U) forall U\n    result = [init]\n    each { |v| result <<\
    \ yield(result.last, v) }\n    result\n  end\n\n  def accumulate(&block : T, T\
    \ -> T) : Array(T)\n    result = [] of T\n    memo = uninitialized T\n    each\
    \ do |v|\n      memo = result.empty? ? v : yield(memo, v)\n      result << memo\n\
    \    end\n    result\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/enumerable/accumulate.cr
  requiredBy:
  - spec/enumerable/accumulate_spec.cr
  timestamp: '2021-09-11 19:10:38+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/enumerable/accumulate.cr
layout: document
redirect_from:
- /library/src/enumerable/accumulate.cr
- /library/src/enumerable/accumulate.cr.html
title: src/enumerable/accumulate.cr
---
