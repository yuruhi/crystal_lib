# verification-helper: PROBLEM https://judge.yosupo.jp/problem/convolution_mod
require "../math/NTT"
require "../math/Mint"
n, m = read_line.split.map(&.to_i)
a = read_line.split.map(&.to_m2)
b = read_line.split.map(&.to_m2)
puts NTT.multiple(a, b).join(' ')
