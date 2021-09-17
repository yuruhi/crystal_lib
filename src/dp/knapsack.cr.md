---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/dp/knapsack01_test.cr
    title: test/dp/knapsack01_test.cr
  - icon: ':heavy_check_mark:'
    path: test/dp/knapsack_test.cr
    title: test/dp/knapsack_test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "module DP\n  extend self\n\n  def knapsack(weight_limit : Int32, value\
    \ : Array(Int), weight : Array(Int32))\n    raise ArgumentError.new unless value.size\
    \ == weight.size\n    n = value.size\n    (0...n).each_with_object([typeof(value.first).zero]\
    \ * weight_limit.succ) do |i, dp|\n      (0..weight_limit - weight[i]).each do\
    \ |j|\n        dp[j + weight[i]] = Math.max(dp[j + weight[i]], dp[j] + value[i])\n\
    \      end\n    end\n  end\n\n  def knapsack01(weight_limit : Int32, value : Array(Int),\
    \ weight : Array(Int32))\n    raise ArgumentError.new unless value.size == weight.size\n\
    \    n = value.size\n    (0...n).each_with_object([typeof(value.first).zero] *\
    \ weight_limit.succ) do |i, dp|\n      (0..weight_limit - weight[i]).reverse_each\
    \ do |j|\n        dp[j + weight[i]] = Math.max(dp[j + weight[i]], dp[j] + value[i])\n\
    \      end\n    end\n  end\nend\n"
  code: "module DP\n  extend self\n\n  def knapsack(weight_limit : Int32, value :\
    \ Array(Int), weight : Array(Int32))\n    raise ArgumentError.new unless value.size\
    \ == weight.size\n    n = value.size\n    (0...n).each_with_object([typeof(value.first).zero]\
    \ * weight_limit.succ) do |i, dp|\n      (0..weight_limit - weight[i]).each do\
    \ |j|\n        dp[j + weight[i]] = Math.max(dp[j + weight[i]], dp[j] + value[i])\n\
    \      end\n    end\n  end\n\n  def knapsack01(weight_limit : Int32, value : Array(Int),\
    \ weight : Array(Int32))\n    raise ArgumentError.new unless value.size == weight.size\n\
    \    n = value.size\n    (0...n).each_with_object([typeof(value.first).zero] *\
    \ weight_limit.succ) do |i, dp|\n      (0..weight_limit - weight[i]).reverse_each\
    \ do |j|\n        dp[j + weight[i]] = Math.max(dp[j + weight[i]], dp[j] + value[i])\n\
    \      end\n    end\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/dp/knapsack.cr
  requiredBy: []
  timestamp: '2021-09-17 10:16:01+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/dp/knapsack01_test.cr
  - test/dp/knapsack_test.cr
documentation_of: src/dp/knapsack.cr
layout: document
redirect_from:
- /library/src/dp/knapsack.cr
- /library/src/dp/knapsack.cr.html
title: src/dp/knapsack.cr
---
