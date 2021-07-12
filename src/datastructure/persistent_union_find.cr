require "./persistent_array"

class PersistentUnionFind
  protected def initialize(@data : PersistentArray(Int32))
  end

  def initialize(size : Int)
    @data = PersistentArray(Int32).new Array.new(size, -1)
  end

  def root(x : Int)
    p = @data[x]
    p >= 0 ? root(p) : x
  end

  def same?(x : Int, y : Int)
    root(x) == root(y)
  end

  def size(x : Int)
    -@data[root(x)]
  end

  def unite(x : Int, y : Int) : {Bool, PersistentUnionFind}
    x, y = root(x), root(y)
    return {false, self} if x == y
    dx, dy = @data[x], @data[y]
    if dx > dy
      x, y = y, x
      dx, dy = dy, dx
    end
    {true, PersistentUnionFind.new(@data.set(x, dx + dy).set(y, x))}
  end
end
