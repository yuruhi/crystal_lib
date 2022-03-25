require "../graph"

module Graph(Edge, Edge2)
  private def subtree_size_dfs(v : Int32, p : Int32, result : Array(Int32)) : Int32
    result[v] = 1 + self[v].sum { |edge|
      edge.to != p ? subtree_size_dfs(edge.to, v, result) : 0
    }
  end

  def subtree_size(root : Int32) : Array(Int32)
    result = Array.new(size, 0)
    subtree_size_dfs(root, -1, result)
    result
  end

  private def tree_distance_dfs(v : Int32, p : Int32, dist : Int32, a) : Nil
    a[v] = dist
    self[v].each do |edge|
      tree_distance_dfs(edge.to, v, dist + edge.cost, a) if edge.to != p
    end
  end

  # Returns the distance of each node from *root*.
  def tree_distance(root : Int32)
    a = Array.new(size, typeof(first.cost).zero)
    tree_distance_dfs(root, -1, 0, a)
    a
  end

  # Calculates diameter of the tree and returns `{distance, vertex1, vertex2}`.
  def diameter
    _, v = tree_distance(0).each_with_index.max
    dist, u = tree_distance(v).each_with_index.max
    {dist, v, u}
  end

  private def parent_table_dfs(v : Int32, p : Int32?, table : Array(Int32?)) : Nil
    table[v] = p
    self[v].each do |edge|
      parent_table_dfs(edge.to, v, table) if edge.to != p
    end
  end

  def parent_table(root : Int32) : Array(Int32?)
    table = Array(Int32?).new(size, nil)
    parent_table_dfs(root, nil, table)
    table
  end

  def tree_path(start : Int32, goal : Int32, &) : Nil
    parent = parent_table(start)
    yield now = goal
    while now = parent[now]
      yield now
    end
  end

  def tree_path(start : Int32, goal : Int32) : Array(Int32)
    path = [] of Int32
    tree_path { |v| path << v }
    path.reverse
  end
end
