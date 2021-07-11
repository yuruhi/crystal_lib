# verification-helper: PROBLEM https://judge.yosupo.jp/problem/static_range_sum
require "../src/datastructure/cul_sum"
_, q = read_line.split.map(&.to_i)
a = read_line.split.map(&.to_i64)
sum = CulSum.new(a)
q.times do
  l, r = read_line.split.map(&.to_i)
  puts sum[l...r]
end
