# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/ALDS1_10_C
require "../../src/dp/lcs"
read_line.to_i.times do
  s = read_line
  t = read_line
  puts DP.lcs(s, t)
end
