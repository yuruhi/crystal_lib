---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: graph/dijkstra.cr
    title: graph/dijkstra.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://onlinejudge.u-aizu.ac.jp/courses/library/5/GRL/all/GRL_1_A
  bundledCode: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/library/5/GRL/all/GRL_1_A\n\
    # require \"../graph/dijkstra\"\n# require \"../atcoder/src/PriorityQueue\"\n\
    # ac-library.cr by hakatashi https://github.com/google/ac-library.cr\n#\n# Copyright\
    \ 2021 Google LLC\n#\n# Licensed under the Apache License, Version 2.0 (the \"\
    License\");\n# you may not use this file except in compliance with the License.\n\
    # You may obtain a copy of the License at\n#\n#      https://www.apache.org/licenses/LICENSE-2.0\n\
    #\n# Unless required by applicable law or agreed to in writing, software\n# distributed\
    \ under the License is distributed on an \"AS IS\" BASIS,\n# WITHOUT WARRANTIES\
    \ OR CONDITIONS OF ANY KIND, either express or implied.\n# See the License for\
    \ the specific language governing permissions and\n# limitations under the License.\n\
    \nmodule AtCoder\n  # Implements standard priority queue like [std::priority_queue](https://en.cppreference.com/w/cpp/container/priority_queue).\n\
    \  #\n  # ```\n  # q = AtCoder::PriorityQueue(Int64).new\n  # q << 1_i64\n  #\
    \ q << 3_i64\n  # q << 2_i64\n  # q.pop # => 3\n  # q.pop # => 2\n  # q.pop #\
    \ => 1\n  # ```\n  class PriorityQueue(T)\n    getter heap : Array(T)\n\n    def\
    \ initialize\n      initialize { |a, b| a <= b }\n    end\n\n    # Initializes\
    \ queue with the custom comperator.\n    #\n    # If the second argument `b` should\
    \ be popped earlier than\n    # the first argument `a`, return `true`. Else, return\
    \ `false`.\n    #\n    # ```\n    # q = AtCoder::PriorityQueue(Int64).new { |a,\
    \ b| a >= b }\n    # q << 1_i64\n    # q << 3_i64\n    # q << 2_i64\n    # q.pop\
    \ # => 1\n    # q.pop # => 2\n    # q.pop # => 3\n    # ```\n    def initialize(&block\
    \ : T, T -> Bool)\n      @heap = Array(T).new\n      @compare_proc = block\n \
    \   end\n\n    # Pushes value into the queue.\n    def push(v : T)\n      @heap\
    \ << v\n      index = @heap.size - 1\n      while index != 0\n        parent =\
    \ (index - 1) // 2\n        if @compare_proc.call(@heap[index], @heap[parent])\n\
    \          break\n        end\n        @heap[parent], @heap[index] = @heap[index],\
    \ @heap[parent]\n        index = parent\n      end\n    end\n\n    # Alias of\
    \ `push`\n    def <<(v : T)\n      push(v)\n    end\n\n    # Pops value from the\
    \ queue.\n    def pop\n      if @heap.size == 0\n        return nil\n      end\n\
    \      if @heap.size == 1\n        return @heap.pop\n      end\n      ret = @heap.first\n\
    \      @heap[0] = @heap.pop\n      index = 0\n      while index * 2 + 1 < @heap.size\n\
    \        child = if index * 2 + 2 < @heap.size && !@compare_proc.call(@heap[index\
    \ * 2 + 2], @heap[index * 2 + 1])\n                  index * 2 + 2\n         \
    \       else\n                  index * 2 + 1\n                end\n        if\
    \ @compare_proc.call(@heap[child], @heap[index])\n          break\n        end\n\
    \        @heap[child], @heap[index] = @heap[index], @heap[child]\n        index\
    \ = child\n      end\n      ret\n    end\n\n    # Returns `true` if the queue\
    \ is empty.\n    delegate :empty?, to: @heap\n\n    # Returns size of the queue.\n\
    \    delegate :size, to: @heap\n  end\nend\n\n# require \"./graph\"\nstruct Edge(T)\n\
    \  include Comparable(Edge(T))\n\n  property to : Int32\n  property cost : T\n\
    \n  def initialize(@to : Int32, @cost : T)\n  end\n\n  def <=>(other : Edge(T))\n\
    \    {cost, to} <=> {other.cost, other.to}\n  end\n\n  def to_s(io) : Nil\n  \
    \  io << '(' << to << \", \" << cost << ')'\n  end\n\n  def inspect(io) : Nil\n\
    \    io << \"->#{to}(#{cost})\"\n  end\nend\n\nstruct Edge2(T)\n  include Comparable(Edge2(T))\n\
    \n  property from : Int32\n  property to : Int32\n  property cost : T\n\n  def\
    \ initialize(@from : Int32, @to : Int32, @cost : T)\n  end\n\n  def <=>(other\
    \ : Edge2(T))\n    {cost, from, to} <=> {other.cost, other.from, other.to}\n \
    \ end\n\n  def reverse\n    Edge2(T).new(to, from, cost)\n  end\n\n  def to_s(io)\
    \ : Nil\n    io << '(' << from << \", \" << to << \", \" << cost << ')'\n  end\n\
    \n  def inspect(io) : Nil\n    io << \"#{from}->#{to}(#{cost})\"\n  end\nend\n\
    \nstruct UnweightedEdge2\n  property from : Int32\n  property to : Int32\n\n \
    \ def initialize(@from, @to)\n  end\n\n  def reverse\n    UnweightedEdge2.new(to,\
    \ from)\n  end\n\n  def to_s(io) : Nil\n    io << '(' << from << \", \" << to\
    \ << ')'\n  end\n\n  def inspect(io) : Nil\n    io << \"#{from}->#{to}\"\n  end\n\
    end\n\nabstract class Graph(T)\n  getter graph : Array(Array(Edge(T)))\n\n  def\
    \ initialize(size : Int)\n    raise ArgumentError.new(\"Negative graph size: #{size}\"\
    ) unless size >= 0\n    @graph = Array.new(size) { Array(Edge(T)).new }\n  end\n\
    \n  def add_edge(i : Int32, j : Int32, cost : T)\n    add_edge(Edge2.new(i, j,\
    \ cost))\n  end\n\n  def add_edges(edges : Array(Edge2(T)))\n    edges.each {\
    \ |edge| add_edge(edge) }\n    self\n  end\n\n  delegate size, to: @graph\n  delegate\
    \ :[], to: @graph\n\n  def each_edge : Nil\n    (0...size).each do |v|\n     \
    \ graph[v].each do |edge|\n        yield Edge2(T).new(v, edge.to, edge.cost)\n\
    \      end\n    end\n  end\n\n  def edges\n    result = [] of Edge2(T)\n    each_edge\
    \ do |edge|\n      result << edge\n    end\n    result\n  end\nend\n\nclass DirectedGraph(T)\
    \ < Graph(T)\n  def initialize(size : Int)\n    super\n  end\n\n  def initialize(size\
    \ : Int, edges : Array(Edge2(T)))\n    super(size)\n    add_edges(edges)\n  end\n\
    \n  def add_edge(edge : Edge2(T))\n    raise IndexError.new unless 0 <= edge.from\
    \ < size\n    raise IndexError.new unless 0 <= edge.to < size\n    @graph[edge.from]\
    \ << Edge.new(edge.to, edge.cost)\n    self\n  end\nend\n\nclass UndirectedGraph(T)\
    \ < Graph(T)\n  def initialize(size : Int)\n    super\n  end\n\n  def initialize(size\
    \ : Int, edges : Array(Edge2(T)))\n    super(size)\n    add_edges(edges)\n  end\n\
    \n  def add_edge(edge : Edge2(T))\n    raise IndexError.new unless 0 <= edge.from\
    \ < size\n    raise IndexError.new unless 0 <= edge.to < size\n    @graph[edge.from]\
    \ << Edge.new(edge.to, edge.cost)\n    @graph[edge.to] << Edge.new(edge.from,\
    \ edge.cost)\n    self\n  end\nend\n\nabstract class UnweightedGraph\n  getter\
    \ graph : Array(Array(Int32))\n\n  def initialize(size : Int)\n    raise ArgumentError.new(\"\
    Negative graph size: #{size}\") unless size >= 0\n    @graph = Array.new(size)\
    \ { Array(Int32).new }\n  end\n\n  def add_edge(i : Int32, j : Int32)\n    add_edge(UnweightedEdge2.new(i,\
    \ j))\n  end\n\n  def add_edges(edges : Array(UnweightedEdge2))\n    edges.each\
    \ { |edge| add_edge(edge) }\n    self\n  end\n\n  delegate size, to: @graph\n\
    \  delegate :[], to: @graph\n\n  def each_edge : Nil\n    (0...size).each do |v|\n\
    \      graph[v].each do |u|\n        yield UnweightedEdge2.new(v, u)\n      end\n\
    \    end\n  end\n\n  def edges\n    result = [] of UnweightedEdge2\n    each_edge\
    \ do |edge|\n      result << edge\n    end\n    result\n  end\nend\n\nclass UnweightedDirectedGraph\
    \ < UnweightedGraph\n  def initialize(size : Int)\n    super\n  end\n\n  def initialize(size\
    \ : Int, edges : Array(UnweightedEdge2))\n    super(size)\n    add_edges(edges)\n\
    \  end\n\n  def add_edge(edge : UnweightedEdge2)\n    raise IndexError.new unless\
    \ 0 <= edge.from < size\n    raise IndexError.new unless 0 <= edge.to < size\n\
    \    @graph[edge.from] << edge.to\n    self\n  end\nend\n\nclass UnweightedUndirectedGraph\
    \ < UnweightedGraph\n  def initialize(size : Int)\n    super\n  end\n\n  def initialize(size\
    \ : Int, edges : Array(UnweightedEdge2))\n    super(size)\n    add_edges(edges)\n\
    \  end\n\n  def add_edge(edge : UnweightedEdge2)\n    raise IndexError.new unless\
    \ 0 <= edge.from < size\n    raise IndexError.new unless 0 <= edge.to < size\n\
    \    @graph[edge.from] << edge.to\n    @graph[edge.to] << edge.from\n    self\n\
    \  end\n\n  def each_child(vertex : Int, parent)\n    graph[vertex].each do |u|\n\
    \      yield u if u != parent\n    end\n  end\nend\n\nclass Graph(T)\n  def dijkstra(start\
    \ : Int32, unreachable : U = nil) forall U\n    raise ArgumentError.new unless\
    \ 0 <= start < size\n    que = AtCoder::PriorityQueue({Int32, T}).new { |(v1,\
    \ d1), (v2, d2)| d1 > d2 }\n    que << {start, T.zero}\n    dist = Array(T?).new(size,\
    \ nil)\n    dist[start] = T.zero\n\n    while vd = que.pop\n      v, d = vd\n\
    \      next if dist[v].try { |dist_v| dist_v < d }\n      dist_v = dist[v].not_nil!\n\
    \      graph[v].each do |edge|\n        if dist[edge.to].nil? || dist[edge.to].not_nil!\
    \ > dist_v + edge.cost\n          dist[edge.to] = dist_v + edge.cost\n       \
    \   que << {edge.to, dist_v + edge.cost}\n        end\n      end\n    end\n  \
    \  dist.map { |i| i || unreachable }\n  end\n\n  def dijkstra!(start : Int32)\n\
    \    dijkstra(start).map(&.not_nil!)\n  end\nend\n\nn, m, s = read_line.split.map(&.to_i)\n\
    g = DirectedGraph.new n, (1..m).map {\n  a, b, c = read_line.split.map(&.to_i)\n\
    \  Edge2.new(a, b, c)\n}\nputs g.dijkstra(s, \"INF\").join('\\n')\n"
  code: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/library/5/GRL/all/GRL_1_A\n\
    require \"../graph/dijkstra\"\nn, m, s = read_line.split.map(&.to_i)\ng = DirectedGraph.new\
    \ n, (1..m).map {\n  a, b, c = read_line.split.map(&.to_i)\n  Edge2.new(a, b,\
    \ c)\n}\nputs g.dijkstra(s, \"INF\").join('\\n')\n"
  dependsOn:
  - graph/dijkstra.cr
  isVerificationFile: true
  path: test/dijkstra.test.cr
  requiredBy: []
  timestamp: '2021-06-22 18:04:14+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/dijkstra.test.cr
layout: document
redirect_from:
- /verify/test/dijkstra.test.cr
- /verify/test/dijkstra.test.cr.html
title: test/dijkstra.test.cr
---
