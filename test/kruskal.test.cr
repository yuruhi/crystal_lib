# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/library/5/GRL/all/GRL_2_A
require "../src/graph/kruskal"
n, m = read_line.split.map(&.to_i)
graph = DirectedGraph.new n, Array.new(m) {
  a, b, c = read_line.split.map(&.to_i)
  {a, b, c.to_i64}
}
puts graph.kruskal.not_nil!
