# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/lesson/1/ALDS1/all/ALDS1_11_D
require "../src/graph/components"
n, m = read_line.split.map(&.to_i)
edges = Array.new(m) { {Int32, Int32}.from read_line.split.map(&.to_i) }
g = DirectedGraph.new n, (edges + edges.map(&.reverse)).map { |u, v| {u, v, 42} }
m, id, groups = g.components
begin
  g2 = UndirectedGraph.new n, edges.map { |u, v| {u, v, 42} }
  m2, id2, groups2 = g2.components
  raise "" unless m == m2 && id == id2 && groups == groups2
end
begin
  g2 = UnweightedDirectedGraph.new n, edges + edges.map(&.reverse)
  m2, id2, groups2 = g2.components
  raise "" unless m == m2 && id == id2 && groups == groups2
end
begin
  g2 = UnweightedUndirectedGraph.new n, edges
  m2, id2, groups2 = g2.components
  raise "" unless m == m2 && id == id2 && groups == groups2
end

read_line.to_i.times do
  a, b = read_line.split.map(&.to_i)
  if id[a] == id[b]
    puts "yes"
    raise "" unless groups[id[a]].includes?(a) && groups[id[a]].includes?(b)
  else
    puts "no"
  end
end
