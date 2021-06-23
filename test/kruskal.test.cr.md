---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: graph/kruskal.cr
    title: graph/kruskal.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://onlinejudge.u-aizu.ac.jp/courses/library/5/GRL/all/GRL_2_A
  bundledCode: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/library/5/GRL/all/GRL_2_A\n\
    # require \"../graph/kruskal\"\n# require \"./graph\"\nstruct Edge(T)\n  include\
    \ Comparable(Edge(T))\n\n  property to : Int32\n  property cost : T\n\n  def initialize(@to\
    \ : Int32, @cost : T)\n  end\n\n  def <=>(other : Edge(T))\n    {cost, to} <=>\
    \ {other.cost, other.to}\n  end\n\n  def to_s(io) : Nil\n    io << '(' << to <<\
    \ \", \" << cost << ')'\n  end\n\n  def inspect(io) : Nil\n    io << \"->#{to}(#{cost})\"\
    \n  end\nend\n\nstruct Edge2(T)\n  include Comparable(Edge2(T))\n\n  property\
    \ from : Int32\n  property to : Int32\n  property cost : T\n\n  def initialize(@from\
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
    \      yield u if u != parent\n    end\n  end\nend\n\n# require \"../datastructure/UnionFind\"\
    \nclass UnionFind\n  @d : Array(Int32)\n\n  def initialize(n : Int32)\n    @d\
    \ = Array.new(n, -1)\n  end\n\n  def root(x : Int32)\n    @d[x] < 0 ? x : (@d[x]\
    \ = root(@d[x]))\n  end\n\n  def unite(x : Int32, y : Int32)\n    x = root(x)\n\
    \    y = root(y)\n    return false if x == y\n    x, y = y, x if @d[x] > @d[y]\n\
    \    @d[x] += @d[y]\n    @d[y] = x\n    true\n  end\n\n  def same?(x : Int32,\
    \ y : Int32)\n    root(x) == root(y)\n  end\n\n  def size(x : Int32)\n    -@d[root(x)]\n\
    \  end\n\n  def groups\n    groups = Hash(Int32, Set(Int32)).new { |h, k| h[k]\
    \ = Set(Int32).new }\n    @d.size.times do |i|\n      groups[root(i)] << i\n \
    \   end\n    groups.values.to_set\n  end\nend\n\ndef kruskal(n : Int32, edges\
    \ : Array(Edge2(T))) : T? forall T\n  uf = UnionFind.new(n)\n  result = edges.sort.sum\
    \ do |edge|\n    if uf.unite(edge.from, edge.to)\n      edge.cost\n    else\n\
    \      T.zero\n    end\n  end\n  uf.size(0) == n ? result : nil\nend\n\nn, m =\
    \ read_line.split.map(&.to_i)\nedges = (1..m).map {\n  a, b, c = read_line.split.map(&.to_i)\n\
    \  Edge2.new(a, b, c.to_i64)\n}\nputs kruskal(n, edges)\n"
  code: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/library/5/GRL/all/GRL_2_A\n\
    require \"../graph/kruskal\"\nn, m = read_line.split.map(&.to_i)\nedges = (1..m).map\
    \ {\n  a, b, c = read_line.split.map(&.to_i)\n  Edge2.new(a, b, c.to_i64)\n}\n\
    puts kruskal(n, edges)\n"
  dependsOn:
  - graph/kruskal.cr
  isVerificationFile: true
  path: test/kruskal.test.cr
  requiredBy: []
  timestamp: '2021-05-26 14:02:49+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/kruskal.test.cr
layout: document
redirect_from:
- /verify/test/kruskal.test.cr
- /verify/test/kruskal.test.cr.html
title: test/kruskal.test.cr
---
