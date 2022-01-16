---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: src/graph.cr
    title: src/graph.cr
  - icon: ':question:'
    path: src/graph/edge.cr
    title: src/graph/edge.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/lca.cr
    title: src/graph/lca.cr
  - icon: ':question:'
    path: src/scanner.cr
    title: src/scanner.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://onlinejudge.u-aizu.ac.jp/problems/GRL_5_C
  bundledCode: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/GRL_5_C\n\
    # require \"../../src/graph/lca\"\n# require \"../graph\"\n# require \"./graph/edge\"\
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
    \    false\n  end\n\n  def self.directed?\n    false\n  end\nend\n\nclass LCA(Edge,\
    \ Edge2)\n  getter graph : Graph(Edge, Edge2)\n  getter depth : Array(Int32)\n\
    \n  private def dfs(vertex : Int, par : Int, dep : Int) : Nil\n    @parent[0][vertex]\
    \ = par\n    @depth[vertex] = dep\n    @graph[vertex].each do |edge|\n      dfs(edge.to,\
    \ vertex, dep + 1) if edge.to != par\n    end\n  end\n\n  def initialize(@graph\
    \ : Graph(Edge, Edge2), root : Int)\n    @log2 = Math.log2(size).to_i.succ.as(Int32)\n\
    \    @depth = Array(Int32).new(size, -1)\n    @parent = Array(Array(Int32)).new(@log2)\
    \ { Array.new(size, 0) }\n    dfs(root, -1, 0)\n    (0...@log2 - 1).each do |k|\n\
    \      (0...size).each do |v|\n        if @parent[k][v] < 0\n          @parent[k\
    \ + 1][v] = -1\n        else\n          @parent[k + 1][v] = @parent[k][@parent[k][v]]\n\
    \        end\n      end\n    end\n  end\n\n  delegate size, to: @graph\n\n  def\
    \ lca(u : Int, v : Int) : Int32\n    raise IndexError.new unless 0 <= u < size\
    \ && 0 <= v < size\n    u, v = v, u if @depth[u] > @depth[v]\n    (0...@log2).each\
    \ do |k|\n      v = @parent[k][v] if (@depth[v] - @depth[u]).bit(k) == 1\n   \
    \ end\n\n    return u if u == v\n\n    (0...@log2).reverse_each do |k|\n     \
    \ u, v = @parent[k][u], @parent[k][v] if @parent[k][u] != @parent[k][v]\n    end\n\
    \    @parent[0][u]\n  end\n\n  def dist(u : Int, v : Int) : Int32\n    @depth[u]\
    \ + @depth[v] - @depth[lca(u, v)] * 2\n  end\nend\n\n# require \"../../src/scanner\"\
    \nmodule Scanner\n  extend self\n\n  private def skip_to_not_space(io)\n    peek\
    \ = io.peek\n    not_space = peek.index { |x| x != 32 && x != 10 } || peek.size\n\
    \    io.skip(not_space)\n  end\n\n  def c(io = STDIN)\n    skip_to_not_space(io)\n\
    \    io.read_char.not_nil!\n  end\n\n  private def int(int_type : T.class, io\
    \ = STDIN) : T forall T\n    skip_to_not_space(io)\n\n    value = T.zero\n   \
    \ signed = false\n    case x = io.read_byte\n    when nil\n      raise IO::EOFError.new\n\
    \    when 45\n      signed = true\n    when 48..57\n      value = T.new 48 &-\
    \ x\n    else\n      raise \"Unexpected char: #{x.chr}\"\n    end\n\n    loop\
    \ do\n      peek = io.peek\n      return signed ? value : -value if peek.empty?\n\
    \      i = 0\n      while i < peek.size\n        c = peek.unsafe_fetch(i)\n  \
    \      if 48 <= c <= 57\n          value = value &* 10 &- c &+ 48\n          i\
    \ &+= 1\n        elsif c == 32 || c == 10\n          io.skip(i &+ 1)\n       \
    \   return signed ? value : -value\n        else\n          raise \"Unexpected\
    \ char: #{c.chr}\"\n        end\n      end\n      io.skip(i)\n    end\n  end\n\
    \n  private def uint(uint_type : T.class, io = STDIN) : T forall T\n    skip_to_not_space(io)\n\
    \    value = T.zero\n    found_digit = false\n    loop do\n      peek = io.peek\n\
    \      if peek.empty?\n        if found_digit\n          return value\n      \
    \  else\n          raise IO::EOFError.new\n        end\n      end\n      i = 0\n\
    \      while i < peek.size\n        c = peek.unsafe_fetch(i)\n        if 48 <=\
    \ c <= 57\n          found_digit = true\n          value = value &* 10 &+ c &-\
    \ 48\n          i &+= 1\n        elsif c == 32 || c == 10\n          io.skip(i\
    \ &+ 1)\n          return value\n        else\n          raise \"Unexpected char:\
    \ #{c.chr}\"\n        end\n      end\n      io.skip(i)\n    end\n  end\n\n  def\
    \ i(io = STDIN)\n    int(Int32, io)\n  end\n\n  {% for n in [8, 16, 32, 64, 128]\
    \ %}\n    def i{{n}}(io = STDIN)\n      int(Int{{n}}, io)\n    end\n\n    def\
    \ u{{n}}(io = STDIN)\n      uint(UInt{{n}}, io)\n    end\n  {% end %}\n\n  {%\
    \ for method in [:f, :f32, :f64] %}\n    def {{method.id}}(io = STDIN)\n     \
    \ s(io).to_{{method.id}}\n    end\n  {% end %}\n\n  def s(io = STDIN)\n    skip_to_not_space(io)\n\
    \n    peek = io.peek\n    if peek.empty?\n      raise IO::EOFError.new\n    end\n\
    \    if index = peek.index { |x| x == 32 || x == 10 }\n      io.skip(index + 1)\n\
    \      return String.new(peek[0, index])\n    end\n\n    String.build do |buffer|\n\
    \      loop do\n        buffer.write peek\n        io.skip(peek.size)\n      \
    \  peek = io.peek\n        break if peek.empty?\n        if index = peek.index\
    \ { |x| x == 32 || x == 10 }\n          buffer.write peek[0, index]\n        \
    \  io.skip(index + 1)\n          break\n        end\n      end\n    end\n  end\n\
    end\n\nmacro internal_input(type, else_ast, io)\n  {% if Scanner.class.has_method?(type.id)\
    \ %}\n    Scanner.{{type.id}}({{io}})\n  {% elsif type.stringify == \"String\"\
    \ %}\n    Scanner.s({{io}})\n  {% elsif type.stringify == \"Char\" %}\n    Scanner.c({{io}})\n\
    \  {% elsif type.is_a?(Path) %}\n    {% if type.resolve.class.has_method?(:scan)\
    \ %}\n      {{type}}.scan(Scanner, {{io}})\n    {% else %}\n      {{type}}.new(Scanner.s({{io}}))\n\
    \    {% end %}\n  {% elsif String.has_method?(\"to_#{type}\".id) %}\n    Scanner.s({{io}}).to_{{type.id}}\n\
    \  {% else %}\n    {{else_ast}}\n  {% end %}\nend\n\nmacro internal_input_array(type,\
    \ args, io)\n  {% for i in 0...args.size %}\n    %size{i} = input({{args[i]}},\
    \ io: {{io}})\n  {% end %}\n  {% begin %}\n    {% for i in 0...args.size %} Array.new(%size{i})\
    \ { {% end %}\n      input({{type.id}}, io: {{io}})\n    {% for i in 0...args.size\
    \ %} } {% end %}\n  {% end %}\nend\n\n# Inputs from *io*.\n#\n# ### Specifications\n\
    #\n# ```plain\n# AST               | Example             | Expanded code\n# ------------------+---------------------+---------------------------------------\n\
    # Uppercase string  | Int32, Int64, etc.  | {}.new(Scanner.s)\n#             \
    \      | s, c, i, iN, uN     | Scanner.{}\n#                   | f, big_i, etc.\
    \      | Scanner.s.to_{}\n# Call []           | type[size]          | Array.new(input(size))\
    \ { input(type) }\n# TupleLiteral      | {t1, t2, t3}        | {input(t1), input(t2),\
    \ input(t3)}\n# ArrayLiteral      | [t1, t2, t3]        | [input(t1), input(t2),\
    \ input(t3)]\n# HashLiteral       | {t1 => t2}          | {input(t1) => input(t2)}\n\
    # NamedTupleLiteral | {a: t1, b: t2}      | {a: input(t1), b: input(t2)}\n# RangeLiteral\
    \      | t1..t2              | input(t1)..input(t2)\n# Expressions       | (exp1;\
    \ exp2)        | (input(exp1); input(exp2);)\n# If                | cond ? t1\
    \ : t2      | input(cond) ? input(t1) : input(t2)\n# Assign            | target\
    \ = value      | target = input(value)\n# ```\n#\n# ### Examples\n#\n# Input:\n\
    # ```plain\n# 5 3\n# foo bar\n# 1 2 3 4 5\n# ```\n# ```\n# n, m = input(Int32,\
    \ Int64) # => {5, 5i64}\n# input(String, Char[m])     # => {\"foo\", ['b', 'a',\
    \ 'r']}\n# input(Int32[n])            # => [1, 2, 3, 4, 5]\n# ```\n# ```\n# n,\
    \ m = input(i, i64) # => {5, 5i64}\n# input(s, c[m])       # => {\"foo\", ['b',\
    \ 'a', 'r']}\n# input(i[n])          # => [1, 2, 3, 4, 5]\n# ```\n#\n# Input:\n\
    # ```plain\n# 2 3\n# 1 2 3\n# 4 5 6\n# ```\n#\n# ```\n# h, w = input(i, i) # =>\
    \ {2, 3}\n# input(i[h, w])     # => [[1, 2, 3], [4, 5, 6]]\n# ```\n# ```\n# input(i[i,\
    \ i]) # => [[1, 2, 3], [4, 5, 6]]\n# ```\n#\n# Input:\n# ```plain\n# 5 3\n# 3\
    \ 1 4 2 5\n# 1 2\n# 2 3\n# 3 1\n# ```\n# ```\n# n, m = input(i, i)       # =>\
    \ {5, 3}\n# input(i.pred[n])         # => [2, 0, 3, 1, 4]\n# input({i - 1, i -\
    \ 1}[m]) # => [{0, 1}, {1, 2}, {2, 0}]\n# ```\n#\n# Input:\n# ```plain\n# 3\n\
    # 1 2\n# 2 2\n# 3 2\n# ```\n# ```\n# input({tmp = i, tmp == 1 ? i : i.pred}[i])\
    \ # => [{1, 2}, {2, 1}, {3, 1}]\n# ```\n#\n# Input:\n# ```plain\n# 3\n# 1 1\n\
    # 2 1 2\n# 5 1 2 3 4 5\n# ```\n# ```\n# n = input(i)   # => 3\n# input(i[i][n])\
    \ # => [[1], [1, 2], [1, 2, 3, 4, 5]]\n# ```\n#\n# Input:\n# ```plain\n# 3\n#\
    \ 1 2\n# 2 3\n# 3 1\n# ```\n# ```\n# n = input(i)\n# input_column({Int32, Int32},\
    \ n) # => {[1, 2, 3], [2, 3, 1]}\n# ```\nmacro input(ast, *, io = STDIN)\n  {%\
    \ if ast.is_a?(Call) %}\n    {% if ast.receiver.is_a?(Nop) %}\n      internal_input(\n\
    \        {{ast.name}},\n        {{ast.name}}({% for argument in ast.args %} input({{argument}},\
    \ io: {{io}}), {% end %}),\n        {{io}},\n      )\n    {% elsif ast.receiver.is_a?(Path)\
    \ && ast.receiver.resolve.class.has_method?(ast.name.symbolize) %}\n      {{ast.receiver}}.{{ast.name}}(\n\
    \        {% for argument in ast.args %} input({{argument}}, io: {{io}}) {% end\
    \ %}\n      ) {{ast.block}}\n    {% elsif ast.name.stringify == \"[]\" %}\n  \
    \    internal_input_array({{ast.receiver}}, {{ast.args}}, {{io}})\n    {% else\
    \ %}\n      input({{ast.receiver}}, io: {{io}}).{{ast.name}}(\n        {% for\
    \ argument in ast.args %} input({{argument}}, io: {{io}}), {% end %}\n      )\
    \ {{ast.block}}\n    {% end %}\n  {% elsif ast.is_a?(TupleLiteral) %}\n    { {%\
    \ for i in 0...ast.size %} input({{ast[i]}}, io: {{io}}), {% end %} }\n  {% elsif\
    \ ast.is_a?(ArrayLiteral) %}\n    [ {% for i in 0...ast.size %} input({{ast[i]}},\
    \ io: {{io}}), {% end %} ]\n  {% elsif ast.is_a?(HashLiteral) %}\n    { {% for\
    \ key, value in ast %} input({{key}}, io: {{io}}) => input({{value}}, io: {{io}}),\
    \ {% end %} }\n  {% elsif ast.is_a?(NamedTupleLiteral) %}\n    { {% for key, value\
    \ in ast %} {{key}}: input({{value}}, io: {{io}}), {% end %} }\n  {% elsif ast.is_a?(RangeLiteral)\
    \ %}\n    Range.new(\n      input({{ast.begin}}, io: {{io}}),\n      input({{ast.end}},\
    \ io: {{io}}),\n      {{ast.excludes_end?}},\n    )\n  {% elsif ast.is_a?(SymbolLiteral)\
    \ %}\n    {{ast.id}}\n  {% elsif ast.is_a?(Expressions) %}\n    ( {% for exp in\
    \ ast.expressions %} input({{exp}}, io: {{io}}); {% end %} )\n  {% elsif ast.is_a?(If)\
    \ %}\n    input({{ast.cond}}, io: {{io}}) ? input({{ast.then}}, io: {{io}}) :\
    \ input({{ast.else}}, io: {{io}})\n  {% elsif ast.is_a?(Assign) %}\n    {{ast.target}}\
    \ = input({{ast.value}}, io: {{io}})\n  {% else %}\n    internal_input({{ast}},\
    \ {{ast}}, io: {{io}})\n  {% end %}\nend\n\nmacro input(*asts, io = STDIN)\n \
    \ { {% for ast in asts %} input({{ast}}, io: {{io}}), {% end %} }\nend\n\nmacro\
    \ input_column(types, size)\n  {% for type, i in types %}\n    %array{i} = Array({{type}}).new({{size}})\n\
    \  {% end %}\n  {{size}}.times do\n    {% for type, i in types %}\n      %array{i}\
    \ << input({{type}})\n    {% end %}\n  end\n  { {% for type, i in types %} %array{i},\
    \ {% end %} }\nend\n\nn = input(i)\n\ng1 = UnweightedUndirectedGraph.new(n)\n\
    g2 = UndirectedGraph(Int32).new(n)\nn.times do |u|\n  input(i[i]).each do |v|\n\
    \    g1 << {u, v}\n    g2 << {u, v, 42}\n  end\nend\n\nlca1 = LCA.new(g1, 0)\n\
    lca2 = LCA.new(g2, 0)\n\ninput(i).times do\n  u, v = input(i, i)\n  a1, a2 = lca1.lca(u,\
    \ v), lca2.lca(u, v)\n  raise \"\" unless a1 == a2\n  puts a1\nend\n"
  code: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/GRL_5_C\n\
    require \"../../src/graph/lca\"\nrequire \"../../src/scanner\"\nn = input(i)\n\
    \ng1 = UnweightedUndirectedGraph.new(n)\ng2 = UndirectedGraph(Int32).new(n)\n\
    n.times do |u|\n  input(i[i]).each do |v|\n    g1 << {u, v}\n    g2 << {u, v,\
    \ 42}\n  end\nend\n\nlca1 = LCA.new(g1, 0)\nlca2 = LCA.new(g2, 0)\n\ninput(i).times\
    \ do\n  u, v = input(i, i)\n  a1, a2 = lca1.lca(u, v), lca2.lca(u, v)\n  raise\
    \ \"\" unless a1 == a2\n  puts a1\nend\n"
  dependsOn:
  - src/graph/lca.cr
  - src/graph.cr
  - src/graph/edge.cr
  - src/scanner.cr
  isVerificationFile: true
  path: test/graph/lca_test.cr
  requiredBy: []
  timestamp: '2022-01-16 12:13:49+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/graph/lca_test.cr
layout: document
redirect_from:
- /verify/test/graph/lca_test.cr
- /verify/test/graph/lca_test.cr.html
title: test/graph/lca_test.cr
---
