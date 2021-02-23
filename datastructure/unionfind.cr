# description : UnionFind
class UnionFind
  @d : Array(Int32)

  def initialize(n : Int32)
    @d = Array.new(n, -1)
  end

  def root(x : Int32)
    @d[x] < 0 ? x : (@d[x] = root(@d[x]))
  end

  def unite(x : Int32, y : Int32)
    x = root(x)
    y = root(y)
    return false if x == y
    x, y = y, x if @d[x] > @d[y]
    @d[x] += @d[y]
    @d[y] = x
    true
  end

  def same?(x : Int32, y : Int32)
    root(x) == root(y)
  end

  def size(x : Int32)
    -@d[root(x)]
  end

  def groups
    groups = Hash(Int32, Set(Int32)).new { |h, k| h[k] = Set(Int32).new }
    @n.times do |i|
      groups[root(i)] << i
    end
    groups.values.to_set
  end
end
