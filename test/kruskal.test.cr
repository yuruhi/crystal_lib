# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/library/5/GRL/all/GRL_2_A
require "../graph/kruskal"
n, m = read_line.split.map(&.to_i)
edges = (1..m).map {
  a, b, c = read_line.split.map(&.to_i)
  Edge2.new(a, b, c.to_i64)
}
puts kruskal(n, edges)
