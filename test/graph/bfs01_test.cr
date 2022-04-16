# verification-helper: PROBLEM https://yukicoder.me/problems/no/1607
require "../../src/graph/bfs01"
require "../../src/scanner"
n, m, k = input(i, i, i)
graph = UnGraph.new n, input({i - 1, i - 1, i}[m])
puts (0..2*10**5).bsearch { |x|
  d1 = graph.bfs01_st(0, n - 1) { |edge| edge.cost > x ? 1 : 0 }.not_nil!
  d2 = graph.bfs01_st!(0, n - 1) { |edge| edge.cost > x ? 1 : 0 }
  d3 = graph.bfs01(0) { |edge| edge.cost > x ? 1 : 0 }.last.not_nil!
  d4 = graph.bfs01!(0) { |edge| edge.cost > x ? 1 : 0 }.last
  raise "" unless d1 == d2 == d3 == d4
  d1 < k
}
