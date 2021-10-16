---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/math/combination.cr
    title: src/math/combination.cr
  - icon: ':question:'
    path: src/math/mint.cr
    title: src/math/mint.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../src/math/combination\"\nclass\
    \ Combination(T)\n  def initialize(initial_capacity : Int = 2)\n    initial_capacity\
    \ += 1\n    @size = 2\n    @factorial = Array(T).new(initial_capacity)\n    @factorial\
    \ << T.new(1) << T.new(1)\n    @inv = Array(T).new(initial_capacity)\n    @inv\
    \ << T.zero << T.new(1)\n    @finv = Array(T).new(initial_capacity)\n    @finv\
    \ << T.new(1) << T.new(1)\n    expand_until(initial_capacity)\n  end\n\n  private\
    \ def expand_until(n : Int)\n    while @size <= n\n      @factorial << @factorial[-1]\
    \ * @size\n      @inv << -@inv[T::MOD % @size] * (T::MOD // @size)\n      @finv\
    \ << @finv[-1] * @inv[@size]\n      @size += 1\n    end\n  end\n\n  def factorial(n\
    \ : Int)\n    raise IndexError.new if n < 0\n    expand_until(n)\n    @factorial.unsafe_fetch(n)\n\
    \  end\n\n  def inv(n : Int)\n    raise DivisionByZeroError.new if n == 0\n  \
    \  raise IndexError.new if n < 0\n    expand_until(n)\n    @inv.unsafe_fetch(n)\n\
    \  end\n\n  def finv(n : Int)\n    raise IndexError.new if n < 0\n    expand_until(n)\n\
    \    @finv.unsafe_fetch(n)\n  end\n\n  def permutation(n : Int, r : Int)\n   \
    \ (n < r || n < 0 || r < 0) ? T.zero : factorial(n) * finv(n - r)\n  end\n\n \
    \ def combination(n : Int, r : Int)\n    (n < r || n < 0 || r < 0) ? T.zero :\
    \ factorial(n) * finv(r) * finv(n - r)\n  end\n\n  def repeated_combination(n\
    \ : Int, r : Int)\n    (n < 0 || r < 0) ? T.zero : r == 0 ? T.new(1) : combination(n\
    \ + r - 1, r)\n  end\n\n  def self.table(n : Int)\n    table = Array.new(n + 1)\
    \ { Array.new(n + 1, T.zero) }\n    (0..n).each do |i|\n      table[i][0] = table[i][i]\
    \ = 1\n    end\n    (1..n).each do |i|\n      (1...i).each do |j|\n        table[i][j]\
    \ = table[i - 1][j - 1] + table[i - 1][j]\n      end\n    end\n    table\n  end\n\
    end\n\n# require \"../../src/math/mint\"\nmacro static_modint(name, mod)\n  struct\
    \ {{name}}\n    MOD = {{mod}}i64\n\n    def self.zero\n      new\n    end\n\n\
    \    def self.raw(value : Int64)\n      result = new\n      result.value = value\n\
    \      result\n    end\n\n    macro [](*nums)\n      {% verbatim do %}\n     \
    \   Array({{@type}}).build({{nums.size}}) do |%buffer|\n          {% for num,\
    \ i in nums %}\n            %buffer[{{i}}] = {{@type}}.new({{num}})\n        \
    \  {% end %}\n          {{nums.size}}\n        end\n      {% end %}\n    end\n\
    \n    getter value : Int64\n\n    def initialize\n      @value = 0i64\n    end\n\
    \n    def initialize(value)\n      @value = value.to_i64 % MOD\n    end\n\n  \
    \  def initialize(m : self)\n      @value = m.value\n    end\n\n    protected\
    \ def value=(value : Int64)\n      @value = value\n    end\n\n    def ==(m : self)\n\
    \      value == m.value\n    end\n\n    def ==(m)\n      value == m\n    end\n\
    \n    def + : self\n      self\n    end\n\n    def - : self\n      self.class.raw(value\
    \ != 0 ? MOD &- value : 0i64)\n    end\n\n    def +(v)\n      self + self.class.new(v)\n\
    \    end\n\n    def +(m : self)\n      x = value &+ m.value\n      x &-= MOD if\
    \ x >= MOD\n      self.class.raw(x)\n    end\n\n    def -(v)\n      self - self.class.new(v)\n\
    \    end\n\n    def -(m : self)\n      x = value &- m.value\n      x &+= MOD if\
    \ x < 0\n      self.class.raw(x)\n    end\n\n    def *(v)\n      self * self.class.new(v)\n\
    \    end\n\n    def *(m : self)\n      self.class.new(value &* m.value)\n    end\n\
    \n    def /(v)\n      self / self.class.new(v)\n    end\n\n    def /(m : self)\n\
    \      raise DivisionByZeroError.new if m.value == 0\n      a, b, u, v = m.value,\
    \ MOD, 1i64, 0i64\n      while b != 0\n        t = a // b\n        a &-= t &*\
    \ b\n        a, b = b, a\n        u &-= t &* v\n        u, v = v, u\n      end\n\
    \      self.class.new(value &* u)\n    end\n\n    def //(v)\n      self / v\n\
    \    end\n\n    def **(exponent : Int)\n      t, res = self, self.class.raw(1i64)\n\
    \      while exponent > 0\n        res *= t if exponent & 1 == 1\n        t *=\
    \ t\n        exponent >>= 1\n      end\n      res\n    end\n\n    {% for op in\
    \ %w[< <= > >=] %}\n      def {{op.id}}(other)\n        raise NotImplementedError.new({{op}})\n\
    \      end\n    {% end %}\n\n    def inv\n      self.class.raw(1) // self\n  \
    \  end\n\n    def succ\n      self.class.raw(value != MOD &- 1 ? value &+ 1 :\
    \ 0i64)\n    end\n\n    def pred\n      self.class.raw(value != 0 ? value &- 1\
    \ : MOD &- 1)\n    end\n\n    def abs\n      self\n    end\n\n    def abs2\n \
    \     self * self\n    end\n\n    def to_i64 : Int64\n      value\n    end\n\n\
    \    delegate to_s, to: @value\n    delegate inspect, to: @value\n  end\n\n  {%\
    \ to = (\"to_\" + name.stringify.downcase.gsub(/mint|modint/, \"m\")).id %}\n\n\
    \  struct Int\n    {% for op in %w[+ - * / //] %}\n      def {{op.id}}(value :\
    \ {{name}})\n        {{to}} {{op.id}} value\n      end\n    {% end %}\n\n    {%\
    \ for op in %w[< <= > >=] %}\n      def {{op.id}}(m : {{name}})\n        raise\
    \ NotImplementedError.new({{op}})\n      end\n    {% end %}\n\n    def {{to}}\
    \ : {{name}}\n      {{name}}.new(self)\n    end\n  end\n\n  class String\n   \
    \ def {{to}} : {{name}}\n      {{name}}.new(self)\n    end\n  end\nend\n\nstatic_modint(Mint,\
    \ 1000000007)\nstatic_modint(Mint2, 998244353)\n\nprivate C = Combination(Mint).new\n\
    \nprivate def iterator\n  Iterator(Int32).chain [\n    (0...10).step(1),\n   \
    \ (10...100).step(10),\n    (100...1000).step(100),\n    (1000...10000).step(1000),\n\
    \    (10000...100000).step(10000),\n    (100000...1000000).step(100000),\n  ]\n\
    end\n\ndescribe Combination do\n  it \"#factorial\" do\n    iterator.each do |x|\n\
    \      C.factorial(x).should eq (1..x).reduce(1.to_m) { |acc, x| acc * x }\n \
    \   end\n    expect_raises(IndexError) { C.factorial(-1) }\n  end\n\n  it \"#inv\"\
    \ do\n    iterator.each do |x|\n      next if x == 0\n      (C.inv(x) * x).should\
    \ eq 1\n    end\n    expect_raises(DivisionByZeroError) { C.inv(0) }\n    expect_raises(IndexError)\
    \ { C.inv(-1) }\n  end\n\n  it \"#finv\" do\n    iterator.each do |x|\n      expected\
    \ = (1..x).reduce(1.to_m) { |acc, x| acc * x.to_m.inv }\n      C.finv(x).should\
    \ eq expected\n    end\n    expect_raises(IndexError) { C.finv(-1) }\n  end\n\n\
    \  it \"#permutation\" do\n    [\n      [1, 0, 0],\n      [1, 1, 0, 0],\n    \
    \  [1, 2, 2, 0, 0],\n      [1, 3, 6, 6, 0, 0],\n      [1, 4, 12, 24, 24, 0, 0],\n\
    \    ].each_with_index do |arr, n|\n      arr.each_with_index do |x, r|\n    \
    \    C.permutation(n, r).should eq x\n      end\n    end\n    [{-1, 1}, {1, -1},\
    \ {-2, 1}, {1, -2}].each do |n, r|\n      C.permutation(n, r).should eq 0\n  \
    \  end\n  end\n\n  it \"#combination\" do\n    [\n      [1, 0, 0],\n      [1,\
    \ 1, 0, 0],\n      [1, 2, 1, 0, 0],\n      [1, 3, 3, 1, 0, 0],\n      [1, 4, 6,\
    \ 4, 1, 0, 0],\n    ].each_with_index do |arr, n|\n      arr.each_with_index do\
    \ |x, r|\n        C.combination(n, r).should eq x\n      end\n    end\n    [{-1,\
    \ 1}, {1, -1}, {-2, 1}, {1, -2}].each do |n, r|\n      C.combination(n, r).should\
    \ eq 0\n    end\n  end\n\n  it \"#repeated_permutation\" do\n    [\n      [1,\
    \ 0, 0],\n      [1, 1, 1, 1],\n      [1, 2, 3, 4, 5],\n      [1, 3, 6, 10, 15,\
    \ 21],\n      [1, 4, 10, 20, 35, 56, 84],\n    ].each_with_index do |arr, n|\n\
    \      arr.each_with_index do |x, r|\n        C.repeated_combination(n, r).should\
    \ eq x\n      end\n    end\n    [{-1, 1}, {1, -1}, {-2, 1}, {1, -2}].each do |n,\
    \ r|\n      C.repeated_combination(n, r).should eq 0\n    end\n  end\n\n  it \"\
    .table\" do\n    Combination(Int32).table(5).should eq [\n      [1, 0, 0, 0, 0,\
    \ 0],\n      [1, 1, 0, 0, 0, 0],\n      [1, 2, 1, 0, 0, 0],\n      [1, 3, 3, 1,\
    \ 0, 0],\n      [1, 4, 6, 4, 1, 0],\n      [1, 5, 10, 10, 5, 1],\n    ]\n  end\n\
    end\n"
  code: "require \"spec\"\nrequire \"../../src/math/combination\"\nrequire \"../../src/math/mint\"\
    \n\nprivate C = Combination(Mint).new\n\nprivate def iterator\n  Iterator(Int32).chain\
    \ [\n    (0...10).step(1),\n    (10...100).step(10),\n    (100...1000).step(100),\n\
    \    (1000...10000).step(1000),\n    (10000...100000).step(10000),\n    (100000...1000000).step(100000),\n\
    \  ]\nend\n\ndescribe Combination do\n  it \"#factorial\" do\n    iterator.each\
    \ do |x|\n      C.factorial(x).should eq (1..x).reduce(1.to_m) { |acc, x| acc\
    \ * x }\n    end\n    expect_raises(IndexError) { C.factorial(-1) }\n  end\n\n\
    \  it \"#inv\" do\n    iterator.each do |x|\n      next if x == 0\n      (C.inv(x)\
    \ * x).should eq 1\n    end\n    expect_raises(DivisionByZeroError) { C.inv(0)\
    \ }\n    expect_raises(IndexError) { C.inv(-1) }\n  end\n\n  it \"#finv\" do\n\
    \    iterator.each do |x|\n      expected = (1..x).reduce(1.to_m) { |acc, x| acc\
    \ * x.to_m.inv }\n      C.finv(x).should eq expected\n    end\n    expect_raises(IndexError)\
    \ { C.finv(-1) }\n  end\n\n  it \"#permutation\" do\n    [\n      [1, 0, 0],\n\
    \      [1, 1, 0, 0],\n      [1, 2, 2, 0, 0],\n      [1, 3, 6, 6, 0, 0],\n    \
    \  [1, 4, 12, 24, 24, 0, 0],\n    ].each_with_index do |arr, n|\n      arr.each_with_index\
    \ do |x, r|\n        C.permutation(n, r).should eq x\n      end\n    end\n   \
    \ [{-1, 1}, {1, -1}, {-2, 1}, {1, -2}].each do |n, r|\n      C.permutation(n,\
    \ r).should eq 0\n    end\n  end\n\n  it \"#combination\" do\n    [\n      [1,\
    \ 0, 0],\n      [1, 1, 0, 0],\n      [1, 2, 1, 0, 0],\n      [1, 3, 3, 1, 0, 0],\n\
    \      [1, 4, 6, 4, 1, 0, 0],\n    ].each_with_index do |arr, n|\n      arr.each_with_index\
    \ do |x, r|\n        C.combination(n, r).should eq x\n      end\n    end\n   \
    \ [{-1, 1}, {1, -1}, {-2, 1}, {1, -2}].each do |n, r|\n      C.combination(n,\
    \ r).should eq 0\n    end\n  end\n\n  it \"#repeated_permutation\" do\n    [\n\
    \      [1, 0, 0],\n      [1, 1, 1, 1],\n      [1, 2, 3, 4, 5],\n      [1, 3, 6,\
    \ 10, 15, 21],\n      [1, 4, 10, 20, 35, 56, 84],\n    ].each_with_index do |arr,\
    \ n|\n      arr.each_with_index do |x, r|\n        C.repeated_combination(n, r).should\
    \ eq x\n      end\n    end\n    [{-1, 1}, {1, -1}, {-2, 1}, {1, -2}].each do |n,\
    \ r|\n      C.repeated_combination(n, r).should eq 0\n    end\n  end\n\n  it \"\
    .table\" do\n    Combination(Int32).table(5).should eq [\n      [1, 0, 0, 0, 0,\
    \ 0],\n      [1, 1, 0, 0, 0, 0],\n      [1, 2, 1, 0, 0, 0],\n      [1, 3, 3, 1,\
    \ 0, 0],\n      [1, 4, 6, 4, 1, 0],\n      [1, 5, 10, 10, 5, 1],\n    ]\n  end\n\
    end\n"
  dependsOn:
  - src/math/combination.cr
  - src/math/mint.cr
  isVerificationFile: false
  path: spec/math/combination_spec.cr
  requiredBy: []
  timestamp: '2021-10-16 11:07:23+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/math/combination_spec.cr
layout: document
redirect_from:
- /library/spec/math/combination_spec.cr
- /library/spec/math/combination_spec.cr.html
title: spec/math/combination_spec.cr
---
