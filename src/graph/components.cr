require "../graph"
require "../datastructure/union_find"

module Graph(Edge, Edge2)
  # Returns `{components size, index, groups}`.
  def components : {Int32, Array(Int32), Array(Set(Int32))}
    uf = UnionFind.new(size)
    each do |edge|
      uf.unite(edge.from, edge.to)
    end
    groups = uf.groups.to_a
    id = Array.new(size, -1)
    groups.each_with_index do |group, i|
      group.each { |v| id[v] = i }
    end
    {groups.size, id, groups}
  end
end
