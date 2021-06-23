---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "class Sieve\n  getter size : Int32\n  getter factor : Array(Int32)\n\
    \  getter primes : Array(Int32)\n\n  def initialize(@size)\n    @factor = Array(Int32).new(@size\
    \ + 1, 0)\n    @primes = [] of Int32\n    sqrt_size = Math.sqrt(@size).to_i +\
    \ 1\n    (2..size).each do |x|\n      next unless @factor[x] == 0\n      @factor[x]\
    \ = x\n      @primes << x\n      next if sqrt_size < x\n      (x * x).step(to:\
    \ size, by: x) { |y|\n        @factor[y] = x if @factor[y] == 0\n      }\n   \
    \ end\n  end\n\n  def prime?(x)\n    factor[x] == x\n  end\n\n  private class\
    \ PrimeDivisionIterator\n    include Iterator({Int32, Int32})\n\n    def initialize(@current\
    \ : Int32, @factor : Array(Int32))\n    end\n\n    def next\n      return stop\
    \ if @current == 1\n      element = @factor[@current]\n      count = 0\n     \
    \ while @current != 1 && @factor[@current] == element\n        count += 1\n  \
    \      @current //= element\n      end\n      {element, count}\n    end\n  end\n\
    \n  def prime_division(x)\n    PrimeDivisionIterator.new(x, factor)\n  end\n\n\
    \  def each_factor(x, &) : Nil\n    while x > 1\n      element = @factor[x]\n\
    \      count = 0\n      while x != 1 && @factor[x] == element\n        count +=\
    \ 1\n        x //= element\n      end\n      yield(element, count)\n    end\n\
    \  end\nend\n"
  code: "class Sieve\n  getter size : Int32\n  getter factor : Array(Int32)\n  getter\
    \ primes : Array(Int32)\n\n  def initialize(@size)\n    @factor = Array(Int32).new(@size\
    \ + 1, 0)\n    @primes = [] of Int32\n    sqrt_size = Math.sqrt(@size).to_i +\
    \ 1\n    (2..size).each do |x|\n      next unless @factor[x] == 0\n      @factor[x]\
    \ = x\n      @primes << x\n      next if sqrt_size < x\n      (x * x).step(to:\
    \ size, by: x) { |y|\n        @factor[y] = x if @factor[y] == 0\n      }\n   \
    \ end\n  end\n\n  def prime?(x)\n    factor[x] == x\n  end\n\n  private class\
    \ PrimeDivisionIterator\n    include Iterator({Int32, Int32})\n\n    def initialize(@current\
    \ : Int32, @factor : Array(Int32))\n    end\n\n    def next\n      return stop\
    \ if @current == 1\n      element = @factor[@current]\n      count = 0\n     \
    \ while @current != 1 && @factor[@current] == element\n        count += 1\n  \
    \      @current //= element\n      end\n      {element, count}\n    end\n  end\n\
    \n  def prime_division(x)\n    PrimeDivisionIterator.new(x, factor)\n  end\n\n\
    \  def each_factor(x, &) : Nil\n    while x > 1\n      element = @factor[x]\n\
    \      count = 0\n      while x != 1 && @factor[x] == element\n        count +=\
    \ 1\n        x //= element\n      end\n      yield(element, count)\n    end\n\
    \  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: math/Sieve.cr
  requiredBy: []
  timestamp: '2021-06-23 20:53:22+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: math/Sieve.cr
layout: document
redirect_from:
- /library/math/Sieve.cr
- /library/math/Sieve.cr.html
title: math/Sieve.cr
---
