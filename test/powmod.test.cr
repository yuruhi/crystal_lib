# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/library/6/NTL/1/NTL_1_B
require "../src/math/mint"
a, b = read_line.split.map(&.to_i)
puts Mint.new(a)**b
