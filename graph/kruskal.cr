require "./graph"
require "../datastructure/UnionFind"

def kruskal(n : Int32, edges : Array(Edge2(T))) forall T
  uf = UnionFind.new(n)
  edges.sort.sum do |edge|
    if uf.unite(edge.from, edge.to)
      edge.cost
    else
      T.zero
    end
  end
end
