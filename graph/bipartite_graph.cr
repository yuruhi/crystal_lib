require "./graph"

class Graph(T)
  def bipartite_graph : Array(Bool)?
    table = Array(Bool?).new(size, nil)
    queue = Deque.new (0...size).to_a
    while v = queue.shift?
      table[v] = true if table[v].nil?
      flag = table[v].not_nil!
      graph[v].each do |edge|
        if (flag2 = table[edge.to]).nil?
					table[edge.to] = !flag
					queue.unshift edge.to
        else
          return nil if flag == flag2
        end
      end
    end
		table.map(&.not_nil!)
  end
end
