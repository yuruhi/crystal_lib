---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/graph.cr
    title: src/graph.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/degree.cr
    title: src/graph/degree.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':x:'
    path: test/graph/namori_decompose_test.cr
    title: test/graph/namori_decompose_test.cr
  _isVerificationFailed: true
  _pathExtension: cr
  _verificationStatusIcon: ':x:'
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
    \    false\n  end\n\n  def self.directed?\n    false\n  end\nend\n\n# require\
    \ \"./degree\"\n# require \"../graph\"\n\nmodule Graph(Edge, Edge2)\n  # Returns\
    \ table of indegree.\n  def indegree : Array(Int32)\n    each_with_object(Array.new(size,\
    \ 0)) do |edge, cnt|\n      cnt[edge.to] += 1\n    end\n  end\n\n  # Returns table\
    \ of outdegree.\n  def outdegree : Array(Int32)\n    each_with_object(Array.new(size,\
    \ 0)) do |edge, cnt|\n      cnt[edge.from] += 1\n    end\n  end\nend\n\nmodule\
    \ Graph(Edge, Edge2)\n  # Returns forest and cycle of the undirected graph with\
    \ equal number of vertices and edges.\n  def namori_decompose : {self, Array(Int32)}\n\
    \    raise ArgumentError.new if self.class.directed?\n    raise ArgumentError.new\
    \ unless size == graph.sum(&.size) // 2\n\n    deg = Array.new(size) { |i| self[i].size\
    \ }\n\n    que = Deque(Int32).new\n    flag = Array.new(size, false)\n    (0...size).each\
    \ do |i|\n      if deg[i] == 1\n        que << i\n        flag[i] = true\n   \
    \   end\n    end\n\n    forest = self.class.new(size)\n    while v = que.shift?\n\
    \      self[v].each do |edge|\n        next if flag[edge.to]\n        deg[edge.to]\
    \ -= 1\n        forest << Edge2.new(v, edge)\n        if deg[edge.to] == 1\n \
    \         que << edge.to\n          flag[edge.to] = true\n        end\n      end\n\
    \    end\n\n    cycle = [] of Int32\n    (0...size).each do |i|\n      que <<\
    \ i unless flag[i]\n      while v = que.pop?\n        next if flag[v]\n      \
    \  cycle << v\n        flag[v] = true\n        self[v].each do |edge|\n      \
    \    que << edge.to unless flag[edge.to]\n        end\n      end\n    end\n  \
    \  {forest, cycle}\n  end\nend\n"
  code: "require \"../graph\"\nrequire \"./degree\"\n\nmodule Graph(Edge, Edge2)\n\
    \  # Returns forest and cycle of the undirected graph with equal number of vertices\
    \ and edges.\n  def namori_decompose : {self, Array(Int32)}\n    raise ArgumentError.new\
    \ if self.class.directed?\n    raise ArgumentError.new unless size == graph.sum(&.size)\
    \ // 2\n\n    deg = Array.new(size) { |i| self[i].size }\n\n    que = Deque(Int32).new\n\
    \    flag = Array.new(size, false)\n    (0...size).each do |i|\n      if deg[i]\
    \ == 1\n        que << i\n        flag[i] = true\n      end\n    end\n\n    forest\
    \ = self.class.new(size)\n    while v = que.shift?\n      self[v].each do |edge|\n\
    \        next if flag[edge.to]\n        deg[edge.to] -= 1\n        forest << Edge2.new(v,\
    \ edge)\n        if deg[edge.to] == 1\n          que << edge.to\n          flag[edge.to]\
    \ = true\n        end\n      end\n    end\n\n    cycle = [] of Int32\n    (0...size).each\
    \ do |i|\n      que << i unless flag[i]\n      while v = que.pop?\n        next\
    \ if flag[v]\n        cycle << v\n        flag[v] = true\n        self[v].each\
    \ do |edge|\n          que << edge.to unless flag[edge.to]\n        end\n    \
    \  end\n    end\n    {forest, cycle}\n  end\nend\n"
  dependsOn:
  - src/graph.cr
  - src/graph/degree.cr
  isVerificationFile: false
  path: src/graph/namori_decompose.cr
  requiredBy: []
  timestamp: '2021-08-07 13:23:14+09:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - test/graph/namori_decompose_test.cr
documentation_of: src/graph/namori_decompose.cr
layout: document
redirect_from:
- /library/src/graph/namori_decompose.cr
- /library/src/graph/namori_decompose.cr.html
title: src/graph/namori_decompose.cr
---