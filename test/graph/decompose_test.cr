# verification-helper: PROBLEM https://yukicoder.me/problems/no/922
require "../../src/scanner"
require "../../src/graph/re_rooting"
require "../../src/graph/decompose"
require "../../src/graph/lca"

struct DP
  getter sum : Int64, cnt : Int32

  class_property! k : Array(Int32)

  def initialize
    @sum, @cnt = 0i64, 0
  end

  def initialize(@sum, @cnt)
  end

  def +(other : self) : self
    DP.new(sum + other.sum, cnt + other.cnt)
  end

  def add_root(v : Int32) : self
    DP.new(sum + cnt, cnt + DP.k[v])
  end
end

n, m, q = input(i, i, i)
g = UnweightedUndirectedGraph.new n, input({i - 1, i - 1}[m])

graphs, index, _ = g.decompose
lcas = graphs.map { |graph| LCA.new(graph, 0) }

ans = 0i64

cnts = Array.new(graphs.size) { |i| Array.new(graphs[i].size, 0) }
q.times do
  a, b = input(i - 1, i - 1)
  ai, aj = index[a]
  bi, bj = index[b]
  if ai == bi
    ans += lcas[ai].dist(aj, bj)
  else
    cnts[ai][aj] += 1
    cnts[bi][bj] += 1
  end
end

graphs.each_with_index do |graph, i|
  DP.k = cnts[i]
  dp = ReRooting(DP, UnweightedUndirectedGraph).new(graph)
  ans += dp.solve.min_of(&.sum)
end

puts ans
