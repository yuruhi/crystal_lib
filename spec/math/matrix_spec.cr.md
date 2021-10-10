---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: src/math/matrix.cr
    title: src/math/matrix.cr
  - icon: ':question:'
    path: src/math/mint.cr
    title: src/math/mint.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../src/math/matrix\"\nclass Matrix(T)\n\
    \  include Indexable(Array(T))\n\n  def Matrix.identity(size : Int32) : self\n\
    \    result = Matrix(T).new(size, size, T.zero)\n    (0...size).each do |i|\n\
    \      result[i][i] = T.new(1)\n    end\n    result\n  end\n\n  macro [](*args)\n\
    \    Matrix.new [{{args.splat}}]\n  end\n\n  getter height : Int32, width : Int32,\
    \ data : Array(Array(T))\n\n  def initialize\n    @height = 0\n    @width = 0\n\
    \    @data = Array(Array(T)).new\n  end\n\n  def initialize(@height, @width, value\
    \ : T)\n    raise ArgumentError.new(\"Negative matrix height: #{@height}\") unless\
    \ @height >= 0\n    raise ArgumentError.new(\"Negative matrix width: #{@width}\"\
    ) unless @width >= 0\n    @data = Array.new(height) { Array(T).new(width, value)\
    \ }\n  end\n\n  def initialize(@height, @width, &block : Int32, Int32 -> T)\n\
    \    raise ArgumentError.new(\"Negative matrix height: #{@height}\") unless @height\
    \ >= 0\n    raise ArgumentError.new(\"Negative matrix width: #{@width}\") unless\
    \ @width >= 0\n    @data = Array.new(height) { |i| Array.new(width) { |j| yield\
    \ i, j } }\n  end\n\n  def initialize(@data : Array(Array(T)))\n    @height =\
    \ @data.size\n    @width = @data[0].size\n    raise ArgumentError.new unless @data.all?\
    \ { |a| a.size == width }\n  end\n\n  delegate size, to: @data\n  delegate unsafe_fetch,\
    \ to: @data\n\n  private def check_index_out_of_bounds(i, j)\n    check_index_out_of_bounds(i,\
    \ j) { raise IndexError.new }\n  end\n\n  private def check_index_out_of_bounds(i,\
    \ j)\n    i += height if i < 0\n    j += width if j < 0\n    if 0 <= i < height\
    \ && 0 <= j < width\n      {i, j}\n    else\n      yield\n    end\n  end\n\n \
    \ def fetch(i : Int, j : Int, &)\n    i, j = check_index_out_of_bounds(i, j) {\
    \ return yield i, j }\n    unsafe_fetch(i, j)\n  end\n\n  def fetch(i : Int, j\
    \ : Int, default)\n    fetch(i, j) { default }\n  end\n\n  def [](i : Int, j :\
    \ Int) : T\n    fetch(i, j) { raise IndexError.new }\n  end\n\n  def []?(i : Int,\
    \ j : Int) : T?\n    fetch(i, j, nil)\n  end\n\n  def unsafe_fetch(i : Int, j\
    \ : Int) : T\n    @data.unsafe_fetch(i).unsafe_fetch(j)\n  end\n\n  def +(other\
    \ : self)\n    raise IndexError.new unless height == other.height && width ==\
    \ other.width\n    Matrix(T).new(height, width) { |i, j|\n      unsafe_fetch(i,\
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
    \ 998244353)\n\nprivate M = Matrix[[1, 2], [3, 4]]\ni_j_value = [\n  {0, 0, 1},\
    \ {0, 1, 2}, {1, 0, 3}, {1, 1, 4},\n  {-2, -2, 1}, {-2, -1, 2}, {-1, -2, 3}, {-1,\
    \ -1, 4},\n]\nout_of_range = [\n  {0, 2}, {2, 0}, {2, 2},\n  {-3, 0}, {0, -3},\
    \ {-3, -3},\n]\n\ndescribe Matrix do\n  it \".identity\" do\n    Matrix(Int32).identity(1).should\
    \ eq Matrix[[1]]\n    Matrix(Int32).identity(2).should eq Matrix[[1, 0], [0, 1]]\n\
    \    Matrix(Int32).identity(3).should eq Matrix[[1, 0, 0], [0, 1, 0], [0, 0, 1]]\n\
    \    expect_raises(ArgumentError) { Matrix(Int32).identity(-1) }\n  end\n\n  it\
    \ \"[]\" do\n    M.should eq Matrix.new [[1, 2], [3, 4]]\n  end\n\n  describe\
    \ \".new\" do\n    it \"receives initial value\" do\n      Matrix.new(1, 1, 0).should\
    \ eq Matrix[[0]]\n      Matrix.new(2, 3, 0).should eq Matrix[[0, 0, 0], [0, 0,\
    \ 0]]\n      expect_raises(ArgumentError) { Matrix.new(-1, 1, 0) }\n      expect_raises(ArgumentError)\
    \ { Matrix.new(1, -1, 0) }\n    end\n\n    it \"receives block\" do\n      Matrix({Int32,\
    \ Int32}).new(3, 3) { |i, j| {i, j} }.should eq Matrix[\n        [{0, 0}, {0,\
    \ 1}, {0, 2}],\n        [{1, 0}, {1, 1}, {1, 2}],\n        [{2, 0}, {2, 1}, {2,\
    \ 2}],\n      ]\n      expect_raises(ArgumentError) { Matrix(Int32).new(-1, 1)\
    \ { 0 } }\n      expect_raises(ArgumentError) { Matrix(Int32).new(1, -1) { 0 }\
    \ }\n    end\n\n    it \"receives Array\" do\n      Matrix.new([[1, 2], [3, 4]]).should\
    \ eq Matrix[[1, 2], [3, 4]]\n      expect_raises(ArgumentError) { Matrix.new [[1,\
    \ 2], [3]] }\n    end\n  end\n\n  it \"#fetch(i, j, &block)\" do\n    i_j_value.each\
    \ do |i, j, value|\n      M.fetch(i, j) { nil }.should eq value\n    end\n   \
    \ out_of_range.each do |i, j|\n      M.fetch(i, j) { |i, j| [i, j] }.should eq\
    \ [i, j]\n    end\n  end\n\n  it \"#fetch(i, j, default)\" do\n    i_j_value.each\
    \ do |i, j, value|\n      M.fetch(i, j, nil).should eq value\n    end\n    out_of_range.each\
    \ do |i, j|\n      M.fetch(i, j, nil).should be_nil\n    end\n  end\n\n  it \"\
    #[](i, j)\" do\n    i_j_value.each do |i, j, value|\n      M[i, j].should eq value\n\
    \    end\n    out_of_range.each do |i, j|\n      expect_raises(IndexError) { M[i,\
    \ j] }\n    end\n  end\n\n  it \"#[]?(i, j)\" do\n    i_j_value.each do |i, j,\
    \ value|\n      M[i, j]?.should eq value\n    end\n    out_of_range.each do |i,\
    \ j|\n      M[i, j]?.should be_nil\n    end\n  end\n\n  it \"#unsafe_fetch(i,\
    \ j)\" do\n    M.unsafe_fetch(0, 0).should eq 1\n    M.unsafe_fetch(0, 1).should\
    \ eq 2\n    M.unsafe_fetch(1, 0).should eq 3\n    M.unsafe_fetch(1, 1).should\
    \ eq 4\n  end\n\n  it \"#+(other)\" do\n    (Matrix[[1, 2], [3, 4]] + Matrix[[5,\
    \ 6], [7, 8]]).should eq Matrix[[6, 8], [10, 12]]\n    expect_raises(IndexError)\
    \ { Matrix[[1, 2], [3, 4]] + Matrix[[1], [2]] }\n  end\n\n  it \"#-(other)\" do\n\
    \    (Matrix[[5, 6], [7, 8]] - Matrix[[1, 2], [3, 4]]).should eq Matrix[[4, 4],\
    \ [4, 4]]\n    expect_raises(IndexError) { Matrix[[1, 2], [3, 4]] - Matrix[[1],\
    \ [2]] }\n  end\n\n  it \"#*(other)\" do\n    a = Matrix[[1, 2], [3, 4], [5, 6]]\n\
    \    b = Matrix[[7, 8, 9], [10, 11, 12]]\n    c = Matrix[[27, 30, 33], [61, 68,\
    \ 75], [95, 106, 117]]\n    (a * b).should eq c\n    expect_raises(IndexError)\
    \ { a * a }\n    expect_raises(IndexError) { b * b }\n  end\n\n  it \"#**(k)\"\
    \ do\n    a1 = Matrix[[1, 2], [3, 4]]\n    (a1 ** 0).should eq Matrix(Int32).identity(2)\n\
    \    (a1 ** 1).should eq a1\n    (a1 ** 2).should eq a1 * a1\n    (a1 ** 3).should\
    \ eq a1 * a1 * a1\n\n    m1 = Matrix[[1.to_m, 2.to_m], [3.to_m, 4.to_m]]\n   \
    \ m2 = Matrix[[414846427.to_m, 59557274.to_m], [89335911.to_m, 504182338.to_m]]\n\
    \    (m1 ** (10i64**18)).should eq m2\n  end\n\n  it \"#to_s\" do\n    M.to_s.should\
    \ eq \"[[1, 2], [3, 4]]\"\n  end\n\n  it \"#inspect\" do\n    M.inspect.should\
    \ eq \"Matrix[[1, 2], [3, 4]]\"\n  end\nend\n"
  code: "require \"spec\"\nrequire \"../../src/math/matrix\"\nrequire \"../../src/math/mint\"\
    \n\nprivate M = Matrix[[1, 2], [3, 4]]\ni_j_value = [\n  {0, 0, 1}, {0, 1, 2},\
    \ {1, 0, 3}, {1, 1, 4},\n  {-2, -2, 1}, {-2, -1, 2}, {-1, -2, 3}, {-1, -1, 4},\n\
    ]\nout_of_range = [\n  {0, 2}, {2, 0}, {2, 2},\n  {-3, 0}, {0, -3}, {-3, -3},\n\
    ]\n\ndescribe Matrix do\n  it \".identity\" do\n    Matrix(Int32).identity(1).should\
    \ eq Matrix[[1]]\n    Matrix(Int32).identity(2).should eq Matrix[[1, 0], [0, 1]]\n\
    \    Matrix(Int32).identity(3).should eq Matrix[[1, 0, 0], [0, 1, 0], [0, 0, 1]]\n\
    \    expect_raises(ArgumentError) { Matrix(Int32).identity(-1) }\n  end\n\n  it\
    \ \"[]\" do\n    M.should eq Matrix.new [[1, 2], [3, 4]]\n  end\n\n  describe\
    \ \".new\" do\n    it \"receives initial value\" do\n      Matrix.new(1, 1, 0).should\
    \ eq Matrix[[0]]\n      Matrix.new(2, 3, 0).should eq Matrix[[0, 0, 0], [0, 0,\
    \ 0]]\n      expect_raises(ArgumentError) { Matrix.new(-1, 1, 0) }\n      expect_raises(ArgumentError)\
    \ { Matrix.new(1, -1, 0) }\n    end\n\n    it \"receives block\" do\n      Matrix({Int32,\
    \ Int32}).new(3, 3) { |i, j| {i, j} }.should eq Matrix[\n        [{0, 0}, {0,\
    \ 1}, {0, 2}],\n        [{1, 0}, {1, 1}, {1, 2}],\n        [{2, 0}, {2, 1}, {2,\
    \ 2}],\n      ]\n      expect_raises(ArgumentError) { Matrix(Int32).new(-1, 1)\
    \ { 0 } }\n      expect_raises(ArgumentError) { Matrix(Int32).new(1, -1) { 0 }\
    \ }\n    end\n\n    it \"receives Array\" do\n      Matrix.new([[1, 2], [3, 4]]).should\
    \ eq Matrix[[1, 2], [3, 4]]\n      expect_raises(ArgumentError) { Matrix.new [[1,\
    \ 2], [3]] }\n    end\n  end\n\n  it \"#fetch(i, j, &block)\" do\n    i_j_value.each\
    \ do |i, j, value|\n      M.fetch(i, j) { nil }.should eq value\n    end\n   \
    \ out_of_range.each do |i, j|\n      M.fetch(i, j) { |i, j| [i, j] }.should eq\
    \ [i, j]\n    end\n  end\n\n  it \"#fetch(i, j, default)\" do\n    i_j_value.each\
    \ do |i, j, value|\n      M.fetch(i, j, nil).should eq value\n    end\n    out_of_range.each\
    \ do |i, j|\n      M.fetch(i, j, nil).should be_nil\n    end\n  end\n\n  it \"\
    #[](i, j)\" do\n    i_j_value.each do |i, j, value|\n      M[i, j].should eq value\n\
    \    end\n    out_of_range.each do |i, j|\n      expect_raises(IndexError) { M[i,\
    \ j] }\n    end\n  end\n\n  it \"#[]?(i, j)\" do\n    i_j_value.each do |i, j,\
    \ value|\n      M[i, j]?.should eq value\n    end\n    out_of_range.each do |i,\
    \ j|\n      M[i, j]?.should be_nil\n    end\n  end\n\n  it \"#unsafe_fetch(i,\
    \ j)\" do\n    M.unsafe_fetch(0, 0).should eq 1\n    M.unsafe_fetch(0, 1).should\
    \ eq 2\n    M.unsafe_fetch(1, 0).should eq 3\n    M.unsafe_fetch(1, 1).should\
    \ eq 4\n  end\n\n  it \"#+(other)\" do\n    (Matrix[[1, 2], [3, 4]] + Matrix[[5,\
    \ 6], [7, 8]]).should eq Matrix[[6, 8], [10, 12]]\n    expect_raises(IndexError)\
    \ { Matrix[[1, 2], [3, 4]] + Matrix[[1], [2]] }\n  end\n\n  it \"#-(other)\" do\n\
    \    (Matrix[[5, 6], [7, 8]] - Matrix[[1, 2], [3, 4]]).should eq Matrix[[4, 4],\
    \ [4, 4]]\n    expect_raises(IndexError) { Matrix[[1, 2], [3, 4]] - Matrix[[1],\
    \ [2]] }\n  end\n\n  it \"#*(other)\" do\n    a = Matrix[[1, 2], [3, 4], [5, 6]]\n\
    \    b = Matrix[[7, 8, 9], [10, 11, 12]]\n    c = Matrix[[27, 30, 33], [61, 68,\
    \ 75], [95, 106, 117]]\n    (a * b).should eq c\n    expect_raises(IndexError)\
    \ { a * a }\n    expect_raises(IndexError) { b * b }\n  end\n\n  it \"#**(k)\"\
    \ do\n    a1 = Matrix[[1, 2], [3, 4]]\n    (a1 ** 0).should eq Matrix(Int32).identity(2)\n\
    \    (a1 ** 1).should eq a1\n    (a1 ** 2).should eq a1 * a1\n    (a1 ** 3).should\
    \ eq a1 * a1 * a1\n\n    m1 = Matrix[[1.to_m, 2.to_m], [3.to_m, 4.to_m]]\n   \
    \ m2 = Matrix[[414846427.to_m, 59557274.to_m], [89335911.to_m, 504182338.to_m]]\n\
    \    (m1 ** (10i64**18)).should eq m2\n  end\n\n  it \"#to_s\" do\n    M.to_s.should\
    \ eq \"[[1, 2], [3, 4]]\"\n  end\n\n  it \"#inspect\" do\n    M.inspect.should\
    \ eq \"Matrix[[1, 2], [3, 4]]\"\n  end\nend\n"
  dependsOn:
  - src/math/matrix.cr
  - src/math/mint.cr
  isVerificationFile: false
  path: spec/math/matrix_spec.cr
  requiredBy: []
  timestamp: '2021-10-07 18:40:18+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/math/matrix_spec.cr
layout: document
redirect_from:
- /library/spec/math/matrix_spec.cr
- /library/spec/math/matrix_spec.cr.html
title: spec/math/matrix_spec.cr
---
