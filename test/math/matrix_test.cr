# verification-helper: PROBLEM https://yukicoder.me/problems/no/997
require "../../src/math/mint"
require "../../src/math/matrix"
require "../../src/scanner"
n, w, k = input(i, i, i64)
a = input(i[n])

dp = Array.new(2 * w + 1) { Mint[0, 0] }
dp[0][0] = Mint.new(1)
(1..2 * w).each do |i|
  (0...n).each do |j|
    i2 = i - a[j]
    dp[i][0] += dp[i2][0] if 0 <= i2
    dp[i][1] += dp[i2][1] if 0 <= i2
    dp[i][1] += dp[i2][0] if 0 <= i2 < w < i
  end
end

val1, val2 = dp[w][0], dp[2 * w][1]
x = Matrix(Mint).from [val1, val2], [1, 0]
y = Matrix(Mint).from [val1], [1]
puts (x**k * y)[1][0]
