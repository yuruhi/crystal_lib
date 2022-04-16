require "../graph"

module Graph(Edge, Edge2)
  private def subtree_size_dfs(v : Int32, p : Int32, a : Array(Int32)) : Int32
    each_child(v, p) do |edge|
      a[v] += subtree_size_dfs(edge.to, v, a)
    end
    a[v] += 1
  end

  def subtree_size(root : Int32) : Array(Int32)
    a = Array.new(size, 0)
    subtree_size_dfs(root, -1, a)
    a
  end

  private def tree_distance_dfs(v : Int32, p : Int32, dist, a) : Nil
    a[v] = dist
    each_child(v, p) do |edge|
      tree_distance_dfs(edge.to, v, dist + edge.cost, a)
    end
  end

  # Returns the distance of each node from *root*.
  def tree_distance(root : Int32)
    a = Array.new(size, typeof(first.cost).zero)
    tree_distance_dfs(root, -1, typeof(first.cost).zero, a)
    a
  end

  # Calculates diameter of the tree and returns `{distance, vertex1, vertex2}`.
  def diameter
    _, v = tree_distance(0).each_with_index.max
    dist, u = tree_distance(v).each_with_index.max
    {dist, v, u}
  end

  private def parent_table_dfs(v : Int32, p : Int32?, a : Array(Int32?)) : Nil
    a[v] = p
    each_child(v, p) do |edge|
      parent_table_dfs(edge.to, v, a)
    end
  end

  def parent_table(root : Int32) : Array(Int32?)
    a = Array(Int32?).new(size, nil)
    parent_table_dfs(root, nil, a)
    a
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
