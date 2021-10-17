# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/lesson/8/ITP2/all/ITP2_11_D
require "../../src/int/each_combination"
n, k = read_line.split.map(&.to_i)

ans = [] of Int32
Int.each_combination(n, k) { |x| ans << x }
ans2 = Int.each_combination(n, k).to_a
raise "" unless ans == ans2

ans.each do |x|
  print x, ": ", (0...n).select { |i| x.bit(i) == 1 }.join(' '), '\n'
end
