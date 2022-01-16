---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/array/compress.cr
    title: src/array/compress.cr
  - icon: ':heavy_check_mark:'
    path: src/datastructure/imos_2d.cr
    title: src/datastructure/imos_2d.cr
  - icon: ':question:'
    path: src/scanner.cr
    title: src/scanner.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://onlinejudge.u-aizu.ac.jp/problems/DSL_4_A
  bundledCode: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/DSL_4_A\n\
    # require \"../../src/array/compress\"\nclass Array(T)\n  def compress(values\
    \ : Array(T), *, index : Int = 0)\n    map do |x|\n      index + values.bsearch_index\
    \ { |y| y >= x }.not_nil!\n    end\n  end\n\n  def compress(*, index : Int = 0)\
    \ : Array(Int32)\n    compress(uniq.sort!, index: index)\n  end\nend\n\n# require\
    \ \"../../src/datastructure/imos_2d\"\nclass Imos2D(T)\n  getter height : Int32,\
    \ width : Int32\n  @built = false\n\n  def initialize(@height, @width, init_val\
    \ : T = T.zero)\n    @table = Array(Array(T)).new(@height + 1) do\n      Array(T).new(@width\
    \ + 1, init_val)\n    end\n  end\n\n  def add(ys : Int, yc : Int, xs : Int, xc\
    \ : Int, val : T) : Nil\n    raise \"self had been called `#build`\" if @built\n\
    \    raise ArgumentError.new \"Negative count: #{yc}\" if yc < 0\n    raise ArgumentError.new\
    \ \"Negative count: #{xc}\" if xc < 0\n    @table[ys + yc][xs + xc] += val\n \
    \   @table[ys + yc][xs] -= val\n    @table[ys][xs + xc] -= val\n    @table[ys][xs]\
    \ += val\n  end\n\n  def add(y : Range, x : Range, val : T) : Nil\n    ys, yc\
    \ = Indexable.range_to_index_and_count(y, height) || raise IndexError.new\n  \
    \  xs, xc = Indexable.range_to_index_and_count(x, width) || raise IndexError.new\n\
    \    add(ys, yc, xs, xc, val)\n  end\n\n  def build : Array(Array(T))\n    raise\
    \ \"self had been called `#build`\" if @built\n    @built = true\n    (0..height).each\
    \ do |y|\n      (1..width).each do |x|\n        @table[y][x] += @table[y][x -\
    \ 1]\n      end\n    end\n    (1..height).each do |y|\n      (0..width).each do\
    \ |x|\n        @table[y][x] += @table[y - 1][x]\n      end\n    end\n    (0...height).map\
    \ { |i| @table[i][0...width] }\n  end\n\n  def [](y : Int32, x : Int32) : T\n\
    \    raise \"self had not been called `#build`\" unless @built\n    @table[y][x]\n\
    \  end\nend\n\n# require \"../../src/scanner\"\nmodule Scanner\n  extend self\n\
    \n  private def skip_to_not_space(io)\n    peek = io.peek\n    not_space = peek.index\
    \ { |x| x != 32 && x != 10 } || peek.size\n    io.skip(not_space)\n  end\n\n \
    \ def c(io = STDIN)\n    skip_to_not_space(io)\n    io.read_char.not_nil!\n  end\n\
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
    \ %}\n    {% if type.resolve.class.has_method?(:scan) %}\n      {{type}}.scan(Scanner,\
    \ {{io}})\n    {% else %}\n      {{type}}.new(Scanner.s({{io}}))\n    {% end %}\n\
    \  {% elsif String.has_method?(\"to_#{type}\".id) %}\n    Scanner.s({{io}}).to_{{type.id}}\n\
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
    \ {% end %} }\nend\n\nn = read_line.to_i\nx1, y1, x2, y2 = input_column({Int64,\
    \ Int64, Int64, Int64}, n)\n\nx_values = (x1 + x2).uniq.sort!\nxx = x_values.size\
    \ - 1\ncx1 = x1.compress(x_values)\ncx2 = x2.compress(x_values)\n\ny_values =\
    \ (y1 + y2).uniq.sort!\nyy = y_values.size - 1\ncy1 = y1.compress(y_values)\n\
    cy2 = y2.compress(y_values)\n\nimos = Imos2D(Int32).new(xx, yy)\ncx1.zip(cy1,\
    \ cx2, cy2) do |x1, y1, x2, y2|\n  imos.add(x1...x2, y1...y2, 1)\nend\nimos.build\n\
    \nputs (0...xx).sum { |i|\n  (0...yy).sum { |j|\n    (x_values[i + 1] - x_values[i])\
    \ * (y_values[j + 1] - y_values[j]) * imos[i, j].sign\n  }\n}\n"
  code: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/DSL_4_A\n\
    require \"../../src/array/compress\"\nrequire \"../../src/datastructure/imos_2d\"\
    \nrequire \"../../src/scanner\"\nn = read_line.to_i\nx1, y1, x2, y2 = input_column({Int64,\
    \ Int64, Int64, Int64}, n)\n\nx_values = (x1 + x2).uniq.sort!\nxx = x_values.size\
    \ - 1\ncx1 = x1.compress(x_values)\ncx2 = x2.compress(x_values)\n\ny_values =\
    \ (y1 + y2).uniq.sort!\nyy = y_values.size - 1\ncy1 = y1.compress(y_values)\n\
    cy2 = y2.compress(y_values)\n\nimos = Imos2D(Int32).new(xx, yy)\ncx1.zip(cy1,\
    \ cx2, cy2) do |x1, y1, x2, y2|\n  imos.add(x1...x2, y1...y2, 1)\nend\nimos.build\n\
    \nputs (0...xx).sum { |i|\n  (0...yy).sum { |j|\n    (x_values[i + 1] - x_values[i])\
    \ * (y_values[j + 1] - y_values[j]) * imos[i, j].sign\n  }\n}\n"
  dependsOn:
  - src/array/compress.cr
  - src/datastructure/imos_2d.cr
  - src/scanner.cr
  isVerificationFile: true
  path: test/array/compress_test.cr
  requiredBy: []
  timestamp: '2022-01-16 12:13:49+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/array/compress_test.cr
layout: document
redirect_from:
- /verify/test/array/compress_test.cr
- /verify/test/array/compress_test.cr.html
title: test/array/compress_test.cr
---
