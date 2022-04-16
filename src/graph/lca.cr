require "../graph"

class LCA(Edge, Edge2)
  getter graph : Graph(Edge, Edge2), depth : Array(Int32), log2 : Int32

  private def dfs(vertex : Int32, par : Int32, dep : Int32) : Nil
    @parent[0][vertex] = par
    @depth[vertex] = dep
    @graph[vertex].each do |edge|
      dfs(edge.to, vertex, dep + 1) if edge.to != par
    end
  end

  def initialize(@graph : Graph(Edge, Edge2), root : Int32)
    @log2 = Math.log2(size).to_i.succ
    @depth = Array(Int32).new(size, -1)
    @parent = Array(Array(Int32)).new(log2) { Array.new(size, 0) }
    dfs(root, -1, 0)
    (0...log2 - 1).each do |k|
      (0...size).each do |v|
        @parent[k + 1][v] = @parent[k][v] < 0 ? -1 : @parent[k][@parent[k][v]]
      end
    end
  end

  delegate size, to: @graph

  def depth(v : Int32) : Int32
    @depth[v]
  end

  def parent_p2(v : Int32, k : Int32) : Int32?
    p = @parent[k][v]
    p >= 0 ? p : nil
  end

  def parent_p2!(v : Int32, k : Int32) : Int32
    parent_p2(v, k).not_nil!
  end

  def parent(v : Int32) : Int32?
    parent_p2(v, 0)
  end

  def parent!(v : Int32) : Int32
    parent(v).not_nil!
  end

  def parent(v : Int32, up : Int32) : Int32?
    log2.times do |k|
      v = @parent[k][v] if up.bit(k) == 1
      return nil if v < 0
    end
    v
  end

  def parent!(v : Int32, up : Int32) : Int32
    parent(v, up).not_nil!
  end

  def lca(u : Int32, v : Int32) : Int32
    raise IndexError.new unless 0 <= u < size && 0 <= v < size
    u, v = v, u if @depth[u] > @depth[v]
    (0...log2).each do |k|
      v = @parent[k][v] if (@depth[v] - @depth[u]).bit(k) == 1
    end

    return u if u == v

    (0...log2).reverse_each do |k|
      u, v = @parent[k][u], @parent[k][v] if @parent[k][u] != @parent[k][v]
    end
    @parent[0][u]
  end

  def dist(u : Int32, v : Int32) : Int32
    depth(u) + depth(v) - depth(lca(u, v)) * 2
  end

  def path(start : Int32, goal : Int32, &) : Nil
    lca = lca(start, goal)
    {start, goal}.each do |first|
      if first != lca
        yield v = first
        while (v = parent!(v)) != lca
          yield v
        end
      end
    end
    yield lca
  end

  def path(start : Int32, goal : Int32) : Array(Int32)
    path = [] of Int32
    path(start, goal) { |v| path << v }
    path
  end
end
