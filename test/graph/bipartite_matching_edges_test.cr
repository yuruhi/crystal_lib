# verification-helper: PROBLEM https://judge.yosupo.jp/problem/bipartitematching
require "../../src/graph/bipartite_matching"
require "../../src/scanner"
l, r, m = input(i, i, i)
graph = BipartiteMatching.new l, r, input({i, i}[m])
puts graph.solve
raise "" unless graph.to_a == graph.each.to_a
graph.each do |edge|
  puts "#{edge.from} #{edge.to}"
end
