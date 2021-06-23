---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "def enumerate_combination(n)\n  res = Array.new(n + 1) { Array.new(n\
    \ + 1, 0i64) }\n  (0..n).each do |i|\n    res[i][0] = res[i][i] = 1\n  end\n \
    \ (1..n).each do |i|\n    (1...i).each do |j|\n      res[i][j] = res[i - 1][j\
    \ - 1] + res[i - 1][j]\n    end\n  end\n  res\nend\n"
  code: "def enumerate_combination(n)\n  res = Array.new(n + 1) { Array.new(n + 1,\
    \ 0i64) }\n  (0..n).each do |i|\n    res[i][0] = res[i][i] = 1\n  end\n  (1..n).each\
    \ do |i|\n    (1...i).each do |j|\n      res[i][j] = res[i - 1][j - 1] + res[i\
    \ - 1][j]\n    end\n  end\n  res\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: math/enumerate_combination.cr
  requiredBy: []
  timestamp: '2021-06-23 22:45:28+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: math/enumerate_combination.cr
layout: document
redirect_from:
- /library/math/enumerate_combination.cr
- /library/math/enumerate_combination.cr.html
title: math/enumerate_combination.cr
---
