---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "struct Int\n  def prime_factor : Array(Tuple(self, Int32))\n    result\
    \ = [] of Tuple(self, Int32)\n    n = self\n    typeof(self).new(2).upto(Math.sqrt(self).ceil)\
    \ do |x|\n      count = 0\n      while n % x == 0\n        n //= x\n        count\
    \ += 1\n      end\n      result << {x, count} if count > 0\n    end\n    result\
    \ << {n, 1} if n != 1\n    result\n  end\n\n  def divisors : Array(self)\n   \
    \ result = [] of self\n    each_divisor do |d|\n      result << d\n    end\n \
    \   result\n  end\n\n  def each_divisor(&)\n    tmp = [] of self\n    typeof(self).new(1).upto(self)\
    \ do |x|\n      break if x * x > self\n      if self % x == 0\n        yield x\n\
    \        tmp << x\n      end\n    end\n    (0...tmp.size).reverse_each do |i|\n\
    \      yield self // tmp[i] if tmp[i] * tmp[i] < self\n    end\n  end\nend\n"
  code: "struct Int\n  def prime_factor : Array(Tuple(self, Int32))\n    result =\
    \ [] of Tuple(self, Int32)\n    n = self\n    typeof(self).new(2).upto(Math.sqrt(self).ceil)\
    \ do |x|\n      count = 0\n      while n % x == 0\n        n //= x\n        count\
    \ += 1\n      end\n      result << {x, count} if count > 0\n    end\n    result\
    \ << {n, 1} if n != 1\n    result\n  end\n\n  def divisors : Array(self)\n   \
    \ result = [] of self\n    each_divisor do |d|\n      result << d\n    end\n \
    \   result\n  end\n\n  def each_divisor(&)\n    tmp = [] of self\n    typeof(self).new(1).upto(self)\
    \ do |x|\n      break if x * x > self\n      if self % x == 0\n        yield x\n\
    \        tmp << x\n      end\n    end\n    (0...tmp.size).reverse_each do |i|\n\
    \      yield self // tmp[i] if tmp[i] * tmp[i] < self\n    end\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/math/prime_factor.cr
  requiredBy: []
  timestamp: '2021-08-03 16:50:02+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/math/prime_factor.cr
layout: document
redirect_from:
- /library/src/math/prime_factor.cr
- /library/src/math/prime_factor.cr.html
title: src/math/prime_factor.cr
---
