# verification-helper: PROBLEM https://judge.yosupo.jp/problem/shortest_path
require "../../src/graph/dijkstra"
require "../../src/scanner"
n, m, s, t = input(i, i, i, i)
graph = DirectedGraph.new n, input({i, i, i64}[m])
if dist_path = graph.dijkstra_with_path(s, t)
  d, path = dist_path
  puts "#{d} #{path.size - 1}"
  path.each_cons_pair do |u, v|
    puts "#{u} #{v}"
  end
else
  puts -1
end
