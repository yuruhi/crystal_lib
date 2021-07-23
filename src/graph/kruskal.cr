require "../graph"
require "../datastructure/union_find"

module Graph(Edge, Edge2)
  # Calculates cost of minimum spanning tree if the graph is connected, otherwise returns `nil`.
  def kruskal
    uf = UnionFind.new(size)
    result = to_a.sort.sum do |edge|
      uf.unite(edge.from, edge.to) ? edge.cost : typeof(first.cost).zero
    end
    uf.size(0) == size ? result : nil
  end
end
