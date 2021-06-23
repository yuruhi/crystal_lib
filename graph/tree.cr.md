---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: graph/graph.cr
    title: graph/graph.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/diameter.test.cr
    title: test/diameter.test.cr
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
    \  # TODO: verify\n  private def subtree_size_dfs(v : Int32, p : Int32, result\
    \ : Array(Int32)) : Int32\n    result[v] = 1 + self[v].sum do |u|\n      subtree_size_dfs(u,\
    \ v, result) if u != p\n    end\n  end\n\n  def subtree_size(root : Int32)\n \
    \   result = Array.new(size, 0)\n    subtree_size_dfs(root, -1, result)\n    result\n\
    \  end\n\n  private def tree_depth_dfs(v : Int32, p : Int32, dist : Int32, a :\
    \ Array(Int32)) : Nil\n    a[v] = dist\n    self[v].each do |u|\n      tree_depth_dfs(u,\
    \ v, dist + 1, a) if u != p\n    end\n  end\n\n  def tree_depth(root : Int32)\n\
    \    a = Array.new(size, 0)\n    tree_depth_dfs(root, -1, 0, a)\n    a\n  end\n\
    end\n\nclass Graph(T)\n  private def tree_distance_dfs(v : Int32, p : Int32, dist\
    \ : T, a : Array(T))\n    a[v] = dist\n    self[v].select { |edge| edge.to !=\
    \ p }.each { |edge|\n      tree_distance_dfs(edge.to, v, dist + edge.cost, a)\n\
    \    }\n  end\n\n  def tree_distance(root : Int32)\n    a = Array(T).new(size,\
    \ T.zero)\n    tree_distance_dfs(root, -1, T.zero, a)\n    a\n  end\n\n  def diameter\
    \ : {T, Int32, Int32}\n    v = tree_distance(0).each_with_index.max[1]\n    dist,\
    \ u = tree_distance(v).each_with_index.max\n    {dist, v, u}\n  end\nend\n"
  code: "require \"./graph\"\n\nclass UnweightedGraph\n  # TODO: verify\n  private\
    \ def subtree_size_dfs(v : Int32, p : Int32, result : Array(Int32)) : Int32\n\
    \    result[v] = 1 + self[v].sum do |u|\n      subtree_size_dfs(u, v, result)\
    \ if u != p\n    end\n  end\n\n  def subtree_size(root : Int32)\n    result =\
    \ Array.new(size, 0)\n    subtree_size_dfs(root, -1, result)\n    result\n  end\n\
    \n  private def tree_depth_dfs(v : Int32, p : Int32, dist : Int32, a : Array(Int32))\
    \ : Nil\n    a[v] = dist\n    self[v].each do |u|\n      tree_depth_dfs(u, v,\
    \ dist + 1, a) if u != p\n    end\n  end\n\n  def tree_depth(root : Int32)\n \
    \   a = Array.new(size, 0)\n    tree_depth_dfs(root, -1, 0, a)\n    a\n  end\n\
    end\n\nclass Graph(T)\n  private def tree_distance_dfs(v : Int32, p : Int32, dist\
    \ : T, a : Array(T))\n    a[v] = dist\n    self[v].select { |edge| edge.to !=\
    \ p }.each { |edge|\n      tree_distance_dfs(edge.to, v, dist + edge.cost, a)\n\
    \    }\n  end\n\n  def tree_distance(root : Int32)\n    a = Array(T).new(size,\
    \ T.zero)\n    tree_distance_dfs(root, -1, T.zero, a)\n    a\n  end\n\n  def diameter\
    \ : {T, Int32, Int32}\n    v = tree_distance(0).each_with_index.max[1]\n    dist,\
    \ u = tree_distance(v).each_with_index.max\n    {dist, v, u}\n  end\nend\n"
  dependsOn:
  - graph/graph.cr
  isVerificationFile: false
  path: graph/tree.cr
  requiredBy: []
  timestamp: '2021-06-23 20:36:51+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/diameter.test.cr
documentation_of: graph/tree.cr
layout: document
redirect_from:
- /library/graph/tree.cr
- /library/graph/tree.cr.html
title: graph/tree.cr
---
