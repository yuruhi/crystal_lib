class UnionFind
  @d : Array(Int32)
  getter count_components : Int32

  def initialize(n : Int)
    @d = Array.new(n, -1)
    @count_components = n
  end

  def initialize(n : Int, edges : Enumerable({Int32, Int32}))
    initialize(n)
    edges.each { |u, v| unite(u, v) }
  end

  def root(x : Int)
    @d[x] < 0 ? x : (@d[x] = root(@d[x]))
  end

  def unite(x : Int, y : Int)
    x = root(x)
    y = root(y)
    return false if x == y
    x, y = y, x if @d[x] > @d[y]
    @d[x] += @d[y]
    @d[y] = x
    @count_components -= 1
    true
  end

  def same?(x : Int, y : Int)
    root(x) == root(y)
  end

  def size(x : Int)
    -@d[root(x)]
  end

  def groups
    groups = Hash(Int32, Set(Int32)).new { |h, k| h[k] = Set(Int32).new }
    @d.size.times do |i|
      groups[root(i)] << i
    end
    groups.values.to_set
  end
end
