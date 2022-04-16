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
    path: test/graph/bipartite_graph_test.cr
    title: test/graph/bipartite_graph_test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "# require \"../graph\"\n# require \"./graph/edge\"\nstruct WeightedEdge(T)\n\
    \  include Comparable(WeightedEdge(T))\n\n  property to : Int32, cost : T\n\n\
    \  def initialize(@to, @cost : T)\n  end\n\n  def <=>(other : WeightedEdge(T))\n\
    \    {cost, to} <=> {other.cost, other.to}\n  end\n\n  def to_s(io) : Nil\n  \
    \  io << '(' << to << \", \" << cost << ')'\n  end\n\n  def inspect(io) : Nil\n\
    \    io << \"->\" << to << '(' << cost << ')'\n  end\nend\n\nstruct WeightedEdge2(T)\n\
    \  include Comparable(WeightedEdge2(T))\n\n  property from : Int32, to : Int32,\
    \ cost : T\n\n  def initialize(@from, @to, @cost : T)\n  end\n\n  def initialize(@from,\
    \ edge : WeightedEdge(T))\n    @to, @cost = edge.to, edge.cost\n  end\n\n  def\
    \ <=>(other : WeightedEdge2(T))\n    {cost, from, to} <=> {other.cost, other.from,\
    \ other.to}\n  end\n\n  def reverse : self\n    WeightedEdge2(T).new(to, from,\
    \ cost)\n  end\n\n  def sort : self\n    WeightedEdge2(T).new(*{to, from}.minmax,\
    \ cost)\n  end\n\n  def to_s(io) : Nil\n    io << '(' << from << \", \" << to\
    \ << \", \" << cost << ')'\n  end\n\n  def inspect(io) : Nil\n    io << from <<\
    \ \"->\" << to << '(' << cost << ')'\n  end\nend\n\nstruct UnweightedEdge\n  property\
    \ to : Int32\n\n  def initialize(@to)\n  end\n\n  def initialize(@to, cost)\n\
    \  end\n\n  def cost : Int32\n    1\n  end\n\n  def to_s(io) : Nil\n    io <<\
    \ to\n  end\n\n  def inspect(io) : Nil\n    io << \"->\" << to\n  end\nend\n\n\
    struct UnweightedEdge2\n  property from : Int32, to : Int32\n\n  def initialize(@from,\
    \ @to)\n  end\n\n  def initialize(@from, @to, cost)\n  end\n\n  def initialize(@from,\
    \ edge : UnweightedEdge)\n    @to = edge.to\n  end\n\n  def cost : Int32\n   \
    \ 1\n  end\n\n  def reverse : self\n    UnweightedEdge2.new(to, from)\n  end\n\
    \n  def sort : self\n    UnweightedEdge2.new(*{to, from}.minmax)\n  end\n\n  def\
    \ to_s(io) : Nil\n    io << '(' << from << \", \" << to << ')'\n  end\n\n  def\
    \ inspect(io) : Nil\n    io << from << \"->\" << to\n  end\nend\n\nmodule Graph(Edge,\
    \ Edge2)\n  include Enumerable(Edge2)\n\n  getter graph : Array(Array(Edge))\n\
    \n  def initialize(size : Int)\n    @graph = Array(Array(Edge)).new(size) { []\
    \ of Edge }\n  end\n\n  def initialize(size : Int, edges : Enumerable)\n    initialize(size)\n\
    \    add_edges(edges)\n  end\n\n  # Add *edge*.\n  abstract def <<(edge : Edge2)\n\
    \n  # :ditto:\n  def <<(edge : Tuple) : self\n    self << Edge2.new(*edge)\n \
    \ end\n\n  def add_edges(edges : Enumerable) : self\n    edges.each { |edge| self\
    \ << edge }\n    self\n  end\n\n  delegate size, :[], to: @graph\n\n  # Yields\
    \ each edge of the graph, ans returns `nil`.\n  def each(&) : Nil\n    (0...size).each\
    \ do |v|\n      graph[v].each do |edge|\n        yield Edge2.new(v, edge)\n  \
    \    end\n    end\n  end\n\n  def each_child(vertex : Int, parent, &block) : Nil\n\
    \    graph[vertex].each do |edge|\n      yield edge if edge.to != parent\n   \
    \ end\n  end\n\n  def each_child(vertex : Int, parent)\n    graph[vertex].each.reject(&.to.==\
    \ parent)\n  end\n\n  def reverse : self\n    if self.class.directed?\n      each_with_object(self.class.new(size))\
    \ do |edge, reversed|\n        reversed << edge.reverse\n      end\n    else\n\
    \      dup\n    end\n  end\n\n  def to_undirected : self\n    if self.class.directed?\n\
    \      each_with_object(self.class.new(size)) do |edge, graph|\n        graph\
    \ << edge << edge.reverse\n      end\n    else\n      dup\n    end\n  end\n\n\
    \  def to_s(io : IO) : Nil\n    io << '['\n    join(\", \", io) do |edge, io|\n\
    \      edge.inspect io\n    end\n    io << ']'\n  end\n\n  def inspect(io : IO)\
    \ : Nil\n    io << \"[\\n\"\n    graph.each do |edges|\n      io << \"  \" <<\
    \ edges << \",\\n\"\n    end\n    io << ']'\n  end\nend\n\nclass DiGraph(T)\n\
    \  include Graph(WeightedEdge(T), WeightedEdge2(T))\n\n  def self.weighted?\n\
    \    true\n  end\n\n  def self.directed?\n    true\n  end\n\n  def initialize(size\
    \ : Int)\n    super\n  end\n\n  def initialize(size : Int, edges : Enumerable(WeightedEdge2(T)))\n\
    \    super\n  end\n\n  def initialize(size : Int, edges : Enumerable({Int32, Int32,\
    \ T}))\n    super\n  end\n\n  def <<(edge : WeightedEdge2(T)) : self\n    raise\
    \ IndexError.new unless 0 <= edge.from < size && 0 <= edge.to < size\n    @graph[edge.from]\
    \ << WeightedEdge.new(edge.to, edge.cost)\n    self\n  end\nend\n\nclass UnGraph(T)\n\
    \  include Graph(WeightedEdge(T), WeightedEdge2(T))\n\n  def self.weighted?\n\
    \    true\n  end\n\n  def self.directed?\n    false\n  end\n\n  def initialize(size\
    \ : Int)\n    super\n  end\n\n  def initialize(size : Int, edges : Enumerable(WeightedEdge2(T)))\n\
    \    super\n  end\n\n  def initialize(size : Int, edges : Enumerable({Int32, Int32,\
    \ T}))\n    super\n  end\n\n  def <<(edge : WeightedEdge2(T)) : self\n    raise\
    \ IndexError.new unless 0 <= edge.from < size && 0 <= edge.to < size\n    @graph[edge.from]\
    \ << WeightedEdge.new(edge.to, edge.cost)\n    @graph[edge.to] << WeightedEdge.new(edge.from,\
    \ edge.cost)\n    self\n  end\nend\n\nclass UnweightedDiGraph\n  include Graph(UnweightedEdge,\
    \ UnweightedEdge2)\n\n  def self.weighted?\n    false\n  end\n\n  def self.directed?\n\
    \    true\n  end\n\n  def initialize(size : Int)\n    super\n  end\n\n  def initialize(size\
    \ : Int, edges : Enumerable)\n    super\n  end\n\n  def <<(edge : UnweightedEdge2)\
    \ : self\n    raise IndexError.new unless 0 <= edge.from < size && 0 <= edge.to\
    \ < size\n    @graph[edge.from] << UnweightedEdge.new(edge.to)\n    self\n  end\n\
    end\n\nclass UnweightedUnGraph\n  include Graph(UnweightedEdge, UnweightedEdge2)\n\
    \n  def self.weighted?\n    false\n  end\n\n  def self.directed?\n    false\n\
    \  end\n\n  def initialize(size : Int)\n    super\n  end\n\n  def initialize(size\
    \ : Int, edges : Enumerable)\n    super\n  end\n\n  def <<(edge : UnweightedEdge2)\
    \ : self\n    raise IndexError.new unless 0 <= edge.from < size && 0 <= edge.to\
    \ < size\n    @graph[edge.from] << UnweightedEdge.new(edge.to)\n    @graph[edge.to]\
    \ << UnweightedEdge.new(edge.from)\n    self\n  end\nend\n\nmodule Graph(Edge,\
    \ Edge2)\n  # Returns table of color if the graph is bipartite graph, otherwise\
    \ returns `nil`\n  def bipartite_graph : Array(Bool)?\n    color = Array(Bool?).new(size,\
    \ nil)\n    queue = Deque.new (0...size).to_a\n    while v = queue.shift?\n  \
    \    c1 = color[v]\n      c1 = color[v] = true if c1.nil?\n      graph[v].each\
    \ do |edge|\n        if (c2 = color[edge.to]).nil?\n          color[edge.to] =\
    \ !c1\n          queue.unshift edge.to\n        else\n          return nil if\
    \ c1 == c2\n        end\n      end\n    end\n    color.map(&.not_nil!)\n  end\n\
    end\n"
  code: "require \"../graph\"\n\nmodule Graph(Edge, Edge2)\n  # Returns table of color\
    \ if the graph is bipartite graph, otherwise returns `nil`\n  def bipartite_graph\
    \ : Array(Bool)?\n    color = Array(Bool?).new(size, nil)\n    queue = Deque.new\
    \ (0...size).to_a\n    while v = queue.shift?\n      c1 = color[v]\n      c1 =\
    \ color[v] = true if c1.nil?\n      graph[v].each do |edge|\n        if (c2 =\
    \ color[edge.to]).nil?\n          color[edge.to] = !c1\n          queue.unshift\
    \ edge.to\n        else\n          return nil if c1 == c2\n        end\n     \
    \ end\n    end\n    color.map(&.not_nil!)\n  end\nend\n"
  dependsOn:
  - src/graph.cr
  - src/graph/edge.cr
  isVerificationFile: false
  path: src/graph/bipartite_graph.cr
  requiredBy: []
  timestamp: '2022-04-16 16:23:13+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/graph/bipartite_graph_test.cr
documentation_of: src/graph/bipartite_graph.cr
layout: document
redirect_from:
- /library/src/graph/bipartite_graph.cr
- /library/src/graph/bipartite_graph.cr.html
title: src/graph/bipartite_graph.cr
---
