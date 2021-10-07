# verification-helper: PROBLEM https://judge.yosupo.jp/problem/matrix_product
require "../../src/math/matrix"
require "../../src/math/mint"
require "../../src/scanner"
x, y, z = input(i, i, i)
a, b = input(m2[x, y], m2[y, z])
a = Matrix.new a
b = Matrix.new b
(a * b).join('\n', STDOUT, &.join(' ', STDOUT)); puts
