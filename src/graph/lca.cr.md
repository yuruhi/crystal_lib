---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/graph.cr
    title: src/graph.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/edge.cr
    title: src/graph/edge.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/graph/decompose_test.cr
    title: test/graph/decompose_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/lca_test.cr
    title: test/graph/lca_test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "# require \"../graph\"\n# require \"./graph/edge\"\nstruct WeightedEdge(T)\n\
    \  include Comparable(WeightedEdge(T))\n\n  property to : Int32, cost : T\n\n\
    \  def initialize(@to, @cost : T)\n  end\n\n  def <=>(other : WeightedEdge(T))\n\
    \    {cost, to} <=> {other.cost, other.to}\n  end\n\n  def to_s(io) : Nil\n  \
    \  io << '(' << to << \", \" << cost << ')'\n  end\n\n  def inspect(io) : Nil\n\
    \    io << \"->#{to}(#{cost})\"\n  end\nend\n\nstruct WeightedEdge2(T)\n  include\
    \ Comparable(WeightedEdge2(T))\n\n  property from : Int32, to : Int32, cost :\
    \ T\n\n  def initialize(@from, @to, @cost : T)\n  end\n\n  def initialize(@from,\
    \ edge : WeightedEdge(T))\n    @to, @cost = edge.to, edge.cost\n  end\n\n  def\
    \ <=>(other : WeightedEdge2(T))\n    {cost, from, to} <=> {other.cost, other.from,\
    \ other.to}\n  end\n\n  def reverse\n    WeightedEdge2(T).new(to, from, cost)\n\
    \  end\n\n  def sort\n    WeightedEdge2(T).new(*{to, from}.minmax, cost)\n  end\n\
    \n  def to_s(io) : Nil\n    io << '(' << from << \", \" << to << \", \" << cost\
    \ << ')'\n  end\n\n  def inspect(io) : Nil\n    io << from << \"->\" << to <<\
    \ '(' << cost << ')'\n  end\nend\n\nstruct UnweightedEdge\n  property to : Int32\n\
    \n  def initialize(@to)\n  end\n\n  def initialize(@to, cost)\n  end\n\n  def\
    \ cost\n    1\n  end\n\n  def to_s(io) : Nil\n    io << to\n  end\n\n  def inspect(io)\
    \ : Nil\n    io << \"->\" << to\n  end\nend\n\nstruct UnweightedEdge2\n  property\
    \ from : Int32, to : Int32\n\n  def initialize(@from, @to)\n  end\n\n  def initialize(@from,\
    \ @to, cost)\n  end\n\n  def initialize(@from, edge : UnweightedEdge)\n    @to\
    \ = edge.to\n  end\n\n  def cost\n    1\n  end\n\n  def reverse\n    UnweightedEdge2.new(to,\
    \ from)\n  end\n\n  def sort\n    UnweightedEdge2.new(*{to, from}.minmax)\n  end\n\
    \n  def to_s(io) : Nil\n    io << '(' << from << \", \" << to << ')'\n  end\n\n\
    \  def inspect(io) : Nil\n    io << from << \"->\" << to\n  end\nend\n\nmodule\
    \ Graph(Edge, Edge2)\n  include Enumerable(Edge2)\n\n  getter graph : Array(Array(Edge))\n\
    \n  def initialize(size : Int)\n    @graph = Array(Array(Edge)).new(size) { []\
    \ of Edge }\n  end\n\n  def initialize(size : Int, edges : Enumerable)\n    initialize(size)\n\
    \    add_edges(edges)\n  end\n\n  # Add *edge*.\n  abstract def <<(edge : Edge2)\n\
    \n  # :ditto:\n  def <<(edge : Tuple)\n    self << Edge2.new(*edge)\n  end\n\n\
    \  def add_edges(edges : Enumerable)\n    edges.each { |edge| self << edge }\n\
    \  end\n\n  delegate size, to: @graph\n  delegate :[], to: @graph\n\n  # Yields\
    \ each edge of the graph, ans returns `nil`.\n  def each(&) : Nil\n    (0...size).each\
    \ do |v|\n      self[v].each do |edge|\n        yield Edge2.new(v, edge)\n   \
    \   end\n    end\n  end\n\n  def reverse\n    if self.class.directed?\n      each_with_object(self.class.new(size))\
    \ do |edge, reversed|\n        reversed << edge.reverse\n      end\n    else\n\
    \      dup\n    end\n  end\n\n  def to_undirected\n    if self.class.directed?\n\
    \      each_with_object(self.class.new(size)) do |edge, graph|\n        graph\
    \ << edge\n        graph << edge.reverse if self.class.directed?\n      end\n\
    \    else\n      dup\n    end\n  end\n\n  def to_s(io : IO) : Nil\n    io << '['\n\
    \    join(\", \", io) do |edge, io|\n      edge.inspect io\n    end\n    io <<\
    \ ']'\n  end\n\n  def inspect(io : IO) : Nil\n    io << \"[\\n\"\n    graph.each\
    \ do |edges|\n      io << \"  \" << edges << \",\\n\"\n    end\n    io << ']'\n\
    \  end\nend\n\nclass DirectedGraph(T)\n  include Graph(WeightedEdge(T), WeightedEdge2(T))\n\
    \n  def initialize(size : Int)\n    super\n  end\n\n  def initialize(size : Int,\
    \ edges : Enumerable(WeightedEdge2(T)))\n    super\n  end\n\n  def initialize(size\
    \ : Int, edges : Enumerable({Int32, Int32, T}))\n    super\n  end\n\n  def <<(edge\
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
    \    false\n  end\n\n  def self.directed?\n    false\n  end\nend\n\nclass LCA(Edge,\
    \ Edge2)\n  getter graph : Graph(Edge, Edge2)\n  getter depth : Array(Int32)\n\
    \  getter log2 : Int32\n\n  private def dfs(vertex : Int32, par : Int32, dep :\
    \ Int32) : Nil\n    @parent[0][vertex] = par\n    @depth[vertex] = dep\n    @graph[vertex].each\
    \ do |edge|\n      dfs(edge.to, vertex, dep + 1) if edge.to != par\n    end\n\
    \  end\n\n  def initialize(@graph : Graph(Edge, Edge2), root : Int32)\n    @log2\
    \ = Math.log2(size).to_i.succ\n    @depth = Array(Int32).new(size, -1)\n    @parent\
    \ = Array(Array(Int32)).new(log2) { Array.new(size, 0) }\n    dfs(root, -1, 0)\n\
    \    (0...log2 - 1).each do |k|\n      (0...size).each do |v|\n        if @parent[k][v]\
    \ < 0\n          @parent[k + 1][v] = -1\n        else\n          @parent[k + 1][v]\
    \ = @parent[k][@parent[k][v]]\n        end\n      end\n    end\n  end\n\n  delegate\
    \ size, to: @graph\n\n  def depth(v : Int32) : Int32\n    @depth[v]\n  end\n\n\
    \  def parent_p2(v : Int32, k : Int32) : Int32?\n    p = @parent[k][v]\n    p\
    \ >= 0 ? p : nil\n  end\n\n  def parent_p2!(v : Int32, k : Int32) : Int32\n  \
    \  parent_p2(v, k).not_nil!\n  end\n\n  def parent(v : Int32) : Int32?\n    parent_p2(v,\
    \ 0)\n  end\n\n  def parent!(v : Int32) : Int32\n    parent(v).not_nil!\n  end\n\
    \n  def parent(v : Int32, up : Int32) : Int32?\n    log2.times do |k|\n      v\
    \ = @parent[k][v] if up.bit(k) == 1\n      return nil if v < 0\n    end\n    v\n\
    \  end\n\n  def parent!(v : Int32, up : Int32) : Int32\n    parent(v, up).not_nil!\n\
    \  end\n\n  def lca(u : Int32, v : Int32) : Int32\n    raise IndexError.new unless\
    \ 0 <= u < size && 0 <= v < size\n    u, v = v, u if @depth[u] > @depth[v]\n \
    \   (0...log2).each do |k|\n      v = @parent[k][v] if (@depth[v] - @depth[u]).bit(k)\
    \ == 1\n    end\n\n    return u if u == v\n\n    (0...log2).reverse_each do |k|\n\
    \      u, v = @parent[k][u], @parent[k][v] if @parent[k][u] != @parent[k][v]\n\
    \    end\n    @parent[0][u]\n  end\n\n  def dist(u : Int32, v : Int32) : Int32\n\
    \    depth(u) + depth(v) - depth(lca(u, v)) * 2\n  end\n\n  def path(start : Int32,\
    \ goal : Int32, &) : Nil\n    lca = lca(start, goal)\n    {start, goal}.each do\
    \ |first|\n      if first != lca\n        yield v = first\n        while (v =\
    \ parent!(v)) != lca\n          yield v\n        end\n      end\n    end\n   \
    \ yield lca\n  end\n\n  def path(start : Int32, goal : Int32) : Array(Int32)\n\
    \    path = [] of Int32\n    path(start, goal) { |v| path << v }\n    path\n \
    \ end\nend\n"
  code: "require \"../graph\"\n\nclass LCA(Edge, Edge2)\n  getter graph : Graph(Edge,\
    \ Edge2)\n  getter depth : Array(Int32)\n  getter log2 : Int32\n\n  private def\
    \ dfs(vertex : Int32, par : Int32, dep : Int32) : Nil\n    @parent[0][vertex]\
    \ = par\n    @depth[vertex] = dep\n    @graph[vertex].each do |edge|\n      dfs(edge.to,\
    \ vertex, dep + 1) if edge.to != par\n    end\n  end\n\n  def initialize(@graph\
    \ : Graph(Edge, Edge2), root : Int32)\n    @log2 = Math.log2(size).to_i.succ\n\
    \    @depth = Array(Int32).new(size, -1)\n    @parent = Array(Array(Int32)).new(log2)\
    \ { Array.new(size, 0) }\n    dfs(root, -1, 0)\n    (0...log2 - 1).each do |k|\n\
    \      (0...size).each do |v|\n        if @parent[k][v] < 0\n          @parent[k\
    \ + 1][v] = -1\n        else\n          @parent[k + 1][v] = @parent[k][@parent[k][v]]\n\
    \        end\n      end\n    end\n  end\n\n  delegate size, to: @graph\n\n  def\
    \ depth(v : Int32) : Int32\n    @depth[v]\n  end\n\n  def parent_p2(v : Int32,\
    \ k : Int32) : Int32?\n    p = @parent[k][v]\n    p >= 0 ? p : nil\n  end\n\n\
    \  def parent_p2!(v : Int32, k : Int32) : Int32\n    parent_p2(v, k).not_nil!\n\
    \  end\n\n  def parent(v : Int32) : Int32?\n    parent_p2(v, 0)\n  end\n\n  def\
    \ parent!(v : Int32) : Int32\n    parent(v).not_nil!\n  end\n\n  def parent(v\
    \ : Int32, up : Int32) : Int32?\n    log2.times do |k|\n      v = @parent[k][v]\
    \ if up.bit(k) == 1\n      return nil if v < 0\n    end\n    v\n  end\n\n  def\
    \ parent!(v : Int32, up : Int32) : Int32\n    parent(v, up).not_nil!\n  end\n\n\
    \  def lca(u : Int32, v : Int32) : Int32\n    raise IndexError.new unless 0 <=\
    \ u < size && 0 <= v < size\n    u, v = v, u if @depth[u] > @depth[v]\n    (0...log2).each\
    \ do |k|\n      v = @parent[k][v] if (@depth[v] - @depth[u]).bit(k) == 1\n   \
    \ end\n\n    return u if u == v\n\n    (0...log2).reverse_each do |k|\n      u,\
    \ v = @parent[k][u], @parent[k][v] if @parent[k][u] != @parent[k][v]\n    end\n\
    \    @parent[0][u]\n  end\n\n  def dist(u : Int32, v : Int32) : Int32\n    depth(u)\
    \ + depth(v) - depth(lca(u, v)) * 2\n  end\n\n  def path(start : Int32, goal :\
    \ Int32, &) : Nil\n    lca = lca(start, goal)\n    {start, goal}.each do |first|\n\
    \      if first != lca\n        yield v = first\n        while (v = parent!(v))\
    \ != lca\n          yield v\n        end\n      end\n    end\n    yield lca\n\
    \  end\n\n  def path(start : Int32, goal : Int32) : Array(Int32)\n    path = []\
    \ of Int32\n    path(start, goal) { |v| path << v }\n    path\n  end\nend\n"
  dependsOn:
  - src/graph.cr
  - src/graph/edge.cr
  isVerificationFile: false
  path: src/graph/lca.cr
  requiredBy: []
  timestamp: '2022-03-25 19:24:34+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/graph/decompose_test.cr
  - test/graph/lca_test.cr
documentation_of: src/graph/lca.cr
layout: document
redirect_from:
- /library/src/graph/lca.cr
- /library/src/graph/lca.cr.html
title: src/graph/lca.cr
---
