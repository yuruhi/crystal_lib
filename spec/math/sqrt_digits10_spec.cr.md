---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/math/sqrt_digits10.cr
    title: src/math/sqrt_digits10.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\nrequire \"big\"\n# require \"../../src/math/sqrt_digits10\"\
    \nrequire \"big\"\n\nmodule Math\n  def sqrt_digits10(x : Int, scale : Int) :\
    \ {Array(Int32), Array(Int32)}\n    raise ArgumentError.new unless x >= 0\n  \
    \  raise ArgumentError.new unless scale >= 0\n\n    a, b = BigInt.zero, BigInt.zero\n\
    \n    # TODO: use Int.digits\n    digits100 = [] of typeof(x)\n    while x > 0\n\
    \      digits100 << x % 100\n      x //= 100\n    end\n\n    integer_digits =\
    \ [] of Int32\n    digits100.reverse_each do |d|\n      a = a * 100 + d\n    \
    \  k = (0..9).reverse_each.find { |k| (b * 10 + k) * k <= a }.not_nil!\n     \
    \ integer_digits << k\n      a -= (b * 10 + k) * k\n      b = b * 10 + k * 2\n\
    \    end\n\n    decimal_digits = [] of Int32\n    scale.times do\n      a *= 100\n\
    \      k = (0..9).reverse_each.find { |k| (b * 10 + k) * k <= a }.not_nil!\n \
    \     decimal_digits << k\n      a -= (b * 10 + k) * k\n      b = b * 10 + k *\
    \ 2\n    end\n\n    {integer_digits, decimal_digits}\n  end\nend\n\nprivate def\
    \ check(x, scale, d1, d2)\n  Math.sqrt_digits10(x, scale).should eq({d1, d2})\n\
    end\n\ndescribe Math do\n  it \"sqrt_digits10\" do\n    check 0, 10, [] of Int32,\
    \ [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]\n    check 1, 10, [1], [0, 0, 0, 0, 0, 0, 0,\
    \ 0, 0, 0]\n    check 2, 10, [1], [4, 1, 4, 2, 1, 3, 5, 6, 2, 3]\n    check 3,\
    \ 10, [1], [7, 3, 2, 0, 5, 0, 8, 0, 7, 5]\n    check 123456789, 0, [1, 1, 1, 1,\
    \ 1], [] of Int32\n    check Int32::MAX, 5, [4, 6, 3, 4, 0], [9, 5, 0, 0, 0]\n\
    \    check Int64::MAX, 5, [3, 0, 3, 7, 0, 0, 0, 4, 9, 9], [9, 7, 6, 0, 4]\n  \
    \  x = (1..9).to_a * 64\n    check x.join.to_big_i**2, 0, x, [] of Int32\n   \
    \ expect_raises(ArgumentError) { Math.sqrt_digits10(0, -1) }\n    expect_raises(ArgumentError)\
    \ { Math.sqrt_digits10(-1, 0) }\n  end\nend\n"
  code: "require \"spec\"\nrequire \"big\"\nrequire \"../../src/math/sqrt_digits10\"\
    \n\nprivate def check(x, scale, d1, d2)\n  Math.sqrt_digits10(x, scale).should\
    \ eq({d1, d2})\nend\n\ndescribe Math do\n  it \"sqrt_digits10\" do\n    check\
    \ 0, 10, [] of Int32, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]\n    check 1, 10, [1], [0,\
    \ 0, 0, 0, 0, 0, 0, 0, 0, 0]\n    check 2, 10, [1], [4, 1, 4, 2, 1, 3, 5, 6, 2,\
    \ 3]\n    check 3, 10, [1], [7, 3, 2, 0, 5, 0, 8, 0, 7, 5]\n    check 123456789,\
    \ 0, [1, 1, 1, 1, 1], [] of Int32\n    check Int32::MAX, 5, [4, 6, 3, 4, 0], [9,\
    \ 5, 0, 0, 0]\n    check Int64::MAX, 5, [3, 0, 3, 7, 0, 0, 0, 4, 9, 9], [9, 7,\
    \ 6, 0, 4]\n    x = (1..9).to_a * 64\n    check x.join.to_big_i**2, 0, x, [] of\
    \ Int32\n    expect_raises(ArgumentError) { Math.sqrt_digits10(0, -1) }\n    expect_raises(ArgumentError)\
    \ { Math.sqrt_digits10(-1, 0) }\n  end\nend\n"
  dependsOn:
  - src/math/sqrt_digits10.cr
  isVerificationFile: false
  path: spec/math/sqrt_digits10_spec.cr
  requiredBy: []
  timestamp: '2021-10-15 20:31:02+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/math/sqrt_digits10_spec.cr
layout: document
redirect_from:
- /library/spec/math/sqrt_digits10_spec.cr
- /library/spec/math/sqrt_digits10_spec.cr.html
title: spec/math/sqrt_digits10_spec.cr
---
