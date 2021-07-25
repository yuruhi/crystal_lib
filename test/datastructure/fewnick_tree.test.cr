# verification-helper: PROBLEM https://judge.yosupo.jp/problem/point_add_range_sum
require "../../src/datastructure/fenwick_tree"
_, q = read_line.split.map(&.to_i)
a = read_line.split.map(&.to_i64)
seg = FenwickTree.new(a)
q.times do
  t, x, y = read_line.split.map(&.to_i)
  if t == 0
    seg.add(x, y)
  else
    puts seg[x...y]
  end
end
