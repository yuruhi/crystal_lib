require "../graph"

module Graph(Edge, Edge2)
  # Returns `{components size, index, groups}`.
  def components
    undirected = to_undirected
    index = Array(Int32?).new(size, nil)
    groups = [] of Set(Int32)
    id = 0
    size.times do |v|
      next if index[v]
      que = Deque{v}
      groups << Set(Int32).new
      while u = que.shift?
        next if index[u]
        index[u] = id
        groups[id] << u
        undirected[u].each do |edge|
          que << edge.to if index[edge.to].nil?
        end
      end
      id += 1
    end
    {id, index.map(&.not_nil!), groups}
  end
end
