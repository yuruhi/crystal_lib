---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: graph/BipartiteMatching.cr
    title: graph/BipartiteMatching.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://yukicoder.me/problems/no/1479
  bundledCode: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/1479\n\
    # require \"../graph/BipartiteMatching\"\n# require \"./graph\"\nstruct Edge(T)\n\
    \  include Comparable(Edge(T))\n\n  property to : Int32\n  property cost : T\n\
    \n  def initialize(@to : Int32, @cost : T)\n  end\n\n  def <=>(other : Edge(T))\n\
    \    {cost, to} <=> {other.cost, other.to}\n  end\n\n  def to_s(io) : Nil\n  \
    \  io << '(' << to << \", \" << cost << ')'\n  end\n\n  def inspect(io) : Nil\n\
    \    io << \"->#{to}(#{cost})\"\n  end\nend\n\nstruct Edge2(T)\n  include Comparable(Edge2(T))\n\
    \n  property from : Int32\n  property to : Int32\n  property cost : T\n\n  def\
    \ initialize(@from : Int32, @to : Int32, @cost : T)\n  end\n\n  def <=>(other\
    \ : Edge2(T))\n    {cost, from, to} <=> {other.cost, other.from, other.to}\n \
    \ end\n\n  def reverse\n    Edge2(T).new(to, from, cost)\n  end\n\n  def to_s(io)\
    \ : Nil\n    io << '(' << from << \", \" << to << \", \" << cost << ')'\n  end\n\
    \n  def inspect(io) : Nil\n    io << \"#{from}->#{to}(#{cost})\"\n  end\nend\n\
    \nstruct UnweightedEdge2\n  property from : Int32\n  property to : Int32\n\n \
    \ def initialize(@from, @to)\n  end\n\n  def reverse\n    UnweightedEdge2.new(to,\
    \ from)\n  end\n\n  def to_s(io) : Nil\n    io << '(' << from << \", \" << to\
    \ << ')'\n  end\n\n  def inspect(io) : Nil\n    io << \"#{from}->#{to}\"\n  end\n\
    end\n\nabstract class Graph(T)\n  getter graph : Array(Array(Edge(T)))\n\n  def\
    \ initialize(size : Int)\n    raise ArgumentError.new(\"Negative graph size: #{size}\"\
    ) unless size >= 0\n    @graph = Array.new(size) { Array(Edge(T)).new }\n  end\n\
    \n  def add_edge(i : Int32, j : Int32, cost : T)\n    add_edge(Edge2.new(i, j,\
    \ cost))\n  end\n\n  def add_edges(edges : Array(Edge2(T)))\n    edges.each {\
    \ |edge| add_edge(edge) }\n    self\n  end\n\n  delegate size, to: @graph\n  delegate\
    \ :[], to: @graph\n\n  def each_edge : Nil\n    (0...size).each do |v|\n     \
    \ graph[v].each do |edge|\n        yield Edge2(T).new(v, edge.to, edge.cost)\n\
    \      end\n    end\n  end\n\n  def edges\n    result = [] of Edge2(T)\n    each_edge\
    \ do |edge|\n      result << edge\n    end\n    result\n  end\nend\n\nclass DirectedGraph(T)\
    \ < Graph(T)\n  def initialize(size : Int)\n    super\n  end\n\n  def initialize(size\
    \ : Int, edges : Array(Edge2(T)))\n    super(size)\n    add_edges(edges)\n  end\n\
    \n  def add_edge(edge : Edge2(T))\n    raise IndexError.new unless 0 <= edge.from\
    \ < size\n    raise IndexError.new unless 0 <= edge.to < size\n    @graph[edge.from]\
    \ << Edge.new(edge.to, edge.cost)\n    self\n  end\nend\n\nclass UndirectedGraph(T)\
    \ < Graph(T)\n  def initialize(size : Int)\n    super\n  end\n\n  def initialize(size\
    \ : Int, edges : Array(Edge2(T)))\n    super(size)\n    add_edges(edges)\n  end\n\
    \n  def add_edge(edge : Edge2(T))\n    raise IndexError.new unless 0 <= edge.from\
    \ < size\n    raise IndexError.new unless 0 <= edge.to < size\n    @graph[edge.from]\
    \ << Edge.new(edge.to, edge.cost)\n    @graph[edge.to] << Edge.new(edge.from,\
    \ edge.cost)\n    self\n  end\nend\n\nabstract class UnweightedGraph\n  getter\
    \ graph : Array(Array(Int32))\n\n  def initialize(size : Int)\n    raise ArgumentError.new(\"\
    Negative graph size: #{size}\") unless size >= 0\n    @graph = Array.new(size)\
    \ { Array(Int32).new }\n  end\n\n  def add_edge(i : Int32, j : Int32)\n    add_edge(UnweightedEdge2.new(i,\
    \ j))\n  end\n\n  def add_edges(edges : Array(UnweightedEdge2))\n    edges.each\
    \ { |edge| add_edge(edge) }\n    self\n  end\n\n  delegate size, to: @graph\n\
    \  delegate :[], to: @graph\n\n  def each_edge : Nil\n    (0...size).each do |v|\n\
    \      graph[v].each do |u|\n        yield UnweightedEdge2.new(v, u)\n      end\n\
    \    end\n  end\n\n  def edges\n    result = [] of UnweightedEdge2\n    each_edge\
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
    \      yield u if u != parent\n    end\n  end\nend\n\nclass BipartiteMatching\n\
    \  getter left : Int32\n  getter right : Int32\n  getter graph : UnweightedDirectedGraph\n\
    \n  def initialize(@left, @right)\n    raise ArgumentError.new \"Negative left\
    \ vertexes size: #{left}\" unless left >= 0\n    raise ArgumentError.new \"Negative\
    \ right vertexes size: #{right}\" unless right >= 0\n    @graph = UnweightedDirectedGraph.new(left)\n\
    \    @left_match = Array(Int32?).new(left, nil)\n    @right_match = Array(Int32?).new(right,\
    \ nil)\n    @used = Array(Bool).new(left, false)\n  end\n\n  def add_edge(l :\
    \ Int32, r : Int32)\n    add_edge(UnweightedEdge2.new(l, r))\n  end\n\n  def add_edge(edge\
    \ : UnweightedEdge2)\n    raise IndexError.new unless 0 <= edge.from < left\n\
    \    raise IndexError.new unless 0 <= edge.to < right\n    graph[edge.from] <<\
    \ edge.to\n    self\n  end\n\n  def add_edges(edges : Array(UnweightedEdge2))\n\
    \    edges.each { |edge| add_edge(edge) }\n    self\n  end\n\n  private def dfs(v\
    \ : Int32) : Bool\n    return false if @used[v]\n    @used[v] = true\n    graph[v].each\
    \ do |edge|\n      if @right_match[edge].nil? || dfs(@right_match[edge].not_nil!)\n\
    \        @left_match[v], @right_match[edge] = edge, v\n        return true\n \
    \     end\n    end\n    return false\n  end\n\n  def solve : Int32\n    while\
    \ (0...left).reduce(false) { |update, i|\n            update | (@left_match[i].nil?\
    \ ? dfs(i) : false)\n          }\n      @used.fill(false)\n    end\n    left -\
    \ @left_match.count(&.nil?)\n  end\nend\n\nh, w = read_line.split.map(&.to_i)\n\
    a = (1..h).map { read_line.split.map(&.to_i) }\n\nl, r = 0, 0\nedges = Array.product((0...h).to_a,\
    \ (0...w).to_a).group_by { |(i, j)|\n  a[i][j]\n}.flat_map { |val, points|\n \
    \ next [] of UnweightedEdge2 if val == 0\n  row = {} of Int32 => Int32\n  column\
    \ = {} of Int32 => Int32\n  points.map do |(y, x)|\n    ll = row[y]? || (row[y]\
    \ = (l += 1) - 1)\n    rr = column[x]? || (column[x] = (r += 1) - 1)\n    UnweightedEdge2.new(ll,\
    \ rr)\n  end\n}\n\nputs BipartiteMatching.new(l, r).add_edges(edges).solve\n"
  code: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/1479\nrequire\
    \ \"../graph/BipartiteMatching\"\n\nh, w = read_line.split.map(&.to_i)\na = (1..h).map\
    \ { read_line.split.map(&.to_i) }\n\nl, r = 0, 0\nedges = Array.product((0...h).to_a,\
    \ (0...w).to_a).group_by { |(i, j)|\n  a[i][j]\n}.flat_map { |val, points|\n \
    \ next [] of UnweightedEdge2 if val == 0\n  row = {} of Int32 => Int32\n  column\
    \ = {} of Int32 => Int32\n  points.map do |(y, x)|\n    ll = row[y]? || (row[y]\
    \ = (l += 1) - 1)\n    rr = column[x]? || (column[x] = (r += 1) - 1)\n    UnweightedEdge2.new(ll,\
    \ rr)\n  end\n}\n\nputs BipartiteMatching.new(l, r).add_edges(edges).solve\n"
  dependsOn:
  - graph/BipartiteMatching.cr
  isVerificationFile: true
  path: test/BipartiteMatching.test.cr
  requiredBy: []
  timestamp: '2021-05-19 19:30:36+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/BipartiteMatching.test.cr
layout: document
redirect_from:
- /verify/test/BipartiteMatching.test.cr
- /verify/test/BipartiteMatching.test.cr.html
title: test/BipartiteMatching.test.cr
---
