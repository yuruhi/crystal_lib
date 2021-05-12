require "graph"

class LCA(T)
  getter graph : Graph(T)
  getter size : Int32
  getter depth : Array(Int32)

  private def dfs(vertex : Int32, par : Int32, dep : Int32) : Nil
    @parent[0][vertex] = par
    @depth[vertex] = dep
    @graph[vertex].each do |edge|
      dfs(edge.to, vertex, dep + 1) if edge.to != par
    end
  end

  def initialize(@graph : Graph(T), root : Int32)
    @size = @graph.size
    @log2 = Math.log2(@size).to_i.succ.as(Int32)
    @depth = Array(Int32).new(@size, -1)
    @parent = Array(Array(Int32)).new(@log2) { Array.new(@size, 0) }
    dfs(root, -1, 0)
    (0...@log2 - 1).each do |k|
      (0...size).each do |v|
        if @parent[k][v] < 0
          @parent[k + 1][v] = -1
        else
          @parent[k + 1][v] = @parent[k][@parent[k][v]]
        end
      end
    end
  end

  def lca(u : Int32, v : Int32) : Int32
    raise IndexError.new unless 0 <= u < size
    raise IndexError.new unless 0 <= v < size
    u, v = v, u if @depth[u] > @depth[v]
    (0...@log2).each do |k|
      v = @parent[k][v] if (@depth[v] - @depth[u]).bit(k) == 1
    end

    return u if u == v

    (0...@log2).reverse_each do |k|
      u, v = @parent[k][u], @parent[k][v] if @parent[k][u] != @parent[k][v]
    end
    @parent[0][u]
  end

  def dist(u : Int32, v : Int32) : Int32
    @depth[u] + @depth[v] - @depth[lca(u, v)] * 2
  end
end
