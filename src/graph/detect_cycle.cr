require "../graph"

module Graph(Edge, Edge2)
  private class DetectCycleDirected(Graph, Edge)
    def initialize(@graph : Graph)
      @cycle = [] of Edge
      @index = Array(Int32?).new(@graph.size, nil)
      @finished = Array(Bool).new(@graph.size, false)
      @ans = [] of Edge
    end

    private def dfs(v) : Bool
      if i = @index[v]
        @ans = @cycle[i..]
        return true
      end
      @index[v] = @cycle.size
      @graph[v].each do |edge|
        unless @finished[edge.to]
          @cycle << edge
          return true if dfs(edge.to)
          @cycle.pop
        end
      end
      @finished[v] = true
      false
    end

    def solve
      @graph.size.times do |i|
        return @ans if !@finished[i] && dfs(i)
      end
    end
  end

  private class DetectCycleUndirected(Graph, Edge)
    def initialize(@graph : Graph)
      @cycle = [] of Edge
      @index = Array(Int32?).new(@graph.size, nil)
      @ans = [] of Edge
    end

    private def dfs(v, prev) : Bool
      if i = @index[v]
        @ans = @cycle[i..]
        return true
      end
      @index[v] = @cycle.size
      @graph[v].each do |edge|
        if edge.to != prev
          @cycle << edge
          return true if dfs(edge.to, v)
          @cycle.pop
        end
      end
      false
    end

    def solve
      @graph.size.times do |i|
        return @ans if @index[i].nil? && dfs(i, -1)
      end
    end
  end

  def detect_cycle : Array(Edge)?
    if self.class.directed?
      DetectCycleDirected(self, Edge).new(self).solve
    else
      DetectCycleUndirected(self, Edge).new(self).solve
    end
  end
end
