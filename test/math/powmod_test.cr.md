---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: src/math/mint.cr
    title: src/math/mint.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: true
  _pathExtension: cr
  _verificationStatusIcon: ':x:'
  attributes:
    PROBLEM: https://onlinejudge.u-aizu.ac.jp/courses/library/6/NTL/1/NTL_1_B
  bundledCode: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/library/6/NTL/1/NTL_1_B\n\
    # require \"../../src/math/mint\"\nstruct ModInt(MOD)\n  def self.mod\n    MOD\n\
    \  end\n\n  def self.zero\n    new\n  end\n\n  def self.raw(value : Int64)\n \
    \   result = new\n    result.value = value\n    result\n  end\n\n  macro [](*nums)\n\
    \    Array({{@type}}).build({{nums.size}}) do |buffer|\n      {% for num, i in\
    \ nums %}\n        buffer[{{i}}] = {{@type}}.new({{num}})\n      {% end %}\n \
    \     {{nums.size}}\n    end\n  end\n\n  getter value : Int64\n\n  private macro\
    \ check_mod\n    {% if MOD.is_a?(NumberLiteral) %}\n      {% raise \"can't instantiate\
    \ ModInt(MOD) with MOD = #{MOD} (MOD must be positive)\" unless MOD >= 1 %}\n\
    \      {% raise \"can't instantiate ModInt(MOD) with MOD = #{MOD.kind} (MOD must\
    \ be Int64)\" unless MOD.kind == :i64 %}\n    {% else %}\n      {% raise \"can't\
    \ instantiate ModInt(MOD) with MOD = #{MOD.class_name.id} (MOD must be an integer)\"\
    \ %}\n    {% end %}\n  end\n\n  def initialize\n    check_mod\n    @value = 0i64\n\
    \  end\n\n  def initialize(value)\n    check_mod\n    @value = value.to_i64 %\
    \ MOD\n  end\n\n  def initialize(m : self)\n    check_mod\n    @value = m.value\n\
    \  end\n\n  protected def value=(value : Int64)\n    @value = value\n  end\n\n\
    \  def self.scan(scanner, io : IO) : self\n    new scanner.i64(io)\n  end\n\n\
    \  def ==(m : ModInt(MOD2)) forall MOD2\n    {% raise \"Can't compare ModInt(#{MOD})\
    \ and ModInt(#{MOD2})\" if MOD != MOD2 %}\n    value == m.value\n  end\n\n  def\
    \ ==(m : Int)\n    value == m\n  end\n\n  def + : self\n    self\n  end\n\n  def\
    \ - : self\n    self.class.raw(value != 0 ? MOD &- value : 0i64)\n  end\n\n  def\
    \ +(v)\n    self + self.class.new(v)\n  end\n\n  def +(m : self)\n    x = value\
    \ &+ m.value\n    x &-= MOD if x >= MOD\n    self.class.raw(x)\n  end\n\n  def\
    \ -(v)\n    self - self.class.new(v)\n  end\n\n  def -(m : self)\n    x = value\
    \ &- m.value\n    x &+= MOD if x < 0\n    self.class.raw(x)\n  end\n\n  def *(v)\n\
    \    self * self.class.new(v)\n  end\n\n  def *(m : self)\n    self.class.new(value\
    \ &* m.value)\n  end\n\n  def /(v)\n    self / self.class.new(v)\n  end\n\n  def\
    \ /(m : self)\n    raise DivisionByZeroError.new if m.value == 0\n    a, b, u,\
    \ v = m.value, MOD, 1i64, 0i64\n    while b != 0\n      t = a // b\n      a &-=\
    \ t &* b\n      a, b = b, a\n      u &-= t &* v\n      u, v = v, u\n    end\n\
    \    self.class.new(value &* u)\n  end\n\n  def //(v)\n    self / v\n  end\n\n\
    \  def **(exponent : Int)\n    t, res = self, self.class.raw(1i64)\n    while\
    \ exponent > 0\n      res *= t if exponent & 1 == 1\n      t *= t\n      exponent\
    \ >>= 1\n    end\n    res\n  end\n\n  {% for op in %w[< <= > >=] %}\n    def {{op.id}}(other)\n\
    \      raise NotImplementedError.new({{op}})\n    end\n  {% end %}\n\n  def inv\n\
    \    self.class.raw(1) // self\n  end\n\n  def succ\n    self.class.raw(value\
    \ != MOD &- 1 ? value &+ 1 : 0i64)\n  end\n\n  def pred\n    self.class.raw(value\
    \ != 0 ? value &- 1 : MOD &- 1)\n  end\n\n  def abs\n    self\n  end\n\n  def\
    \ abs2\n    self * self\n  end\n\n  def to_i64 : Int64\n    value\n  end\n\n \
    \ def to_s(io : IO) : Nil\n    value.to_s(io)\n  end\n\n  def inspect(io : IO)\
    \ : Nil\n    value.inspect(io)\n  end\nend\n\nstruct Int\n  def to_m(type : M.class)\
    \ forall M\n    M.new(self)\n  end\nend\n\nclass String\n  def to_m(type : M.class)\
    \ forall M\n    M.new(self)\n  end\nend\n\nalias Mint = ModInt(1000000007i64)\n\
    alias Mint2 = ModInt(998244353i64)\n\na, b = read_line.split.map(&.to_i)\nputs\
    \ Mint.new(a)**b\n"
  code: '# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/library/6/NTL/1/NTL_1_B

    require "../../src/math/mint"

    a, b = read_line.split.map(&.to_i)

    puts Mint.new(a)**b

    '
  dependsOn:
  - src/math/mint.cr
  isVerificationFile: true
  path: test/math/powmod_test.cr
  requiredBy: []
  timestamp: '2022-01-23 11:59:02+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: test/math/powmod_test.cr
layout: document
redirect_from:
- /verify/test/math/powmod_test.cr
- /verify/test/math/powmod_test.cr.html
title: test/math/powmod_test.cr
---
