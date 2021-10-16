---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/math/combination_spec.cr
    title: spec/math/combination_spec.cr
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/math/combination_test.cr
    title: test/math/combination_test.cr
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
    \  end\n\n  def factorial(n : Int)\n    raise IndexError.new if n < 0\n    expand_until(n)\n\
    \    @factorial.unsafe_fetch(n)\n  end\n\n  def inv(n : Int)\n    raise DivisionByZeroError.new\
    \ if n == 0\n    raise IndexError.new if n < 0\n    expand_until(n)\n    @inv.unsafe_fetch(n)\n\
    \  end\n\n  def finv(n : Int)\n    raise IndexError.new if n < 0\n    expand_until(n)\n\
    \    @finv.unsafe_fetch(n)\n  end\n\n  def permutation(n : Int, r : Int)\n   \
    \ (n < r || n < 0 || r < 0) ? T.zero : factorial(n) * finv(n - r)\n  end\n\n \
    \ def combination(n : Int, r : Int)\n    (n < r || n < 0 || r < 0) ? T.zero :\
    \ factorial(n) * finv(r) * finv(n - r)\n  end\n\n  def repeated_combination(n\
    \ : Int, r : Int)\n    (n < 0 || r < 0) ? T.zero : r == 0 ? T.new(1) : combination(n\
    \ + r - 1, r)\n  end\n\n  def self.table(n : Int)\n    table = Array.new(n + 1)\
    \ { Array.new(n + 1, T.zero) }\n    (0..n).each do |i|\n      table[i][0] = table[i][i]\
    \ = 1\n    end\n    (1..n).each do |i|\n      (1...i).each do |j|\n        table[i][j]\
    \ = table[i - 1][j - 1] + table[i - 1][j]\n      end\n    end\n    table\n  end\n\
    end\n"
  code: "class Combination(T)\n  def initialize(initial_capacity : Int = 2)\n    initial_capacity\
    \ += 1\n    @size = 2\n    @factorial = Array(T).new(initial_capacity)\n    @factorial\
    \ << T.new(1) << T.new(1)\n    @inv = Array(T).new(initial_capacity)\n    @inv\
    \ << T.zero << T.new(1)\n    @finv = Array(T).new(initial_capacity)\n    @finv\
    \ << T.new(1) << T.new(1)\n    expand_until(initial_capacity)\n  end\n\n  private\
    \ def expand_until(n : Int)\n    while @size <= n\n      @factorial << @factorial[-1]\
    \ * @size\n      @inv << -@inv[T::MOD % @size] * (T::MOD // @size)\n      @finv\
    \ << @finv[-1] * @inv[@size]\n      @size += 1\n    end\n  end\n\n  def factorial(n\
    \ : Int)\n    raise IndexError.new if n < 0\n    expand_until(n)\n    @factorial.unsafe_fetch(n)\n\
    \  end\n\n  def inv(n : Int)\n    raise DivisionByZeroError.new if n == 0\n  \
    \  raise IndexError.new if n < 0\n    expand_until(n)\n    @inv.unsafe_fetch(n)\n\
    \  end\n\n  def finv(n : Int)\n    raise IndexError.new if n < 0\n    expand_until(n)\n\
    \    @finv.unsafe_fetch(n)\n  end\n\n  def permutation(n : Int, r : Int)\n   \
    \ (n < r || n < 0 || r < 0) ? T.zero : factorial(n) * finv(n - r)\n  end\n\n \
    \ def combination(n : Int, r : Int)\n    (n < r || n < 0 || r < 0) ? T.zero :\
    \ factorial(n) * finv(r) * finv(n - r)\n  end\n\n  def repeated_combination(n\
    \ : Int, r : Int)\n    (n < 0 || r < 0) ? T.zero : r == 0 ? T.new(1) : combination(n\
    \ + r - 1, r)\n  end\n\n  def self.table(n : Int)\n    table = Array.new(n + 1)\
    \ { Array.new(n + 1, T.zero) }\n    (0..n).each do |i|\n      table[i][0] = table[i][i]\
    \ = 1\n    end\n    (1..n).each do |i|\n      (1...i).each do |j|\n        table[i][j]\
    \ = table[i - 1][j - 1] + table[i - 1][j]\n      end\n    end\n    table\n  end\n\
    end\n"
  dependsOn: []
  isVerificationFile: false
  path: src/math/combination.cr
  requiredBy:
  - spec/math/combination_spec.cr
  timestamp: '2021-10-16 03:30:46+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/math/combination_test.cr
documentation_of: src/math/combination.cr
layout: document
redirect_from:
- /library/src/math/combination.cr
- /library/src/math/combination.cr.html
title: src/math/combination.cr
---