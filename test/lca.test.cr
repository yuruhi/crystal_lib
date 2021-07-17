# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/GRL_5_C
require "../src/graph/lca"
n = read_line.to_i
g1 = UnweightedUndirectedGraph.new(n)
g2 = UndirectedGraph(Int32).new(n)
n.times do |u|
  read_line.split.map(&.to_i).skip(1).each do |v|
    g1 << {u, v}
    g2 << {u, v, 42}
  end
end
lca1 = LCA.new(g1, 0)
lca2 = LCA.new(g2, 0)
read_line.to_i.times do
  u, v = read_line.split.map(&.to_i)
  a1, a2 = lca1.lca(u, v), lca2.lca(u, v)
  raise "" unless a1 == a2
  puts a1
end
