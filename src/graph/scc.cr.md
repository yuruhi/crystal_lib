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
    path: test/graph/scc_test.cr
    title: test/graph/scc_test.cr
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
    \    false\n  end\n\n  def self.directed?\n    false\n  end\nend\n\nclass SCC(Edge,\
    \ Edge2)\n  private def dfs(v : Int32) : Nil\n    @visited[v] = true\n    @graph[v].each\
    \ do |edge|\n      dfs(edge.to) if !@visited[edge.to]\n    end\n    @topological_order\
    \ << v\n  end\n\n  private def dfs_reverse(v : Int32) : Nil\n    @visited[v] =\
    \ true\n    @ids[v] = @now_id\n    @rgraph[v].each do |edge|\n      dfs_reverse(edge.to)\
    \ if !@visited[edge.to]\n    end\n  end\n\n  getter graph\n  @rgraph : Graph(Edge,\
    \ Edge2)\n\n  delegate size, to: @graph\n\n  def initialize(@graph : Graph(Edge,\
    \ Edge2))\n    @rgraph = @graph.reverse\n    @topological_order = [] of Int32\n\
    \    @visited = Array(Bool).new(size, false)\n    @ids = Array(Int32).new(size,\
    \ -1)\n    @now_id = 0\n\n    size.times do |v|\n      dfs(v) if !@visited[v]\n\
    \    end\n    @visited.fill(false)\n    @topological_order.reverse_each do |v|\n\
    \      if !@visited[v]\n        dfs_reverse(v)\n        @now_id += 1\n      end\n\
    \    end\n  end\n\n  def count_scc : Int32\n    @now_id\n  end\n\n  def groups\
    \ : Array(Set(Int32))\n    groups = Array.new(count_scc) { Set(Int32).new }\n\
    \    size.times do |i|\n      groups[@ids[i]] << i\n    end\n    groups\n  end\n\
    \n  def dag : UnweightedDirectedGraph\n    edges = Set({Int32, Int32}).new\n \
    \   @graph.each do |edge|\n      from, to = @ids[edge.from], @ids[edge.to]\n \
    \     edges << {from, to} if from != to\n    end\n    UnweightedDirectedGraph.new\
    \ count_scc, edges\n  end\n\n  def scc : {Int32, Array(Set(Int32)), UnweightedDirectedGraph}\n\
    \    {count_scc, groups, dag}\n  end\nend\n"
  code: "require \"../graph\"\n\nclass SCC(Edge, Edge2)\n  private def dfs(v : Int32)\
    \ : Nil\n    @visited[v] = true\n    @graph[v].each do |edge|\n      dfs(edge.to)\
    \ if !@visited[edge.to]\n    end\n    @topological_order << v\n  end\n\n  private\
    \ def dfs_reverse(v : Int32) : Nil\n    @visited[v] = true\n    @ids[v] = @now_id\n\
    \    @rgraph[v].each do |edge|\n      dfs_reverse(edge.to) if !@visited[edge.to]\n\
    \    end\n  end\n\n  getter graph\n  @rgraph : Graph(Edge, Edge2)\n\n  delegate\
    \ size, to: @graph\n\n  def initialize(@graph : Graph(Edge, Edge2))\n    @rgraph\
    \ = @graph.reverse\n    @topological_order = [] of Int32\n    @visited = Array(Bool).new(size,\
    \ false)\n    @ids = Array(Int32).new(size, -1)\n    @now_id = 0\n\n    size.times\
    \ do |v|\n      dfs(v) if !@visited[v]\n    end\n    @visited.fill(false)\n  \
    \  @topological_order.reverse_each do |v|\n      if !@visited[v]\n        dfs_reverse(v)\n\
    \        @now_id += 1\n      end\n    end\n  end\n\n  def count_scc : Int32\n\
    \    @now_id\n  end\n\n  def groups : Array(Set(Int32))\n    groups = Array.new(count_scc)\
    \ { Set(Int32).new }\n    size.times do |i|\n      groups[@ids[i]] << i\n    end\n\
    \    groups\n  end\n\n  def dag : UnweightedDirectedGraph\n    edges = Set({Int32,\
    \ Int32}).new\n    @graph.each do |edge|\n      from, to = @ids[edge.from], @ids[edge.to]\n\
    \      edges << {from, to} if from != to\n    end\n    UnweightedDirectedGraph.new\
    \ count_scc, edges\n  end\n\n  def scc : {Int32, Array(Set(Int32)), UnweightedDirectedGraph}\n\
    \    {count_scc, groups, dag}\n  end\nend\n"
  dependsOn:
  - src/graph.cr
  - src/graph/edge.cr
  isVerificationFile: false
  path: src/graph/scc.cr
  requiredBy: []
  timestamp: '2022-03-27 15:35:11+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/graph/scc_test.cr
documentation_of: src/graph/scc.cr
layout: document
redirect_from:
- /library/src/graph/scc.cr
- /library/src/graph/scc.cr.html
title: src/graph/scc.cr
---
