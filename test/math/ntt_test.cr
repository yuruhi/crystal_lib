# verification-helper: PROBLEM https://judge.yosupo.jp/problem/convolution_mod
require "../../src/math/ntt"
require "../../src/math/mint"
require "../../src/scanner"
n, m = input(i, i) # ameba:disable Lint/UselessAssign
a, b = input(Mint2[n], Mint2[:m])
puts NTT.convolution(a, b).join(' ')
