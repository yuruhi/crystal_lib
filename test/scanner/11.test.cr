# verification-helper: PROBLEM https://yukicoder.me/problems/no/1507
require "../../src/scanner"
require "../../src/graph/tree"
require "../../src/math/mint"
n = input(i)
m = Mint2.new(n.to_i64 * ~-n // 2)
g = UnweightedUndirectedGraph.new n, Array.new(n - 1) { input(i - 1, i.pred) }

puts g.subtree_size(0)[1..].sum { |size|
  size2 = Mint2.new(size.to_i64 * (n - size))
  (m - size2) / m
} / n.pred
