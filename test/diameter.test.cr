# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/GRL_5_A
require "../src/graph/tree"
n = read_line.to_i
g = UndirectedGraph.new n, (1..n - 1).map {
  a, b, c = read_line.split.map(&.to_i)
  Edge2.new(a, b, c.to_i)
}
puts g.diameter[0]
