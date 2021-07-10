# verification-helper: PROBLEM https://judge.yosupo.jp/problem/bipartitematching
require "../src/graph/BipartiteMatching"
l, r, m = read_line.split.map(&.to_i)
graph = BipartiteMatching.new(l, r)
m.times do
  a, b = read_line.split.map(&.to_i)
  graph.add_edge(a, b)
end
puts graph.solve
graph.each_edge do |edge|
  puts "#{edge.from} #{edge.to}"
end
