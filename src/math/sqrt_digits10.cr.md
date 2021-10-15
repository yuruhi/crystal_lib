---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"big\"\n\nmodule Math\n  def sqrt_digits10(x : Int32, scale\
    \ : Int)\n    raise ArgumentError.new unless x >= 0\n\n    a, b = BigInt.zero,\
    \ BigInt.zero\n\n    integer_digits = [] of Int32\n    x.digits(100).reverse_each\
    \ do |d|\n      a = a * 100 + d\n      k = (0..9).reverse_each.find { |k| (b *\
    \ 10 + k) * k <= a }.not_nil!\n      integer_digits << k\n      a -= (b * 10 +\
    \ k) * k\n      b = b * 10 + k * 2\n    end\n\n    decimal_digits = [] of Int32\n\
    \    scale.times do\n      a *= 100\n      k = (0..9).reverse_each.find { |k|\
    \ (b * 10 + k) * k <= a }.not_nil!\n      decimal_digits << k\n      a -= (b *\
    \ 10 + k) * k\n      b = b * 10 + k * 2\n    end\n\n    {integer_digits, decimal_digits}\n\
    \  end\nend\n"
  code: "require \"big\"\n\nmodule Math\n  def sqrt_digits10(x : Int32, scale : Int)\n\
    \    raise ArgumentError.new unless x >= 0\n\n    a, b = BigInt.zero, BigInt.zero\n\
    \n    integer_digits = [] of Int32\n    x.digits(100).reverse_each do |d|\n  \
    \    a = a * 100 + d\n      k = (0..9).reverse_each.find { |k| (b * 10 + k) *\
    \ k <= a }.not_nil!\n      integer_digits << k\n      a -= (b * 10 + k) * k\n\
    \      b = b * 10 + k * 2\n    end\n\n    decimal_digits = [] of Int32\n    scale.times\
    \ do\n      a *= 100\n      k = (0..9).reverse_each.find { |k| (b * 10 + k) *\
    \ k <= a }.not_nil!\n      decimal_digits << k\n      a -= (b * 10 + k) * k\n\
    \      b = b * 10 + k * 2\n    end\n\n    {integer_digits, decimal_digits}\n \
    \ end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/math/sqrt_digits10.cr
  requiredBy: []
  timestamp: '2021-10-15 06:50:44+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/math/sqrt_digits10.cr
layout: document
redirect_from:
- /library/src/math/sqrt_digits10.cr
- /library/src/math/sqrt_digits10.cr.html
title: src/math/sqrt_digits10.cr
---
