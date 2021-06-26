require "./graph"

class BipartiteMatching
  getter left : Int32
  getter right : Int32
  getter graph : UnweightedDirectedGraph

  def initialize(@left, @right)
    raise ArgumentError.new "Negative left vertexes size: #{left}" unless left >= 0
    raise ArgumentError.new "Negative right vertexes size: #{right}" unless right >= 0
    @graph = UnweightedDirectedGraph.new(left)
    @left_match = Array(Int32?).new(left, nil)
    @right_match = Array(Int32?).new(right, nil)
    @used = Array(Bool).new(left, false)
  end

  def add_edge(l : Int32, r : Int32)
    add_edge(UnweightedEdge2.new(l, r))
  end

  def add_edge(edge : UnweightedEdge2)
    raise IndexError.new unless 0 <= edge.from < left
    raise IndexError.new unless 0 <= edge.to < right
    graph[edge.from] << edge.to
    self
  end

  def add_edges(edges : Array(UnweightedEdge2))
    edges.each { |edge| add_edge(edge) }
    self
  end

  private def dfs(v : Int32) : Bool
    return false if @used[v]
    @used[v] = true
    graph[v].each do |edge|
      if @right_match[edge].nil? || dfs(@right_match[edge].not_nil!)
        @left_match[v], @right_match[edge] = edge, v
        return true
      end
    end
    return false
  end

  def solve : Int32
    while (0...left).reduce(false) { |update, i|
            update | (@left_match[i].nil? && dfs(i))
          }
      @used.fill(false)
    end
    left - @left_match.count(&.nil?)
  end

  def each_edge(&block) : Nil
    (0...left).each do |i|
      if l = @left_match[i]
        yield UnweightedEdge2.new(i, l)
      end
    end
  end

  def each_edge
    (0...left).each.select { |i| @left_match[i] }.map { |i|
      UnweightedEdge2.new i, @left_match[i].not_nil!
    }
  end

  def edges
    result = [] of UnweightedEdge2
    (0...left).each do |i|
      if l = @left_match[i]
        result << UnweightedEdge2.new(i, l)
      end
    end
    result
  end
end
