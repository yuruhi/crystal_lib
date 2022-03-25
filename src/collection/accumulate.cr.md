---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/collection/accumulate_spec.cr
    title: spec/collection/accumulate_spec.cr
  - icon: ':warning:'
    path: src/template.cr
    title: src/template.cr
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
  path: src/collection/accumulate.cr
  requiredBy:
  - src/template.cr
  - spec/collection/accumulate_spec.cr
  timestamp: '2022-03-25 11:37:47+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/collection/accumulate.cr
layout: document
redirect_from:
- /library/src/collection/accumulate.cr
- /library/src/collection/accumulate.cr.html
title: src/collection/accumulate.cr
---
