# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/library/5/GRL/all/GRL_4_B
require "graph/topological_sort"
n, m = read_line.split.map(&.to_i)
g = Graph.new n, (1..m).map {
  a, b = read_line.split.map(&.to_i)
  Edge2.new(a, b, nil)
}, undirected: false
puts g.topological_sort.join('\n')
