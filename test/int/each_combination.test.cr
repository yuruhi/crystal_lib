# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/lesson/8/ITP2/all/ITP2_11_D
require "../../src/int/each_combination"
n, k = read_line.split.map(&.to_i)

ans = [] of Int32
n.each_combination(k) { |x| ans << x }
ans2 = n.each_combination(k).to_a
raise "" unless ans == ans2

ans.each do |x|
  print x, ":"
  (0...n).each do |i|
    print ' ', i if x.bit(i) == 1
  end
  puts
end
