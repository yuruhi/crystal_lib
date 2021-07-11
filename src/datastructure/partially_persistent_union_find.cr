class PartiallyPersistentUnionFind
  getter size : Int32, now : Int32

  def initialize(size : Int)
    @size = size.to_i
    @now = 0
    @parent = Array(Int32).new(size, &.itself)
    @rank = Array(Int32).new(size, 0)
    @time = Array(Int32).new(size, Int32::MAX)
    @num = Array(Array({Int32, Int32})).new(size) { [{0, 1}] }
  end

  def root(x : Int, time : Int) : Int32
    time < @time[x] ? x : root(@parent[x], time)
  end

  def same?(x : Int, y : Int, time : Int) : Bool
    root(x, time) == root(y, time)
  end

  def unite(x : Int, y : Int) : Bool
    @now += 1
    x, y = root(x, now), root(y, now)
    return false if x == y
    x, y = y, x if @rank[x] < @rank[y]
    @num[x] << {now, size(x, now) + size(y, now)}
    @parent[y] = x
    @time[y] = now
    @rank[x] += 1 if @rank[x] == @rank[y]
    true
  end

  def size(x : Int, time : Int) : Int
    x = root(x, time)
    pos = @num[x].bsearch_index { |(t, s), _| t > time } || @num[x].size
    @num[x][pos - 1][1]
  end
end
