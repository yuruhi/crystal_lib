# verification-helper: PROBLEM https://judge.yosupo.jp/problem/cycle_detection
require "../../src/graph/detect_cycle"
require "../../src/scanner"

n, m = input(i, i)
graph = DirectedGraph.new n, (0...m).map { |i| input(i, i) + {i} }
if ans = graph.detect_cycle
	puts ans.size, ans.join('\n', &.cost)
else
	puts -1
end
