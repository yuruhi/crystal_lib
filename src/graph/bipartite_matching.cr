require "../graph"

class BipartiteMatching
  include Enumerable(UnweightedEdge2)
  include Iterable(UnweightedEdge2)

  getter left : Int32, right : Int32
  getter graph : Array(Array(Int32))

  def initialize(@left, @right)
    raise ArgumentError.new unless left >= 0 && right >= 0
    @graph = Array.new(left) { [] of Int32 }
    @left_match = Array(Int32?).new(left, nil)
    @right_match = Array(Int32?).new(right, nil)
    @used = Array(Bool).new(left, false)
  end

  def initialize(left, right, edges : Enumerable)
    initialize(left, right)
    edges.each { |edge| self << edge }
  end

  def <<(edge : UnweightedEdge2) : self
    raise IndexError.new unless 0 <= edge.from < left && 0 <= edge.to < right
    @graph[edge.from] << edge.to
    self
  end

  def <<(edge : Tuple) : self
    self << UnweightedEdge2.new(*edge)
  end

  def add_edges(edges : Enumerable) : self
    edges.each { |edge| self << edge }
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
    false
  end

  def solve : Int32
    while (0...left).reduce(false) { |update, i|
            update | (@left_match[i].nil? && dfs(i))
          }
      @used.fill(false)
    end
    left - @left_match.count(&.nil?)
  end

  def each(&block) : Nil
    (0...left).each do |i|
      if l = @left_match[i]
        yield UnweightedEdge2.new(i, l)
      end
    end
  end

  def each
    (0...left).each.select { |i| @left_match[i] }.map { |i|
      UnweightedEdge2.new i, @left_match[i].not_nil!
    }
  end
end
