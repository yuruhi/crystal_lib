# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/lesson/1/ALDS1/all/ALDS1_11_D
require "../src/graph/components"
n, m = read_line.split.map(&.to_i)
graph = UnweightedUndirectedGraph.new n, Array.new(m) {
  a, b = read_line.split.map(&.to_i)
  {a, b}
}
m, id, groups = graph.components

read_line.to_i.times do
  a, b = read_line.split.map(&.to_i)
  if id[a] == id[b]
    puts "yes"
    raise "" unless groups[id[a]].includes?(a) && groups[id[a]].includes?(b)
  else
    puts "no"
  end
end
