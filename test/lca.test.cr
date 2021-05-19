# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/GRL_5_C
require "../graph/lca"
n = read_line.to_i
graph = UnweightedUndirectedGraph.new(n)
n.times do |u|
  read_line.split.map(&.to_i).skip(1).each do |v|
    graph.add_edge(u, v)
  end
end
lca = LCA.new(graph, 0)
read_line.to_i.times do
  u, v = read_line.split.map(&.to_i)
  puts lca.lca(u, v)
end
