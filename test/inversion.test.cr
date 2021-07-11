# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/lesson/1/ALDS1/all/ALDS1_5_D
require "../src/DP/inversion"
require "../src/array/compress"
read_line
a = read_line.split.map(&.to_i)
puts DP.inversion(a.compress)
