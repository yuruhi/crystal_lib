---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':heavy_check_mark:'
    path: graph/BipartiteMatching.cr
    title: graph/BipartiteMatching.cr
  - icon: ':heavy_check_mark:'
    path: graph/ReRooting.cr
    title: graph/ReRooting.cr
  - icon: ':heavy_check_mark:'
    path: graph/bfs.cr
    title: graph/bfs.cr
  - icon: ':heavy_check_mark:'
    path: graph/bipartite_graph.cr
    title: graph/bipartite_graph.cr
  - icon: ':heavy_check_mark:'
    path: graph/dijkstra.cr
    title: graph/dijkstra.cr
  - icon: ':heavy_check_mark:'
    path: graph/kruskal.cr
    title: graph/kruskal.cr
  - icon: ':heavy_check_mark:'
    path: graph/lca.cr
    title: graph/lca.cr
  - icon: ':heavy_check_mark:'
    path: graph/topological_sort.cr
    title: graph/topological_sort.cr
  - icon: ':heavy_check_mark:'
    path: graph/tree.cr
    title: graph/tree.cr
  - icon: ':heavy_check_mark:'
    path: graph/tree_walk.cr
    title: graph/tree_walk.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "struct Edge(T)\n  include Comparable(Edge(T))\n\n  property to : Int32\n\
    \  property cost : T\n\n  def initialize(@to : Int32, @cost : T)\n  end\n\n  def\
    \ <=>(other : Edge(T))\n    {cost, to} <=> {other.cost, other.to}\n  end\n\n \
    \ def to_s(io) : Nil\n    io << '(' << to << \", \" << cost << ')'\n  end\n\n\
    \  def inspect(io) : Nil\n    io << \"->#{to}(#{cost})\"\n  end\nend\n\nstruct\
    \ Edge2(T)\n  include Comparable(Edge2(T))\n\n  property from : Int32\n  property\
    \ to : Int32\n  property cost : T\n\n  def initialize(@from : Int32, @to : Int32,\
    \ @cost : T)\n  end\n\n  def <=>(other : Edge2(T))\n    {cost, from, to} <=> {other.cost,\
    \ other.from, other.to}\n  end\n\n  def reverse\n    Edge2(T).new(to, from, cost)\n\
    \  end\n\n  def to_s(io) : Nil\n    io << '(' << from << \", \" << to << \", \"\
    \ << cost << ')'\n  end\n\n  def inspect(io) : Nil\n    io << \"#{from}->#{to}(#{cost})\"\
    \n  end\nend\n\nstruct UnweightedEdge2\n  property from : Int32\n  property to\
    \ : Int32\n\n  def initialize(@from, @to)\n  end\n\n  def reverse\n    UnweightedEdge2.new(to,\
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
    \      yield u if u != parent\n    end\n  end\nend\n"
  code: "struct Edge(T)\n  include Comparable(Edge(T))\n\n  property to : Int32\n\
    \  property cost : T\n\n  def initialize(@to : Int32, @cost : T)\n  end\n\n  def\
    \ <=>(other : Edge(T))\n    {cost, to} <=> {other.cost, other.to}\n  end\n\n \
    \ def to_s(io) : Nil\n    io << '(' << to << \", \" << cost << ')'\n  end\n\n\
    \  def inspect(io) : Nil\n    io << \"->#{to}(#{cost})\"\n  end\nend\n\nstruct\
    \ Edge2(T)\n  include Comparable(Edge2(T))\n\n  property from : Int32\n  property\
    \ to : Int32\n  property cost : T\n\n  def initialize(@from : Int32, @to : Int32,\
    \ @cost : T)\n  end\n\n  def <=>(other : Edge2(T))\n    {cost, from, to} <=> {other.cost,\
    \ other.from, other.to}\n  end\n\n  def reverse\n    Edge2(T).new(to, from, cost)\n\
    \  end\n\n  def to_s(io) : Nil\n    io << '(' << from << \", \" << to << \", \"\
    \ << cost << ')'\n  end\n\n  def inspect(io) : Nil\n    io << \"#{from}->#{to}(#{cost})\"\
    \n  end\nend\n\nstruct UnweightedEdge2\n  property from : Int32\n  property to\
    \ : Int32\n\n  def initialize(@from, @to)\n  end\n\n  def reverse\n    UnweightedEdge2.new(to,\
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
    \      yield u if u != parent\n    end\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: graph/graph.cr
  requiredBy:
  - graph/tree_walk.cr
  - graph/dijkstra.cr
  - graph/bfs.cr
  - graph/kruskal.cr
  - graph/bipartite_graph.cr
  - graph/ReRooting.cr
  - graph/lca.cr
  - graph/tree.cr
  - graph/topological_sort.cr
  - graph/BipartiteMatching.cr
  timestamp: '2021-06-23 21:16:54+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: graph/graph.cr
layout: document
redirect_from:
- /library/graph/graph.cr
- /library/graph/graph.cr.html
title: graph/graph.cr
---
