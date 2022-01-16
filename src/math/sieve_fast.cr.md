---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: benchmarks/math/sieve.cr
    title: benchmarks/math/sieve.cr
  - icon: ':warning:'
    path: spec/math/sieve_spec.cr
    title: spec/math/sieve_spec.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "class SieveFast\n  getter size : Int32, factor : Array(Int32), primes\
    \ : Array(Int32)\n\n  private def value(i)\n    2 * i + 3\n  end\n\n  private\
    \ def index(x)\n    (x - 3) // 2\n  end\n\n  # index :  0  1  2  3  4  5  6  7\
    \  8  9 10 11\n  # value :  3  5  7  9 11 13 15 17 19 21 23 25\n  # factor:  3\
    \  5  7  3 11 13  3 17 19  3 23  5\n\n  private def sift(n)\n    # factor(i) \
    \      = value(i)          = 2i + 3\n    # index_square(i) = index(value(i)^2)\
    \ = 2i^2 + 6i + 3\n    # factor(i + 1)       - factor(i)       = 2\n    # index_square(i\
    \ + 1) - index_square(i) = 4i + 8 = factor(i) + factor(i + 1)\n    i, factor,\
    \ index_square = 0, 3, 3\n    while index_square < n\n      if @factor[i] == 0\n\
    \        @factor[i] = factor\n        @primes << factor\n        index_square.step(to:\
    \ n - 1, by: factor) do |j|\n          @factor[j] = factor if @factor[j] == 0\n\
    \        end\n      end\n      i += 1\n      index_square += factor\n      factor\
    \ += 2\n      index_square += factor\n    end\n    while i < n\n      if @factor[i]\
    \ == 0\n        @factor[i] = factor\n        @primes << factor\n      end\n  \
    \    i += 1\n      factor += 2\n    end\n  end\n\n  def initialize(@size)\n  \
    \  @primes = [2]\n    n = (@size - 1) // 2\n    @factor = Array(Int32).new(n,\
    \ 0)\n    sift(n)\n  end\n\n  def prime?(x : Int32)\n    raise ArgumentError.new\
    \ unless 1 <= x <= size\n    if x.even?\n      x == 2\n    elsif x == 1\n    \
    \  false\n    else\n      @factor[index(x)] == x\n    end\n  end\n\n  private\
    \ class PrimeDivisionIterator\n    include Iterator({Int32, Int32})\n\n    @done2\
    \ : Bool\n\n    def initialize(@current : Int32, @factor : Array(Int32))\n   \
    \   @done2 = @current.odd?\n    end\n\n    def next\n      return stop if @current\
    \ == 1\n\n      unless @done2\n        @current //= 2\n        count = 1\n   \
    \     while @current.even?\n          @current //= 2\n          count += 1\n \
    \       end\n        @done2 = true\n        return {2, count}\n      end\n\n \
    \     element = @factor[(@current - 3) // 2]\n      @current //= element\n   \
    \   count = 1\n      while @current != 1 && @factor[(@current - 3) // 2] == element\n\
    \        count += 1\n        @current //= element\n      end\n      {element,\
    \ count}\n    end\n  end\n\n  def prime_division(x : Int32)\n    raise ArgumentError.new\
    \ unless 1 <= x <= size\n    PrimeDivisionIterator.new(x, @factor)\n  end\n\n\
    \  def each_factor(x : Int32, & : Int32, Int32 ->) : Nil\n    raise ArgumentError.new\
    \ unless 1 <= x <= size\n    if x.even?\n      count = 1\n      x //= 2\n    \
    \  while x.even?\n        count += 1\n        x //= 2\n      end\n      yield\
    \ 2, count\n    end\n    while x > 1\n      element = @factor[index(x)]\n    \
    \  x //= element\n      count = 1\n      while x != 1 && @factor[index(x)] ==\
    \ element\n        count += 1\n        x //= element\n      end\n      yield element,\
    \ count\n    end\n  end\n\n  def number_of_divisors(x : Int) : Int32\n    cnt\
    \ = 1\n    each_factor(x) do |_, c|\n      cnt *= c + 1\n    end\n    cnt\n  end\n\
    \n  def sum_of_divisors(x : Int) : Int64\n    sum = 1i64\n    each_factor(x) do\
    \ |elem, cnt|\n      sum *= (elem.to_i64 ** cnt.succ - 1) // (elem - 1)\n    end\n\
    \    sum\n  end\nend\n"
  code: "class SieveFast\n  getter size : Int32, factor : Array(Int32), primes : Array(Int32)\n\
    \n  private def value(i)\n    2 * i + 3\n  end\n\n  private def index(x)\n   \
    \ (x - 3) // 2\n  end\n\n  # index :  0  1  2  3  4  5  6  7  8  9 10 11\n  #\
    \ value :  3  5  7  9 11 13 15 17 19 21 23 25\n  # factor:  3  5  7  3 11 13 \
    \ 3 17 19  3 23  5\n\n  private def sift(n)\n    # factor(i)       = value(i)\
    \          = 2i + 3\n    # index_square(i) = index(value(i)^2) = 2i^2 + 6i + 3\n\
    \    # factor(i + 1)       - factor(i)       = 2\n    # index_square(i + 1) -\
    \ index_square(i) = 4i + 8 = factor(i) + factor(i + 1)\n    i, factor, index_square\
    \ = 0, 3, 3\n    while index_square < n\n      if @factor[i] == 0\n        @factor[i]\
    \ = factor\n        @primes << factor\n        index_square.step(to: n - 1, by:\
    \ factor) do |j|\n          @factor[j] = factor if @factor[j] == 0\n        end\n\
    \      end\n      i += 1\n      index_square += factor\n      factor += 2\n  \
    \    index_square += factor\n    end\n    while i < n\n      if @factor[i] ==\
    \ 0\n        @factor[i] = factor\n        @primes << factor\n      end\n     \
    \ i += 1\n      factor += 2\n    end\n  end\n\n  def initialize(@size)\n    @primes\
    \ = [2]\n    n = (@size - 1) // 2\n    @factor = Array(Int32).new(n, 0)\n    sift(n)\n\
    \  end\n\n  def prime?(x : Int32)\n    raise ArgumentError.new unless 1 <= x <=\
    \ size\n    if x.even?\n      x == 2\n    elsif x == 1\n      false\n    else\n\
    \      @factor[index(x)] == x\n    end\n  end\n\n  private class PrimeDivisionIterator\n\
    \    include Iterator({Int32, Int32})\n\n    @done2 : Bool\n\n    def initialize(@current\
    \ : Int32, @factor : Array(Int32))\n      @done2 = @current.odd?\n    end\n\n\
    \    def next\n      return stop if @current == 1\n\n      unless @done2\n   \
    \     @current //= 2\n        count = 1\n        while @current.even?\n      \
    \    @current //= 2\n          count += 1\n        end\n        @done2 = true\n\
    \        return {2, count}\n      end\n\n      element = @factor[(@current - 3)\
    \ // 2]\n      @current //= element\n      count = 1\n      while @current !=\
    \ 1 && @factor[(@current - 3) // 2] == element\n        count += 1\n        @current\
    \ //= element\n      end\n      {element, count}\n    end\n  end\n\n  def prime_division(x\
    \ : Int32)\n    raise ArgumentError.new unless 1 <= x <= size\n    PrimeDivisionIterator.new(x,\
    \ @factor)\n  end\n\n  def each_factor(x : Int32, & : Int32, Int32 ->) : Nil\n\
    \    raise ArgumentError.new unless 1 <= x <= size\n    if x.even?\n      count\
    \ = 1\n      x //= 2\n      while x.even?\n        count += 1\n        x //= 2\n\
    \      end\n      yield 2, count\n    end\n    while x > 1\n      element = @factor[index(x)]\n\
    \      x //= element\n      count = 1\n      while x != 1 && @factor[index(x)]\
    \ == element\n        count += 1\n        x //= element\n      end\n      yield\
    \ element, count\n    end\n  end\n\n  def number_of_divisors(x : Int) : Int32\n\
    \    cnt = 1\n    each_factor(x) do |_, c|\n      cnt *= c + 1\n    end\n    cnt\n\
    \  end\n\n  def sum_of_divisors(x : Int) : Int64\n    sum = 1i64\n    each_factor(x)\
    \ do |elem, cnt|\n      sum *= (elem.to_i64 ** cnt.succ - 1) // (elem - 1)\n \
    \   end\n    sum\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/math/sieve_fast.cr
  requiredBy:
  - spec/math/sieve_spec.cr
  - benchmarks/math/sieve.cr
  timestamp: '2022-01-16 04:07:26+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/math/sieve_fast.cr
layout: document
redirect_from:
- /library/src/math/sieve_fast.cr
- /library/src/math/sieve_fast.cr.html
title: src/math/sieve_fast.cr
---
