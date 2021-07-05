# verification-helper: PROBLEM https://judge.yosupo.jp/problem/point_add_range_sum
require "../datastructure/BinaryIndexedTree"
_, q = read_line.split.map(&.to_i)
a = read_line.split.map(&.to_i64)
seg = BinaryIndexedTree.new(a)
q.times do
  t, x, y = read_line.split.map(&.to_i)
  if t == 0
    seg.add(x, y)
  else
    puts seg[x...y]
  end
end
