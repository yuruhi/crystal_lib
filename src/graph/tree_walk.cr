require "../graph"

class UnweightedGraph
  def pre_order(root : Int32)
    result = Array(Int32).new(size)
    stack = Deque{ {root, -1} }
    while vp = stack.pop?
      vertex, parent = vp
      result << vertex
      self[vertex].reverse_each do |to|
        stack << {to, vertex} if to != parent
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
        self[vertex].reverse_each do |to|
          stack << {to, vertex} if to != parent
        end
        visited[vertex] = true
      end
    end
    result
  end
end
