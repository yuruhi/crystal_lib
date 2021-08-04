# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/lesson/1/ALDS1/all/ALDS1_14_B
require "../../src/string/rolling_hash"
s = RollingHash.new read_line
t = RollingHash.new read_line
(0..s.size - t.size).each { |i|
  puts i if s[i, t.size] == t[0, t.size]
}
