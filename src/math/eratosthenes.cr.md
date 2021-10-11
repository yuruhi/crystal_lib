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
  path: src/math/eratosthenes.cr
  requiredBy: []
  timestamp: '2021-10-11 09:19:30+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/math/eratosthenes.cr
layout: document
redirect_from:
- /library/src/math/eratosthenes.cr
- /library/src/math/eratosthenes.cr.html
title: src/math/eratosthenes.cr
---
