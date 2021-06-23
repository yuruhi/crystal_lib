---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/Combination.test.cr
    title: test/Combination.test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "class Combination(T)\n  def initialize\n    @size = 2\n    @factorial\
    \ = [T.new(1), T.new(1)]\n    @inv = [T.zero, T.new(1)]\n    @finv = [T.new(1),\
    \ T.new(1)]\n  end\n\n  private def expand_until(n : Int)\n    while @size <=\
    \ n\n      @factorial << @factorial[-1] * @size\n      @inv << -@inv[T::MOD %\
    \ @size] * (T::MOD // @size)\n      @finv << @finv[-1] * @inv[@size]\n      @size\
    \ += 1\n    end\n  end\n\n  def factorial(n : Int)\n    expand_until(n)\n    @factorial[n]\n\
    \  end\n\n  def inv(n : Int)\n    expand_until(n)\n    @inv[n]\n  end\n\n  def\
    \ finv(n : Int)\n    expand_until(n)\n    @finv[n]\n  end\n\n  def permutation(n\
    \ : Int, r : Int)\n    (n < r || n < 0 || r < 0) ? T.zero : factorial(n) * finv(n\
    \ - r)\n  end\n\n  def combination(n : Int, r : Int)\n    (n < r || n < 0 || r\
    \ < 0) ? T.zero : factorial(n) * finv(r) * finv(n - r)\n  end\n\n  def repeated_combination(n\
    \ : Int, r : Int)\n    (n < 0 || r < 0) ? T.zero : r == 0 ? T.new(1) : combination(n\
    \ + r - 1, r)\n  end\nend\n"
  code: "class Combination(T)\n  def initialize\n    @size = 2\n    @factorial = [T.new(1),\
    \ T.new(1)]\n    @inv = [T.zero, T.new(1)]\n    @finv = [T.new(1), T.new(1)]\n\
    \  end\n\n  private def expand_until(n : Int)\n    while @size <= n\n      @factorial\
    \ << @factorial[-1] * @size\n      @inv << -@inv[T::MOD % @size] * (T::MOD //\
    \ @size)\n      @finv << @finv[-1] * @inv[@size]\n      @size += 1\n    end\n\
    \  end\n\n  def factorial(n : Int)\n    expand_until(n)\n    @factorial[n]\n \
    \ end\n\n  def inv(n : Int)\n    expand_until(n)\n    @inv[n]\n  end\n\n  def\
    \ finv(n : Int)\n    expand_until(n)\n    @finv[n]\n  end\n\n  def permutation(n\
    \ : Int, r : Int)\n    (n < r || n < 0 || r < 0) ? T.zero : factorial(n) * finv(n\
    \ - r)\n  end\n\n  def combination(n : Int, r : Int)\n    (n < r || n < 0 || r\
    \ < 0) ? T.zero : factorial(n) * finv(r) * finv(n - r)\n  end\n\n  def repeated_combination(n\
    \ : Int, r : Int)\n    (n < 0 || r < 0) ? T.zero : r == 0 ? T.new(1) : combination(n\
    \ + r - 1, r)\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: math/Combination.cr
  requiredBy: []
  timestamp: '2021-06-23 22:32:57+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/Combination.test.cr
documentation_of: math/Combination.cr
layout: document
redirect_from:
- /library/math/Combination.cr
- /library/math/Combination.cr.html
title: math/Combination.cr
---
