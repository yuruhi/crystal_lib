# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/library/7/DPL/1/DPL_1_C
require "../../src/dp/knapsack"
require "../../src/scanner"
n, limit = input(i, i)
v, w = input_column({Int32, Int32}, n)
puts DP.knapsack(limit, v, w).last
