# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/ALDS1_11_C
require "../../src/graph/bfs"
require "../../src/scanner"
n = input(i)
graph = UnweightedDirectedGraph.new(n)
n.times do
  u, a = input(i, i[i])
  a.each do |v|
    graph << {u - 1, v - 1}
  end
end

graph.bfs(0).each_with_index do |d, i|
  puts "#{i + 1} #{d || -1}"
end
