# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/library/6/NTL/1/NTL_1_B
require "../math/Mint"
static_modint(Mint, 1000000007)
a, b = read_line.split.map(&.to_i)
puts Mint.new(a)**b
