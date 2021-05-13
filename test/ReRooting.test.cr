# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/challenges/sources/VPC/WUPC/3163
require "../graph/ReRooting"

struct DP
  getter sum : Int64
  getter val : Int64

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

n = read_line.to_i
DP.a = read_line.split.map(&.to_i64)
dp = ReRooting(DP).new(n)
(n - 1).times do
  a, b = read_line.split.map(&.to_i.pred)
  dp.add_edge(a, b)
end
puts dp.solve.join('\n', &.val)
