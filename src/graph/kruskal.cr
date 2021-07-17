require "../graph"
require "../datastructure/union_find"

module Graph(Edge, Edge2)
  def kruskal
    uf = UnionFind.new(size)
    result = to_a.sort.sum do |edge|
      uf.unite(edge.from, edge.to) ? edge.cost : typeof(first.cost).zero
    end
    uf.size(0) == size ? result : nil
  end
end
