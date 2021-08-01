---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/graph/tree_walk.cr
    title: src/graph/tree_walk.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://onlinejudge.u-aizu.ac.jp/courses/lesson/1/ALDS1/all/ALDS1_7_C
  bundledCode: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/lesson/1/ALDS1/all/ALDS1_7_C\n\
    # require \"../../src/graph/tree_walk\"\n# require \"../graph\"\n# require \"\
    ./graph/edge\"\nstruct WeightedEdge(T)\n  include Comparable(WeightedEdge(T))\n\
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
    \    false\n  end\n\n  def self.directed?\n    false\n  end\nend\n\nmodule Graph(Edge,\
    \ Edge2)\n  def pre_order(root : Int) : Array(Int32)\n    result = Array(Int32).new(size)\n\
    \    stack = Deque{ {root, -1} }\n    while vp = stack.pop?\n      vertex, parent\
    \ = vp\n      result << vertex\n      self[vertex].reverse_each do |edge|\n  \
    \      stack << {edge.to, vertex} if edge.to != parent\n      end\n    end\n \
    \   result\n  end\n\n  def post_order(root : Int) : Array(Int32)\n    result =\
    \ Array(Int32).new(size)\n    visited = Array(Bool).new(size, false)\n    stack\
    \ = Deque{ {root, -1} }\n    while vp = stack.last?\n      vertex, parent = vp\n\
    \      if visited[vertex]\n        stack.pop\n        result << vertex\n     \
    \ else\n        self[vertex].reverse_each do |edge|\n          stack << {edge.to,\
    \ vertex} if edge.to != parent\n        end\n        visited[vertex] = true\n\
    \      end\n    end\n    result\n  end\nend\n\ndef in_order(graph, v, result)\n\
    \  if left = graph[v][0]\n    in_order(graph, left, result)\n  end\n  result <<\
    \ v\n  if right = graph[v][1]\n    in_order(graph, right, result)\n  end\nend\n\
    \nn = read_line.to_i\ngraph = UnweightedUndirectedGraph.new(n)\ngraph2 = Array({Int32?,\
    \ Int32?}).new(n, {nil, nil})\nin_degree = [0] * n\nn.times do\n  v, left, right\
    \ = read_line.split.map(&.to_i)\n  if left != -1\n    graph << {v, left}\n   \
    \ in_degree[left] += 1\n  end\n  if right != -1\n    graph << {v, right}\n   \
    \ in_degree[right] += 1\n  end\n  graph2[v] = {left >= 0 ? left : nil, right >=\
    \ 0 ? right : nil}\nend\nroot = (0...n).find { |i| in_degree[i] == 0 }.not_nil!\n\
    \nin_ans = [] of Int32\nin_order(graph2, root, in_ans)\n\nputs \"Preorder\", graph.pre_order(root).join\
    \ { |i| \" #{i}\" }\nputs \"Inorder\", in_ans.join { |i| \" #{i}\" }\nputs \"\
    Postorder\", graph.post_order(root).join { |i| \" #{i}\" }\n"
  code: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/lesson/1/ALDS1/all/ALDS1_7_C\n\
    require \"../../src/graph/tree_walk\"\n\ndef in_order(graph, v, result)\n  if\
    \ left = graph[v][0]\n    in_order(graph, left, result)\n  end\n  result << v\n\
    \  if right = graph[v][1]\n    in_order(graph, right, result)\n  end\nend\n\n\
    n = read_line.to_i\ngraph = UnweightedUndirectedGraph.new(n)\ngraph2 = Array({Int32?,\
    \ Int32?}).new(n, {nil, nil})\nin_degree = [0] * n\nn.times do\n  v, left, right\
    \ = read_line.split.map(&.to_i)\n  if left != -1\n    graph << {v, left}\n   \
    \ in_degree[left] += 1\n  end\n  if right != -1\n    graph << {v, right}\n   \
    \ in_degree[right] += 1\n  end\n  graph2[v] = {left >= 0 ? left : nil, right >=\
    \ 0 ? right : nil}\nend\nroot = (0...n).find { |i| in_degree[i] == 0 }.not_nil!\n\
    \nin_ans = [] of Int32\nin_order(graph2, root, in_ans)\n\nputs \"Preorder\", graph.pre_order(root).join\
    \ { |i| \" #{i}\" }\nputs \"Inorder\", in_ans.join { |i| \" #{i}\" }\nputs \"\
    Postorder\", graph.post_order(root).join { |i| \" #{i}\" }\n"
  dependsOn:
  - src/graph/tree_walk.cr
  isVerificationFile: true
  path: test/graph/tree_walk.test.cr
  requiredBy: []
  timestamp: '2021-07-18 13:52:56+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/graph/tree_walk.test.cr
layout: document
redirect_from:
- /verify/test/graph/tree_walk.test.cr
- /verify/test/graph/tree_walk.test.cr.html
title: test/graph/tree_walk.test.cr
---
