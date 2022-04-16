# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/2891
require "../../src/graph/detect_cycle"
require "../../src/scanner"

n = input(i)
graph = UnweightedUnGraph.new n, input({i - 1, i - 1}[n])

cycle = Set.new graph.detect_cycle.not_nil!.map(&.to)

input(i).times do
  x, y = input(i - 1, i - 1)
  if cycle.includes?(x) && cycle.includes?(y)
    puts 2
  else
    puts 1
  end
end
