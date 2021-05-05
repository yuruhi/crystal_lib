# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/library/5/GRL/all/GRL_1_A
require "../graph/dijkstra"
n, m, s = read_line.split.map(&.to_i)
g = Graph.new n, (1..m).map {
  a, b, c = read_line.split.map(&.to_i)
  Edge2.new(a, b, c)
}, undirected: false
puts g.dijkstra(s, "INF").join('\n')
