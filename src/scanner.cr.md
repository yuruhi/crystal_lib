---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: benchmarks/scanner.cr
    title: benchmarks/scanner.cr
  - icon: ':warning:'
    path: spec/scanner_spec.cr
    title: spec/scanner_spec.cr
  - icon: ':warning:'
    path: src/template.cr
    title: src/template.cr
  - icon: ':warning:'
    path: test/graph/namori_decompose_test_.cr
    title: test/graph/namori_decompose_test_.cr
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/collection/compress_test.cr
    title: test/collection/compress_test.cr
  - icon: ':heavy_check_mark:'
    path: test/datastructure/cul_sum_2d_2_test.cr
    title: test/datastructure/cul_sum_2d_2_test.cr
  - icon: ':heavy_check_mark:'
    path: test/datastructure/cul_sum_2d_imos_2d_test.cr
    title: test/datastructure/cul_sum_2d_imos_2d_test.cr
  - icon: ':heavy_check_mark:'
    path: test/datastructure/imos_linear_test.cr
    title: test/datastructure/imos_linear_test.cr
  - icon: ':heavy_check_mark:'
    path: test/datastructure/partially_persistent_union_find_test.cr
    title: test/datastructure/partially_persistent_union_find_test.cr
  - icon: ':heavy_check_mark:'
    path: test/dp/knapsack01_test.cr
    title: test/dp/knapsack01_test.cr
  - icon: ':heavy_check_mark:'
    path: test/dp/knapsack_test.cr
    title: test/dp/knapsack_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/bfs01_test.cr
    title: test/graph/bfs01_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/bfs_test.cr
    title: test/graph/bfs_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/bipartite_graph_test.cr
    title: test/graph/bipartite_graph_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/bipartite_matching_edges_test.cr
    title: test/graph/bipartite_matching_edges_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/bipartite_matching_test.cr
    title: test/graph/bipartite_matching_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/components_test.cr
    title: test/graph/components_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/compress_degree_test.cr
    title: test/graph/compress_degree_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/decompose_test.cr
    title: test/graph/decompose_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/detect_cycle_for_directed_graph_test.cr
    title: test/graph/detect_cycle_for_directed_graph_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/detect_cycle_for_undirected_graph_test.cr
    title: test/graph/detect_cycle_for_undirected_graph_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/diameter_test.cr
    title: test/graph/diameter_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/dijkstra_path_test.cr
    title: test/graph/dijkstra_path_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/dijkstra_test.cr
    title: test/graph/dijkstra_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/euler_tour_for_vertex_test.cr
    title: test/graph/euler_tour_for_vertex_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/kruskal_test.cr
    title: test/graph/kruskal_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/lca_test.cr
    title: test/graph/lca_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/namori_decompose_test.cr
    title: test/graph/namori_decompose_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/re_rooting_test.cr
    title: test/graph/re_rooting_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/scc_test.cr
    title: test/graph/scc_test.cr
  - icon: ':heavy_check_mark:'
    path: test/math/matrix_product_test.cr
    title: test/math/matrix_product_test.cr
  - icon: ':heavy_check_mark:'
    path: test/math/matrix_test.cr
    title: test/math/matrix_test.cr
  - icon: ':heavy_check_mark:'
    path: test/math/ntt_test.cr
    title: test/math/ntt_test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "module Scanner\n  extend self\n\n  private def skip_to_not_space(io)\n\
    \    peek = io.peek\n    not_space = peek.index { |x| x != 32 && x != 10 } ||\
    \ peek.size\n    io.skip(not_space)\n  end\n\n  def c(io = STDIN)\n    skip_to_not_space(io)\n\
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
    \ input_column(types, size, *, io = STDIN)\n  %size = {{size}}\n  {% for type,\
    \ i in types %}\n    %array{i} = Array({{type}}).new(%size)\n  {% end %}\n  %size.times\
    \ do\n    {% for type, i in types %}\n      %array{i} << input({{type}}, io: {{io}})\n\
    \    {% end %}\n  end\n  { {% for type, i in types %} %array{i}, {% end %} }\n\
    end\n"
  code: "module Scanner\n  extend self\n\n  private def skip_to_not_space(io)\n  \
    \  peek = io.peek\n    not_space = peek.index { |x| x != 32 && x != 10 } || peek.size\n\
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
    \ input_column(types, size, *, io = STDIN)\n  %size = {{size}}\n  {% for type,\
    \ i in types %}\n    %array{i} = Array({{type}}).new(%size)\n  {% end %}\n  %size.times\
    \ do\n    {% for type, i in types %}\n      %array{i} << input({{type}}, io: {{io}})\n\
    \    {% end %}\n  end\n  { {% for type, i in types %} %array{i}, {% end %} }\n\
    end\n"
  dependsOn: []
  isVerificationFile: false
  path: src/scanner.cr
  requiredBy:
  - benchmarks/scanner.cr
  - spec/scanner_spec.cr
  - src/template.cr
  - test/graph/namori_decompose_test_.cr
  timestamp: '2022-04-10 01:35:43+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/math/matrix_product_test.cr
  - test/math/matrix_test.cr
  - test/math/ntt_test.cr
  - test/graph/scc_test.cr
  - test/graph/namori_decompose_test.cr
  - test/graph/diameter_test.cr
  - test/graph/dijkstra_path_test.cr
  - test/graph/detect_cycle_for_directed_graph_test.cr
  - test/graph/dijkstra_test.cr
  - test/graph/bfs_test.cr
  - test/graph/compress_degree_test.cr
  - test/graph/bfs01_test.cr
  - test/graph/euler_tour_for_vertex_test.cr
  - test/graph/kruskal_test.cr
  - test/graph/bipartite_matching_test.cr
  - test/graph/decompose_test.cr
  - test/graph/bipartite_matching_edges_test.cr
  - test/graph/lca_test.cr
  - test/graph/detect_cycle_for_undirected_graph_test.cr
  - test/graph/bipartite_graph_test.cr
  - test/graph/re_rooting_test.cr
  - test/graph/components_test.cr
  - test/dp/knapsack_test.cr
  - test/dp/knapsack01_test.cr
  - test/collection/compress_test.cr
  - test/datastructure/imos_linear_test.cr
  - test/datastructure/partially_persistent_union_find_test.cr
  - test/datastructure/cul_sum_2d_imos_2d_test.cr
  - test/datastructure/cul_sum_2d_2_test.cr
documentation_of: src/scanner.cr
layout: document
redirect_from:
- /library/src/scanner.cr
- /library/src/scanner.cr.html
title: src/scanner.cr
---
