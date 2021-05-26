require "./graph"
require "../datastructure/UnionFind"

def kruskal(n : Int32, edges : Array(Edge2(T))) : T? forall T
  uf = UnionFind.new(n)
  result = edges.sort.sum do |edge|
    if uf.unite(edge.from, edge.to)
      edge.cost
    else
      T.zero
    end
  end
  uf.size(0) == n ? result : nil
end
