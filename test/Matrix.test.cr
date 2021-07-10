# verification-helper: PROBLEM https://yukicoder.me/problems/no/997
require "../src/math/Mint"
require "../src/math/Matrix"

n, w, k = read_line.split.try { |(n, w, k)|
  {n.to_i, w.to_i, k.to_i64}
}
a = read_line.split.map(&.to_i)

dp = Array.new(2 * w + 1) { Array.new(2, 0.to_m) }
dp[0][0] = 1.to_m
(1..2 * w).each do |i|
  (0...n).each do |j|
    i2 = i - a[j]
    dp[i][0] += dp[i2][0] if 0 <= i2
    dp[i][1] += dp[i2][1] if 0 <= i2
    dp[i][1] += dp[i2][0] if 0 <= i2 < w < i
  end
end

val1, val2 = dp[w][0], dp[2 * w][1]
x = Matrix.new([[val1, val2], [1.to_m, 0.to_m]])
y = Matrix.new([[val1], [1.to_m]])
puts (x**k * y)[1][0]
