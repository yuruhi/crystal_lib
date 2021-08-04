# verification-helper: PROBLEM https://yukicoder.me/problems/no/1607
require "../../src/scanner"
require "../../src/graph/bfs01"
n, m, k = input(i, i, i)
graph = UndirectedGraph.new n, input({i - 1, i - 1, i64}[m])
puts (0..2*10**5).bsearch { |x|
  graph.bfs01_st(0, n - 1) { |edge| edge.cost > x ? 1 : 0 }.not_nil! < k
}
