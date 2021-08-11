---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/array/change.cr
    title: src/array/change.cr
  - icon: ':x:'
    path: src/array/new.cr
    title: src/array/new.cr
  - icon: ':warning:'
    path: src/comparable/min_max.cr
    title: src/comparable/min_max.cr
  - icon: ':question:'
    path: src/scanner.cr
    title: src/scanner.cr
  - icon: ':heavy_check_mark:'
    path: src/tuple/times.cr
    title: src/tuple/times.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "# require \"./tuple/times\"\nstruct Tuple\n  def times(&block) : Nil\n\
    \    {% begin %}\n      {% for i in 0...@type.size %}\n        {% if @type[i].has_method?(:each)\
    \ %}\n          self[{{i}}].each do |i{{i}}|\n        {% else %}\n          self[{{i}}].times\
    \ do |i{{i}}|\n        {% end %}\n      {% end %}\n      yield({% for i in 0...@type.size\
    \ %} i{{i}}, {% end %})\n      {% for i in 0...@type.size %} end {% end %}\n \
    \   {% end %}\n  end\n\n  private class TimesIterator(T)\n    include Iterator(T)\n\
    \n    def initialize(@n : T)\n      tuple = {% begin %}\n                { {%\
    \ for i in 0...T.size %} T[{{i}}].zero, {% end %} }\n              {% end %}\n\
    \      @index = tuple.as(T)\n      @first = true\n    end\n\n    def next\n  \
    \    if @first\n        @first = false\n        return @index\n      end\n   \
    \   {% begin %}\n        {%\n          type = @type.type_vars[0]\n          size\
    \ = type.size\n        %}\n        {% for i in 1..size %}\n          if @index[{{size\
    \ - i}}] < @n[{{size - i}}] - 1\n            @index = {\n              {% for\
    \ j in 0...size %}\n                {% if j < size - i %}\n                  @index[{{j}}],\n\
    \                {% elsif j == size - i %}\n                  @index[{{j}}] +\
    \ 1,\n                {% else %}\n                  {{type[j]}}.zero,\n      \
    \          {% end %}\n              {% end %}\n            }\n            return\
    \ @index\n          end\n        {% end %}\n        stop\n      {% end %}\n  \
    \  end\n  end\n\n  def times\n    TimesIterator(self).new(self)\n  end\nend\n\n\
    # require \"./comparable/min_max\"\nmodule Comparable(T)\n  def min(x : T)\n \
    \   self > x ? x : self\n  end\n\n  def max(x : T)\n    self < x ? x : self\n\
    \  end\nend\n\n# require \"./array/new\"\nclass Array\n  def self.new(sizes :\
    \ Tuple(*T), initial_value) forall T\n    {% begin %}\n      {% for i in 0...T.size\
    \ %} Array.new(sizes[{{i}}]) { {% end %}\n      initial_value\n      {% for i\
    \ in 0...T.size %} } {% end %}\n    {% end %}\n  end\n\n  def self.new(sizes :\
    \ Tuple(*T), &block) forall T\n    {% begin %}\n      {% for i in 0...T.size %}\
    \ Array.new(sizes[{{i}}]) { |index{{i}}| {% end %}\n      yield({% for i in 0...T.size\
    \ %} index{{i}}, {% end %})\n      {% for i in 0...T.size %} } {% end %}\n   \
    \ {% end %}\n  end\nend\n\n# require \"./array/change\"\nclass Array(T)\n  def\
    \ chmin(i : Int, value : T)\n    (self[i] > value).tap do |f|\n      self[i] =\
    \ value if f\n    end\n  end\n\n  protected def chmin(i : Int, *indexes, value)\n\
    \    self[i].chmin(*indexes, value: value)\n  end\n\n  def chmin(indexes : Tuple,\
    \ value)\n    chmin(*indexes, value: value)\n  end\n\n  def chmax(i : Int, value\
    \ : T)\n    (self[i] < value).tap do |f|\n      self[i] = value if f\n    end\n\
    \  end\n\n  protected def chmax(i : Int, *indexes, value)\n    self[i].chmax(*indexes,\
    \ value: value)\n  end\n\n  def chmax(indexes : Tuple, value)\n    chmax(*indexes,\
    \ value: value)\n  end\nend\n\n# require \"./scanner\"\n# ### Specifications\n\
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
    \ {% end %}\n  end\n  { {% for type, i in types %} %array{i}, {% end %} }\nend\n"
  code: 'require "./tuple/times"

    require "./comparable/min_max"

    require "./array/new"

    require "./array/change"

    require "./scanner"

    '
  dependsOn:
  - src/tuple/times.cr
  - src/comparable/min_max.cr
  - src/array/new.cr
  - src/array/change.cr
  - src/scanner.cr
  isVerificationFile: false
  path: src/template.cr
  requiredBy: []
  timestamp: '2021-08-09 09:32:32+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/template.cr
layout: document
redirect_from:
- /library/src/template.cr
- /library/src/template.cr.html
title: src/template.cr
---
