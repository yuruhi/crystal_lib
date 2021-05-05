# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/challenges/sources/VPC/HUPC/3185
require "utility/Point"
h, w = read_line.split.map(&.to_i)
s = (1..h).map { read_line }
d = Point.to_direction(read_line, "EWSN")
Point.set_range(h, w)
puts Point.select { |p| s[p] == '#' }.max_of { |p|
  cnt = 0
  while p.in_range?
    cnt += 1
    p += d
  end
  cnt
}
