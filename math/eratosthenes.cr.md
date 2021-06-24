---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "def eratosthenes(n : Int32)\n  raise ArgumentError.new if n <= 0\n\
    \  res = [true] * (n + 1)\n  res[0] = res[1] = false\n  2.upto(n) do |i|\n   \
    \ next if !res[i] || i.to_i64 ** 2 > n\n    (i**2).step(to: n, by: i) do |j|\n\
    \      res[j] = false\n    end\n  end\n  res\nend\n\ndef primes(n : Int32)\n \
    \ flag = eratosthenes(n)\n  (2..n).select { |i| flag[i] }\nend\n"
  code: "def eratosthenes(n : Int32)\n  raise ArgumentError.new if n <= 0\n  res =\
    \ [true] * (n + 1)\n  res[0] = res[1] = false\n  2.upto(n) do |i|\n    next if\
    \ !res[i] || i.to_i64 ** 2 > n\n    (i**2).step(to: n, by: i) do |j|\n      res[j]\
    \ = false\n    end\n  end\n  res\nend\n\ndef primes(n : Int32)\n  flag = eratosthenes(n)\n\
    \  (2..n).select { |i| flag[i] }\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: math/eratosthenes.cr
  requiredBy: []
  timestamp: '2021-06-24 09:33:06+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: math/eratosthenes.cr
layout: document
redirect_from:
- /library/math/eratosthenes.cr
- /library/math/eratosthenes.cr.html
title: math/eratosthenes.cr
---