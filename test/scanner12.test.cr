# verification-helper: PROBLEM https://yukicoder.me/problems/no/1606
require "../src/scanner"
s = input(c[i].join)
n = s.size
ans = s.split('2').map { |s|
  {s.count('0'), s.count('1')}
}.reduce([0] + [10**9] * (2*n)) { |dp, (a, b)|
  (-n..n).each_with_object([10**9] * (2*n + 1)) do |i, dp2|
    dp2[i - a] = {dp2[i - a], dp[i] + a}.min if i - a >= -n
    dp2[i + b] = {dp2[i + b], dp[i] + b}.min if i + b <= +n
  end
}[0]
puts ans < 10**9 ? ans // 2 : -1
