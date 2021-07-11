# verification-helper: PROBLEM https://judge.yosupo.jp/problem/convolution_mod
require "../src/math/ntt"
require "../src/math/mint"
_, _ = read_line.split.map(&.to_i)
a = read_line.split.map(&.to_m2)
b = read_line.split.map(&.to_m2)
puts NTT.convolution(a, b).join(' ')
