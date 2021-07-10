# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/library/5/GRL/all/GRL_4_B
require "../src/graph/topological_sort"
n, m = read_line.split.map(&.to_i)
g = UnweightedDirectedGraph.new n, (1..m).map {
  a, b = read_line.split.map(&.to_i)
  UnweightedEdge2.new(a, b)
}
puts g.topological_sort.join('\n')
