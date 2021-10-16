---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/math/prime_factor.cr
    title: src/math/prime_factor.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../src/math/prime_factor\"\nstruct\
    \ Int\n  def prime_factor : Array({self, Int32})\n    raise DivisionByZeroError.new\
    \ if self == 0\n    result = [] of {self, Int32}\n    result << {self.class.new(-1),\
    \ 1} if self < 0\n    n = abs\n    self.class.new(2).upto(Math.sqrt(n).ceil) do\
    \ |x|\n      count = 0\n      while n % x == 0\n        n //= x\n        count\
    \ += 1\n      end\n      result << {x, count} if count > 0\n    end\n    result\
    \ << {n, 1} if n != 1\n    result\n  end\n\n  def divisors : Array(self)\n   \
    \ result = [] of self\n    each_divisor do |d|\n      result << d\n    end\n \
    \   result\n  end\n\n  def each_divisor(&)\n    raise DivisionByZeroError.new\
    \ if self == 0\n    raise ArgumentError.new unless self > 0\n    tmp = [] of self\n\
    \    self.class.new(1).upto(self) do |x|\n      break if x * x > self\n      if\
    \ self % x == 0\n        yield x\n        tmp << x\n      end\n    end\n    (0...tmp.size).reverse_each\
    \ do |i|\n      yield self // tmp[i] if tmp[i] * tmp[i] < self\n    end\n  end\n\
    end\n\ndescribe Int do\n  it \"#prime_factor\" do\n    1.prime_factor.should eq\
    \ [] of {Int32, Int32}\n    -1.prime_factor.should eq [{-1, 1}]\n    12.prime_factor.should\
    \ eq [{2, 2}, {3, 1}]\n    -12.prime_factor.should eq [{-1, 1}, {2, 2}, {3, 1}]\n\
    \    24.prime_factor.should eq [{2, 3}, {3, 1}]\n    60.prime_factor.should eq\
    \ [{2, 2}, {3, 1}, {5, 1}]\n    10108248702552000.prime_factor.should eq [\n \
    \     {2, 6}, {3, 3}, {5, 3}, {7, 2}, {11, 1}, {13, 1}, {17, 1}, {19, 1}, {23,\
    \ 1}, {29, 1}, {31, 1},\n    ]\n    [2, 3, 5, 7, 13, 10**9 + 7, 10i64**12 + 39,\
    \ 10i64**15 + 37].each do |x|\n      x.prime_factor.should eq [{x, 1}]\n     \
    \ (-x).prime_factor.should eq [{-1, 1}, {x, 1}]\n    end\n    expect_raises(DivisionByZeroError)\
    \ { 0.prime_factor }\n  end\n\n  it \"#divisors\" do\n    1.divisors.should eq\
    \ [1]\n    4.divisors.should eq [1, 2, 4]\n    12.divisors.should eq [1, 2, 3,\
    \ 4, 6, 12]\n    60.divisors.should eq [1, 2, 3, 4, 5, 6, 10, 12, 15, 20, 30,\
    \ 60]\n    72.divisors.should eq [1, 2, 3, 4, 6, 8, 9, 12, 18, 24, 36, 72]\n \
    \   [2, 3, 5, 7, 13, 10**9 + 7, 10i64**12 + 39, 10i64**15 + 37].each do |x|\n\
    \      x.divisors.should eq [1, x]\n    end\n    expect_raises(DivisionByZeroError)\
    \ { 0.divisors }\n    expect_raises(ArgumentError) { -1.divisors }\n  end\nend\n"
  code: "require \"spec\"\nrequire \"../../src/math/prime_factor\"\n\ndescribe Int\
    \ do\n  it \"#prime_factor\" do\n    1.prime_factor.should eq [] of {Int32, Int32}\n\
    \    -1.prime_factor.should eq [{-1, 1}]\n    12.prime_factor.should eq [{2, 2},\
    \ {3, 1}]\n    -12.prime_factor.should eq [{-1, 1}, {2, 2}, {3, 1}]\n    24.prime_factor.should\
    \ eq [{2, 3}, {3, 1}]\n    60.prime_factor.should eq [{2, 2}, {3, 1}, {5, 1}]\n\
    \    10108248702552000.prime_factor.should eq [\n      {2, 6}, {3, 3}, {5, 3},\
    \ {7, 2}, {11, 1}, {13, 1}, {17, 1}, {19, 1}, {23, 1}, {29, 1}, {31, 1},\n   \
    \ ]\n    [2, 3, 5, 7, 13, 10**9 + 7, 10i64**12 + 39, 10i64**15 + 37].each do |x|\n\
    \      x.prime_factor.should eq [{x, 1}]\n      (-x).prime_factor.should eq [{-1,\
    \ 1}, {x, 1}]\n    end\n    expect_raises(DivisionByZeroError) { 0.prime_factor\
    \ }\n  end\n\n  it \"#divisors\" do\n    1.divisors.should eq [1]\n    4.divisors.should\
    \ eq [1, 2, 4]\n    12.divisors.should eq [1, 2, 3, 4, 6, 12]\n    60.divisors.should\
    \ eq [1, 2, 3, 4, 5, 6, 10, 12, 15, 20, 30, 60]\n    72.divisors.should eq [1,\
    \ 2, 3, 4, 6, 8, 9, 12, 18, 24, 36, 72]\n    [2, 3, 5, 7, 13, 10**9 + 7, 10i64**12\
    \ + 39, 10i64**15 + 37].each do |x|\n      x.divisors.should eq [1, x]\n    end\n\
    \    expect_raises(DivisionByZeroError) { 0.divisors }\n    expect_raises(ArgumentError)\
    \ { -1.divisors }\n  end\nend\n"
  dependsOn:
  - src/math/prime_factor.cr
  isVerificationFile: false
  path: spec/math/prime_factor_spec.cr
  requiredBy: []
  timestamp: '2021-10-15 21:00:47+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/math/prime_factor_spec.cr
layout: document
redirect_from:
- /library/spec/math/prime_factor_spec.cr
- /library/spec/math/prime_factor_spec.cr.html
title: spec/math/prime_factor_spec.cr
---
