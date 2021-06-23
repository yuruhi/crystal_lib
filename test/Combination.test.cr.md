---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: math/Combination.cr
    title: math/Combination.cr
  - icon: ':heavy_check_mark:'
    path: math/Mint.cr
    title: math/Mint.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://yukicoder.me/problems/no/117
  bundledCode: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/117\n\
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
    \ \"../math/Combination\"\nclass Combination(T)\n  def initialize\n    @size =\
    \ 2\n    @factorial = [T.new(1), T.new(1)]\n    @inv = [T.zero, T.new(1)]\n  \
    \  @finv = [T.new(1), T.new(1)]\n  end\n\n  private def expand_until(n : Int)\n\
    \    while @size <= n\n      @factorial << @factorial[-1] * @size\n      @inv\
    \ << -@inv[T::MOD % @size] * (T::MOD // @size)\n      @finv << @finv[-1] * @inv[@size]\n\
    \      @size += 1\n    end\n  end\n\n  def factorial(n : Int)\n    expand_until(n)\n\
    \    @factorial[n]\n  end\n\n  def inv(n : Int)\n    expand_until(n)\n    @inv[n]\n\
    \  end\n\n  def finv(n : Int)\n    expand_until(n)\n    @finv[n]\n  end\n\n  def\
    \ permutation(n : Int, r : Int)\n    (n < r || n < 0 || r < 0) ? T.zero : factorial(n)\
    \ * finv(n - r)\n  end\n\n  def combination(n : Int, r : Int)\n    (n < r || n\
    \ < 0 || r < 0) ? T.zero : factorial(n) * finv(r) * finv(n - r)\n  end\n\n  def\
    \ repeated_combination(n : Int, r : Int)\n    (n < 0 || r < 0) ? T.zero : r ==\
    \ 0 ? T.new(1) : combination(n + r - 1, r)\n  end\nend\n\nstatic_modint(Mint,\
    \ 10**9 + 7)\n\nC = Combination(Mint).new\n\nread_line.to_i.times do\n  read_line\
    \ =~ /(.).(\\d+).(\\d+)./\n  c, n, r = $1[-1], $2.to_i, $3.to_i\n  puts case c\n\
    \  when 'C'\n    C.combination(n, r)\n  when 'P'\n    C.permutation(n, r)\n  when\
    \ 'H'\n    C.repeated_combination(n, r)\n  end\nend\n"
  code: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/117\nrequire\
    \ \"../math/Mint\"\nrequire \"../math/Combination\"\nstatic_modint(Mint, 10**9\
    \ + 7)\n\nC = Combination(Mint).new\n\nread_line.to_i.times do\n  read_line =~\
    \ /(.).(\\d+).(\\d+)./\n  c, n, r = $1[-1], $2.to_i, $3.to_i\n  puts case c\n\
    \  when 'C'\n    C.combination(n, r)\n  when 'P'\n    C.permutation(n, r)\n  when\
    \ 'H'\n    C.repeated_combination(n, r)\n  end\nend\n"
  dependsOn:
  - math/Mint.cr
  - math/Combination.cr
  isVerificationFile: true
  path: test/Combination.test.cr
  requiredBy: []
  timestamp: '2021-05-30 13:39:04+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/Combination.test.cr
layout: document
redirect_from:
- /verify/test/Combination.test.cr
- /verify/test/Combination.test.cr.html
title: test/Combination.test.cr
---
