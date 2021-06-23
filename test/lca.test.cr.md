---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: graph/lca.cr
    title: graph/lca.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://onlinejudge.u-aizu.ac.jp/problems/GRL_5_C
  bundledCode: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/GRL_5_C\n\
    # require \"../graph/lca\"\n# require \"./graph\"\nstruct Edge(T)\n  include Comparable(Edge(T))\n\
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
    \      yield u if u != parent\n    end\n  end\nend\n\nclass LCA\n  getter graph\
    \ : UnweightedUndirectedGraph\n  getter size : Int32\n  getter depth : Array(Int32)\n\
    \n  private def dfs(vertex : Int32, par : Int32, dep : Int32) : Nil\n    @parent[0][vertex]\
    \ = par\n    @depth[vertex] = dep\n    @graph[vertex].each do |edge|\n      dfs(edge,\
    \ vertex, dep + 1) if edge != par\n    end\n  end\n\n  def initialize(@graph :\
    \ UnweightedUndirectedGraph, root : Int32)\n    @size = @graph.size\n    @log2\
    \ = Math.log2(@size).to_i.succ.as(Int32)\n    @depth = Array(Int32).new(@size,\
    \ -1)\n    @parent = Array(Array(Int32)).new(@log2) { Array.new(@size, 0) }\n\
    \    dfs(root, -1, 0)\n    (0...@log2 - 1).each do |k|\n      (0...size).each\
    \ do |v|\n        if @parent[k][v] < 0\n          @parent[k + 1][v] = -1\n   \
    \     else\n          @parent[k + 1][v] = @parent[k][@parent[k][v]]\n        end\n\
    \      end\n    end\n  end\n\n  def lca(u : Int32, v : Int32) : Int32\n    raise\
    \ IndexError.new unless 0 <= u < size\n    raise IndexError.new unless 0 <= v\
    \ < size\n    u, v = v, u if @depth[u] > @depth[v]\n    (0...@log2).each do |k|\n\
    \      v = @parent[k][v] if (@depth[v] - @depth[u]).bit(k) == 1\n    end\n\n \
    \   return u if u == v\n\n    (0...@log2).reverse_each do |k|\n      u, v = @parent[k][u],\
    \ @parent[k][v] if @parent[k][u] != @parent[k][v]\n    end\n    @parent[0][u]\n\
    \  end\n\n  def dist(u : Int32, v : Int32) : Int32\n    @depth[u] + @depth[v]\
    \ - @depth[lca(u, v)] * 2\n  end\nend\n\nn = read_line.to_i\ngraph = UnweightedUndirectedGraph.new(n)\n\
    n.times do |u|\n  read_line.split.map(&.to_i).skip(1).each do |v|\n    graph.add_edge(u,\
    \ v)\n  end\nend\nlca = LCA.new(graph, 0)\nread_line.to_i.times do\n  u, v = read_line.split.map(&.to_i)\n\
    \  puts lca.lca(u, v)\nend\n"
  code: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/GRL_5_C\n\
    require \"../graph/lca\"\nn = read_line.to_i\ngraph = UnweightedUndirectedGraph.new(n)\n\
    n.times do |u|\n  read_line.split.map(&.to_i).skip(1).each do |v|\n    graph.add_edge(u,\
    \ v)\n  end\nend\nlca = LCA.new(graph, 0)\nread_line.to_i.times do\n  u, v = read_line.split.map(&.to_i)\n\
    \  puts lca.lca(u, v)\nend\n"
  dependsOn:
  - graph/lca.cr
  isVerificationFile: true
  path: test/lca.test.cr
  requiredBy: []
  timestamp: '2021-05-19 19:30:36+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/lca.test.cr
layout: document
redirect_from:
- /verify/test/lca.test.cr
- /verify/test/lca.test.cr.html
title: test/lca.test.cr
---
