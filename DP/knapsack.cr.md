---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/Knapsack.test.cr
    title: test/Knapsack.test.cr
  - icon: ':heavy_check_mark:'
    path: test/Knapsack01.test.cr
    title: test/Knapsack01.test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "def knapsack(weight_limit : Int32, value : Array(Int), weight : Array(Int32))\n\
    \  raise ArgumentError.new unless value.size == weight.size\n  n = value.size\n\
    \  (0...n).each_with_object([typeof(value.first).zero] * weight_limit.succ) do\
    \ |i, dp|\n    (0..weight_limit - weight[i]).each do |j|\n      dp[j + weight[i]]\
    \ = Math.max(dp[j + weight[i]], dp[j] + value[i])\n    end\n  end\nend\n\ndef\
    \ knapsack01(weight_limit : Int32, value : Array(Int), weight : Array(Int32))\n\
    \  raise ArgumentError.new unless value.size == weight.size\n  n = value.size\n\
    \  (0...n).each_with_object([typeof(value.first).zero] * weight_limit.succ) do\
    \ |i, dp|\n    (0..weight_limit - weight[i]).reverse_each do |j|\n      dp[j +\
    \ weight[i]] = Math.max(dp[j + weight[i]], dp[j] + value[i])\n    end\n  end\n\
    end\n"
  code: "def knapsack(weight_limit : Int32, value : Array(Int), weight : Array(Int32))\n\
    \  raise ArgumentError.new unless value.size == weight.size\n  n = value.size\n\
    \  (0...n).each_with_object([typeof(value.first).zero] * weight_limit.succ) do\
    \ |i, dp|\n    (0..weight_limit - weight[i]).each do |j|\n      dp[j + weight[i]]\
    \ = Math.max(dp[j + weight[i]], dp[j] + value[i])\n    end\n  end\nend\n\ndef\
    \ knapsack01(weight_limit : Int32, value : Array(Int), weight : Array(Int32))\n\
    \  raise ArgumentError.new unless value.size == weight.size\n  n = value.size\n\
    \  (0...n).each_with_object([typeof(value.first).zero] * weight_limit.succ) do\
    \ |i, dp|\n    (0..weight_limit - weight[i]).reverse_each do |j|\n      dp[j +\
    \ weight[i]] = Math.max(dp[j + weight[i]], dp[j] + value[i])\n    end\n  end\n\
    end\n"
  dependsOn: []
  isVerificationFile: false
  path: DP/knapsack.cr
  requiredBy: []
  timestamp: '2021-06-24 10:46:20+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/Knapsack.test.cr
  - test/Knapsack01.test.cr
documentation_of: DP/knapsack.cr
layout: document
redirect_from:
- /library/DP/knapsack.cr
- /library/DP/knapsack.cr.html
title: DP/knapsack.cr
---
