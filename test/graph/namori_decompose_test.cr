# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/2891
require "../../src/graph/namori_decompose"
require "../../src/scanner"

n = input(i)
graph = UnweightedUnGraph.new n, input({i - 1, i - 1}[n])
_, cycle = graph.namori_decompose
set = Set.new cycle

input(i).times do
  x, y = input(i - 1, i - 1)
  if set.includes?(x) && set.includes?(y)
    puts 2
  else
    puts 1
  end
end
