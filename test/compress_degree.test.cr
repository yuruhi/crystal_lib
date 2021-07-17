# verification-helper: PROBLEM https://yukicoder.me/problems/no/1605
require "../src/graph/compress"
require "../src/graph/degree"
require "../src/datastructure/union_find"
n = read_line.to_i
edges = Array.new(n) { u, v = read_line.split.map(&.to_i); UnweightedEdge2.new(u, v) }
graph = UnweightedDirectedGraph.new(2*10**5 + 1, edges).compress
m = graph.size
uf = UnionFind.new(m)
graph.each { |e| uf.unite(e.from, e.to) }

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
