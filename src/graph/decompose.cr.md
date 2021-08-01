---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/datastructure/union_find.cr
    title: src/datastructure/union_find.cr
  - icon: ':warning:'
    path: src/graph.cr
    title: src/graph.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/graph/decompose.test.cr
    title: test/graph/decompose.test.cr
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
    \n  def initialize(@to)\n  end\n\n  def cost\n    1\n  end\n\n  def to_s(io) :\
    \ Nil\n    io << to\n  end\n\n  def inspect(io) : Nil\n    io << \"->\" << to\n\
    \  end\nend\n\nstruct UnweightedEdge2\n  property from : Int32, to : Int32\n\n\
    \  def initialize(@from, @to)\n  end\n\n  def initialize(@from, edge : UnweightedEdge)\n\
    \    @to = edge.to\n  end\n\n  def cost\n    1\n  end\n\n  def reverse\n    UnweightedEdge2.new(to,\
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
    \    false\n  end\n\n  def self.directed?\n    false\n  end\nend\n\n# require\
    \ \"../datastructure/union_find\"\nclass UnionFind\n  @d : Array(Int32)\n\n  def\
    \ initialize(n : Int)\n    @d = Array.new(n, -1)\n  end\n\n  def initialize(n\
    \ : Int, edges : Enumerable({Int32, Int32}))\n    initialize(n)\n    edges.each\
    \ { |u, v| unite(u, v) }\n  end\n\n  def root(x : Int)\n    @d[x] < 0 ? x : (@d[x]\
    \ = root(@d[x]))\n  end\n\n  def unite(x : Int, y : Int)\n    x = root(x)\n  \
    \  y = root(y)\n    return false if x == y\n    x, y = y, x if @d[x] > @d[y]\n\
    \    @d[x] += @d[y]\n    @d[y] = x\n    true\n  end\n\n  def same?(x : Int, y\
    \ : Int)\n    root(x) == root(y)\n  end\n\n  def size(x : Int)\n    -@d[root(x)]\n\
    \  end\n\n  def groups\n    groups = Hash(Int32, Set(Int32)).new { |h, k| h[k]\
    \ = Set(Int32).new }\n    @d.size.times do |i|\n      groups[root(i)] << i\n \
    \   end\n    groups.values.to_set\n  end\nend\n\nmodule Graph(Edge, Edge2)\n \
    \ # Decomposes the graph into each conected components.\n  def decompose : {Array(self),\
    \ Array({Int32, Int32})}\n    uf = UnionFind.new(size)\n    each do |edge|\n \
    \     uf.unite(edge.from, edge.to)\n    end\n    groups = uf.groups.to_a\n   \
    \ index = Array.new(size, {-1, -1})\n    groups.each_with_index do |group, i|\n\
    \      group.each_with_index do |v, j|\n        index[v] = {i, j}\n      end\n\
    \    end\n\n    graphs = Array.new(groups.size) { |i| self.class.new(groups[i].size)\
    \ }\n    if self.class.directed?\n      each do |edge|\n        i1, j1 = index[edge.from]\n\
    \        _, j2 = index[edge.to]\n        graphs[i1] << {j1, j2}\n      end\n \
    \   else\n      edge_set = Set(Edge2).new\n      each do |edge|\n        if edge_set.add?(edge.sort)\n\
    \          i1, j1 = index[edge.from]\n          _, j2 = index[edge.to]\n     \
    \     graphs[i1] << {j1, j2}\n        end\n      end\n    end\n    {graphs, index}\n\
    \  end\nend\n"
  code: "require \"../graph\"\nrequire \"../datastructure/union_find\"\n\nmodule Graph(Edge,\
    \ Edge2)\n  # Decomposes the graph into each conected components.\n  def decompose\
    \ : {Array(self), Array({Int32, Int32})}\n    uf = UnionFind.new(size)\n    each\
    \ do |edge|\n      uf.unite(edge.from, edge.to)\n    end\n    groups = uf.groups.to_a\n\
    \    index = Array.new(size, {-1, -1})\n    groups.each_with_index do |group,\
    \ i|\n      group.each_with_index do |v, j|\n        index[v] = {i, j}\n     \
    \ end\n    end\n\n    graphs = Array.new(groups.size) { |i| self.class.new(groups[i].size)\
    \ }\n    if self.class.directed?\n      each do |edge|\n        i1, j1 = index[edge.from]\n\
    \        _, j2 = index[edge.to]\n        graphs[i1] << {j1, j2}\n      end\n \
    \   else\n      edge_set = Set(Edge2).new\n      each do |edge|\n        if edge_set.add?(edge.sort)\n\
    \          i1, j1 = index[edge.from]\n          _, j2 = index[edge.to]\n     \
    \     graphs[i1] << {j1, j2}\n        end\n      end\n    end\n    {graphs, index}\n\
    \  end\nend\n"
  dependsOn:
  - src/graph.cr
  - src/datastructure/union_find.cr
  isVerificationFile: false
  path: src/graph/decompose.cr
  requiredBy: []
  timestamp: '2021-07-23 17:17:24+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/graph/decompose.test.cr
documentation_of: src/graph/decompose.cr
layout: document
redirect_from:
- /library/src/graph/decompose.cr
- /library/src/graph/decompose.cr.html
title: src/graph/decompose.cr
---