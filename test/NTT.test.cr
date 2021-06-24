# verification-helper: PROBLEM https://judge.yosupo.jp/problem/convolution_mod
require "../math/NTT"
require "../math/Mint"
static_modint(Mint, 998244353)
n, m = read_line.split.map(&.to_i)
a = read_line.split.map(&.to_m)
b = read_line.split.map(&.to_m)
puts NTT.multiple(a, b).join(' ')
