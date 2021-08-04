# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/library/5/GRL/all/GRL_1_A
require "../../src/graph/dijkstra"
require "../../src/scanner"
n, m, s = input(i, i, i)
graph = DirectedGraph.new n, input({i, i, i}[m])
puts graph.dijkstra(s).join('\n') { |d| d || "INF" }
