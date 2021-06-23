---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: math/Matrix.cr
    title: math/Matrix.cr
  - icon: ':heavy_check_mark:'
    path: math/Mint.cr
    title: math/Mint.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://yukicoder.me/problems/no/997
  bundledCode: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/997\n\
    # require \"../math/Mint\"\nmacro static_modint(name, mod)\n  struct {{name}}\n\
    \    MOD = Int64.new({{mod}})\n\n    def self.zero\n      new\n    end\n\n   \
    \ def self.raw(value : Int64)\n      result = new\n      result.value = value\n\
    \      result\n    end\n\n    @value : Int64\n\n    def initialize\n      @value\
    \ = 0i64\n    end\n\n    def initialize(value)\n      @value = value.to_i64 %\
    \ MOD\n    end\n\n    def initialize(m : self)\n      @value = m.value\n    end\n\
    \n    protected def value=(value : Int64)\n      @value = value\n    end\n\n \
    \   getter value : Int64\n\n    def + : self\n      self\n    end\n\n    def -\
    \ : self\n      self.class.raw(value != 0 ? MOD &- value : 0i64)\n    end\n\n\
    \    def +(v)\n      self + v.to_m\n    end\n\n    def +(m : self)\n      x =\
    \ value &+ m.value\n      x &-= MOD if x >= MOD\n      self.class.raw(x)\n   \
    \ end\n\n    def -(v)\n      self - v.to_m\n    end\n\n    def -(m : self)\n \
    \     x = value &- m.value\n      x &+= MOD if x < 0\n      self.class.raw(x)\n\
    \    end\n\n    def *(v)\n      self * v.to_m\n    end\n\n    def *(m : self)\n\
    \      self.class.new(value &* m.value)\n    end\n\n    def /(v)\n      self /\
    \ v.to_m\n    end\n\n    def /(m : self)\n      raise DivisionByZeroError.new\
    \ if m.value == 0\n      a, b, u, v = m.to_i64, MOD, 1i64, 0i64\n      while b\
    \ != 0\n        t = a // b\n        a &-= t &* b\n        a, b = b, a\n      \
    \  u &-= t &* v\n        u, v = v, u\n      end\n      self.class.new(value &*\
    \ u)\n    end\n\n    def //(v)\n      self / v\n    end\n\n    def **(exponent\
    \ : Int)\n      t, res = self, self.class.raw(1i64)\n      while exponent > 0\n\
    \        res *= t if exponent & 1 == 1\n        t *= t\n        exponent >>= 1\n\
    \      end\n      res\n    end\n\n    def ==(m : self)\n      value == m.value\n\
    \    end\n\n    def ==(m : Int)\n      raise NotImplementedError.new(\"==\")\n\
    \    end\n\n    {% for op in %w[< <= > >=] %}\n      def {{op.id}}(other)\n  \
    \      raise NotImplementedError.new({{op}})\n      end\n    {% end %}\n\n   \
    \ def succ\n      self.class.raw(value != MOD &- 1 ? value &+ 1 : 0i64)\n    end\n\
    \n    def pred\n      self.class.raw(value != 0 ? value &- 1 : MOD &- 1)\n   \
    \ end\n\n    def abs\n      self\n    end\n\n    def to_i64 : Int64\n      value\n\
    \    end\n\n    delegate to_s, to: @value\n    delegate inspect, to: @value\n\
    \  end\n\n  struct Int\n    {% for op in %w[+ - * / //] %}\n      def {{op.id}}(value\
    \ : {{name}})\n        to_m {{op.id}} value\n      end\n    {% end %}\n\n    {%\
    \ for op in %w[== != < <= > >=] %}\n      def {{op.id}}(m : {{name}})\n      \
    \  raise NotImplementedError.new({{op}})\n      end\n    {% end %}\n\n    def\
    \ to_m : {{name}}\n      {{name}}.new(self)\n    end\n  end\n\n  class String\n\
    \    def to_m : {{name}}\n      {{name}}.new(self)\n    end\n  end\nend\n\n# require\
    \ \"../math/Matrix\"\nclass Matrix(T)\n  include Indexable(Array(T))\n\n  getter\
    \ height : Int32\n  getter width : Int32\n  getter data : Array(Array(T))\n\n\
    \  def Matrix.identity(size : Int32)\n    result = Matrix(T).new(size, size)\n\
    \    (0...size).each do |i|\n      result[i][i] = T.new(1)\n    end\n    result\n\
    \  end\n\n  def initialize(@height, @width, init_value : T = T.zero)\n    @data\
    \ = Array(Array(T)).new(height) { Array(T).new(width, init_value) }\n  end\n\n\
    \  def initialize(init_matrix : Array(Array(T)))\n    @height = init_matrix.size\n\
    \    @width = init_matrix[0].size\n    raise ArgumentError.new unless init_matrix.all?\
    \ { |a| a.size == width }\n    @data = init_matrix\n  end\n\n  delegate size,\
    \ to: @data\n  delegate unsafe_fetch, to: @data\n\n  def +(other : self)\n   \
    \ IndexError.new unless height == other.height && width == other.width\n    result\
    \ = Matrix(T).new(height, width)\n    (0...height).each do |i|\n      (0...width).each\
    \ do |j|\n        result[i][j] = data[i][j] + other[i][j]\n      end\n    end\n\
    \    result\n  end\n\n  def -(other : self)\n    IndexError.new unless height\
    \ == other.height && width == other.width\n    result = Matrix(T).new(height,\
    \ width)\n    (0...height).each do |i|\n      (0...width).each do |j|\n      \
    \  result[i][j] = data[i][j] - other[i][j]\n      end\n    end\n    result\n \
    \ end\n\n  def *(other : self)\n    IndexError.new unless width == other.height\n\
    \    result = Matrix(T).new(height, other.width)\n    (0...height).each do |i|\n\
    \      (0...other.width).each do |j|\n        (0...width).each do |k|\n      \
    \    result[i][j] += data[i][k] * other[k][j]\n        end\n      end\n    end\n\
    \    result\n  end\n\n  def **(k : Int)\n    result = Matrix(T).identity(height)\n\
    \    memo = Matrix.new(data)\n    while k > 0\n      result *= memo if k.odd?\n\
    \      memo *= memo\n      k >>= 1\n    end\n    result\n  end\n\n  def to_s(io)\n\
    \    io << data\n  end\nend\n\nstatic_modint(Mint, 1000000007)\nn, w, k = read_line.split.try\
    \ { |(n, w, k)|\n  {n.to_i, w.to_i, k.to_i64}\n}\na = read_line.split.map(&.to_i)\n\
    \ndp = Array.new(2 * w + 1) { Array.new(2, 0.to_m) }\ndp[0][0] = 1.to_m\n(1..2\
    \ * w).each do |i|\n  (0...n).each do |j|\n    i2 = i - a[j]\n    dp[i][0] +=\
    \ dp[i2][0] if 0 <= i2\n    dp[i][1] += dp[i2][1] if 0 <= i2\n    dp[i][1] +=\
    \ dp[i2][0] if 0 <= i2 < w < i\n  end\nend\n\nval1, val2 = dp[w][0], dp[2 * w][1]\n\
    x = Matrix.new([[val1, val2], [1.to_m, 0.to_m]])\ny = Matrix.new([[val1], [1.to_m]])\n\
    puts (x**k * y)[1][0]\n"
  code: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/997\nrequire\
    \ \"../math/Mint\"\nrequire \"../math/Matrix\"\n\nstatic_modint(Mint, 1000000007)\n\
    n, w, k = read_line.split.try { |(n, w, k)|\n  {n.to_i, w.to_i, k.to_i64}\n}\n\
    a = read_line.split.map(&.to_i)\n\ndp = Array.new(2 * w + 1) { Array.new(2, 0.to_m)\
    \ }\ndp[0][0] = 1.to_m\n(1..2 * w).each do |i|\n  (0...n).each do |j|\n    i2\
    \ = i - a[j]\n    dp[i][0] += dp[i2][0] if 0 <= i2\n    dp[i][1] += dp[i2][1]\
    \ if 0 <= i2\n    dp[i][1] += dp[i2][0] if 0 <= i2 < w < i\n  end\nend\n\nval1,\
    \ val2 = dp[w][0], dp[2 * w][1]\nx = Matrix.new([[val1, val2], [1.to_m, 0.to_m]])\n\
    y = Matrix.new([[val1], [1.to_m]])\nputs (x**k * y)[1][0]\n"
  dependsOn:
  - math/Mint.cr
  - math/Matrix.cr
  isVerificationFile: true
  path: test/Matrix.test.cr
  requiredBy: []
  timestamp: '2021-05-30 13:38:48+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/Matrix.test.cr
layout: document
redirect_from:
- /verify/test/Matrix.test.cr
- /verify/test/Matrix.test.cr.html
title: test/Matrix.test.cr
---