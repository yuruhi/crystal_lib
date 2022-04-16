# verification-helper: PROBLEM https://judge.yosupo.jp/problem/scc
require "../../src/graph/scc"
require "../../src/scanner"
n, m = input(i, i)
graph = UnweightedDiGraph.new n, input({i, i}[m])
scc = SCC.new(graph)
puts scc.count_scc
scc.groups.each do |group|
  print group.size, ' '
  puts group.join(' ')
end
