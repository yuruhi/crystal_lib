# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/library/5/GRL/all/GRL_2_A
require "../../src/graph/kruskal"
require "../../src/scanner"
n, m = input(i, i)
graph = DirectedGraph.new n, input({i, i, i64}[m])
puts graph.kruskal.not_nil!
