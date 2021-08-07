---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/datastructure/imos_linear.cr
    title: src/datastructure/imos_linear.cr
  - icon: ':question:'
    path: src/scanner.cr
    title: src/scanner.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://yukicoder.me/problems/no/1008
  bundledCode: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/1008\n\
    # require \"../../src/datastructure/imos_linear\"\nclass ImosLinear(T)\n  getter\
    \ size : Int32\n  @builded = false\n\n  def initialize(@size : Int32)\n    @a\
    \ = Array(T).new(@size + 1, T.zero)\n    @b = Array(T).new(@size + 1, T.zero)\n\
    \  end\n\n  # Add `a + (i - l) * b` to `[l, r)`.\n  def add(start : Int, count\
    \ : Int, val_a : T, val_b : T) : Nil\n    raise \"self had been called `#build`\"\
    \ if @builded\n    raise ArgumentError.new \"Negative count: #{count}\" if count\
    \ < 0\n    @a[start] += val_a - val_b * start\n    @b[start] += val_b\n    @a[start\
    \ + count] -= val_a - val_b * start\n    @b[start + count] -= val_b\n  end\n\n\
    \  def add(range : Range, val_a : T, val_b : T) : Nil\n    start, count = Indexable.range_to_index_and_count(range,\
    \ size) || raise IndexError.new\n    add(start, count, val_a, val_b)\n  end\n\n\
    \  def build : Array(T)\n    raise \"self had been called `#build`\" if @builded\n\
    \    @builded = true\n    (0...size).map do |i|\n      @a[i + 1] += @a[i]\n  \
    \    @b[i + 1] += @b[i]\n      @a[i] + @b[i] * i\n    end\n  end\nend\n\n# require\
    \ \"../../src/scanner\"\n# ### Specifications\n#\n# ```plain\n# Inside input macro\
    \                            | Expanded code\n# ----------------------------------------------+---------------------------------------\n\
    # Uppercase string: Int32, Int64, Float64, etc. | {}.new(Scanner.s)\n# s     \
    \                                        | Scanner.s\n# c                    \
    \                         | Scanner.c\n# Other lowercase string: i, i64, f, etc.\
    \       | Scanner.s.to_{}\n# operator[]: type[size]                        | Array.new(input(size))\
    \ { input(type) }\n# Tuple literal: {t1, t2, t3}                   | {input(t1),\
    \ input(t2), input(t3)}\n# Array literal: [t1, t2, t3]                   | [input(t1),\
    \ input(t2), input(t3)]\n# Range literal: t1..t2                         | input(t1)..input(t2)\n\
    # If: cond ? t1 : t2                            | cond ? input(t1) : input(t2)\n\
    # Assign: target = value                        | target = input(value)\n# ```\n\
    #\n# ### Examples\n#\n# Input:\n# ```plain\n# 5 3\n# foo bar\n# 1 2 3 4 5\n# ```\n\
    # ```\n# n, m = input(Int32, Int64) # => {5, 10i64}\n# input(String, Char[m])\
    \     # => {\"foo\", ['b', 'a', 'r']}\n# input(Int32[n])            # => [1, 2,\
    \ 3, 4, 5]\n# ```\n# ```\n# n, m = input(i, i64) # => {5, 10i64}\n# input(s, c[m])\
    \       # => {\"foo\", ['b', 'a', 'r']}\n# input(i[n])          # => [1, 2, 3,\
    \ 4, 5]\n# ```\n#\n# Input:\n# ```plain\n# 2 3\n# 1 2 3\n# 4 5 6\n# ```\n#\n#\
    \ ```\n# h, w = input(i, i) # => {2, 3}\n# input(i[h, w])     # => [[1, 2, 3],\
    \ [4, 5, 6]]\n# ```\n# ```\n# input(i[i][i]) # => [[1, 2, 3], [4, 5, 6]]\n# ```\n\
    #\n# Input:\n# ```plain\n# 5 3\n# 3 1 4 2 5\n# 1 2\n# 2 3\n# 3 1\n# ```\n# ```\n\
    # n, m = input(i, i)       # => {5, 3}\n# input(i.pred[n])         # => [2, 0,\
    \ 3, 1, 4]\n# input({i - 1, i - 1}[m]) # => [{0, 1}, {1, 2}, {2, 0}]\n# ```\n\
    #\n# Input:\n# ```plain\n# 3\n# 1 2\n# 2 2\n# 3 2\n# ```\n# ```\n# input({tmp\
    \ = i, tmp == 1 ? i : i.pred}[i]) # => [{1, 2}, {2, 1}, {3, 1}]\n# ```\n#\n# Input:\n\
    # ```plain\n# 3\n# 1 2\n# 2 3\n# 3 1\n# ```\n# ```\n# n = input(i)\n# input_column({Int32,\
    \ Int32}, n) # => {[1, 2, 3], [2, 3, 1]}\n# ```\nclass Scanner\n  private def\
    \ self.skip_to_not_space\n    peek = STDIN.peek\n    not_space = peek.index {\
    \ |x| x != 32 && x != 10 } || peek.size\n    STDIN.skip(not_space)\n  end\n\n\
    \  def self.c\n    skip_to_not_space\n    STDIN.read_char.not_nil!\n  end\n\n\
    \  def self.s\n    skip_to_not_space\n\n    peek = STDIN.peek\n    if index =\
    \ peek.index { |x| x == 32 || x == 10 }\n      STDIN.skip(index + 1)\n      return\
    \ String.new(peek[0, index])\n    end\n\n    String.build do |buffer|\n      loop\
    \ do\n        buffer.write peek\n        STDIN.skip(peek.size)\n        peek =\
    \ STDIN.peek\n        break if peek.empty?\n        if index = peek.index { |x|\
    \ x == 32 || x == 10 }\n          buffer.write peek[0, index]\n          STDIN.skip(index)\n\
    \          break\n        end\n      end\n    end\n  end\nend\n\nmacro internal_input(type,\
    \ else_ast)\n  {% if Scanner.class.has_method?(type.id) %}\n    Scanner.{{type.id}}\n\
    \  {% elsif type.stringify == \"String\" %}\n    Scanner.s\n  {% elsif type.stringify\
    \ == \"Char\" %}\n    Scanner.c\n  {% elsif type.stringify =~ /[A-Z][a-z0-9_]*/\
    \ %}\n    {{type.id}}.new(Scanner.s)\n  {% elsif String.has_method?(\"to_#{type}\"\
    .id) %}\n    Scanner.s.to_{{type.id}}\n  {% else %}\n    {{else_ast}}\n  {% end\
    \ %}\nend\n\nmacro internal_input_array(type, args)\n  {% for i in 0...args.size\
    \ %}\n    %size{i} = input({{args[i]}})\n  {% end %}\n  {% begin %}\n    {% for\
    \ i in 0...args.size %} Array.new(%size{i}) { {% end %}\n      input({{type.id}})\n\
    \    {% for i in 0...args.size %} } {% end %}\n  {% end %}\nend\n\nmacro input(type)\n\
    \  {% if type.is_a?(Call) %}\n    {% if type.receiver.is_a?(Nop) %}\n      internal_input(\n\
    \        {{type.name}}, {{type.name}}(\n          {% for argument in type.args\
    \ %} input({{argument}}), {% end %}\n        )\n      )\n    {% elsif type.name.stringify\
    \ == \"[]\" %}\n      internal_input_array({{type.receiver}}, {{type.args}})\n\
    \    {% else %}\n      input({{type.receiver}}).{{type.name.id}}(\n        {%\
    \ for argument in type.args %} input({{argument}}), {% end %}\n      ) {{type.block}}\n\
    \    {% end %}\n  {% elsif type.is_a?(TupleLiteral) %}\n    { {% for i in 0...type.size\
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
    \nn, m = input(i, i)\na = input(i64[n])\nxw = input({i - 1, i64}[m])\n\nif xw.sum(&.[1])\
    \ < a.min\n  puts 0\n  exit\nend\n\nputs (1i64..10i64**9).bsearch { |c|\n  imos\
    \ = ImosLinear(Int64).new(n)\n  xw.each do |x, w|\n    imos.add(x..x, w, 0)\n\
    \    left = {x, w // c}.min\n    imos.add(x - left, left, w - c * left, c)\n \
    \   right = {n - 1 - x, w // c}.min\n    imos.add(x + 1, right, w - c, -c)\n \
    \ end\n  imos.build.zip(a).all? { |imos, a| imos < a }\n} || -1\n"
  code: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/1008\nrequire\
    \ \"../../src/datastructure/imos_linear\"\nrequire \"../../src/scanner\"\nn, m\
    \ = input(i, i)\na = input(i64[n])\nxw = input({i - 1, i64}[m])\n\nif xw.sum(&.[1])\
    \ < a.min\n  puts 0\n  exit\nend\n\nputs (1i64..10i64**9).bsearch { |c|\n  imos\
    \ = ImosLinear(Int64).new(n)\n  xw.each do |x, w|\n    imos.add(x..x, w, 0)\n\
    \    left = {x, w // c}.min\n    imos.add(x - left, left, w - c * left, c)\n \
    \   right = {n - 1 - x, w // c}.min\n    imos.add(x + 1, right, w - c, -c)\n \
    \ end\n  imos.build.zip(a).all? { |imos, a| imos < a }\n} || -1\n"
  dependsOn:
  - src/datastructure/imos_linear.cr
  - src/scanner.cr
  isVerificationFile: true
  path: test/datastructure/imos_linear_test.cr
  requiredBy: []
  timestamp: '2021-08-04 18:11:49+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/datastructure/imos_linear_test.cr
layout: document
redirect_from:
- /verify/test/datastructure/imos_linear_test.cr
- /verify/test/datastructure/imos_linear_test.cr.html
title: test/datastructure/imos_linear_test.cr
---
