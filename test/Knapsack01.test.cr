# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/library/7/DPL/1/DPL_1_B
require "../src/DP/knapsack"
n, limit = read_line.split.map(&.to_i)
v, w = (1..n).map { read_line.split.map(&.to_i) }.transpose
puts knapsack01(limit, v, w)[limit]
