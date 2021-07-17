require "../graph"

module Graph(Edge, Edge2)
  def pre_order(root : Int)
    result = Array(Int32).new(size)
    stack = Deque{ {root, -1} }
    while vp = stack.pop?
      vertex, parent = vp
      result << vertex
      self[vertex].reverse_each do |edge|
        stack << {edge.to, vertex} if edge.to != parent
      end
    end
    result
  end

  def post_order(root : Int)
    result = Array(Int32).new(size)
    visited = Array(Bool).new(size, false)
    stack = Deque{ {root, -1} }
    while vp = stack.last?
      vertex, parent = vp
      if visited[vertex]
        stack.pop
        result << vertex
      else
        self[vertex].reverse_each do |edge|
          stack << {edge.to, vertex} if edge.to != parent
        end
        visited[vertex] = true
      end
    end
    result
  end
end
