---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/math/sieve.cr
    title: src/math/sieve.cr
  - icon: ':warning:'
    path: src/math/sieve_fast.cr
    title: src/math/sieve_fast.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../src/math/sieve\"\nclass Sieve\n\
    \  getter size : Int32, factor : Array(Int32), primes : Array(Int32)\n\n  def\
    \ initialize(@size)\n    @factor = Array(Int32).new(@size + 1, 0)\n    @primes\
    \ = [] of Int32\n    sqrt_size = Math.sqrt(@size).to_i + 1\n    (2..size).each\
    \ do |x|\n      next unless @factor[x] == 0\n      @factor[x] = x\n      @primes\
    \ << x\n      next if sqrt_size < x\n      (x * x).step(to: size, by: x) do |y|\n\
    \        @factor[y] = x if @factor[y] == 0\n      end\n    end\n  end\n\n  def\
    \ prime?(x : Int) : Bool\n    raise ArgumentError.new unless 1 <= x <= size\n\
    \    factor[x] == x\n  end\n\n  private class PrimeDivisionIterator\n    include\
    \ Iterator({Int32, Int32})\n\n    def initialize(@current : Int32, @factor : Array(Int32))\n\
    \    end\n\n    def next\n      return stop if @current == 1\n      element =\
    \ @factor[@current]\n      count = 0\n      while @current != 1 && @factor[@current]\
    \ == element\n        count += 1\n        @current //= element\n      end\n  \
    \    {element, count}\n    end\n  end\n\n  def prime_division(x : Int)\n    raise\
    \ ArgumentError.new unless 1 <= x <= size\n    PrimeDivisionIterator.new(x, factor)\n\
    \  end\n\n  def each_factor(x : Int, &) : Nil\n    raise ArgumentError.new unless\
    \ 1 <= x <= size\n    while x > 1\n      element = @factor[x]\n      count = 0\n\
    \      while x != 1 && @factor[x] == element\n        count += 1\n        x //=\
    \ element\n      end\n      yield(element, count)\n    end\n  end\n\n  def number_of_divisors(x\
    \ : Int) : Int32\n    raise ArgumentError.new unless 1 <= x <= size\n    cnt =\
    \ 1\n    each_factor(x) do |_, c|\n      cnt *= c.succ\n    end\n    cnt\n  end\n\
    \n  def sum_of_divisors(x : Int) : Int64\n    raise ArgumentError.new unless 1\
    \ <= x <= size\n    sum = 1i64\n    each_factor(x) do |elem, cnt|\n      sum *=\
    \ (elem.to_i64 ** cnt.succ - 1) // elem.pred\n    end\n    sum\n  end\nend\n\n\
    # require \"../../src/math/sieve_fast\"\nclass SieveFast\n  getter size : Int32,\
    \ factor : Array(Int32), primes : Array(Int32)\n\n  # i      :  0  1  2  3  4\
    \  5  6\n  # factor :  3  5  7  9 11 13 15\n\n  private def value(i)\n    2 *\
    \ i + 3\n  end\n\n  private def index(x)\n    (x - 3) // 2\n  end\n\n  private\
    \ def sift(n)\n    # factor(i)       = value(i)          = 2i + 3\n    # index_square(i)\
    \ = index(value(i)^2) = 2i^2 + 6i + 3\n    # factor(i + 1)       - factor(i) \
    \      = 2\n    # index_square(i + 1) - index_square(i) = 4i + 8 = factor(i) +\
    \ factor(i + 1)\n    i, factor, index_square = 0, 3, 3\n    while index_square\
    \ < n\n      if @factor[i] == 0\n        @factor[i] = factor\n        @primes\
    \ << factor\n        index_square.step(to: n - 1, by: factor) do |j|\n       \
    \   @factor[j] = factor if @factor[j] == 0\n        end\n      end\n      i +=\
    \ 1\n      index_square += factor\n      factor += 2\n      index_square += factor\n\
    \    end\n    while i < n\n      if @factor[i] == 0\n        @factor[i] = factor\n\
    \        @primes << factor\n      end\n      i += 1\n      factor += 2\n    end\n\
    \  end\n\n  def initialize(@size)\n    @primes = [2]\n    n = (@size - 1) // 2\n\
    \    @factor = Array(Int32).new(n, 0)\n    sift(n)\n  end\n\n  def prime?(x :\
    \ Int32)\n    raise ArgumentError.new unless 1 <= x <= size\n    if x.even?\n\
    \      x == 2\n    elsif x == 1\n      false\n    else\n      @factor[index(x)]\
    \ == x\n    end\n  end\n\n  private class PrimeDivisionIterator\n    include Iterator({Int32,\
    \ Int32})\n\n    @done2 : Bool\n\n    def initialize(@current : Int32, @factor\
    \ : Array(Int32))\n      @done2 = @current.odd?\n    end\n\n    def next\n   \
    \   return stop if @current == 1\n\n      unless @done2\n        @current //=\
    \ 2\n        count = 1\n        while @current.even?\n          @current //= 2\n\
    \          count += 1\n        end\n        @done2 = true\n        return {2,\
    \ count}\n      end\n\n      element = @factor[(@current - 3) // 2]\n      @current\
    \ //= element\n      count = 1\n      while @current != 1 && @factor[(@current\
    \ - 3) // 2] == element\n        count += 1\n        @current //= element\n  \
    \    end\n      {element, count}\n    end\n  end\n\n  def prime_division(x : Int32)\n\
    \    raise ArgumentError.new unless 1 <= x <= size\n    PrimeDivisionIterator.new(x,\
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
    \   end\n    sum\n  end\nend\n\nprivate N = 10000\nprivate P = (2..N).select {\
    \ |x| (2..Math.sqrt(x)).none? { |f| x % f == 0 } }\n\nprivate def check_prime_division(x\
    \ : Int32, division : Array({Int32, Int32}))\n  division.all? { |factor, count|\
    \ P.includes?(factor) && count >= 1 } &&\n    division.each_cons(2, reuse: true).all?\
    \ { |(t1, t2)| t1[0] < t2[0] } &&\n    division.reduce(1) { |acc, (factor, count)|\
    \ acc * factor**count } == x\nend\n\n{% for klass in [Sieve, SieveFast] %}\n \
    \ describe {{klass}} do\n    sieve = {{klass}}.new N\n    it \"#prime?\" do\n\
    \      (1..20).each do |x|\n        sieve.prime?(x).should eq P.includes?(x)\n\
    \      end\n      expect_raises(ArgumentError) { sieve.prime? 0 }\n      expect_raises(ArgumentError)\
    \ { sieve.prime? -1 }\n      expect_raises(ArgumentError) { sieve.prime? N + 1\
    \ }\n    end\n\n    it \"#primes\" do\n      sieve.primes.should eq P\n    end\n\
    \n    it \"#prime_division\" do\n      (1..N).each do |x|\n        result = sieve.prime_division(x).to_a\n\
    \        check_prime_division(x, result).should be_true\n      end\n      expect_raises(ArgumentError)\
    \ { sieve.prime_division(0) }\n      expect_raises(ArgumentError) { sieve.prime_division(-1)\
    \ }\n      expect_raises(ArgumentError) { sieve.prime_division(N + 1) }\n    end\n\
    \n    it \"#each_factor\" do\n      (1..N).each do |x|\n        result = [] of\
    \ {Int32, Int32}\n        sieve.each_factor(x) do |factor, count|\n          result\
    \ << {factor, count}\n        end\n        check_prime_division(x, result).should\
    \ be_true\n      end\n      expect_raises(ArgumentError) { sieve.each_factor(0)\
    \ { } }\n      expect_raises(ArgumentError) { sieve.each_factor(-1) { } }\n  \
    \    expect_raises(ArgumentError) { sieve.each_factor(N + 1) { } }\n    end\n\n\
    \    it \"#number_of_divisors\" do\n      (1..N).each do |x|\n        expect =\
    \ (1..x).count { |i| x % i == 0 }\n        sieve.number_of_divisors(x).should\
    \ eq expect\n      end\n      expect_raises(ArgumentError) { sieve.number_of_divisors(0)\
    \ }\n      expect_raises(ArgumentError) { sieve.number_of_divisors(-1) }\n   \
    \   expect_raises(ArgumentError) { sieve.number_of_divisors(N + 1) }\n    end\n\
    \n    it \"#sum_of_divisors\" do\n      (1..N).each do |x|\n        expect = (1..x).select\
    \ { |i| x % i == 0 }.sum(0i64)\n        sieve.sum_of_divisors(x).should eq expect\n\
    \      end\n      expect_raises(ArgumentError) { sieve.sum_of_divisors(0) }\n\
    \      expect_raises(ArgumentError) { sieve.sum_of_divisors(-1) }\n      expect_raises(ArgumentError)\
    \ { sieve.sum_of_divisors(N + 1) }\n    end\n  end\n{% end %}\n"
  code: "require \"spec\"\nrequire \"../../src/math/sieve\"\nrequire \"../../src/math/sieve_fast\"\
    \n\nprivate N = 10000\nprivate P = (2..N).select { |x| (2..Math.sqrt(x)).none?\
    \ { |f| x % f == 0 } }\n\nprivate def check_prime_division(x : Int32, division\
    \ : Array({Int32, Int32}))\n  division.all? { |factor, count| P.includes?(factor)\
    \ && count >= 1 } &&\n    division.each_cons(2, reuse: true).all? { |(t1, t2)|\
    \ t1[0] < t2[0] } &&\n    division.reduce(1) { |acc, (factor, count)| acc * factor**count\
    \ } == x\nend\n\n{% for klass in [Sieve, SieveFast] %}\n  describe {{klass}} do\n\
    \    sieve = {{klass}}.new N\n    it \"#prime?\" do\n      (1..20).each do |x|\n\
    \        sieve.prime?(x).should eq P.includes?(x)\n      end\n      expect_raises(ArgumentError)\
    \ { sieve.prime? 0 }\n      expect_raises(ArgumentError) { sieve.prime? -1 }\n\
    \      expect_raises(ArgumentError) { sieve.prime? N + 1 }\n    end\n\n    it\
    \ \"#primes\" do\n      sieve.primes.should eq P\n    end\n\n    it \"#prime_division\"\
    \ do\n      (1..N).each do |x|\n        result = sieve.prime_division(x).to_a\n\
    \        check_prime_division(x, result).should be_true\n      end\n      expect_raises(ArgumentError)\
    \ { sieve.prime_division(0) }\n      expect_raises(ArgumentError) { sieve.prime_division(-1)\
    \ }\n      expect_raises(ArgumentError) { sieve.prime_division(N + 1) }\n    end\n\
    \n    it \"#each_factor\" do\n      (1..N).each do |x|\n        result = [] of\
    \ {Int32, Int32}\n        sieve.each_factor(x) do |factor, count|\n          result\
    \ << {factor, count}\n        end\n        check_prime_division(x, result).should\
    \ be_true\n      end\n      expect_raises(ArgumentError) { sieve.each_factor(0)\
    \ { } }\n      expect_raises(ArgumentError) { sieve.each_factor(-1) { } }\n  \
    \    expect_raises(ArgumentError) { sieve.each_factor(N + 1) { } }\n    end\n\n\
    \    it \"#number_of_divisors\" do\n      (1..N).each do |x|\n        expect =\
    \ (1..x).count { |i| x % i == 0 }\n        sieve.number_of_divisors(x).should\
    \ eq expect\n      end\n      expect_raises(ArgumentError) { sieve.number_of_divisors(0)\
    \ }\n      expect_raises(ArgumentError) { sieve.number_of_divisors(-1) }\n   \
    \   expect_raises(ArgumentError) { sieve.number_of_divisors(N + 1) }\n    end\n\
    \n    it \"#sum_of_divisors\" do\n      (1..N).each do |x|\n        expect = (1..x).select\
    \ { |i| x % i == 0 }.sum(0i64)\n        sieve.sum_of_divisors(x).should eq expect\n\
    \      end\n      expect_raises(ArgumentError) { sieve.sum_of_divisors(0) }\n\
    \      expect_raises(ArgumentError) { sieve.sum_of_divisors(-1) }\n      expect_raises(ArgumentError)\
    \ { sieve.sum_of_divisors(N + 1) }\n    end\n  end\n{% end %}\n"
  dependsOn:
  - src/math/sieve.cr
  - src/math/sieve_fast.cr
  isVerificationFile: false
  path: spec/math/sieve_spec.cr
  requiredBy: []
  timestamp: '2022-01-02 16:26:14+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/math/sieve_spec.cr
layout: document
redirect_from:
- /library/spec/math/sieve_spec.cr
- /library/spec/math/sieve_spec.cr.html
title: spec/math/sieve_spec.cr
---
