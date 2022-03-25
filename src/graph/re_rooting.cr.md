---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: src/graph.cr
    title: src/graph.cr
  - icon: ':question:'
    path: src/graph/edge.cr
    title: src/graph/edge.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/graph/decompose_test.cr
    title: test/graph/decompose_test.cr
  - icon: ':x:'
    path: test/graph/re_rooting_test.cr
    title: test/graph/re_rooting_test.cr
  _isVerificationFailed: true
  _pathExtension: cr
  _verificationStatusIcon: ':question:'
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
    \    false\n  end\n\n  def self.directed?\n    false\n  end\nend\n\n# Example\
    \ of `T`:\n# ```\n# struct DP\n#   getter val : Int64, cnt : Int32\n#\n#   def\
    \ initialize\n#     @val, @cnt = 0i64, 0\n#   end\n#\n#   def initialize(@val,\
    \ @cnt)\n#   end\n#\n#   def +(other : self) : self\n#     DP.new(val + other.val,\
    \ cnt + other.cnt)\n#   end\n#\n#   def add_root(v : Int32) : self\n#     DP.new(val\
    \ + cnt, cnt + 1)\n#   end\n# end\n# ```\nclass ReRooting(T, GraphType)\n  getter\
    \ graph : GraphType\n\n  def initialize(size : Int)\n    initialize(GraphType.new(size))\n\
    \  end\n\n  def initialize(@graph : GraphType)\n    @dp = Array(Array(T)).new\n\
    \    @result = Array(T).new\n  end\n\n  def initialize(size : Int, edges : Enumerable)\n\
    \    initialize(GraphType.new(size, edges))\n  end\n\n  delegate size, to: @graph\n\
    \  delegate :<<, to: @graph\n  delegate add_edges, to: @graph\n\n  private def\
    \ dfs(v : Int32, p : Int32) : T\n    graph[v].each_with_index.select { |(edge,\
    \ i)| edge.to != p }.reduce(T.new) { |acc, (edge, i)|\n      acc + (@dp[v][i]\
    \ = dfs(edge.to, v))\n    }.add_root(v)\n  end\n\n  private def bfs(v : Int32,\
    \ p : Int32, dp_par : T) : Nil\n    graph[v].each_with_index do |edge, i|\n  \
    \    @dp[v][i] = dp_par if edge.to == p\n    end\n\n    n = graph[v].size\n  \
    \  dp_left = Array.new(n + 1, T.new)\n    (0...n).each do |i|\n      dp_left[i\
    \ + 1] = dp_left[i] + @dp[v][i]\n    end\n    dp_right = Array.new(n + 1, T.new)\n\
    \    (0...n).reverse_each do |i|\n      dp_right[i] = dp_right[i + 1] + @dp[v][i]\n\
    \    end\n    @result[v] = dp_left.last.add_root(v)\n\n    graph[v].each_with_index\
    \ do |edge, i|\n      bfs(edge.to, v, (dp_left[i] + dp_right[i + 1]).add_root(v))\
    \ if edge.to != p\n    end\n  end\n\n  def solve : Array(T)\n    @dp = Array.new(size)\
    \ { |i| Array.new(@graph[i].size, T.new) }\n    @result = Array.new(size, T.new)\n\
    \    dfs(0, -1)\n    bfs(0, -1, T.new)\n    @result\n  end\nend\n"
  code: "require \"../graph\"\n\n# Example of `T`:\n# ```\n# struct DP\n#   getter\
    \ val : Int64, cnt : Int32\n#\n#   def initialize\n#     @val, @cnt = 0i64, 0\n\
    #   end\n#\n#   def initialize(@val, @cnt)\n#   end\n#\n#   def +(other : self)\
    \ : self\n#     DP.new(val + other.val, cnt + other.cnt)\n#   end\n#\n#   def\
    \ add_root(v : Int32) : self\n#     DP.new(val + cnt, cnt + 1)\n#   end\n# end\n\
    # ```\nclass ReRooting(T, GraphType)\n  getter graph : GraphType\n\n  def initialize(size\
    \ : Int)\n    initialize(GraphType.new(size))\n  end\n\n  def initialize(@graph\
    \ : GraphType)\n    @dp = Array(Array(T)).new\n    @result = Array(T).new\n  end\n\
    \n  def initialize(size : Int, edges : Enumerable)\n    initialize(GraphType.new(size,\
    \ edges))\n  end\n\n  delegate size, to: @graph\n  delegate :<<, to: @graph\n\
    \  delegate add_edges, to: @graph\n\n  private def dfs(v : Int32, p : Int32) :\
    \ T\n    graph[v].each_with_index.select { |(edge, i)| edge.to != p }.reduce(T.new)\
    \ { |acc, (edge, i)|\n      acc + (@dp[v][i] = dfs(edge.to, v))\n    }.add_root(v)\n\
    \  end\n\n  private def bfs(v : Int32, p : Int32, dp_par : T) : Nil\n    graph[v].each_with_index\
    \ do |edge, i|\n      @dp[v][i] = dp_par if edge.to == p\n    end\n\n    n = graph[v].size\n\
    \    dp_left = Array.new(n + 1, T.new)\n    (0...n).each do |i|\n      dp_left[i\
    \ + 1] = dp_left[i] + @dp[v][i]\n    end\n    dp_right = Array.new(n + 1, T.new)\n\
    \    (0...n).reverse_each do |i|\n      dp_right[i] = dp_right[i + 1] + @dp[v][i]\n\
    \    end\n    @result[v] = dp_left.last.add_root(v)\n\n    graph[v].each_with_index\
    \ do |edge, i|\n      bfs(edge.to, v, (dp_left[i] + dp_right[i + 1]).add_root(v))\
    \ if edge.to != p\n    end\n  end\n\n  def solve : Array(T)\n    @dp = Array.new(size)\
    \ { |i| Array.new(@graph[i].size, T.new) }\n    @result = Array.new(size, T.new)\n\
    \    dfs(0, -1)\n    bfs(0, -1, T.new)\n    @result\n  end\nend\n"
  dependsOn:
  - src/graph.cr
  - src/graph/edge.cr
  isVerificationFile: false
  path: src/graph/re_rooting.cr
  requiredBy: []
  timestamp: '2021-10-16 21:19:52+09:00'
  verificationStatus: LIBRARY_SOME_WA
  verifiedWith:
  - test/graph/re_rooting_test.cr
  - test/graph/decompose_test.cr
documentation_of: src/graph/re_rooting.cr
layout: document
redirect_from:
- /library/src/graph/re_rooting.cr
- /library/src/graph/re_rooting.cr.html
title: src/graph/re_rooting.cr
---
