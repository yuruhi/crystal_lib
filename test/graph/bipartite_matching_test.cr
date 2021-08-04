# verification-helper: PROBLEM https://yukicoder.me/problems/no/1479
require "../../src/graph/bipartite_matching"
require "../../src/scanner"
require "../../src/tuple/times"

h, w = input(i, i)
a = input(i[h, w])

l, r = 0, 0
edges = {h, w}.times.group_by { |(i, j)|
  a[i][j]
}.flat_map { |val, points|
  next [] of {Int32, Int32} if val == 0
  row = {} of Int32 => Int32
  column = {} of Int32 => Int32
  points.map do |(y, x)|
    ll = row[y]? || (row[y] = (l += 1) - 1)
    rr = column[x]? || (column[x] = (r += 1) - 1)
    {ll, rr}
  end
}

ans1 = BipartiteMatching.new(l, r).add_edges(edges).solve
ans2 = BipartiteMatching.new(l, r, edges).solve
raise "" unless ans1 == ans2
puts ans1
