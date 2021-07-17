require "../graph"

class UnweightedGraph
  # Returns {components size, index, groups}
  def components
    graph = to_undirected
    index = Array(Int32?).new(size, nil)
    groups = [] of Set(Int32)
    id = 0
    size.times do |v|
      next if index[v]
      que = Deque{v}
      groups << Set(Int32).new
      while u = que.shift?
        index[u] = id
        groups[id] << u
        graph[u].each do |edge|
          if index[edge].nil?
            que << edge
          end
        end
      end
      id += 1
    end
    {id, index.map(&.not_nil!), groups}
  end
end
