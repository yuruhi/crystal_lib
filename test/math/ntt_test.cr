# verification-helper: PROBLEM https://judge.yosupo.jp/problem/convolution_mod
require "../../src/math/ntt"
require "../../src/math/mint"
require "../../src/scanner"
n, m = input(i, i)
a, b = input(m2[n], m2[(m)])
puts NTT.convolution(a, b).join(' ')
