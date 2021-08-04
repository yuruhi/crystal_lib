# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/challenges/sources/VPC/WUPC/3163
require "../../src/graph/re_rooting"
require "../../src/scanner"

struct DP
  getter sum : Int64, val : Int64

  @@a = [] of Int64

  def DP.a=(a)
    @@a = a
  end

  def initialize
    @sum, @val = 0i64, 0i64
  end

  def initialize(@sum, @val)
  end

  def +(other : DP)
    DP.new(sum + other.sum, val + other.val)
  end

  def add_root(v : Int32)
    DP.new(sum + @@a[v], val + sum)
  end
end

n = input(i)
DP.a = input(i64[n])
dp = ReRooting(DP, UnweightedUndirectedGraph).new n, input({i - 1, i - 1}[n - 1])
puts dp.solve.join('\n', &.val)
