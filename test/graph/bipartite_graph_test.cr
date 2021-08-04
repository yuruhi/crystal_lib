# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/2885
require "../../src/graph/bipartite_graph"
require "../../src/scanner"

loop do
  n, m = input(i, i)
  break if n + m == 0
  graph = UnweightedUndirectedGraph.new n, input({i - 1, i - 1}[m])
  if color = graph.bipartite_graph
    ans = {false, true}.map { |c| color.count(c) }.select(&.even?).map(&.//(2)).uniq!.sort!
    puts ans.size
    puts ans.join('\n') unless ans.empty?
  else
    puts 0
  end
end
