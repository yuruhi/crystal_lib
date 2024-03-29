# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/GRL_5_C
require "../../src/graph/lca"
require "../../src/scanner"
n = input(i)

g1 = UnweightedUnGraph.new(n)
g2 = UnGraph(Int32).new(n)
n.times do |u|
  input(i[i]).each do |v|
    g1 << {u, v}
    g2 << {u, v, 42}
  end
end

lca1 = LCA.new(g1, 0)
lca2 = LCA.new(g2, 0)

input(i).times do
  u, v = input(i, i)
  a1, a2 = lca1.lca(u, v), lca2.lca(u, v)
  raise "" unless a1 == a2
  puts a1
end
