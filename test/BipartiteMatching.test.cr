# verification-helper: PROBLEM https://yukicoder.me/problems/no/1479
require "../graph/BipartiteMatching"

h, w = read_line.split.map(&.to_i)
a = (1..h).map { read_line.split.map(&.to_i) }

l, r = 0, 0
edges = Array.product((0...h).to_a, (0...w).to_a).group_by { |(i, j)|
  a[i][j]
}.flat_map { |val, points|
  next [] of Edge2(Nil) if val == 0
  row = {} of Int32 => Int32
  column = {} of Int32 => Int32
  points.map do |(y, x)|
    ll = row[y]? || (row[y] = (l += 1) - 1)
    rr = column[x]? || (column[x] = (r += 1) - 1)
    Edge2.new(ll, rr, nil)
  end
}

puts BipartiteMatching.new(l, r).add_edge(edges).solve
