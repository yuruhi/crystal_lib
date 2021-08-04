---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: src/math/matrix.cr
    title: src/math/matrix.cr
  - icon: ':x:'
    path: src/math/mint.cr
    title: src/math/mint.cr
  - icon: ':question:'
    path: src/scanner.cr
    title: src/scanner.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: true
  _pathExtension: cr
  _verificationStatusIcon: ':x:'
  attributes:
    PROBLEM: https://yukicoder.me/problems/no/997
  bundledCode: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/997\n\
    # require \"../../src/math/mint\"\nmacro static_modint(name, mod)\n  struct {{name}}\n\
    \    MOD = {{mod}}i64\n\n    def self.zero\n      new\n    end\n\n    def self.raw(value\
    \ : Int64)\n      result = new\n      result.value = value\n      result\n   \
    \ end\n\n    macro [](*nums)\n      {% verbatim do %}\n        Array({{@type}}).build({{nums.size}})\
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
    \    end\n\n    def to_i64 : Int64\n      value\n    end\n\n    delegate to_s,\
    \ to: @value\n    delegate inspect, to: @value\n  end\n\n  {% to = (\"to_\" +\
    \ name.stringify.downcase.gsub(/mint|modint/, \"m\")).id %}\n\n  struct Int\n\
    \    {% for op in %w[+ - * / //] %}\n      def {{op.id}}(value : {{name}})\n \
    \       {{to}} {{op.id}} value\n      end\n    {% end %}\n\n    {% for op in %w[<\
    \ <= > >=] %}\n      def {{op.id}}(m : {{name}})\n        raise NotImplementedError.new({{op}})\n\
    \      end\n    {% end %}\n\n    def {{to}} : {{name}}\n      {{name}}.new(self)\n\
    \    end\n  end\n\n  class String\n    def {{to}} : {{name}}\n      {{name}}.new(self)\n\
    \    end\n  end\nend\n\nstatic_modint(Mint, 1000000007)\nstatic_modint(Mint2,\
    \ 998244353)\n\n# require \"../../src/math/matrix\"\nclass Matrix(T)\n  include\
    \ Indexable(Array(T))\n\n  getter height : Int32, width : Int32\n  getter data\
    \ : Array(Array(T))\n\n  def Matrix.identity(size : Int32) : self\n    result\
    \ = Matrix(T).new(size, size)\n    (0...size).each do |i|\n      result[i][i]\
    \ = T.new(1)\n    end\n    result\n  end\n\n  def initialize(@height, @width,\
    \ init_value : T = T.zero)\n    @data = Array(Array(T)).new(height) { Array(T).new(width,\
    \ init_value) }\n  end\n\n  def initialize(init_matrix : Array(Array(T)))\n  \
    \  @height = init_matrix.size\n    @width = init_matrix[0].size\n    raise ArgumentError.new\
    \ unless init_matrix.all? { |a| a.size == width }\n    @data = init_matrix\n \
    \ end\n\n  delegate size, to: @data\n  delegate unsafe_fetch, to: @data\n\n  def\
    \ +(other : self)\n    IndexError.new unless height == other.height && width ==\
    \ other.width\n    result = Matrix(T).new(height, width)\n    (0...height).each\
    \ do |i|\n      (0...width).each do |j|\n        result[i][j] = data[i][j] + other[i][j]\n\
    \      end\n    end\n    result\n  end\n\n  def -(other : self)\n    IndexError.new\
    \ unless height == other.height && width == other.width\n    result = Matrix(T).new(height,\
    \ width)\n    (0...height).each do |i|\n      (0...width).each do |j|\n      \
    \  result[i][j] = data[i][j] - other[i][j]\n      end\n    end\n    result\n \
    \ end\n\n  def *(other : self)\n    IndexError.new unless width == other.height\n\
    \    result = Matrix(T).new(height, other.width)\n    (0...height).each do |i|\n\
    \      (0...other.width).each do |j|\n        (0...width).each do |k|\n      \
    \    result[i][j] += data[i][k] * other[k][j]\n        end\n      end\n    end\n\
    \    result\n  end\n\n  def **(k : Int)\n    result = Matrix(T).identity(height)\n\
    \    memo = Matrix.new(data)\n    while k > 0\n      result *= memo if k.odd?\n\
    \      memo *= memo\n      k >>= 1\n    end\n    result\n  end\n\n  def to_s(io)\
    \ : Nil\n    io << data\n  end\nend\n\n# require \"../../src/scanner\"\n# ###\
    \ Specifications\n#\n# ```plain\n# Inside input macro                        \
    \    | Expanded code\n# ----------------------------------------------+---------------------------------------\n\
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
    \nn, w, k = input(i, i, i64)\na = input(i[n])\n\ndp = Array.new(2 * w + 1) { [0.to_m,\
    \ 0.to_m] }\ndp[0][0] = 1.to_m\n(1..2 * w).each do |i|\n  (0...n).each do |j|\n\
    \    i2 = i - a[j]\n    dp[i][0] += dp[i2][0] if 0 <= i2\n    dp[i][1] += dp[i2][1]\
    \ if 0 <= i2\n    dp[i][1] += dp[i2][0] if 0 <= i2 < w < i\n  end\nend\n\nval1,\
    \ val2 = dp[w][0], dp[2 * w][1]\nx = Matrix.new([[val1, val2], [1.to_m, 0.to_m]])\n\
    y = Matrix.new([[val1], [1.to_m]])\nputs (x**k * y)[1][0]\n"
  code: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/997\nrequire\
    \ \"../../src/math/mint\"\nrequire \"../../src/math/matrix\"\nrequire \"../../src/scanner\"\
    \nn, w, k = input(i, i, i64)\na = input(i[n])\n\ndp = Array.new(2 * w + 1) { [0.to_m,\
    \ 0.to_m] }\ndp[0][0] = 1.to_m\n(1..2 * w).each do |i|\n  (0...n).each do |j|\n\
    \    i2 = i - a[j]\n    dp[i][0] += dp[i2][0] if 0 <= i2\n    dp[i][1] += dp[i2][1]\
    \ if 0 <= i2\n    dp[i][1] += dp[i2][0] if 0 <= i2 < w < i\n  end\nend\n\nval1,\
    \ val2 = dp[w][0], dp[2 * w][1]\nx = Matrix.new([[val1, val2], [1.to_m, 0.to_m]])\n\
    y = Matrix.new([[val1], [1.to_m]])\nputs (x**k * y)[1][0]\n"
  dependsOn:
  - src/math/mint.cr
  - src/math/matrix.cr
  - src/scanner.cr
  isVerificationFile: true
  path: test/math/matrix_test.cr
  requiredBy: []
  timestamp: '2021-08-04 18:11:49+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: test/math/matrix_test.cr
layout: document
redirect_from:
- /verify/test/math/matrix_test.cr
- /verify/test/math/matrix_test.cr.html
title: test/math/matrix_test.cr
---
