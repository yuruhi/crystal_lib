---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/math/combination.test.cr
    title: test/math/combination.test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "class Combination(T)\n  def initialize(initial_capacity : Int = 2)\n\
    \    initial_capacity += 1\n    @size = 2\n    @factorial = Array(T).new(initial_capacity)\n\
    \    @factorial << T.new(1) << T.new(1)\n    @inv = Array(T).new(initial_capacity)\n\
    \    @inv << T.zero << T.new(1)\n    @finv = Array(T).new(initial_capacity)\n\
    \    @finv << T.new(1) << T.new(1)\n    expand_until(initial_capacity)\n  end\n\
    \n  private def expand_until(n : Int)\n    while @size <= n\n      @factorial\
    \ << @factorial[-1] * @size\n      @inv << -@inv[T::MOD % @size] * (T::MOD //\
    \ @size)\n      @finv << @finv[-1] * @inv[@size]\n      @size += 1\n    end\n\
    \  end\n\n  def factorial(n : Int)\n    expand_until(n)\n    @factorial.unsafe_fetch(n)\n\
    \  end\n\n  def inv(n : Int)\n    expand_until(n)\n    @inv.unsafe_fetch(n)\n\
    \  end\n\n  def finv(n : Int)\n    expand_until(n)\n    @finv.unsafe_fetch(n)\n\
    \  end\n\n  def permutation(n : Int, r : Int)\n    (n < r || n < 0 || r < 0) ?\
    \ T.zero : factorial(n) * finv(n - r)\n  end\n\n  def combination(n : Int, r :\
    \ Int)\n    (n < r || n < 0 || r < 0) ? T.zero : factorial(n) * finv(r) * finv(n\
    \ - r)\n  end\n\n  def repeated_combination(n : Int, r : Int)\n    (n < 0 || r\
    \ < 0) ? T.zero : r == 0 ? T.new(1) : combination(n + r - 1, r)\n  end\nend\n"
  code: "class Combination(T)\n  def initialize(initial_capacity : Int = 2)\n    initial_capacity\
    \ += 1\n    @size = 2\n    @factorial = Array(T).new(initial_capacity)\n    @factorial\
    \ << T.new(1) << T.new(1)\n    @inv = Array(T).new(initial_capacity)\n    @inv\
    \ << T.zero << T.new(1)\n    @finv = Array(T).new(initial_capacity)\n    @finv\
    \ << T.new(1) << T.new(1)\n    expand_until(initial_capacity)\n  end\n\n  private\
    \ def expand_until(n : Int)\n    while @size <= n\n      @factorial << @factorial[-1]\
    \ * @size\n      @inv << -@inv[T::MOD % @size] * (T::MOD // @size)\n      @finv\
    \ << @finv[-1] * @inv[@size]\n      @size += 1\n    end\n  end\n\n  def factorial(n\
    \ : Int)\n    expand_until(n)\n    @factorial.unsafe_fetch(n)\n  end\n\n  def\
    \ inv(n : Int)\n    expand_until(n)\n    @inv.unsafe_fetch(n)\n  end\n\n  def\
    \ finv(n : Int)\n    expand_until(n)\n    @finv.unsafe_fetch(n)\n  end\n\n  def\
    \ permutation(n : Int, r : Int)\n    (n < r || n < 0 || r < 0) ? T.zero : factorial(n)\
    \ * finv(n - r)\n  end\n\n  def combination(n : Int, r : Int)\n    (n < r || n\
    \ < 0 || r < 0) ? T.zero : factorial(n) * finv(r) * finv(n - r)\n  end\n\n  def\
    \ repeated_combination(n : Int, r : Int)\n    (n < 0 || r < 0) ? T.zero : r ==\
    \ 0 ? T.new(1) : combination(n + r - 1, r)\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/math/combination.cr
  requiredBy: []
  timestamp: '2021-08-03 16:41:37+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/math/combination.test.cr
documentation_of: src/math/combination.cr
layout: document
redirect_from:
- /library/src/math/combination.cr
- /library/src/math/combination.cr.html
title: src/math/combination.cr
---
