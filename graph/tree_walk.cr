require "graph"

class Graph(T)
  def pre_order(root : Int32)
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

  def post_order(root : Int32)
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

  def in_order(root : Int32)
    raise ArgumentError.new "graph is not binary tree" unless @graph.all? { |v| v.size <= 2 }
    result = Array(Int32).new(size)
    stack = Deque(Int32).new
    vertex = root
    while vertex || !stack.empty?
      while vertex
        stack << vertex
        vertex = self[vertex][0]?.try(&.to)
      end
      vertex = stack.pop
      result << vertex
      vertex = self[vertex][1]?.try(&.to)
    end
    result
  end
end
