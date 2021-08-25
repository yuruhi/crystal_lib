# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/challenges/sources/VPC/RUPC/2286?year=2011
require "../../src/math/euler"

MAX_A = 1000000
euler = Math.euler_table(MAX_A)
ans = [1i64]
(1..MAX_A).each do |i|
  ans << ans.last + euler[i]
end

read_line.to_i.times do
  x = read_line.to_i
  puts ans[x]
end
