# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/ALDS1_11_C
require "../graph/bfs"
n = read_line.to_i
graph = UnweightedDirectedGraph.new(n)
n.times do
  a = read_line.split.map(&.to_i)
  u = a.shift
  k = a.shift
  a.each do |v|
    graph.add_edge(u - 1, v - 1)
  end
end

dist = graph.bfs(0, -1)
(0...n).each do |i|
  puts({i + 1, dist[i]}.join(' '))
end
