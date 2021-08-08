# verification-helper: PROBLEM https://yukicoder.me/problems/no/1641
require "../../src/graph/euler_tour_for_vertex"
require "../../atcoder/src/SegTree"
require "../../src/scanner"

n, q = input(i, i)
c = input(i64[n])
graph = UnweightedUndirectedGraph.new n, input({i - 1, i - 1}[n - 1])
ls, rs = EulerTourForVertex.new(graph).run(0)

seg = AtCoder::SegTree.new([0i64] * n) { |x, y| x ^ y }
ls.each_with_index { |x, i| seg[x] = c[i] }

q.times do
  t, x, y = input(i, i - 1, i)
  case t
  when 1
    seg[ls[x]] ^= y
  when 2
    puts seg[ls[x]...rs[x]]
  end
end
