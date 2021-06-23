---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: graph/tree_walk.cr
    title: graph/tree_walk.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://onlinejudge.u-aizu.ac.jp/courses/lesson/1/ALDS1/all/ALDS1_7_C
  bundledCode: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/lesson/1/ALDS1/all/ALDS1_7_C\n\
    # require \"../graph/tree_walk\"\n# require \"./graph\"\nstruct Edge(T)\n  include\
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
    \      yield u if u != parent\n    end\n  end\nend\n\nclass UnweightedGraph\n\
    \  def pre_order(root : Int32)\n    result = Array(Int32).new(size)\n    stack\
    \ = Deque{ {root, -1} }\n    while vp = stack.pop?\n      vertex, parent = vp\n\
    \      result << vertex\n      self[vertex].reverse_each do |to|\n        stack\
    \ << {to, vertex} if to != parent\n      end\n    end\n    result\n  end\n\n \
    \ def post_order(root : Int32)\n    result = Array(Int32).new(size)\n    visited\
    \ = Array(Bool).new(size, false)\n    stack = Deque{ {root, -1} }\n    while vp\
    \ = stack.last?\n      vertex, parent = vp\n      if visited[vertex]\n       \
    \ stack.pop\n        result << vertex\n      else\n        self[vertex].reverse_each\
    \ do |to|\n          stack << {to, vertex} if to != parent\n        end\n    \
    \    visited[vertex] = true\n      end\n    end\n    result\n  end\nend\n\ndef\
    \ in_order(graph, v, result)\n  if left = graph[v][0]\n    in_order(graph, left,\
    \ result)\n  end\n  result << v\n  if right = graph[v][1]\n    in_order(graph,\
    \ right, result)\n  end\nend\n\nn = read_line.to_i\ngraph = UnweightedUndirectedGraph.new(n)\n\
    graph2 = Array({Int32?, Int32?}).new(n, {nil, nil})\nin_degree = [0] * n\nn.times\
    \ do |i|\n  v, left, right = read_line.split.map(&.to_i)\n  if left != -1\n  \
    \  graph.add_edge(v, left)\n    in_degree[left] += 1\n  end\n  if right != -1\n\
    \    graph.add_edge(v, right)\n    in_degree[right] += 1\n  end\n  graph2[v] =\
    \ {left >= 0 ? left : nil, right >= 0 ? right : nil}\nend\nroot = (0...n).find\
    \ { |i| in_degree[i] == 0 }.not_nil!\n\nin_ans = [] of Int32\nin_order(graph2,\
    \ root, in_ans)\n\nputs \"Preorder\", graph.pre_order(root).join { |i| \" #{i}\"\
    \ }\nputs \"Inorder\", in_ans.join { |i| \" #{i}\" }\nputs \"Postorder\", graph.post_order(root).join\
    \ { |i| \" #{i}\" }\n"
  code: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/lesson/1/ALDS1/all/ALDS1_7_C\n\
    require \"../graph/tree_walk\"\n\ndef in_order(graph, v, result)\n  if left =\
    \ graph[v][0]\n    in_order(graph, left, result)\n  end\n  result << v\n  if right\
    \ = graph[v][1]\n    in_order(graph, right, result)\n  end\nend\n\nn = read_line.to_i\n\
    graph = UnweightedUndirectedGraph.new(n)\ngraph2 = Array({Int32?, Int32?}).new(n,\
    \ {nil, nil})\nin_degree = [0] * n\nn.times do |i|\n  v, left, right = read_line.split.map(&.to_i)\n\
    \  if left != -1\n    graph.add_edge(v, left)\n    in_degree[left] += 1\n  end\n\
    \  if right != -1\n    graph.add_edge(v, right)\n    in_degree[right] += 1\n \
    \ end\n  graph2[v] = {left >= 0 ? left : nil, right >= 0 ? right : nil}\nend\n\
    root = (0...n).find { |i| in_degree[i] == 0 }.not_nil!\n\nin_ans = [] of Int32\n\
    in_order(graph2, root, in_ans)\n\nputs \"Preorder\", graph.pre_order(root).join\
    \ { |i| \" #{i}\" }\nputs \"Inorder\", in_ans.join { |i| \" #{i}\" }\nputs \"\
    Postorder\", graph.post_order(root).join { |i| \" #{i}\" }\n"
  dependsOn:
  - graph/tree_walk.cr
  isVerificationFile: true
  path: test/tree_walk.test.cr
  requiredBy: []
  timestamp: '2021-06-20 21:15:01+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/tree_walk.test.cr
layout: document
redirect_from:
- /verify/test/tree_walk.test.cr
- /verify/test/tree_walk.test.cr.html
title: test/tree_walk.test.cr
---
