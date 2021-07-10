# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/library/5/GRL/all/GRL_1_A
require "../src/graph/dijkstra"
n, m, s = read_line.split.map(&.to_i)
g = DirectedGraph.new n, (1..m).map {
  a, b, c = read_line.split.map(&.to_i)
  Edge2.new(a, b, c)
}
puts g.dijkstra(s, "INF").join('\n')
