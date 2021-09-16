---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/dp/lcs_test.cr
    title: test/dp/lcs_test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "module DP\n  extend self\n\n  def lcs(s, t)\n    n, m = s.size, t.size\n\
    \    dp = Array.new(m + 1, 0)\n    n.times do |i|\n      dp2 = dp.dup\n      m.times\
    \ do |j|\n        dp2[j + 1] = {dp2[j + 1], dp[j] + 1}.max if s[i] == t[j]\n \
    \       dp2[j + 1] = {dp2[j + 1], dp2[j]}.max\n      end\n      dp = dp2\n   \
    \ end\n    dp[m]\n  end\nend\n"
  code: "module DP\n  extend self\n\n  def lcs(s, t)\n    n, m = s.size, t.size\n\
    \    dp = Array.new(m + 1, 0)\n    n.times do |i|\n      dp2 = dp.dup\n      m.times\
    \ do |j|\n        dp2[j + 1] = {dp2[j + 1], dp[j] + 1}.max if s[i] == t[j]\n \
    \       dp2[j + 1] = {dp2[j + 1], dp2[j]}.max\n      end\n      dp = dp2\n   \
    \ end\n    dp[m]\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/dp/lcs.cr
  requiredBy: []
  timestamp: '2021-09-16 12:06:18+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/dp/lcs_test.cr
documentation_of: src/dp/lcs.cr
layout: document
redirect_from:
- /library/src/dp/lcs.cr
- /library/src/dp/lcs.cr.html
title: src/dp/lcs.cr
---
