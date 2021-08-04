# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/lesson/1/ALDS1/all/ALDS1_11_D
require "../../src/graph/components"
require "../../src/scanner"
n, m = input(i, i)
edges = input({i, i}[m])

g = DirectedGraph.new n, (edges + edges.map(&.reverse)).map { |u, v| {u, v, 42} }
m, id, groups = g.components

begin
  g2 = UndirectedGraph.new n, edges.map { |u, v| {u, v, 42} }
  raise "" unless {m, id, groups} == g2.components
end
begin
  g2 = UnweightedDirectedGraph.new n, edges + edges.map(&.reverse)
  raise "" unless {m, id, groups} == g2.components
end
begin
  g2 = UnweightedUndirectedGraph.new n, edges
  raise "" unless {m, id, groups} == g2.components
end

read_line.to_i.times do
  a, b = input(i, i)
  if id[a] == id[b]
    puts "yes"
    raise "" unless groups[id[a]].includes?(a) && groups[id[a]].includes?(b)
  else
    puts "no"
  end
end
