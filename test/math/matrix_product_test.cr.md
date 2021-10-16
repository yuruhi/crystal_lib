---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/math/matrix.cr
    title: src/math/matrix.cr
  - icon: ':heavy_check_mark:'
    path: src/math/mint.cr
    title: src/math/mint.cr
  - icon: ':heavy_check_mark:'
    path: src/scanner.cr
    title: src/scanner.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/matrix_product
  bundledCode: "# verification-helper: PROBLEM https://judge.yosupo.jp/problem/matrix_product\n\
    # require \"../../src/math/matrix\"\nclass Matrix(T)\n  include Indexable(Array(T))\n\
    \n  def Matrix.identity(size : Int32) : self\n    result = Matrix(T).new(size,\
    \ size, T.zero)\n    (0...size).each do |i|\n      result[i][i] = T.new(1)\n \
    \   end\n    result\n  end\n\n  macro [](*args)\n    Matrix.new [{{args.splat}}]\n\
    \  end\n\n  getter height : Int32, width : Int32, data : Array(Array(T))\n\n \
    \ def initialize\n    @height = 0\n    @width = 0\n    @data = Array(Array(T)).new\n\
    \  end\n\n  def initialize(@height, @width, value : T)\n    raise ArgumentError.new(\"\
    Negative matrix height: #{@height}\") unless @height >= 0\n    raise ArgumentError.new(\"\
    Negative matrix width: #{@width}\") unless @width >= 0\n    @data = Array.new(height)\
    \ { Array(T).new(width, value) }\n  end\n\n  def initialize(@height, @width, &block\
    \ : Int32, Int32 -> T)\n    raise ArgumentError.new(\"Negative matrix height:\
    \ #{@height}\") unless @height >= 0\n    raise ArgumentError.new(\"Negative matrix\
    \ width: #{@width}\") unless @width >= 0\n    @data = Array.new(height) { |i|\
    \ Array.new(width) { |j| yield i, j } }\n  end\n\n  def initialize(@data : Array(Array(T)))\n\
    \    @height = @data.size\n    @width = @data[0].size\n    raise ArgumentError.new\
    \ unless @data.all? { |a| a.size == width }\n  end\n\n  delegate size, to: @data\n\
    \  delegate unsafe_fetch, to: @data\n\n  private def check_index_out_of_bounds(i,\
    \ j)\n    check_index_out_of_bounds(i, j) { raise IndexError.new }\n  end\n\n\
    \  private def check_index_out_of_bounds(i, j)\n    i += height if i < 0\n   \
    \ j += width if j < 0\n    if 0 <= i < height && 0 <= j < width\n      {i, j}\n\
    \    else\n      yield\n    end\n  end\n\n  def fetch(i : Int, j : Int, &)\n \
    \   i, j = check_index_out_of_bounds(i, j) { return yield i, j }\n    unsafe_fetch(i,\
    \ j)\n  end\n\n  def fetch(i : Int, j : Int, default)\n    fetch(i, j) { default\
    \ }\n  end\n\n  def [](i : Int, j : Int) : T\n    fetch(i, j) { raise IndexError.new\
    \ }\n  end\n\n  def []?(i : Int, j : Int) : T?\n    fetch(i, j, nil)\n  end\n\n\
    \  def unsafe_fetch(i : Int, j : Int) : T\n    @data.unsafe_fetch(i).unsafe_fetch(j)\n\
    \  end\n\n  def +(other : self)\n    raise IndexError.new unless height == other.height\
    \ && width == other.width\n    Matrix(T).new(height, width) { |i, j|\n      unsafe_fetch(i,\
    \ j) + other.unsafe_fetch(i, j)\n    }\n  end\n\n  def -(other : self)\n    raise\
    \ IndexError.new unless height == other.height && width == other.width\n    Matrix(T).new(height,\
    \ width) { |i, j|\n      unsafe_fetch(i, j) - other.unsafe_fetch(i, j)\n    }\n\
    \  end\n\n  def *(other : self)\n    raise IndexError.new unless width == other.height\n\
    \    Matrix(T).new(height, other.width) { |i, j|\n      (0...width).sum { |k|\
    \ unsafe_fetch(i, k) * other.unsafe_fetch(k, j) }\n    }\n  end\n\n  def **(k\
    \ : Int)\n    result = Matrix(T).identity(height)\n    memo = Matrix.new(data)\n\
    \    while k > 0\n      result *= memo if k.odd?\n      memo *= memo\n      k\
    \ >>= 1\n    end\n    result\n  end\n\n  def ==(other : Matrix)\n    return false\
    \ unless height == other.height && width == other.width\n    data == other.data\n\
    \  end\n\n  def to_s(io) : Nil\n    io << data\n  end\n\n  def inspect(io) : Nil\n\
    \    io << \"Matrix\" << data\n  end\nend\n\n# require \"../../src/math/mint\"\
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
    \    end\n\n    def to_i64 : Int64\n      value\n    end\n\n    delegate to_s,\
    \ to: @value\n    delegate inspect, to: @value\n  end\n\n  {% to = (\"to_\" +\
    \ name.stringify.downcase.gsub(/mint|modint/, \"m\")).id %}\n\n  struct Int\n\
    \    {% for op in %w[+ - * / //] %}\n      def {{op.id}}(value : {{name}})\n \
    \       {{to}} {{op.id}} value\n      end\n    {% end %}\n\n    {% for op in %w[<\
    \ <= > >=] %}\n      def {{op.id}}(m : {{name}})\n        raise NotImplementedError.new({{op}})\n\
    \      end\n    {% end %}\n\n    def {{to}} : {{name}}\n      {{name}}.new(self)\n\
    \    end\n  end\n\n  class String\n    def {{to}} : {{name}}\n      {{name}}.new(self)\n\
    \    end\n  end\nend\n\nstatic_modint(Mint, 1000000007)\nstatic_modint(Mint2,\
    \ 998244353)\n\n# require \"../../src/scanner\"\n# ### Specifications\n#\n# ```plain\n\
    # Inside input macro                     | Expanded code\n# ---------------------------------------+---------------------------------------\n\
    # Uppercase string: Int32, Int64, etc.   | {}.new(Scanner.s)\n# s, c, i, iN, uN\
    \                        | Scanner.{}\n# Other lowercase string: f, big_i, etc.\
    \ | Scanner.s.to_{}\n# operator[]: type[size]                 | Array.new(input(size))\
    \ { input(type) }\n# Tuple literal: {t1, t2, t3}            | {input(t1), input(t2),\
    \ input(t3)}\n# Array literal: [t1, t2, t3]            | [input(t1), input(t2),\
    \ input(t3)]\n# Range literal: t1..t2                  | input(t1)..input(t2)\n\
    # If: cond ? t1 : t2                     | cond ? input(t1) : input(t2)\n# Assign:\
    \ target = value                 | target = input(value)\n# ```\n#\n# ### Examples\n\
    #\n# Input:\n# ```plain\n# 5 3\n# foo bar\n# 1 2 3 4 5\n# ```\n# ```\n# n, m =\
    \ input(Int32, Int64) # => {5, 10i64}\n# input(String, Char[m])     # => {\"foo\"\
    , ['b', 'a', 'r']}\n# input(Int32[n])            # => [1, 2, 3, 4, 5]\n# ```\n\
    # ```\n# n, m = input(i, i64) # => {5, 10i64}\n# input(s, c[m])       # => {\"\
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
    \ # => {[1, 2, 3], [2, 3, 1]}\n# ```\nclass Scanner\n  private def self.skip_to_not_space(io)\n\
    \    peek = io.peek\n    not_space = peek.index { |x| x != 32 && x != 10 } ||\
    \ peek.size\n    io.skip(not_space)\n  end\n\n  def self.c(io = STDIN)\n    skip_to_not_space(io)\n\
    \    io.read_char.not_nil!\n  end\n\n  private def self.int(int_type : T.class,\
    \ io = STDIN) : T forall T\n    skip_to_not_space(io)\n\n    value = T.zero\n\
    \    signed = false\n    case x = io.read_byte\n    when nil\n      raise IO::EOFError.new\n\
    \    when 45\n      signed = true\n    when 48..57\n      value = T.new 48 &-\
    \ x\n    else\n      raise \"Unexpected char: #{x.chr}\"\n    end\n\n    loop\
    \ do\n      peek = io.peek\n      return signed ? value : -value if peek.empty?\n\
    \      i = 0\n      while i < peek.size\n        c = peek.unsafe_fetch(i)\n  \
    \      if 48 <= c <= 57\n          value = value &* 10 &- c &+ 48\n          i\
    \ &+= 1\n        elsif c == 32 || c == 10\n          io.skip(i &+ 1)\n       \
    \   return signed ? value : -value\n        else\n          raise \"Unexpected\
    \ char: #{c.chr}\"\n        end\n      end\n      io.skip(i)\n    end\n  end\n\
    \n  private def self.uint(uint_type : T.class, io = STDIN) : T forall T\n    skip_to_not_space(io)\n\
    \    value = T.zero\n    found_digit = false\n    loop do\n      peek = io.peek\n\
    \      if peek.empty?\n        if found_digit\n          return value\n      \
    \  else\n          raise IO::EOFError.new\n        end\n      end\n      i = 0\n\
    \      while i < peek.size\n        c = peek.unsafe_fetch(i)\n        if 48 <=\
    \ c <= 57\n          found_digit = true\n          value = value &* 10 &+ c &-\
    \ 48\n          i &+= 1\n        elsif c == 32 || c == 10\n          io.skip(i\
    \ &+ 1)\n          return value\n        else\n          raise \"Unexpected char:\
    \ #{c.chr}\"\n        end\n      end\n      io.skip(i)\n    end\n  end\n\n  def\
    \ self.i(io = STDIN)\n    int(Int32, io)\n  end\n\n  {% for signed in [true, false]\
    \ %}\n    {% for n in [8, 16, 32, 64, 128] %}\n      {%\n        name = signed\
    \ ? \"i#{n}\".id : \"u#{n}\".id\n        type = signed ? \"Int#{n}\".id : \"UInt#{n}\"\
    .id\n        method = signed ? \"int\".id : \"uint\".id\n      %}\n      def self.{{name}}(io\
    \ = STDIN)\n        {{method}}({{type}}, io)\n      end\n    {% end %}\n  {% end\
    \ %}\n\n  def self.s(io = STDIN)\n    skip_to_not_space(io)\n\n    peek = io.peek\n\
    \    if peek.empty?\n      raise IO::EOFError.new\n    end\n    if index = peek.index\
    \ { |x| x == 32 || x == 10 }\n      io.skip(index + 1)\n      return String.new(peek[0,\
    \ index])\n    end\n\n    String.build do |buffer|\n      loop do\n        buffer.write\
    \ peek\n        io.skip(peek.size)\n        peek = io.peek\n        break if peek.empty?\n\
    \        if index = peek.index { |x| x == 32 || x == 10 }\n          buffer.write\
    \ peek[0, index]\n          io.skip(index + 1)\n          break\n        end\n\
    \      end\n    end\n  end\nend\n\nmacro internal_input(type, else_ast)\n  {%\
    \ if Scanner.class.has_method?(type.id) %}\n    Scanner.{{type.id}}\n  {% elsif\
    \ type.stringify == \"String\" %}\n    Scanner.s\n  {% elsif type.stringify ==\
    \ \"Char\" %}\n    Scanner.c\n  {% elsif type.stringify =~ /[A-Z][a-z0-9_]*/ %}\n\
    \    {{type.id}}.new(Scanner.s)\n  {% elsif String.has_method?(\"to_#{type}\"\
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
    \nx, y, z = input(i, i, i)\na, b = input(m2[x, y], m2[y, z])\na = Matrix.new a\n\
    b = Matrix.new b\n(a * b).join('\\n', STDOUT, &.join(' ', STDOUT)); puts\n"
  code: '# verification-helper: PROBLEM https://judge.yosupo.jp/problem/matrix_product

    require "../../src/math/matrix"

    require "../../src/math/mint"

    require "../../src/scanner"

    x, y, z = input(i, i, i)

    a, b = input(m2[x, y], m2[y, z])

    a = Matrix.new a

    b = Matrix.new b

    (a * b).join(''\n'', STDOUT, &.join('' '', STDOUT)); puts

    '
  dependsOn:
  - src/math/matrix.cr
  - src/math/mint.cr
  - src/scanner.cr
  isVerificationFile: true
  path: test/math/matrix_product_test.cr
  requiredBy: []
  timestamp: '2021-10-07 18:54:34+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/math/matrix_product_test.cr
layout: document
redirect_from:
- /verify/test/math/matrix_product_test.cr
- /verify/test/math/matrix_product_test.cr.html
title: test/math/matrix_product_test.cr
---
