---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: graph/ReRooting.cr
    title: graph/ReRooting.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://onlinejudge.u-aizu.ac.jp/challenges/sources/VPC/WUPC/3163
  bundledCode: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/challenges/sources/VPC/WUPC/3163\n\
    # require \"../graph/ReRooting\"\n# require \"./graph\"\nstruct Edge(T)\n  include\
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
    \      yield u if u != parent\n    end\n  end\nend\n\nclass ReRooting(T, GraphType)\n\
    \  getter graph : UnweightedGraph\n\n  def initialize(size : Int32)\n    @graph\
    \ = GraphType.new(size)\n    @dp = Array(Array(T)).new\n    @result = Array(T).new\n\
    \  end\n\n  delegate size, to: @graph\n  delegate add_edge, to: @graph\n  delegate\
    \ add_edges, to: @graph\n\n  private def dfs(v : Int32, p : Int32) : T\n    graph[v].each_with_index.select\
    \ { |(u, i)| u != p }.reduce(T.new) { |acc, (u, i)|\n      acc + (@dp[v][i] =\
    \ dfs(u, v))\n    }.add_root(v)\n  end\n\n  private def bfs(v : Int32, p : Int32,\
    \ dp_par : T) : Nil\n    graph[v].each_with_index do |u, i|\n      @dp[v][i] =\
    \ dp_par if u == p\n    end\n\n    n = graph[v].size\n    dp_left = Array.new(n\
    \ + 1, T.new)\n    (0...n).each do |i|\n      dp_left[i + 1] = dp_left[i] + @dp[v][i]\n\
    \    end\n    dp_right = Array.new(n + 1, T.new)\n    (0...n).reverse_each do\
    \ |i|\n      dp_right[i] = dp_right[i + 1] + @dp[v][i]\n    end\n    @result[v]\
    \ = dp_left.last.add_root(v)\n\n    graph[v].each_with_index do |u, i|\n     \
    \ bfs(u, v, (dp_left[i] + dp_right[i + 1]).add_root(v)) if u != p\n    end\n \
    \ end\n\n  def solve : Array(T)\n    @dp = Array.new(size) { |i| Array.new(@graph[i].size,\
    \ T.new) }\n    @result = Array.new(size, T.new)\n    dfs(0, -1)\n    bfs(0, -1,\
    \ T.new)\n    @result\n  end\nend\n\nstruct DP\n  getter sum : Int64\n  getter\
    \ val : Int64\n\n  @@a = [] of Int64\n\n  def DP.a=(a)\n    @@a = a\n  end\n\n\
    \  def initialize\n    @sum, @val = 0i64, 0i64\n  end\n\n  def initialize(@sum,\
    \ @val)\n  end\n\n  def +(other : DP)\n    DP.new(sum + other.sum, val + other.val)\n\
    \  end\n\n  def add_root(v : Int32)\n    DP.new(sum + @@a[v], val + sum)\n  end\n\
    end\n\nn = read_line.to_i\nDP.a = read_line.split.map(&.to_i64)\ndp = ReRooting(DP,\
    \ UnweightedUndirectedGraph).new(n)\n(n - 1).times do\n  a, b = read_line.split.map(&.to_i.pred)\n\
    \  dp.add_edge(a, b)\nend\nputs dp.solve.join('\\n', &.val)\n"
  code: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/challenges/sources/VPC/WUPC/3163\n\
    require \"../graph/ReRooting\"\n\nstruct DP\n  getter sum : Int64\n  getter val\
    \ : Int64\n\n  @@a = [] of Int64\n\n  def DP.a=(a)\n    @@a = a\n  end\n\n  def\
    \ initialize\n    @sum, @val = 0i64, 0i64\n  end\n\n  def initialize(@sum, @val)\n\
    \  end\n\n  def +(other : DP)\n    DP.new(sum + other.sum, val + other.val)\n\
    \  end\n\n  def add_root(v : Int32)\n    DP.new(sum + @@a[v], val + sum)\n  end\n\
    end\n\nn = read_line.to_i\nDP.a = read_line.split.map(&.to_i64)\ndp = ReRooting(DP,\
    \ UnweightedUndirectedGraph).new(n)\n(n - 1).times do\n  a, b = read_line.split.map(&.to_i.pred)\n\
    \  dp.add_edge(a, b)\nend\nputs dp.solve.join('\\n', &.val)\n"
  dependsOn:
  - graph/ReRooting.cr
  isVerificationFile: true
  path: test/ReRooting.test.cr
  requiredBy: []
  timestamp: '2021-05-19 19:30:36+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/ReRooting.test.cr
layout: document
redirect_from:
- /verify/test/ReRooting.test.cr
- /verify/test/ReRooting.test.cr.html
title: test/ReRooting.test.cr
---
