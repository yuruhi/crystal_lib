# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/2885
require "../src/graph/bipartite_graph"

loop do
  n, m = read_line.split.map(&.to_i)
  break if n + m == 0
  graph = UnweightedUndirectedGraph.new n, (1..m).map {
    u, v = read_line.split.map(&.to_i.pred)
    UnweightedEdge2.new(u, v)
  }
  if color = graph.bipartite_graph
    ans = {false, true}.map { |c| color.count(c) }.select(&.even?).map(&.//(2)).uniq!.sort!
    puts ans.size
    puts ans.join('\n') unless ans.empty?
  else
    puts 0
  end
end
