---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/graph/bipartite_matching.cr
    title: src/graph/bipartite_matching.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/bipartitematching
  bundledCode: "# verification-helper: PROBLEM https://judge.yosupo.jp/problem/bipartitematching\n\
    # require \"../../src/graph/bipartite_matching\"\n# require \"../graph\"\n# require\
    \ \"./graph/edge\"\nstruct WeightedEdge(T)\n  include Comparable(WeightedEdge(T))\n\
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
    \    false\n  end\n\n  def self.directed?\n    false\n  end\nend\n\nclass BipartiteMatching\n\
    \  include Enumerable(UnweightedEdge2)\n  include Iterable(UnweightedEdge2)\n\n\
    \  getter left : Int32, right : Int32\n  getter graph : Array(Array(Int32))\n\n\
    \  def initialize(@left, @right)\n    raise ArgumentError.new unless left >= 0\
    \ && right >= 0\n    @graph = Array.new(left) { [] of Int32 }\n    @left_match\
    \ = Array(Int32?).new(left, nil)\n    @right_match = Array(Int32?).new(right,\
    \ nil)\n    @used = Array(Bool).new(left, false)\n  end\n\n  def initialize(left,\
    \ right, edges : Enumerable)\n    initialize(left, right)\n    edges.each { |edge|\
    \ self << edge }\n  end\n\n  def <<(edge : UnweightedEdge2) : self\n    raise\
    \ IndexError.new unless 0 <= edge.from < left && 0 <= edge.to < right\n    @graph[edge.from]\
    \ << edge.to\n    self\n  end\n\n  def <<(edge : Tuple) : self\n    self << UnweightedEdge2.new(*edge)\n\
    \  end\n\n  def add_edges(edges : Enumerable) : self\n    edges.each { |edge|\
    \ self << edge }\n    self\n  end\n\n  private def dfs(v : Int32) : Bool\n   \
    \ return false if @used[v]\n    @used[v] = true\n    graph[v].each do |edge|\n\
    \      if @right_match[edge].nil? || dfs(@right_match[edge].not_nil!)\n      \
    \  @left_match[v], @right_match[edge] = edge, v\n        return true\n      end\n\
    \    end\n    false\n  end\n\n  def solve : Int32\n    while (0...left).reduce(false)\
    \ { |update, i|\n            update | (@left_match[i].nil? && dfs(i))\n      \
    \    }\n      @used.fill(false)\n    end\n    left - @left_match.count(&.nil?)\n\
    \  end\n\n  def each(&block) : Nil\n    (0...left).each do |i|\n      if l = @left_match[i]\n\
    \        yield UnweightedEdge2.new(i, l)\n      end\n    end\n  end\n\n  def each\n\
    \    (0...left).each.select { |i| @left_match[i] }.map { |i|\n      UnweightedEdge2.new\
    \ i, @left_match[i].not_nil!\n    }\n  end\nend\n\nl, r, m = read_line.split.map(&.to_i)\n\
    graph = BipartiteMatching.new(l, r)\nm.times do\n  a, b = read_line.split.map(&.to_i)\n\
    \  graph << {a, b}\nend\nputs graph.solve\nraise \"\" unless graph.to_a == graph.each.to_a\n\
    graph.each do |edge|\n  puts \"#{edge.from} #{edge.to}\"\nend\n"
  code: "# verification-helper: PROBLEM https://judge.yosupo.jp/problem/bipartitematching\n\
    require \"../../src/graph/bipartite_matching\"\nl, r, m = read_line.split.map(&.to_i)\n\
    graph = BipartiteMatching.new(l, r)\nm.times do\n  a, b = read_line.split.map(&.to_i)\n\
    \  graph << {a, b}\nend\nputs graph.solve\nraise \"\" unless graph.to_a == graph.each.to_a\n\
    graph.each do |edge|\n  puts \"#{edge.from} #{edge.to}\"\nend\n"
  dependsOn:
  - src/graph/bipartite_matching.cr
  isVerificationFile: true
  path: test/graph/bipartite_matching_edges.test.cr
  requiredBy: []
  timestamp: '2021-07-18 13:52:56+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/graph/bipartite_matching_edges.test.cr
layout: document
redirect_from:
- /verify/test/graph/bipartite_matching_edges.test.cr
- /verify/test/graph/bipartite_matching_edges.test.cr.html
title: test/graph/bipartite_matching_edges.test.cr
---
