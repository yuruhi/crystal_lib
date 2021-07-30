---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/datastructure/union_find.cr
    title: src/datastructure/union_find.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/compress.cr
    title: src/graph/compress.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/degree.cr
    title: src/graph/degree.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://yukicoder.me/problems/no/1605
  bundledCode: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/1605\n\
    # require \"../../src/graph/compress\"\n# require \"../graph\"\n# require \"./graph/edge\"\
    \nstruct WeightedEdge(T)\n  include Comparable(WeightedEdge(T))\n\n  property\
    \ to : Int32, cost : T\n\n  def initialize(@to, @cost : T)\n  end\n\n  def <=>(other\
    \ : WeightedEdge(T))\n    {cost, to} <=> {other.cost, other.to}\n  end\n\n  def\
    \ to_s(io) : Nil\n    io << '(' << to << \", \" << cost << ')'\n  end\n\n  def\
    \ inspect(io) : Nil\n    io << \"->#{to}(#{cost})\"\n  end\nend\n\nstruct WeightedEdge2(T)\n\
    \  include Comparable(WeightedEdge2(T))\n\n  property from : Int32, to : Int32,\
    \ cost : T\n\n  def initialize(@from, @to, @cost : T)\n  end\n\n  def initialize(@from,\
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
    \    false\n  end\n\n  def self.directed?\n    false\n  end\nend\n\nmodule Graph(Edge,\
    \ Edge2)\n  # Returns the graph that deleted isolated vertices.\n  def compress\
    \ : self\n    values = [] of Int32\n    each { |edge| values << edge.from << edge.to\
    \ }\n    values.uniq!.sort!\n\n    each_with_object(self.class.new(values.size))\
    \ do |edge, compressed|\n      edge.from = values.bsearch_index { |x| edge.from\
    \ <= x }.not_nil!\n      edge.to = values.bsearch_index { |x| edge.to <= x }.not_nil!\n\
    \      compressed << edge\n    end\n  end\nend\n\n# require \"../../src/graph/degree\"\
    \n# require \"../graph\"\n\nmodule Graph(Edge, Edge2)\n  # Returns table of indegree.\n\
    \  def indegree : Array(Int32)\n    each_with_object(Array.new(size, 0)) do |edge,\
    \ cnt|\n      cnt[edge.to] += 1\n    end\n  end\n\n  # Returns table of outdegree.\n\
    \  def outdegree : Array(Int32)\n    each_with_object(Array.new(size, 0)) do |edge,\
    \ cnt|\n      cnt[edge.from] += 1\n    end\n  end\nend\n\n# require \"../../src/datastructure/union_find\"\
    \nclass UnionFind\n  @d : Array(Int32)\n\n  def initialize(n : Int)\n    @d =\
    \ Array.new(n, -1)\n  end\n\n  def initialize(n : Int, edges : Enumerable({Int32,\
    \ Int32}))\n    initialize(n)\n    edges.each { |u, v| unite(u, v) }\n  end\n\n\
    \  def root(x : Int)\n    @d[x] < 0 ? x : (@d[x] = root(@d[x]))\n  end\n\n  def\
    \ unite(x : Int, y : Int)\n    x = root(x)\n    y = root(y)\n    return false\
    \ if x == y\n    x, y = y, x if @d[x] > @d[y]\n    @d[x] += @d[y]\n    @d[y] =\
    \ x\n    true\n  end\n\n  def same?(x : Int, y : Int)\n    root(x) == root(y)\n\
    \  end\n\n  def size(x : Int)\n    -@d[root(x)]\n  end\n\n  def groups\n    groups\
    \ = Hash(Int32, Set(Int32)).new { |h, k| h[k] = Set(Int32).new }\n    @d.size.times\
    \ do |i|\n      groups[root(i)] << i\n    end\n    groups.values.to_set\n  end\n\
    end\n\nn = read_line.to_i\nedges = Array.new(n) { u, v = read_line.split.map(&.to_i);\
    \ UnweightedEdge2.new(u, v) }\ngraph = UnweightedDirectedGraph.new(2*10**5 + 1,\
    \ edges).compress\nm = graph.size\nuf = UnionFind.new(m)\ngraph.each { |e| uf.unite(e.from,\
    \ e.to) }\n\nif uf.size(0) != m\n  puts 0\nelse\n  degree = graph.indegree.zip(graph.outdegree).map\
    \ { |x, y| x - y }\n  if degree.all?(0)\n    puts m\n  elsif degree.tally == {-1\
    \ => 1, 1 => 1, 0 => m - 2}\n    puts 1\n  else\n    puts 0\n  end\nend\n"
  code: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/1605\nrequire\
    \ \"../../src/graph/compress\"\nrequire \"../../src/graph/degree\"\nrequire \"\
    ../../src/datastructure/union_find\"\nn = read_line.to_i\nedges = Array.new(n)\
    \ { u, v = read_line.split.map(&.to_i); UnweightedEdge2.new(u, v) }\ngraph = UnweightedDirectedGraph.new(2*10**5\
    \ + 1, edges).compress\nm = graph.size\nuf = UnionFind.new(m)\ngraph.each { |e|\
    \ uf.unite(e.from, e.to) }\n\nif uf.size(0) != m\n  puts 0\nelse\n  degree = graph.indegree.zip(graph.outdegree).map\
    \ { |x, y| x - y }\n  if degree.all?(0)\n    puts m\n  elsif degree.tally == {-1\
    \ => 1, 1 => 1, 0 => m - 2}\n    puts 1\n  else\n    puts 0\n  end\nend\n"
  dependsOn:
  - src/graph/compress.cr
  - src/graph/degree.cr
  - src/datastructure/union_find.cr
  isVerificationFile: true
  path: test/graph/compress_degree.test.cr
  requiredBy: []
  timestamp: '2021-07-23 17:17:24+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/graph/compress_degree.test.cr
layout: document
redirect_from:
- /verify/test/graph/compress_degree.test.cr
- /verify/test/graph/compress_degree.test.cr.html
title: test/graph/compress_degree.test.cr
---
