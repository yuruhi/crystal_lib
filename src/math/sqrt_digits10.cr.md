---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/math/sqrt_digits10_spec.cr
    title: spec/math/sqrt_digits10_spec.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"big\"\n\nmodule Math\n  def sqrt_digits10(x : Int, scale\
    \ : Int) : {Array(Int32), Array(Int32)}\n    raise ArgumentError.new unless x\
    \ >= 0\n    raise ArgumentError.new unless scale >= 0\n\n    a, b = BigInt.zero,\
    \ BigInt.zero\n\n    # TODO: use Int.digits\n    digits100 = [] of typeof(x)\n\
    \    while x > 0\n      digits100 << x % 100\n      x //= 100\n    end\n\n   \
    \ integer_digits = [] of Int32\n    digits100.reverse_each do |d|\n      a = a\
    \ * 100 + d\n      k = (0..9).reverse_each.find { |k| (b * 10 + k) * k <= a }.not_nil!\n\
    \      integer_digits << k\n      a -= (b * 10 + k) * k\n      b = b * 10 + k\
    \ * 2\n    end\n\n    decimal_digits = [] of Int32\n    scale.times do\n     \
    \ a *= 100\n      k = (0..9).reverse_each.find { |k| (b * 10 + k) * k <= a }.not_nil!\n\
    \      decimal_digits << k\n      a -= (b * 10 + k) * k\n      b = b * 10 + k\
    \ * 2\n    end\n\n    {integer_digits, decimal_digits}\n  end\nend\n"
  code: "require \"big\"\n\nmodule Math\n  def sqrt_digits10(x : Int, scale : Int)\
    \ : {Array(Int32), Array(Int32)}\n    raise ArgumentError.new unless x >= 0\n\
    \    raise ArgumentError.new unless scale >= 0\n\n    a, b = BigInt.zero, BigInt.zero\n\
    \n    # TODO: use Int.digits\n    digits100 = [] of typeof(x)\n    while x > 0\n\
    \      digits100 << x % 100\n      x //= 100\n    end\n\n    integer_digits =\
    \ [] of Int32\n    digits100.reverse_each do |d|\n      a = a * 100 + d\n    \
    \  k = (0..9).reverse_each.find { |k| (b * 10 + k) * k <= a }.not_nil!\n     \
    \ integer_digits << k\n      a -= (b * 10 + k) * k\n      b = b * 10 + k * 2\n\
    \    end\n\n    decimal_digits = [] of Int32\n    scale.times do\n      a *= 100\n\
    \      k = (0..9).reverse_each.find { |k| (b * 10 + k) * k <= a }.not_nil!\n \
    \     decimal_digits << k\n      a -= (b * 10 + k) * k\n      b = b * 10 + k *\
    \ 2\n    end\n\n    {integer_digits, decimal_digits}\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/math/sqrt_digits10.cr
  requiredBy:
  - spec/math/sqrt_digits10_spec.cr
  timestamp: '2021-11-14 01:52:04+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/math/sqrt_digits10.cr
layout: document
redirect_from:
- /library/src/math/sqrt_digits10.cr
- /library/src/math/sqrt_digits10.cr.html
title: src/math/sqrt_digits10.cr
---
