require "../graph"
require "../datastructure/union_find"

module Graph(Edge, Edge2)
  # Decomposes the graph into each conected components.
  def decompose : {Array(self), Array({Int32, Int32}), Array(Array(Int32))}
    uf = UnionFind.new(size)
    each do |edge|
      uf.unite(edge.from, edge.to)
    end
    groups = uf.groups.to_a

    index = Array.new(size, {-1, -1})
    groups.each_with_index do |group, i|
      group.each_with_index do |v, j|
        index[v] = {i, j}
      end
    end

    normalize = Array.new(groups.size) { |i| Array.new(groups[i].size, -1) }
    index.each_with_index { |(i, j), k| normalize[i][j] = k }

    graphs = Array.new(groups.size) { |i| self.class.new(groups[i].size) }
    if self.class.directed?
      each do |edge|
        i1, j1 = index[edge.from]
        _, j2 = index[edge.to]
        graphs[i1] << {j1, j2, edge.cost}
      end
    else
      edge_set = Set(Edge2).new
      each do |edge|
        if edge_set.add?(edge.sort)
          i1, j1 = index[edge.from]
          _, j2 = index[edge.to]
          graphs[i1] << {j1, j2, edge.cost}
        end
      end
    end
    {graphs, index, normalize}
  end
end
