# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/2013
require "../datastructure/Imos"
loop do
  n = read_line.to_i
  break if n == 0
  imos = Imos(Int32).new(24 * 60 * 60)
  n.times do
    s, t = read_line.split.map { |i|
      h, m, s = i.split(':').map(&.to_i)
      h * 3600 + m * 60 + s
    }
    imos.add(s...t, 1)
  end
  puts imos.build.max
end
