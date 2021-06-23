---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: graph/graph.cr
    title: graph/graph.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/bfs.test.cr
    title: test/bfs.test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "# require \"./graph\"\nstruct Edge(T)\n  include Comparable(Edge(T))\n\
    \n  property to : Int32\n  property cost : T\n\n  def initialize(@to : Int32,\
    \ @cost : T)\n  end\n\n  def <=>(other : Edge(T))\n    {cost, to} <=> {other.cost,\
    \ other.to}\n  end\n\n  def to_s(io) : Nil\n    io << '(' << to << \", \" << cost\
    \ << ')'\n  end\n\n  def inspect(io) : Nil\n    io << \"->#{to}(#{cost})\"\n \
    \ end\nend\n\nstruct Edge2(T)\n  include Comparable(Edge2(T))\n\n  property from\
    \ : Int32\n  property to : Int32\n  property cost : T\n\n  def initialize(@from\
    \ : Int32, @to : Int32, @cost : T)\n  end\n\n  def <=>(other : Edge2(T))\n   \
    \ {cost, from, to} <=> {other.cost, other.from, other.to}\n  end\n\n  def reverse\n\
    \    Edge2(T).new(to, from, cost)\n  end\n\n  def to_s(io) : Nil\n    io << '('\
    \ << from << \", \" << to << \", \" << cost << ')'\n  end\n\n  def inspect(io)\
    \ : Nil\n    io << \"#{from}->#{to}(#{cost})\"\n  end\nend\n\nstruct UnweightedEdge2\n\
    \  property from : Int32\n  property to : Int32\n\n  def initialize(@from, @to)\n\
    \  end\n\n  def reverse\n    UnweightedEdge2.new(to, from)\n  end\n\n  def to_s(io)\
    \ : Nil\n    io << '(' << from << \", \" << to << ')'\n  end\n\n  def inspect(io)\
    \ : Nil\n    io << \"#{from}->#{to}\"\n  end\nend\n\nabstract class Graph(T)\n\
    \  getter graph : Array(Array(Edge(T)))\n\n  def initialize(size : Int)\n    raise\
    \ ArgumentError.new(\"Negative graph size: #{size}\") unless size >= 0\n    @graph\
    \ = Array.new(size) { Array(Edge(T)).new }\n  end\n\n  def add_edge(i : Int32,\
    \ j : Int32, cost : T)\n    add_edge(Edge2.new(i, j, cost))\n  end\n\n  def add_edges(edges\
    \ : Array(Edge2(T)))\n    edges.each { |edge| add_edge(edge) }\n    self\n  end\n\
    \n  delegate size, to: @graph\n  delegate :[], to: @graph\n\n  def each_edge :\
    \ Nil\n    (0...size).each do |v|\n      graph[v].each do |edge|\n        yield\
    \ Edge2(T).new(v, edge.to, edge.cost)\n      end\n    end\n  end\n\n  def edges\n\
    \    result = [] of Edge2(T)\n    each_edge do |edge|\n      result << edge\n\
    \    end\n    result\n  end\nend\n\nclass DirectedGraph(T) < Graph(T)\n  def initialize(size\
    \ : Int)\n    super\n  end\n\n  def initialize(size : Int, edges : Array(Edge2(T)))\n\
    \    super(size)\n    add_edges(edges)\n  end\n\n  def add_edge(edge : Edge2(T))\n\
    \    raise IndexError.new unless 0 <= edge.from < size\n    raise IndexError.new\
    \ unless 0 <= edge.to < size\n    @graph[edge.from] << Edge.new(edge.to, edge.cost)\n\
    \    self\n  end\nend\n\nclass UndirectedGraph(T) < Graph(T)\n  def initialize(size\
    \ : Int)\n    super\n  end\n\n  def initialize(size : Int, edges : Array(Edge2(T)))\n\
    \    super(size)\n    add_edges(edges)\n  end\n\n  def add_edge(edge : Edge2(T))\n\
    \    raise IndexError.new unless 0 <= edge.from < size\n    raise IndexError.new\
    \ unless 0 <= edge.to < size\n    @graph[edge.from] << Edge.new(edge.to, edge.cost)\n\
    \    @graph[edge.to] << Edge.new(edge.from, edge.cost)\n    self\n  end\nend\n\
    \nabstract class UnweightedGraph\n  getter graph : Array(Array(Int32))\n\n  def\
    \ initialize(size : Int)\n    raise ArgumentError.new(\"Negative graph size: #{size}\"\
    ) unless size >= 0\n    @graph = Array.new(size) { Array(Int32).new }\n  end\n\
    \n  def add_edge(i : Int32, j : Int32)\n    add_edge(UnweightedEdge2.new(i, j))\n\
    \  end\n\n  def add_edges(edges : Array(UnweightedEdge2))\n    edges.each { |edge|\
    \ add_edge(edge) }\n    self\n  end\n\n  delegate size, to: @graph\n  delegate\
    \ :[], to: @graph\n\n  def each_edge : Nil\n    (0...size).each do |v|\n     \
    \ graph[v].each do |u|\n        yield UnweightedEdge2.new(v, u)\n      end\n \
    \   end\n  end\n\n  def edges\n    result = [] of UnweightedEdge2\n    each_edge\
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
    \      yield u if u != parent\n    end\n  end\nend\n\nclass UnweightedGraph\n\
    \  def bfs(start : Int32, unreachable : U = nil) forall U\n    raise ArgumentError.new\
    \ unless 0 <= start < size\n    queue = Deque{start}\n    dist = Array(Int32?).new(size,\
    \ nil)\n    dist[start] = 0\n    while v = queue.pop?\n      graph[v].each do\
    \ |edge|\n        if dist[edge].nil?\n          dist[edge] = dist[v].not_nil!\
    \ + 1\n          queue.unshift edge\n        end\n      end\n    end\n    dist.map\
    \ { |i| i || unreachable }\n  end\n\n  def bfs!(start : Int32)\n    bfs(start).map(&.not_nil!)\n\
    \  end\n\n  def bfs_st(start : Int32, goal : Int32, unreachable : U = nil) forall\
    \ U\n    raise ArgumentError.new unless 0 <= start < size\n    queue = Deque{start}\n\
    \    dist = Array(Int32?).new(size, nil)\n    dist[start] = 0\n    while v = queue.pop?\n\
    \      d = dist[v].not_nil!\n      return d if v == goal\n      graph[v].each\
    \ do |edge|\n        if dist[edge].nil?\n          dist[edge] = d + 1\n      \
    \    queue.unshift edge\n        end\n      end\n    end\n    unreachable\n  end\n\
    end\n"
  code: "require \"./graph\"\n\nclass UnweightedGraph\n  def bfs(start : Int32, unreachable\
    \ : U = nil) forall U\n    raise ArgumentError.new unless 0 <= start < size\n\
    \    queue = Deque{start}\n    dist = Array(Int32?).new(size, nil)\n    dist[start]\
    \ = 0\n    while v = queue.pop?\n      graph[v].each do |edge|\n        if dist[edge].nil?\n\
    \          dist[edge] = dist[v].not_nil! + 1\n          queue.unshift edge\n \
    \       end\n      end\n    end\n    dist.map { |i| i || unreachable }\n  end\n\
    \n  def bfs!(start : Int32)\n    bfs(start).map(&.not_nil!)\n  end\n\n  def bfs_st(start\
    \ : Int32, goal : Int32, unreachable : U = nil) forall U\n    raise ArgumentError.new\
    \ unless 0 <= start < size\n    queue = Deque{start}\n    dist = Array(Int32?).new(size,\
    \ nil)\n    dist[start] = 0\n    while v = queue.pop?\n      d = dist[v].not_nil!\n\
    \      return d if v == goal\n      graph[v].each do |edge|\n        if dist[edge].nil?\n\
    \          dist[edge] = d + 1\n          queue.unshift edge\n        end\n   \
    \   end\n    end\n    unreachable\n  end\nend\n"
  dependsOn:
  - graph/graph.cr
  isVerificationFile: false
  path: graph/bfs.cr
  requiredBy: []
  timestamp: '2021-06-23 20:36:51+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/bfs.test.cr
documentation_of: graph/bfs.cr
layout: document
redirect_from:
- /library/graph/bfs.cr
- /library/graph/bfs.cr.html
title: graph/bfs.cr
---
