---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: DP/knapsack.cr
    title: DP/knapsack.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://onlinejudge.u-aizu.ac.jp/courses/library/7/DPL/1/DPL_1_B
  bundledCode: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/library/7/DPL/1/DPL_1_B\n\
    # require \"../DP/knapsack\"\ndef knapsack(weight_limit : Int32, value : Array(Int),\
    \ weight : Array(Int32))\n  raise ArgumentError.new unless value.size == weight.size\n\
    \  n = value.size\n  (0...n).each_with_object([typeof(value.first).zero] * weight_limit.succ)\
    \ do |i, dp|\n    (0..weight_limit - weight[i]).each do |j|\n      dp[j + weight[i]]\
    \ = Math.max(dp[j + weight[i]], dp[j] + value[i])\n    end\n  end\nend\n\ndef\
    \ knapsack01(weight_limit : Int32, value : Array(Int), weight : Array(Int32))\n\
    \  raise ArgumentError.new unless value.size == weight.size\n  n = value.size\n\
    \  (0...n).each_with_object([typeof(value.first).zero] * weight_limit.succ) do\
    \ |i, dp|\n    (0..weight_limit - weight[i]).reverse_each do |j|\n      dp[j +\
    \ weight[i]] = Math.max(dp[j + weight[i]], dp[j] + value[i])\n    end\n  end\n\
    end\n\nn, limit = read_line.split.map(&.to_i)\nv, w = (1..n).map { read_line.split.map(&.to_i)\
    \ }.transpose\nputs knapsack01(limit, v, w)[limit]\n"
  code: '# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/library/7/DPL/1/DPL_1_B

    require "../DP/knapsack"

    n, limit = read_line.split.map(&.to_i)

    v, w = (1..n).map { read_line.split.map(&.to_i) }.transpose

    puts knapsack01(limit, v, w)[limit]

    '
  dependsOn:
  - DP/knapsack.cr
  isVerificationFile: true
  path: test/Knapsack01.test.cr
  requiredBy: []
  timestamp: '2021-06-20 15:20:58+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/Knapsack01.test.cr
layout: document
redirect_from:
- /verify/test/Knapsack01.test.cr
- /verify/test/Knapsack01.test.cr.html
title: test/Knapsack01.test.cr
---
