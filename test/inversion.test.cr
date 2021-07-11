# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/lesson/1/ALDS1/all/ALDS1_5_D
require "../src/DP/inversion"
n = read_line.to_i
a = read_line.split.map(&.to_i)
values = a.uniq.sort
a.map! { |x| values.bsearch_index { |y| y >= x }.not_nil! }
puts DP.inversion(a)
