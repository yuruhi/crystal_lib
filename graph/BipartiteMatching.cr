require "./graph"

class BipartiteMatching
  getter left : Int32
  getter right : Int32
  getter graph : Graph(Nil)

  def initialize(@left, @right)
    raise ArgumentError.new "Negative left vertexes size: #{left}" unless left >= 0
    raise ArgumentError.new "Negative right vertexes size: #{right}" unless right >= 0
    @graph = Graph(Nil).new(left)
    @left_match = Array(Int32?).new(left, nil)
    @right_match = Array(Int32?).new(right, nil)
    @used = Array(Bool).new(left, false)
  end

  def add_edge(l : Int32, r : Int32)
    raise IndexError.new unless 0 <= l < left
    raise IndexError.new unless 0 <= r < right
    graph[l] << Edge.new(r, nil)
    self
  end

  def add_edge(edges : Array(Edge2(Nil)))
    edges.each do |edge|
      add_edge(edge.from, edge.to)
    end
    self
  end

  private def dfs(v : Int32) : Bool
    return false if @used[v]
    @used[v] = true
    graph[v].each do |edge|
      if @right_match[edge.to].nil? || dfs(@right_match[edge.to].not_nil!)
        @left_match[v], @right_match[edge.to] = edge.to, v
        return true
      end
    end
    return false
  end

  def solve : Int32
    while (0...left).reduce(false) { |update, i|
            update | (@left_match[i].nil? ? dfs(i) : false)
          }
      @used.fill(false)
    end
    left - @left_match.count(&.nil?)
  end
end
