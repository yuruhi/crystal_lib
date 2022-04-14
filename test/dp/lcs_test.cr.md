---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/dp/lcs.cr
    title: src/dp/lcs.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://onlinejudge.u-aizu.ac.jp/problems/ALDS1_10_C
  bundledCode: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/ALDS1_10_C\n\
    # require \"../../src/dp/lcs\"\nmodule DP\n  extend self\n\n  def lcs(s, t)\n\
    \    n, m = s.size, t.size\n    dp = Array.new(m + 1, 0)\n    n.times do |i|\n\
    \      dp2 = dp.dup\n      m.times do |j|\n        dp2[j + 1] = {dp2[j + 1], dp[j]\
    \ + 1}.max if s[i] == t[j]\n        dp2[j + 1] = {dp2[j + 1], dp2[j]}.max\n  \
    \    end\n      dp = dp2\n    end\n    dp[m]\n  end\nend\n\nread_line.to_i.times\
    \ do\n  s = read_line\n  t = read_line\n  puts DP.lcs(s, t)\nend\n"
  code: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/ALDS1_10_C\n\
    require \"../../src/dp/lcs\"\nread_line.to_i.times do\n  s = read_line\n  t =\
    \ read_line\n  puts DP.lcs(s, t)\nend\n"
  dependsOn:
  - src/dp/lcs.cr
  isVerificationFile: true
  path: test/dp/lcs_test.cr
  requiredBy: []
  timestamp: '2021-08-04 13:11:57+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/dp/lcs_test.cr
layout: document
redirect_from:
- /verify/test/dp/lcs_test.cr
- /verify/test/dp/lcs_test.cr.html
title: test/dp/lcs_test.cr
---
