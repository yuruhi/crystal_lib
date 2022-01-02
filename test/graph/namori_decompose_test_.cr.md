---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/datastructure/union_find.cr
    title: src/datastructure/union_find.cr
  - icon: ':question:'
    path: src/graph.cr
    title: src/graph.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/decompose.cr
    title: src/graph/decompose.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/degree.cr
    title: src/graph/degree.cr
  - icon: ':question:'
    path: src/graph/edge.cr
    title: src/graph/edge.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/namori_decompose.cr
    title: src/graph/namori_decompose.cr
  - icon: ':question:'
    path: src/scanner.cr
    title: src/scanner.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes:
    IGNORE: ''
    PROBLEM: https://yukicoder.me/problems/no/1640
  bundledCode: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/1640\n\
    # verification-helper: IGNORE\n# require \"../../src/graph/namori_decompose\"\n\
    # require \"../graph\"\n# require \"./graph/edge\"\nstruct WeightedEdge(T)\n \
    \ include Comparable(WeightedEdge(T))\n\n  property to : Int32, cost : T\n\n \
    \ def initialize(@to, @cost : T)\n  end\n\n  def <=>(other : WeightedEdge(T))\n\
    \    {cost, to} <=> {other.cost, other.to}\n  end\n\n  def to_s(io) : Nil\n  \
    \  io << '(' << to << \", \" << cost << ')'\n  end\n\n  def inspect(io) : Nil\n\
    \    io << \"->#{to}(#{cost})\"\n  end\nend\n\nstruct WeightedEdge2(T)\n  include\
    \ Comparable(WeightedEdge2(T))\n\n  property from : Int32, to : Int32, cost :\
    \ T\n\n  def initialize(@from, @to, @cost : T)\n  end\n\n  def initialize(@from,\
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
    \    false\n  end\n\n  def self.directed?\n    false\n  end\nend\n\n# require\
    \ \"./degree\"\n# require \"../graph\"\n\nmodule Graph(Edge, Edge2)\n  # Returns\
    \ table of indegree.\n  def indegree : Array(Int32)\n    each_with_object(Array.new(size,\
    \ 0)) do |edge, cnt|\n      cnt[edge.to] += 1\n    end\n  end\n\n  # Returns table\
    \ of outdegree.\n  def outdegree : Array(Int32)\n    each_with_object(Array.new(size,\
    \ 0)) do |edge, cnt|\n      cnt[edge.from] += 1\n    end\n  end\nend\n\nmodule\
    \ Graph(Edge, Edge2)\n  # Returns forest and cycle of the undirected graph with\
    \ equal number of vertices and edges.\n  def namori_decompose : {self, Array(Int32)}\n\
    \    raise ArgumentError.new if self.class.directed?\n    raise ArgumentError.new\
    \ unless size == graph.sum(&.size) // 2\n\n    deg = Array.new(size) { |i| self[i].size\
    \ }\n\n    que = Deque(Int32).new\n    flag = Array.new(size, false)\n    (0...size).each\
    \ do |i|\n      if deg[i] == 1\n        que << i\n        flag[i] = true\n   \
    \   end\n    end\n\n    forest = self.class.new(size)\n    while v = que.shift?\n\
    \      self[v].each do |edge|\n        next if flag[edge.to]\n        deg[edge.to]\
    \ -= 1\n        forest << Edge2.new(v, edge)\n        if deg[edge.to] == 1\n \
    \         que << edge.to\n          flag[edge.to] = true\n        end\n      end\n\
    \    end\n\n    cycle = [] of Int32\n    (0...size).each do |i|\n      que <<\
    \ i unless flag[i]\n      while v = que.pop?\n        next if flag[v]\n      \
    \  cycle << v\n        flag[v] = true\n        self[v].each do |edge|\n      \
    \    que << edge.to unless flag[edge.to]\n        end\n      end\n    end\n  \
    \  {forest, cycle}\n  end\nend\n\n# require \"../../src/graph/decompose\"\n# require\
    \ \"../graph\"\n\n# require \"../datastructure/union_find\"\nclass UnionFind\n\
    \  @d : Array(Int32)\n\n  def initialize(n : Int)\n    @d = Array.new(n, -1)\n\
    \  end\n\n  def initialize(n : Int, edges : Enumerable({Int32, Int32}))\n    initialize(n)\n\
    \    edges.each { |u, v| unite(u, v) }\n  end\n\n  def root(x : Int)\n    @d[x]\
    \ < 0 ? x : (@d[x] = root(@d[x]))\n  end\n\n  def unite(x : Int, y : Int)\n  \
    \  x = root(x)\n    y = root(y)\n    return false if x == y\n    x, y = y, x if\
    \ @d[x] > @d[y]\n    @d[x] += @d[y]\n    @d[y] = x\n    true\n  end\n\n  def same?(x\
    \ : Int, y : Int)\n    root(x) == root(y)\n  end\n\n  def size(x : Int)\n    -@d[root(x)]\n\
    \  end\n\n  def groups\n    groups = Hash(Int32, Set(Int32)).new { |h, k| h[k]\
    \ = Set(Int32).new }\n    @d.size.times do |i|\n      groups[root(i)] << i\n \
    \   end\n    groups.values.to_set\n  end\nend\n\nmodule Graph(Edge, Edge2)\n \
    \ # Decomposes the graph into each conected components.\n  def decompose : {Array(self),\
    \ Array({Int32, Int32}), Array(Array(Int32))}\n    uf = UnionFind.new(size)\n\
    \    each do |edge|\n      uf.unite(edge.from, edge.to)\n    end\n    groups =\
    \ uf.groups.to_a\n\n    index = Array.new(size, {-1, -1})\n    groups.each_with_index\
    \ do |group, i|\n      group.each_with_index do |v, j|\n        index[v] = {i,\
    \ j}\n      end\n    end\n\n    normalize = Array.new(groups.size) { |i| Array.new(groups[i].size,\
    \ -1) }\n    index.each_with_index { |(i, j), k| normalize[i][j] = k }\n\n   \
    \ graphs = Array.new(groups.size) { |i| self.class.new(groups[i].size) }\n   \
    \ if self.class.directed?\n      each do |edge|\n        i1, j1 = index[edge.from]\n\
    \        _, j2 = index[edge.to]\n        graphs[i1] << {j1, j2, edge.cost}\n \
    \     end\n    else\n      edge_set = Set(Edge2).new\n      each do |edge|\n \
    \       if edge_set.add?(edge.sort)\n          i1, j1 = index[edge.from]\n   \
    \       _, j2 = index[edge.to]\n          graphs[i1] << {j1, j2, edge.cost}\n\
    \        end\n      end\n    end\n    {graphs, index, normalize}\n  end\nend\n\
    \n# require \"../../src/scanner\"\n# ### Specifications\n#\n# ```plain\n# Inside\
    \ input macro                     | Expanded code\n# ---------------------------------------+---------------------------------------\n\
    # Uppercase string: Int32, Int64, etc.   | {}.new(Scanner.s)\n# s, c, i, iN, uN\
    \                        | Scanner.{}\n# Other lowercase string: f, big_i, etc.\
    \ | Scanner.s.to_{}\n# operator[]: type[size]                 | Array.new(input(size))\
    \ { input(type) }\n# Tuple literal: {t1, t2, t3}            | {input(t1), input(t2),\
    \ input(t3)}\n# Array literal: [t1, t2, t3]            | [input(t1), input(t2),\
    \ input(t3)]\n# Range literal: t1..t2                  | input(t1)..input(t2)\n\
    # If: cond ? t1 : t2                     | cond ? input(t1) : input(t2)\n# Assign:\
    \ target = value                 | target = input(value)\n# ```\n#\n# ### Examples\n\
    #\n# Input:\n# ```plain\n# 5 3\n# foo bar\n# 1 2 3 4 5\n# ```\n# ```\n# n, m =\
    \ input(Int32, Int64) # => {5, 5i64}\n# input(String, Char[m])     # => {\"foo\"\
    , ['b', 'a', 'r']}\n# input(Int32[n])            # => [1, 2, 3, 4, 5]\n# ```\n\
    # ```\n# n, m = input(i, i64) # => {5, 5i64}\n# input(s, c[m])       # => {\"\
    foo\", ['b', 'a', 'r']}\n# input(i[n])          # => [1, 2, 3, 4, 5]\n# ```\n\
    #\n# Input:\n# ```plain\n# 2 3\n# 1 2 3\n# 4 5 6\n# ```\n#\n# ```\n# h, w = input(i,\
    \ i) # => {2, 3}\n# input(i[h, w])     # => [[1, 2, 3], [4, 5, 6]]\n# ```\n# ```\n\
    # input(i[i][i]) # => [[1, 2, 3], [4, 5, 6]]\n# ```\n#\n# Input:\n# ```plain\n\
    # 5 3\n# 3 1 4 2 5\n# 1 2\n# 2 3\n# 3 1\n# ```\n# ```\n# n, m = input(i, i)  \
    \     # => {5, 3}\n# input(i.pred[n])         # => [2, 0, 3, 1, 4]\n# input({i\
    \ - 1, i - 1}[m]) # => [{0, 1}, {1, 2}, {2, 0}]\n# ```\n#\n# Input:\n# ```plain\n\
    # 3\n# 1 2\n# 2 2\n# 3 2\n# ```\n# ```\n# input({tmp = i, tmp == 1 ? i : i.pred}[i])\
    \ # => [{1, 2}, {2, 1}, {3, 1}]\n# ```\n#\n# Input:\n# ```plain\n# 3\n# 1 2\n\
    # 2 3\n# 3 1\n# ```\n# ```\n# n = input(i)\n# input_column({Int32, Int32}, n)\
    \ # => {[1, 2, 3], [2, 3, 1]}\n# ```\nmodule Scanner\n  extend self\n\n  private\
    \ def skip_to_not_space(io)\n    peek = io.peek\n    not_space = peek.index {\
    \ |x| x != 32 && x != 10 } || peek.size\n    io.skip(not_space)\n  end\n\n  def\
    \ c(io = STDIN)\n    skip_to_not_space(io)\n    io.read_char.not_nil!\n  end\n\
    \n  private def int(int_type : T.class, io = STDIN) : T forall T\n    skip_to_not_space(io)\n\
    \n    value = T.zero\n    signed = false\n    case x = io.read_byte\n    when\
    \ nil\n      raise IO::EOFError.new\n    when 45\n      signed = true\n    when\
    \ 48..57\n      value = T.new 48 &- x\n    else\n      raise \"Unexpected char:\
    \ #{x.chr}\"\n    end\n\n    loop do\n      peek = io.peek\n      return signed\
    \ ? value : -value if peek.empty?\n      i = 0\n      while i < peek.size\n  \
    \      c = peek.unsafe_fetch(i)\n        if 48 <= c <= 57\n          value = value\
    \ &* 10 &- c &+ 48\n          i &+= 1\n        elsif c == 32 || c == 10\n    \
    \      io.skip(i &+ 1)\n          return signed ? value : -value\n        else\n\
    \          raise \"Unexpected char: #{c.chr}\"\n        end\n      end\n     \
    \ io.skip(i)\n    end\n  end\n\n  private def uint(uint_type : T.class, io = STDIN)\
    \ : T forall T\n    skip_to_not_space(io)\n    value = T.zero\n    found_digit\
    \ = false\n    loop do\n      peek = io.peek\n      if peek.empty?\n        if\
    \ found_digit\n          return value\n        else\n          raise IO::EOFError.new\n\
    \        end\n      end\n      i = 0\n      while i < peek.size\n        c = peek.unsafe_fetch(i)\n\
    \        if 48 <= c <= 57\n          found_digit = true\n          value = value\
    \ &* 10 &+ c &- 48\n          i &+= 1\n        elsif c == 32 || c == 10\n    \
    \      io.skip(i &+ 1)\n          return value\n        else\n          raise\
    \ \"Unexpected char: #{c.chr}\"\n        end\n      end\n      io.skip(i)\n  \
    \  end\n  end\n\n  def i(io = STDIN)\n    int(Int32, io)\n  end\n\n  {% for n\
    \ in [8, 16, 32, 64, 128] %}\n    def i{{n}}(io = STDIN)\n      int(Int{{n}},\
    \ io)\n    end\n\n    def u{{n}}(io = STDIN)\n      uint(UInt{{n}}, io)\n    end\n\
    \  {% end %}\n\n  {% for method in [:f, :f32, :f64] %}\n    def {{method.id}}(io\
    \ = STDIN)\n      s(io).to_{{method.id}}\n    end\n  {% end %}\n\n  def s(io =\
    \ STDIN)\n    skip_to_not_space(io)\n\n    peek = io.peek\n    if peek.empty?\n\
    \      raise IO::EOFError.new\n    end\n    if index = peek.index { |x| x == 32\
    \ || x == 10 }\n      io.skip(index + 1)\n      return String.new(peek[0, index])\n\
    \    end\n\n    String.build do |buffer|\n      loop do\n        buffer.write\
    \ peek\n        io.skip(peek.size)\n        peek = io.peek\n        break if peek.empty?\n\
    \        if index = peek.index { |x| x == 32 || x == 10 }\n          buffer.write\
    \ peek[0, index]\n          io.skip(index + 1)\n          break\n        end\n\
    \      end\n    end\n  end\nend\n\nmacro internal_input(type, else_ast, io)\n\
    \  {% if Scanner.class.has_method?(type.id) %}\n    Scanner.{{type.id}}({{io}})\n\
    \  {% elsif type.stringify == \"String\" %}\n    Scanner.s({{io}})\n  {% elsif\
    \ type.stringify == \"Char\" %}\n    Scanner.c({{io}})\n  {% elsif type.is_a?(Path)\
    \ %}\n    {% if type.resolve.class.has_method?(:scan) %}\n      {{type}}.scan(Scanner)\n\
    \    {% else %}\n      {{type}}.new(Scanner.s({{io}}))\n    {% end %}\n  {% elsif\
    \ String.has_method?(\"to_#{type}\".id) %}\n    Scanner.s({{io}}).to_{{type.id}}\n\
    \  {% else %}\n    {{else_ast}}\n  {% end %}\nend\n\nmacro internal_input_array(type,\
    \ args)\n  {% for i in 0...args.size %}\n    %size{i} = input({{args[i]}})\n \
    \ {% end %}\n  {% begin %}\n    {% for i in 0...args.size %} Array.new(%size{i})\
    \ { {% end %}\n      input({{type.id}})\n    {% for i in 0...args.size %} } {%\
    \ end %}\n  {% end %}\nend\n\nmacro input(ast, *, io = STDIN)\n  {% if ast.is_a?(Call)\
    \ %}\n    {% if ast.receiver.is_a?(Nop) %}\n      internal_input(\n        {{ast.name}},\n\
    \        {{ast.name}}({% for argument in ast.args %} input({{argument}}), {% end\
    \ %}),\n        {{io}},\n      )\n    {% elsif ast.name.stringify == \"[]\" %}\n\
    \      internal_input_array({{ast.receiver}}, {{ast.args}})\n    {% else %}\n\
    \      input({{ast.receiver}}, io: {{io}}).{{ast.name}}(\n        {% for argument\
    \ in ast.args %} input({{argument}}), {% end %}\n      ) {{ast.block}}\n    {%\
    \ end %}\n  {% elsif ast.is_a?(TupleLiteral) %}\n    { {% for i in 0...ast.size\
    \ %} input({{ast[i]}}, io: {{io}}), {% end %} }\n  {% elsif ast.is_a?(ArrayLiteral)\
    \ %}\n    [ {% for i in 0...ast.size %} input({{ast[i]}}, io: {{io}}), {% end\
    \ %} ]\n  {% elsif ast.is_a?(RangeLiteral) %}\n    Range.new(\n      input({{ast.begin}},\
    \ io: {{io}}),\n      input({{ast.end}}, io: {{io}}),\n      {{ast.excludes_end?}},\n\
    \    )\n  {% elsif ast.is_a?(If) %}\n    {{ast.cond}} ? input({{ast.then}}, io:\
    \ {{io}}) : input({{ast.else}}, io: {{io}})\n  {% elsif ast.is_a?(Assign) %}\n\
    \    {{ast.target}} = input({{ast.value}}, io: {{io}})\n  {% else %}\n    internal_input({{ast}},\
    \ {{ast}}, io: {{io}})\n  {% end %}\nend\n\nmacro input(*asts, io = STDIN)\n \
    \ { {% for ast in asts %} input({{ast}}, io: {{io}}), {% end %} }\nend\n\nmacro\
    \ input_column(types, size)\n  {% for type, i in types %}\n    %array{i} = Array({{type}}).new({{size}})\n\
    \  {% end %}\n  {{size}}.times do\n    {% for type, i in types %}\n      %array{i}\
    \ << input({{type}})\n    {% end %}\n  end\n  { {% for type, i in types %} %array{i},\
    \ {% end %} }\nend\n\ndef dfs(graph, v, p, dist, a)\n  a[v] = dist\n  graph[v].each\
    \ do |edge|\n    next if edge.to == p\n    dfs(graph, edge.to, v, dist + 1, a)\n\
    \  end\nend\n\nn = input(i)\nedges = input({i - 1, i - 1}[n])\nans = Array(Int32?).new(n,\
    \ nil)\ng = UndirectedGraph.new n, edges.each_with_index.map { |(e, i)| {e[0],\
    \ e[1], i} }\ngraphs, _, normalize = g.decompose\n\ngraphs.zip(normalize) do |graph,\
    \ normalize|\n  if graph.size != graph.graph.sum(&.size) // 2\n    puts \"No\"\
    ; exit\n  end\n  forest, cycle = graph.namori_decompose\n\n  dist = [0] * graph.size\n\
    \  cycle_index = [nil.as Int32?] * graph.size\n  cycle.each_with_index do |v,\
    \ i|\n    cycle_index[v] = i\n    dfs(forest, v, -1, 0, dist)\n  end\n\n  flag\
    \ = false\n  graph.each do |edge|\n    d_from, d_to = dist[edge.from], dist[edge.to]\n\
    \    c_from, c_to = cycle_index[edge.from], cycle_index[edge.to]\n    if d_from\
    \ < d_to\n      ans[edge.cost] = normalize[edge.to]\n    elsif d_from == d_to\
    \ && c_from.not_nil! <= c_to.not_nil!\n      if {edge.from, edge.to} == {cycle.first,\
    \ cycle.last}\n        if cycle.size == 2\n          ans[edge.cost] = normalize[flag\
    \ ? edge.to : edge.from]\n          flag = true\n        else\n          ans[edge.cost]\
    \ = normalize[edge.to]\n        end\n      else\n        ans[edge.cost] = normalize[edge.from]\n\
    \      end\n    end\n  end\nend\n\nputs \"Yes\", ans.join('\\n', &.not_nil!.succ)\n"
  code: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/1640\n# verification-helper:\
    \ IGNORE\nrequire \"../../src/graph/namori_decompose\"\nrequire \"../../src/graph/decompose\"\
    \nrequire \"../../src/scanner\"\n\ndef dfs(graph, v, p, dist, a)\n  a[v] = dist\n\
    \  graph[v].each do |edge|\n    next if edge.to == p\n    dfs(graph, edge.to,\
    \ v, dist + 1, a)\n  end\nend\n\nn = input(i)\nedges = input({i - 1, i - 1}[n])\n\
    ans = Array(Int32?).new(n, nil)\ng = UndirectedGraph.new n, edges.each_with_index.map\
    \ { |(e, i)| {e[0], e[1], i} }\ngraphs, _, normalize = g.decompose\n\ngraphs.zip(normalize)\
    \ do |graph, normalize|\n  if graph.size != graph.graph.sum(&.size) // 2\n   \
    \ puts \"No\"; exit\n  end\n  forest, cycle = graph.namori_decompose\n\n  dist\
    \ = [0] * graph.size\n  cycle_index = [nil.as Int32?] * graph.size\n  cycle.each_with_index\
    \ do |v, i|\n    cycle_index[v] = i\n    dfs(forest, v, -1, 0, dist)\n  end\n\n\
    \  flag = false\n  graph.each do |edge|\n    d_from, d_to = dist[edge.from], dist[edge.to]\n\
    \    c_from, c_to = cycle_index[edge.from], cycle_index[edge.to]\n    if d_from\
    \ < d_to\n      ans[edge.cost] = normalize[edge.to]\n    elsif d_from == d_to\
    \ && c_from.not_nil! <= c_to.not_nil!\n      if {edge.from, edge.to} == {cycle.first,\
    \ cycle.last}\n        if cycle.size == 2\n          ans[edge.cost] = normalize[flag\
    \ ? edge.to : edge.from]\n          flag = true\n        else\n          ans[edge.cost]\
    \ = normalize[edge.to]\n        end\n      else\n        ans[edge.cost] = normalize[edge.from]\n\
    \      end\n    end\n  end\nend\n\nputs \"Yes\", ans.join('\\n', &.not_nil!.succ)\n"
  dependsOn:
  - src/graph/namori_decompose.cr
  - src/graph.cr
  - src/graph/edge.cr
  - src/graph/degree.cr
  - src/graph/decompose.cr
  - src/datastructure/union_find.cr
  - src/scanner.cr
  isVerificationFile: false
  path: test/graph/namori_decompose_test_.cr
  requiredBy: []
  timestamp: '2022-01-02 17:14:17+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/graph/namori_decompose_test_.cr
layout: document
redirect_from:
- /library/test/graph/namori_decompose_test_.cr
- /library/test/graph/namori_decompose_test_.cr.html
title: test/graph/namori_decompose_test_.cr
---
