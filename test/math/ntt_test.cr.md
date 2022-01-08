---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: src/math/mint.cr
    title: src/math/mint.cr
  - icon: ':x:'
    path: src/math/ntt.cr
    title: src/math/ntt.cr
  - icon: ':question:'
    path: src/scanner.cr
    title: src/scanner.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: true
  _pathExtension: cr
  _verificationStatusIcon: ':x:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/convolution_mod
  bundledCode: "# verification-helper: PROBLEM https://judge.yosupo.jp/problem/convolution_mod\n\
    # require \"../../src/math/ntt\"\n# reference : https://kopricky.github.io/code/FFTs/ntt.html\n\
    class NTT\n  ROOT = 3\n\n  private def self.ntt(a : Array(T), rev = false) forall\
    \ T\n    return a if a.size == 1\n    b = Array.new(a.size, T.zero)\n    r = T::MOD.pred\
    \ // a.size\n    r = T::MOD.pred - r if rev\n    s = T.new(ROOT) ** r\n    kp\
    \ = Array.new(a.size // 2 + 1, T.new(1))\n    (1...kp.size).each { |i| kp[i] =\
    \ kp[i - 1] * s }\n\n    i, l = 1, a.size // 2\n    while i < a.size\n      r\
    \ = 0\n      (0...l).each do |j|\n        s = kp[i * j]\n        (0...i).each\
    \ do |k|\n          p, q = a[k + r], a[k + r + a.size // 2]\n          b[k + 2\
    \ * r] = p + q\n          b[k + 2 * r + i] = (p - q) * s\n        end\n      \
    \  r += i\n      end\n      a, b = b, a\n      i <<= 1; l >>= 1\n    end\n   \
    \ if rev\n      s = T.new(a.size).inv\n      a.map! { |x| x * s }\n    end\n \
    \   a\n  end\n\n  def self.convolution(a : Array(T), b : Array(T)) forall T\n\
    \    size = a.size + b.size - 1\n    t = Math.pw2ceil(size)\n    aa = a + Array.new(t\
    \ - a.size, T.zero)\n    bb = b + Array.new(t - b.size, T.zero)\n    c = ntt(aa).zip(ntt(bb)).map\
    \ { |x, y| x * y }\n    ntt(c, true).first(size)\n  end\nend\n\n# require \"../../src/math/mint\"\
    \nmacro static_modint(name, mod)\n  struct {{name}}\n    MOD = {{mod}}i64\n\n\
    \    def self.zero\n      new\n    end\n\n    def self.raw(value : Int64)\n  \
    \    result = new\n      result.value = value\n      result\n    end\n\n    macro\
    \ [](*nums)\n      {% verbatim do %}\n        Array({{@type}}).build({{nums.size}})\
    \ do |%buffer|\n          {% for num, i in nums %}\n            %buffer[{{i}}]\
    \ = {{@type}}.new({{num}})\n          {% end %}\n          {{nums.size}}\n   \
    \     end\n      {% end %}\n    end\n\n    getter value : Int64\n\n    def initialize\n\
    \      @value = 0i64\n    end\n\n    def initialize(value)\n      @value = value.to_i64\
    \ % MOD\n    end\n\n    def initialize(m : self)\n      @value = m.value\n   \
    \ end\n\n    protected def value=(value : Int64)\n      @value = value\n    end\n\
    \n    def ==(m : self)\n      value == m.value\n    end\n\n    def ==(m)\n   \
    \   value == m\n    end\n\n    def + : self\n      self\n    end\n\n    def -\
    \ : self\n      self.class.raw(value != 0 ? MOD &- value : 0i64)\n    end\n\n\
    \    def +(v)\n      self + self.class.new(v)\n    end\n\n    def +(m : self)\n\
    \      x = value &+ m.value\n      x &-= MOD if x >= MOD\n      self.class.raw(x)\n\
    \    end\n\n    def -(v)\n      self - self.class.new(v)\n    end\n\n    def -(m\
    \ : self)\n      x = value &- m.value\n      x &+= MOD if x < 0\n      self.class.raw(x)\n\
    \    end\n\n    def *(v)\n      self * self.class.new(v)\n    end\n\n    def *(m\
    \ : self)\n      self.class.new(value &* m.value)\n    end\n\n    def /(v)\n \
    \     self / self.class.new(v)\n    end\n\n    def /(m : self)\n      raise DivisionByZeroError.new\
    \ if m.value == 0\n      a, b, u, v = m.value, MOD, 1i64, 0i64\n      while b\
    \ != 0\n        t = a // b\n        a &-= t &* b\n        a, b = b, a\n      \
    \  u &-= t &* v\n        u, v = v, u\n      end\n      self.class.new(value &*\
    \ u)\n    end\n\n    def //(v)\n      self / v\n    end\n\n    def **(exponent\
    \ : Int)\n      t, res = self, self.class.raw(1i64)\n      while exponent > 0\n\
    \        res *= t if exponent & 1 == 1\n        t *= t\n        exponent >>= 1\n\
    \      end\n      res\n    end\n\n    {% for op in %w[< <= > >=] %}\n      def\
    \ {{op.id}}(other)\n        raise NotImplementedError.new({{op}})\n      end\n\
    \    {% end %}\n\n    def inv\n      self.class.raw(1) // self\n    end\n\n  \
    \  def succ\n      self.class.raw(value != MOD &- 1 ? value &+ 1 : 0i64)\n   \
    \ end\n\n    def pred\n      self.class.raw(value != 0 ? value &- 1 : MOD &- 1)\n\
    \    end\n\n    def abs\n      self\n    end\n\n    def abs2\n      self * self\n\
    \    end\n\n    def to_i64 : Int64\n      value\n    end\n\n    def to_s(io :\
    \ IO) : Nil\n      value.to_s(io)\n    end\n\n    def inspect(io : IO) : Nil\n\
    \      value.inspect(io)\n    end\n  end\n\n  {% to = (\"to_\" + name.stringify.downcase.gsub(/mint|modint/,\
    \ \"m\")).id %}\n\n  struct Int\n    {% for op in %w[+ - * / //] %}\n      def\
    \ {{op.id}}(value : {{name}})\n        {{to}} {{op.id}} value\n      end\n   \
    \ {% end %}\n\n    {% for op in %w[< <= > >=] %}\n      def {{op.id}}(m : {{name}})\n\
    \        raise NotImplementedError.new({{op}})\n      end\n    {% end %}\n\n \
    \   def {{to}} : {{name}}\n      {{name}}.new(self)\n    end\n  end\n\n  class\
    \ String\n    def {{to}} : {{name}}\n      {{name}}.new(self)\n    end\n  end\n\
    end\n\nstatic_modint(Mint, 1000000007)\nstatic_modint(Mint2, 998244353)\n\n# require\
    \ \"../../src/scanner\"\nmodule Scanner\n  extend self\n\n  private def skip_to_not_space(io)\n\
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
    \ io: {{io}}),\n      {{ast.excludes_end?}},\n    )\n  {% elsif ast.is_a?(Expressions)\
    \ %}\n    ( {% for exp in ast.expressions %} input({{exp}}, io: {{io}}); {% end\
    \ %} )\n  {% elsif ast.is_a?(If) %}\n    input({{ast.cond}}, io: {{io}}) ? input({{ast.then}},\
    \ io: {{io}}) : input({{ast.else}}, io: {{io}})\n  {% elsif ast.is_a?(Assign)\
    \ %}\n    {{ast.target}} = input({{ast.value}}, io: {{io}})\n  {% else %}\n  \
    \  internal_input({{ast}}, {{ast}}, io: {{io}})\n  {% end %}\nend\n\nmacro input(*asts,\
    \ io = STDIN)\n  { {% for ast in asts %} input({{ast}}, io: {{io}}), {% end %}\
    \ }\nend\n\nmacro input_column(types, size)\n  {% for type, i in types %}\n  \
    \  %array{i} = Array({{type}}).new({{size}})\n  {% end %}\n  {{size}}.times do\n\
    \    {% for type, i in types %}\n      %array{i} << input({{type}})\n    {% end\
    \ %}\n  end\n  { {% for type, i in types %} %array{i}, {% end %} }\nend\n\nn,\
    \ m = input(i, i)\na, b = input(m2[n], m2[(m)])\nputs NTT.convolution(a, b).join('\
    \ ')\n"
  code: '# verification-helper: PROBLEM https://judge.yosupo.jp/problem/convolution_mod

    require "../../src/math/ntt"

    require "../../src/math/mint"

    require "../../src/scanner"

    n, m = input(i, i)

    a, b = input(m2[n], m2[(m)])

    puts NTT.convolution(a, b).join('' '')

    '
  dependsOn:
  - src/math/ntt.cr
  - src/math/mint.cr
  - src/scanner.cr
  isVerificationFile: true
  path: test/math/ntt_test.cr
  requiredBy: []
  timestamp: '2022-01-08 20:25:18+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: test/math/ntt_test.cr
layout: document
redirect_from:
- /verify/test/math/ntt_test.cr
- /verify/test/math/ntt_test.cr.html
title: test/math/ntt_test.cr
---
