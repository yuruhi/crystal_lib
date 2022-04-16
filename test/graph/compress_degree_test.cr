# verification-helper: PROBLEM https://yukicoder.me/problems/no/1605
require "../../src/graph/compress"
require "../../src/graph/degree"
require "../../src/datastructure/union_find"
require "../../src/scanner"
n = input(i)
edges = input({i, i}[n])
graph = UnweightedDiGraph.new(2*10**5 + 1, edges).compress
m = graph.size
uf = UnionFind.new(m)
graph.each { |edge| uf.unite(edge.from, edge.to) }

if uf.size(0) != m
  puts 0
else
  degree = graph.indegree.zip(graph.outdegree).map { |x, y| x - y }
  if degree.all?(0)
    puts m
  elsif degree.tally == {-1 => 1, 1 => 1, 0 => m - 2}
    puts 1
  else
    puts 0
  end
end
