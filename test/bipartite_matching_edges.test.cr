# verification-helper: PROBLEM https://judge.yosupo.jp/problem/bipartitematching
require "../src/graph/bipartite_matching"
l, r, m = read_line.split.map(&.to_i)
graph = BipartiteMatching.new(l, r)
m.times do
  a, b = read_line.split.map(&.to_i)
  graph << {a, b}
end
puts graph.solve
raise "" unless graph.to_a == graph.each.to_a
graph.each do |edge|
  puts "#{edge.from} #{edge.to}"
end
