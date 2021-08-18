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
    \ width : Int32\n  @builded = false\n\n  def initialize(@height, @width, init_val\
    \ : T = T.zero)\n    @table = Array(Array(T)).new(@height + 1) do\n      Array(T).new(@width\
    \ + 1, init_val)\n    end\n  end\n\n  def add(ys : Int, yc : Int, xs : Int, xc\
    \ : Int, val : T) : Nil\n    raise \"self had been called `build`\" if @builded\n\
    \    raise ArgumentError.new \"Negative count: #{yc}\" if yc < 0\n    raise ArgumentError.new\
    \ \"Negative count: #{xc}\" if xc < 0\n    @table[ys + yc][xs + xc] += val\n \
    \   @table[ys + yc][xs] -= val\n    @table[ys][xs + xc] -= val\n    @table[ys][xs]\
    \ += val\n  end\n\n  def add(y : Range, x : Range, val : T) : Nil\n    ys, yc\
    \ = Indexable.range_to_index_and_count(y, height) || raise IndexError.new\n  \
    \  xs, xc = Indexable.range_to_index_and_count(x, width) || raise IndexError.new\n\
    \    add(ys, yc, xs, xc, val)\n  end\n\n  def build : Array(Array(T))\n    raise\
    \ \"self had been called `#build`\" if @builded\n    @builded = true\n    (0..height).each\
    \ do |y|\n      (1..width).each do |x|\n        @table[y][x] += @table[y][x -\
    \ 1]\n      end\n    end\n    (1..height).each do |y|\n      (0..width).each do\
    \ |x|\n        @table[y][x] += @table[y - 1][x]\n      end\n    end\n    (0...height).map\
    \ { |i| @table[i][0...width] }\n  end\n\n  def [](y : Int32, x : Int32) : T\n\
    \    raise \"self had not been called `#build`\" unless @builded\n    @table[y][x]\n\
    \  end\nend\n\n# require \"../../src/scanner\"\n# ### Specifications\n#\n# ```plain\n\
    # Inside input macro                   | Expanded code\n# -------------------------------------+---------------------------------------\n\
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
    \nn = read_line.to_i\nx1, y1, x2, y2 = input_column({Int64, Int64, Int64, Int64},\
    \ n)\n\nx_values = (x1 + x2).uniq.sort!\nxx = x_values.size - 1\ncx1 = x1.compress(x_values)\n\
    cx2 = x2.compress(x_values)\n\ny_values = (y1 + y2).uniq.sort!\nyy = y_values.size\
    \ - 1\ncy1 = y1.compress(y_values)\ncy2 = y2.compress(y_values)\n\nimos = Imos2D(Int32).new(xx,\
    \ yy)\ncx1.zip(cy1, cx2, cy2) do |x1, y1, x2, y2|\n  imos.add(x1...x2, y1...y2,\
    \ 1)\nend\nimos.build\n\nputs (0...xx).sum { |i|\n  (0...yy).sum { |j|\n    (x_values[i\
    \ + 1] - x_values[i]) * (y_values[j + 1] - y_values[j]) * imos[i, j].sign\n  }\n\
    }\n"
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
  timestamp: '2021-08-09 09:32:32+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/array/compress_test.cr
layout: document
redirect_from:
- /verify/test/array/compress_test.cr
- /verify/test/array/compress_test.cr.html
title: test/array/compress_test.cr
---