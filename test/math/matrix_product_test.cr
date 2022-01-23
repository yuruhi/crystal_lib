# verification-helper: PROBLEM https://judge.yosupo.jp/problem/matrix_product
require "../../src/math/matrix"
require "../../src/math/mint"
require "../../src/scanner"
x, y, z = input(i, i, i)
a, b = input(Matrix.new(Mint2[x, y]), Matrix.new(Mint2[y, z]))
(a * b).join('\n', STDOUT, &.join(' ', STDOUT)); puts
