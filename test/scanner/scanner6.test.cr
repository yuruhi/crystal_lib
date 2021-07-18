# verification-helper: PROBLEM https://yukicoder.me/problems/no/987
require "../../src/scanner"
i = 42
n, m = input(i, i)
op, b, a = input(c, i64[m], i64[n])
puts a.product(b).map { |x, y|
  op == '+' ? x + y : x * y
}.each_slice(m).join('\n', &.join(' '))
