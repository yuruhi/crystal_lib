---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/graph/edge.cr
    title: src/graph/edge.cr
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/graph_spec.cr
    title: spec/graph_spec.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/bfs.cr
    title: src/graph/bfs.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/bfs01.cr
    title: src/graph/bfs01.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/bipartite_graph.cr
    title: src/graph/bipartite_graph.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/bipartite_matching.cr
    title: src/graph/bipartite_matching.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/components.cr
    title: src/graph/components.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/compress.cr
    title: src/graph/compress.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/decompose.cr
    title: src/graph/decompose.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/degree.cr
    title: src/graph/degree.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/dijkstra.cr
    title: src/graph/dijkstra.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/kruskal.cr
    title: src/graph/kruskal.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/lca.cr
    title: src/graph/lca.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/re_rooting.cr
    title: src/graph/re_rooting.cr
  - icon: ':x:'
    path: src/graph/topological_sort.cr
    title: src/graph/topological_sort.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/tree.cr
    title: src/graph/tree.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/tree_walk.cr
    title: src/graph/tree_walk.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "# require \"./graph/edge\"\nstruct WeightedEdge(T)\n  include Comparable(WeightedEdge(T))\n\
    \n  property to : Int32, cost : T\n\n  def initialize(@to, @cost : T)\n  end\n\
    \n  def <=>(other : WeightedEdge(T))\n    {cost, to} <=> {other.cost, other.to}\n\
    \  end\n\n  def to_s(io) : Nil\n    io << '(' << to << \", \" << cost << ')'\n\
    \  end\n\n  def inspect(io) : Nil\n    io << \"->#{to}(#{cost})\"\n  end\nend\n\
    \nstruct WeightedEdge2(T)\n  include Comparable(WeightedEdge2(T))\n\n  property\
    \ from : Int32, to : Int32, cost : T\n\n  def initialize(@from, @to, @cost : T)\n\
    \  end\n\n  def initialize(@from, edge : WeightedEdge(T))\n    @to, @cost = edge.to,\
    \ edge.cost\n  end\n\n  def <=>(other : WeightedEdge2(T))\n    {cost, from, to}\
    \ <=> {other.cost, other.from, other.to}\n  end\n\n  def reverse\n    WeightedEdge2(T).new(to,\
    \ from, cost)\n  end\n\n  def sort\n    WeightedEdge2(T).new(*{to, from}.minmax,\
    \ cost)\n  end\n\n  def to_s(io) : Nil\n    io << '(' << from << \", \" << to\
    \ << \", \" << cost << ')'\n  end\n\n  def inspect(io) : Nil\n    io << from <<\
    \ \"->\" << to << '(' << cost << ')'\n  end\nend\n\nstruct UnweightedEdge\n  property\
    \ to : Int32\n\n  def initialize(@to)\n  end\n\n  def cost\n    1\n  end\n\n \
    \ def to_s(io) : Nil\n    io << to\n  end\n\n  def inspect(io) : Nil\n    io <<\
    \ \"->\" << to\n  end\nend\n\nstruct UnweightedEdge2\n  property from : Int32,\
    \ to : Int32\n\n  def initialize(@from, @to)\n  end\n\n  def initialize(@from,\
    \ edge : UnweightedEdge)\n    @to = edge.to\n  end\n\n  def cost\n    1\n  end\n\
    \n  def reverse\n    UnweightedEdge2.new(to, from)\n  end\n\n  def sort\n    UnweightedEdge2.new(*{to,\
    \ from}.minmax)\n  end\n\n  def to_s(io) : Nil\n    io << '(' << from << \", \"\
    \ << to << ')'\n  end\n\n  def inspect(io) : Nil\n    io << from << \"->\" <<\
    \ to\n  end\nend\n\nmodule Graph(Edge, Edge2)\n  include Enumerable(Edge2)\n\n\
    \  getter graph : Array(Array(Edge))\n\n  def initialize(size : Int)\n    @graph\
    \ = Array(Array(Edge)).new(size) { [] of Edge }\n  end\n\n  def initialize(size\
    \ : Int, edges : Enumerable)\n    initialize(size)\n    add_edges(edges)\n  end\n\
    \n  # Add *edge*.\n  abstract def <<(edge : Edge2)\n\n  # :ditto:\n  def <<(edge\
    \ : Tuple)\n    self << Edge2.new(*edge)\n  end\n\n  def add_edges(edges : Enumerable)\n\
    \    edges.each { |edge| self << edge }\n  end\n\n  delegate size, to: @graph\n\
    \  delegate :[], to: @graph\n\n  # Yields each edge of the graph, ans returns\
    \ `nil`.\n  def each(&) : Nil\n    (0...size).each do |v|\n      self[v].each\
    \ do |edge|\n        yield Edge2.new(v, edge)\n      end\n    end\n  end\n\n \
    \ def reverse\n    if self.class.directed?\n      each_with_object(self.class.new(size))\
    \ do |edge, reversed|\n        reversed << edge.reverse\n      end\n    else\n\
    \      dup\n    end\n  end\n\n  def to_undirected\n    if self.class.directed?\n\
    \      each_with_object(self.class.new(size)) do |edge, graph|\n        graph\
    \ << edge\n        graph << edge.reverse if self.class.directed?\n      end\n\
    \    else\n      dup\n    end\n  end\n\n  def to_s(io : IO) : Nil\n    io << '['\n\
    \    join(\", \", io) do |edge, io|\n      edge.inspect io\n    end\n    io <<\
    \ ']'\n  end\n\n  def inspect(io : IO) : Nil\n    to_s(io)\n  end\nend\n\nclass\
    \ DirectedGraph(T)\n  include Graph(WeightedEdge(T), WeightedEdge2(T))\n\n  def\
    \ initialize(size : Int)\n    super\n  end\n\n  def initialize(size : Int, edges\
    \ : Enumerable(WeightedEdge2(T)))\n    super\n  end\n\n  def initialize(size :\
    \ Int, edges : Enumerable({Int32, Int32, T}))\n    super\n  end\n\n  def <<(edge\
    \ : WeightedEdge2(T))\n    raise IndexError.new unless 0 <= edge.from < size &&\
    \ 0 <= edge.to < size\n    @graph[edge.from] << WeightedEdge.new(edge.to, edge.cost)\n\
    \    self\n  end\n\n  def self.weighted?\n    true\n  end\n\n  def self.directed?\n\
    \    true\n  end\nend\n\nclass UndirectedGraph(T)\n  include Graph(WeightedEdge(T),\
    \ WeightedEdge2(T))\n\n  def initialize(size : Int)\n    super\n  end\n\n  def\
    \ initialize(size : Int, edges : Enumerable(WeightedEdge2(T)))\n    super\n  end\n\
    \n  def initialize(size : Int, edges : Enumerable({Int32, Int32, T}))\n    super\n\
    \  end\n\n  def <<(edge : WeightedEdge2(T))\n    raise IndexError.new unless 0\
    \ <= edge.from < size && 0 <= edge.to < size\n    @graph[edge.from] << WeightedEdge.new(edge.to,\
    \ edge.cost)\n    @graph[edge.to] << WeightedEdge.new(edge.from, edge.cost)\n\
    \    self\n  end\n\n  def self.weighted?\n    true\n  end\n\n  def self.directed?\n\
    \    false\n  end\nend\n\nclass UnweightedDirectedGraph\n  include Graph(UnweightedEdge,\
    \ UnweightedEdge2)\n\n  def initialize(size : Int)\n    super\n  end\n\n  def\
    \ initialize(size : Int, edges : Enumerable)\n    super\n  end\n\n  def <<(edge\
    \ : UnweightedEdge2)\n    raise IndexError.new unless 0 <= edge.from < size &&\
    \ 0 <= edge.to < size\n    @graph[edge.from] << UnweightedEdge.new(edge.to)\n\
    \    self\n  end\n\n  def self.weighted?\n    false\n  end\n\n  def self.directed?\n\
    \    true\n  end\nend\n\nclass UnweightedUndirectedGraph\n  include Graph(UnweightedEdge,\
    \ UnweightedEdge2)\n\n  def initialize(size : Int)\n    super\n  end\n\n  def\
    \ initialize(size : Int, edges : Enumerable)\n    super\n  end\n\n  def <<(edge\
    \ : UnweightedEdge2)\n    raise IndexError.new unless 0 <= edge.from < size &&\
    \ 0 <= edge.to < size\n    @graph[edge.from] << UnweightedEdge.new(edge.to)\n\
    \    @graph[edge.to] << UnweightedEdge.new(edge.from)\n    self\n  end\n\n  def\
    \ each_child(vertex : Int, parent, &block) : Nil\n    graph[vertex].each do |u|\n\
    \      yield u if u != parent\n    end\n  end\n\n  def each_child(vertex : Int,\
    \ parent)\n    graph[vertex].each.select { |u| u != parent }\n  end\n\n  def self.weighted?\n\
    \    false\n  end\n\n  def self.directed?\n    false\n  end\nend\n"
  code: "require \"./graph/edge\"\n\nmodule Graph(Edge, Edge2)\n  include Enumerable(Edge2)\n\
    \n  getter graph : Array(Array(Edge))\n\n  def initialize(size : Int)\n    @graph\
    \ = Array(Array(Edge)).new(size) { [] of Edge }\n  end\n\n  def initialize(size\
    \ : Int, edges : Enumerable)\n    initialize(size)\n    add_edges(edges)\n  end\n\
    \n  # Add *edge*.\n  abstract def <<(edge : Edge2)\n\n  # :ditto:\n  def <<(edge\
    \ : Tuple)\n    self << Edge2.new(*edge)\n  end\n\n  def add_edges(edges : Enumerable)\n\
    \    edges.each { |edge| self << edge }\n  end\n\n  delegate size, to: @graph\n\
    \  delegate :[], to: @graph\n\n  # Yields each edge of the graph, ans returns\
    \ `nil`.\n  def each(&) : Nil\n    (0...size).each do |v|\n      self[v].each\
    \ do |edge|\n        yield Edge2.new(v, edge)\n      end\n    end\n  end\n\n \
    \ def reverse\n    if self.class.directed?\n      each_with_object(self.class.new(size))\
    \ do |edge, reversed|\n        reversed << edge.reverse\n      end\n    else\n\
    \      dup\n    end\n  end\n\n  def to_undirected\n    if self.class.directed?\n\
    \      each_with_object(self.class.new(size)) do |edge, graph|\n        graph\
    \ << edge\n        graph << edge.reverse if self.class.directed?\n      end\n\
    \    else\n      dup\n    end\n  end\n\n  def to_s(io : IO) : Nil\n    io << '['\n\
    \    join(\", \", io) do |edge, io|\n      edge.inspect io\n    end\n    io <<\
    \ ']'\n  end\n\n  def inspect(io : IO) : Nil\n    to_s(io)\n  end\nend\n\nclass\
    \ DirectedGraph(T)\n  include Graph(WeightedEdge(T), WeightedEdge2(T))\n\n  def\
    \ initialize(size : Int)\n    super\n  end\n\n  def initialize(size : Int, edges\
    \ : Enumerable(WeightedEdge2(T)))\n    super\n  end\n\n  def initialize(size :\
    \ Int, edges : Enumerable({Int32, Int32, T}))\n    super\n  end\n\n  def <<(edge\
    \ : WeightedEdge2(T))\n    raise IndexError.new unless 0 <= edge.from < size &&\
    \ 0 <= edge.to < size\n    @graph[edge.from] << WeightedEdge.new(edge.to, edge.cost)\n\
    \    self\n  end\n\n  def self.weighted?\n    true\n  end\n\n  def self.directed?\n\
    \    true\n  end\nend\n\nclass UndirectedGraph(T)\n  include Graph(WeightedEdge(T),\
    \ WeightedEdge2(T))\n\n  def initialize(size : Int)\n    super\n  end\n\n  def\
    \ initialize(size : Int, edges : Enumerable(WeightedEdge2(T)))\n    super\n  end\n\
    \n  def initialize(size : Int, edges : Enumerable({Int32, Int32, T}))\n    super\n\
    \  end\n\n  def <<(edge : WeightedEdge2(T))\n    raise IndexError.new unless 0\
    \ <= edge.from < size && 0 <= edge.to < size\n    @graph[edge.from] << WeightedEdge.new(edge.to,\
    \ edge.cost)\n    @graph[edge.to] << WeightedEdge.new(edge.from, edge.cost)\n\
    \    self\n  end\n\n  def self.weighted?\n    true\n  end\n\n  def self.directed?\n\
    \    false\n  end\nend\n\nclass UnweightedDirectedGraph\n  include Graph(UnweightedEdge,\
    \ UnweightedEdge2)\n\n  def initialize(size : Int)\n    super\n  end\n\n  def\
    \ initialize(size : Int, edges : Enumerable)\n    super\n  end\n\n  def <<(edge\
    \ : UnweightedEdge2)\n    raise IndexError.new unless 0 <= edge.from < size &&\
    \ 0 <= edge.to < size\n    @graph[edge.from] << UnweightedEdge.new(edge.to)\n\
    \    self\n  end\n\n  def self.weighted?\n    false\n  end\n\n  def self.directed?\n\
    \    true\n  end\nend\n\nclass UnweightedUndirectedGraph\n  include Graph(UnweightedEdge,\
    \ UnweightedEdge2)\n\n  def initialize(size : Int)\n    super\n  end\n\n  def\
    \ initialize(size : Int, edges : Enumerable)\n    super\n  end\n\n  def <<(edge\
    \ : UnweightedEdge2)\n    raise IndexError.new unless 0 <= edge.from < size &&\
    \ 0 <= edge.to < size\n    @graph[edge.from] << UnweightedEdge.new(edge.to)\n\
    \    @graph[edge.to] << UnweightedEdge.new(edge.from)\n    self\n  end\n\n  def\
    \ each_child(vertex : Int, parent, &block) : Nil\n    graph[vertex].each do |u|\n\
    \      yield u if u != parent\n    end\n  end\n\n  def each_child(vertex : Int,\
    \ parent)\n    graph[vertex].each.select { |u| u != parent }\n  end\n\n  def self.weighted?\n\
    \    false\n  end\n\n  def self.directed?\n    false\n  end\nend\n"
  dependsOn:
  - src/graph/edge.cr
  isVerificationFile: false
  path: src/graph.cr
  requiredBy:
  - src/graph/compress.cr
  - src/graph/tree.cr
  - src/graph/bipartite_graph.cr
  - src/graph/degree.cr
  - src/graph/components.cr
  - src/graph/dijkstra.cr
  - src/graph/re_rooting.cr
  - src/graph/tree_walk.cr
  - src/graph/lca.cr
  - src/graph/bfs.cr
  - src/graph/bipartite_matching.cr
  - src/graph/decompose.cr
  - src/graph/bfs01.cr
  - src/graph/kruskal.cr
  - src/graph/topological_sort.cr
  - spec/graph_spec.cr
  timestamp: '2021-07-23 17:17:24+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/graph.cr
layout: document
redirect_from:
- /library/src/graph.cr
- /library/src/graph.cr.html
title: src/graph.cr
---