# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/ALDS1_11_C
require "../src/graph/bfs"
n = read_line.to_i
graph = UnweightedDirectedGraph.new(n)
n.times do
  a = read_line.split.map(&.to_i)
  u = a.shift
  a.shift
  a.each do |v|
    graph.add_edge(u - 1, v - 1)
  end
end

graph.bfs(0).each_with_index do |d, i|
  puts "#{i + 1} #{d || -1}"
end
