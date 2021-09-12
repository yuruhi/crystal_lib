---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/graph/components.cr
    title: src/graph/components.cr
  - icon: ':heavy_check_mark:'
    path: src/scanner.cr
    title: src/scanner.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://onlinejudge.u-aizu.ac.jp/courses/lesson/1/ALDS1/all/ALDS1_11_D
  bundledCode: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/lesson/1/ALDS1/all/ALDS1_11_D\n\
    # require \"../../src/graph/components\"\n# require \"../graph\"\n# require \"\
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
    \ to : Int32\n\n  def initialize(@to)\n  end\n\n  def initialize(@to, cost)\n\
    \  end\n\n  def cost\n    1\n  end\n\n  def to_s(io) : Nil\n    io << to\n  end\n\
    \n  def inspect(io) : Nil\n    io << \"->\" << to\n  end\nend\n\nstruct UnweightedEdge2\n\
    \  property from : Int32, to : Int32\n\n  def initialize(@from, @to)\n  end\n\n\
    \  def initialize(@from, @to, cost)\n  end\n\n  def initialize(@from, edge : UnweightedEdge)\n\
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
    \    false\n  end\n\n  def self.directed?\n    false\n  end\nend\n\n# require\
    \ \"../datastructure/union_find\"\nclass UnionFind\n  @d : Array(Int32)\n\n  def\
    \ initialize(n : Int)\n    @d = Array.new(n, -1)\n  end\n\n  def initialize(n\
    \ : Int, edges : Enumerable({Int32, Int32}))\n    initialize(n)\n    edges.each\
    \ { |u, v| unite(u, v) }\n  end\n\n  def root(x : Int)\n    @d[x] < 0 ? x : (@d[x]\
    \ = root(@d[x]))\n  end\n\n  def unite(x : Int, y : Int)\n    x = root(x)\n  \
    \  y = root(y)\n    return false if x == y\n    x, y = y, x if @d[x] > @d[y]\n\
    \    @d[x] += @d[y]\n    @d[y] = x\n    true\n  end\n\n  def same?(x : Int, y\
    \ : Int)\n    root(x) == root(y)\n  end\n\n  def size(x : Int)\n    -@d[root(x)]\n\
    \  end\n\n  def groups\n    groups = Hash(Int32, Set(Int32)).new { |h, k| h[k]\
    \ = Set(Int32).new }\n    @d.size.times do |i|\n      groups[root(i)] << i\n \
    \   end\n    groups.values.to_set\n  end\nend\n\nmodule Graph(Edge, Edge2)\n \
    \ # Returns `{number of connected components, index, groups}`.\n  def components\
    \ : {Int32, Array(Int32), Array(Set(Int32))}\n    uf = UnionFind.new(size)\n \
    \   each do |edge|\n      uf.unite(edge.from, edge.to)\n    end\n    groups =\
    \ uf.groups.to_a\n    id = Array.new(size, -1)\n    groups.each_with_index do\
    \ |group, i|\n      group.each { |v| id[v] = i }\n    end\n    {groups.size, id,\
    \ groups}\n  end\nend\n\n# require \"../../src/scanner\"\n# ### Specifications\n\
    #\n# ```plain\n# Inside input macro                   | Expanded code\n# -------------------------------------+---------------------------------------\n\
    # Uppercase string: Int32, Int64, etc. | {}.new(Scanner.s)\n# s              \
    \                      | Scanner.s\n# c                                    | Scanner.c\n\
    # Other lowercase string: i, i64, etc. | Scanner.s.to_{}\n# operator[]: type[size]\
    \               | Array.new(input(size)) { input(type) }\n# Tuple literal: {t1,\
    \ t2, t3}          | {input(t1), input(t2), input(t3)}\n# Array literal: [t1,\
    \ t2, t3]          | [input(t1), input(t2), input(t3)]\n# Range literal: t1..t2\
    \                | input(t1)..input(t2)\n# If: cond ? t1 : t2                \
    \   | cond ? input(t1) : input(t2)\n# Assign: target = value               | target\
    \ = input(value)\n# ```\n#\n# ### Examples\n#\n# Input:\n# ```plain\n# 5 3\n#\
    \ foo bar\n# 1 2 3 4 5\n# ```\n# ```\n# n, m = input(Int32, Int64) # => {5, 10i64}\n\
    # input(String, Char[m])     # => {\"foo\", ['b', 'a', 'r']}\n# input(Int32[n])\
    \            # => [1, 2, 3, 4, 5]\n# ```\n# ```\n# n, m = input(i, i64) # => {5,\
    \ 10i64}\n# input(s, c[m])       # => {\"foo\", ['b', 'a', 'r']}\n# input(i[n])\
    \          # => [1, 2, 3, 4, 5]\n# ```\n#\n# Input:\n# ```plain\n# 2 3\n# 1 2\
    \ 3\n# 4 5 6\n# ```\n#\n# ```\n# h, w = input(i, i) # => {2, 3}\n# input(i[h,\
    \ w])     # => [[1, 2, 3], [4, 5, 6]]\n# ```\n# ```\n# input(i[i][i]) # => [[1,\
    \ 2, 3], [4, 5, 6]]\n# ```\n#\n# Input:\n# ```plain\n# 5 3\n# 3 1 4 2 5\n# 1 2\n\
    # 2 3\n# 3 1\n# ```\n# ```\n# n, m = input(i, i)       # => {5, 3}\n# input(i.pred[n])\
    \         # => [2, 0, 3, 1, 4]\n# input({i - 1, i - 1}[m]) # => [{0, 1}, {1, 2},\
    \ {2, 0}]\n# ```\n#\n# Input:\n# ```plain\n# 3\n# 1 2\n# 2 2\n# 3 2\n# ```\n#\
    \ ```\n# input({tmp = i, tmp == 1 ? i : i.pred}[i]) # => [{1, 2}, {2, 1}, {3,\
    \ 1}]\n# ```\n#\n# Input:\n# ```plain\n# 3\n# 1 2\n# 2 3\n# 3 1\n# ```\n# ```\n\
    # n = input(i)\n# input_column({Int32, Int32}, n) # => {[1, 2, 3], [2, 3, 1]}\n\
    # ```\nclass Scanner\n  private def self.skip_to_not_space\n    peek = STDIN.peek\n\
    \    not_space = peek.index { |x| x != 32 && x != 10 } || peek.size\n    STDIN.skip(not_space)\n\
    \  end\n\n  def self.c\n    skip_to_not_space\n    STDIN.read_char.not_nil!\n\
    \  end\n\n  def self.s\n    skip_to_not_space\n\n    peek = STDIN.peek\n    if\
    \ index = peek.index { |x| x == 32 || x == 10 }\n      STDIN.skip(index + 1)\n\
    \      return String.new(peek[0, index])\n    end\n\n    String.build do |buffer|\n\
    \      loop do\n        buffer.write peek\n        STDIN.skip(peek.size)\n   \
    \     peek = STDIN.peek\n        break if peek.empty?\n        if index = peek.index\
    \ { |x| x == 32 || x == 10 }\n          buffer.write peek[0, index]\n        \
    \  STDIN.skip(index)\n          break\n        end\n      end\n    end\n  end\n\
    end\n\nmacro internal_input(type, else_ast)\n  {% if Scanner.class.has_method?(type.id)\
    \ %}\n    Scanner.{{type.id}}\n  {% elsif type.stringify == \"String\" %}\n  \
    \  Scanner.s\n  {% elsif type.stringify == \"Char\" %}\n    Scanner.c\n  {% elsif\
    \ type.stringify =~ /[A-Z][a-z0-9_]*/ %}\n    {{type.id}}.new(Scanner.s)\n  {%\
    \ elsif String.has_method?(\"to_#{type}\".id) %}\n    Scanner.s.to_{{type.id}}\n\
    \  {% else %}\n    {{else_ast}}\n  {% end %}\nend\n\nmacro internal_input_array(type,\
    \ args)\n  {% for i in 0...args.size %}\n    %size{i} = input({{args[i]}})\n \
    \ {% end %}\n  {% begin %}\n    {% for i in 0...args.size %} Array.new(%size{i})\
    \ { {% end %}\n      input({{type.id}})\n    {% for i in 0...args.size %} } {%\
    \ end %}\n  {% end %}\nend\n\nmacro input(type)\n  {% if type.is_a?(Call) %}\n\
    \    {% if type.receiver.is_a?(Nop) %}\n      internal_input(\n        {{type.name}},\
    \ {{type.name}}(\n          {% for argument in type.args %} input({{argument}}),\
    \ {% end %}\n        )\n      )\n    {% elsif type.name.stringify == \"[]\" %}\n\
    \      internal_input_array({{type.receiver}}, {{type.args}})\n    {% else %}\n\
    \      input({{type.receiver}}).{{type.name.id}}(\n        {% for argument in\
    \ type.args %} input({{argument}}), {% end %}\n      ) {{type.block}}\n    {%\
    \ end %}\n  {% elsif type.is_a?(TupleLiteral) %}\n    { {% for i in 0...type.size\
    \ %} input({{type[i]}}), {% end %} }\n  {% elsif type.is_a?(ArrayLiteral) %}\n\
    \    [ {% for i in 0...type.size %} input({{type[i]}}), {% end %} ]\n  {% elsif\
    \ type.is_a?(RangeLiteral) %}\n    Range.new(input({{type.begin}}), input({{type.end}}),\
    \ {{type.excludes_end?}})\n  {% elsif type.is_a?(If) %}\n    {{type.cond}} ? input({{type.then}})\
    \ : input({{type.else}})\n  {% elsif type.is_a?(Assign) %}\n    {{type.target}}\
    \ = input({{type.value}})\n  {% else %}\n    internal_input({{type.id}}, {{type.id}})\n\
    \  {% end %}\nend\n\nmacro input(*types)\n  { {% for type in types %} input({{type}}),\
    \ {% end %} }\nend\n\nmacro input_column(types, size)\n  {% for type, i in types\
    \ %}\n    %array{i} = Array({{type}}).new({{size}})\n  {% end %}\n  {{size}}.times\
    \ do\n    {% for type, i in types %}\n      %array{i} << input({{type}})\n   \
    \ {% end %}\n  end\n  { {% for type, i in types %} %array{i}, {% end %} }\nend\n\
    \nn, m = input(i, i)\nedges = input({i, i}[m])\n\ng = DirectedGraph.new n, (edges\
    \ + edges.map(&.reverse)).map { |u, v| {u, v, 42} }\nm, id, groups = g.components\n\
    \nbegin\n  g2 = UndirectedGraph.new n, edges.map { |u, v| {u, v, 42} }\n  raise\
    \ \"\" unless {m, id, groups} == g2.components\nend\nbegin\n  g2 = UnweightedDirectedGraph.new\
    \ n, edges + edges.map(&.reverse)\n  raise \"\" unless {m, id, groups} == g2.components\n\
    end\nbegin\n  g2 = UnweightedUndirectedGraph.new n, edges\n  raise \"\" unless\
    \ {m, id, groups} == g2.components\nend\n\nread_line.to_i.times do\n  a, b = input(i,\
    \ i)\n  if id[a] == id[b]\n    puts \"yes\"\n    raise \"\" unless groups[id[a]].includes?(a)\
    \ && groups[id[a]].includes?(b)\n  else\n    puts \"no\"\n  end\nend\n"
  code: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/lesson/1/ALDS1/all/ALDS1_11_D\n\
    require \"../../src/graph/components\"\nrequire \"../../src/scanner\"\nn, m =\
    \ input(i, i)\nedges = input({i, i}[m])\n\ng = DirectedGraph.new n, (edges + edges.map(&.reverse)).map\
    \ { |u, v| {u, v, 42} }\nm, id, groups = g.components\n\nbegin\n  g2 = UndirectedGraph.new\
    \ n, edges.map { |u, v| {u, v, 42} }\n  raise \"\" unless {m, id, groups} == g2.components\n\
    end\nbegin\n  g2 = UnweightedDirectedGraph.new n, edges + edges.map(&.reverse)\n\
    \  raise \"\" unless {m, id, groups} == g2.components\nend\nbegin\n  g2 = UnweightedUndirectedGraph.new\
    \ n, edges\n  raise \"\" unless {m, id, groups} == g2.components\nend\n\nread_line.to_i.times\
    \ do\n  a, b = input(i, i)\n  if id[a] == id[b]\n    puts \"yes\"\n    raise \"\
    \" unless groups[id[a]].includes?(a) && groups[id[a]].includes?(b)\n  else\n \
    \   puts \"no\"\n  end\nend\n"
  dependsOn:
  - src/graph/components.cr
  - src/scanner.cr
  isVerificationFile: true
  path: test/graph/components_test.cr
  requiredBy: []
  timestamp: '2021-08-09 09:32:32+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/graph/components_test.cr
layout: document
redirect_from:
- /verify/test/graph/components_test.cr
- /verify/test/graph/components_test.cr.html
title: test/graph/components_test.cr
---
