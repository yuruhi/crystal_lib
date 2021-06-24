---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: math/Mint.cr
    title: math/Mint.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "# require \"../math/Mint\"\nmacro static_modint(name, mod)\n  struct\
    \ {{name}}\n    MOD = Int64.new({{mod}})\n\n    def self.zero\n      new\n   \
    \ end\n\n    def self.raw(value : Int64)\n      result = new\n      result.value\
    \ = value\n      result\n    end\n\n    @value : Int64\n\n    def initialize\n\
    \      @value = 0i64\n    end\n\n    def initialize(value)\n      @value = value.to_i64\
    \ % MOD\n    end\n\n    def initialize(m : self)\n      @value = m.value\n   \
    \ end\n\n    protected def value=(value : Int64)\n      @value = value\n    end\n\
    \n    getter value : Int64\n\n    def + : self\n      self\n    end\n\n    def\
    \ - : self\n      self.class.raw(value != 0 ? MOD &- value : 0i64)\n    end\n\n\
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
    \    def to_m : {{name}}\n      {{name}}.new(self)\n    end\n  end\nend\n\nstatic_modint(Mint,\
    \ 1000000007)\nmod = 10i64**9 + 7\nx = Mint.new(mod - 1)\nmax = Int64::MAX % mod\n\
    \ndescribe \"Mint\" do\n  it \"mod\" do\n    Mint::MOD.should eq mod\n  end\n\n\
    \  it \"self.zero\" do\n    Mint.zero.value.should eq 0\n  end\n\n  it \"initialize\"\
    \ do\n    Mint.new.value.should eq 0\n    Mint.new(Int64::MIN).value.should eq\
    \ Int64::MIN % mod\n    Mint.new(0).value.should eq 0\n    Mint.new(42).value.should\
    \ eq 42\n    Mint.new(42i64).value.should eq 42\n    Mint.new(42i8).value.should\
    \ eq 42\n    Mint.new(mod).value.should eq 0\n    Mint.new(mod + 1).value.should\
    \ eq 1\n    Mint.new(mod * mod).value.should eq 0\n    Mint.new(Int64::MAX).value.should\
    \ eq max\n  end\n\n  it \"+\" do\n    (+Mint.new).value.should eq 0\n    (+Mint.new(12)).value.should\
    \ eq 12\n  end\n\n  it \"-\" do\n    (-Mint.new).value.should eq 0\n    (-Mint.new(12)).value.should\
    \ eq mod - 12\n  end\n\n  it \"+(other)\" do\n    a = Mint.new(1)\n    (a + a).value.should\
    \ eq 2\n    (a + 3).value.should eq 4\n    (a + 3i64).value.should eq 4\n    (a\
    \ + 3i8).value.should eq 4\n    (a + mod).value.should eq 1\n    (a + mod * 2).value.should\
    \ eq 1\n    (x + x).value.should eq mod - 2\n  end\n\n  it \"-(other)\" do\n \
    \   a = Mint.new(3)\n    (a - Mint.new(4)).value.should eq mod - 1\n    (a - 3).value.should\
    \ eq 0\n    (a - 3i64).value.should eq 0\n    (a - 3i8).value.should eq 0\n  \
    \  (a - 4).value.should eq mod - 1\n    (a - mod).value.should eq 3\n    (Mint.zero\
    \ - x).value.should eq 1\n  end\n\n  it \"*(other)\" do\n    a = Mint.new(3)\n\
    \    (a * 3).value.should eq 9\n    (a * a).value.should eq 9\n    (a * mod).value.should\
    \ eq 0\n    (x * mod).value.should eq 0\n    (x * x).value.should eq 1\n    (x\
    \ * Int64::MAX).value.should eq mod.pred * max % mod\n  end\n\n  it \"/(other)\"\
    \ do\n    a = Mint.new(3)\n    (a / 1).value.should eq 3\n    (a / 2).value.should\
    \ eq mod // 2 + 2\n    (a / 3).value.should eq 1\n    expect_raises(DivisionByZeroError)\
    \ { a / 0 }\n    expect_raises(DivisionByZeroError) { a / 0i8 }\n    expect_raises(DivisionByZeroError)\
    \ { a / mod }\n    expect_raises(DivisionByZeroError) { a / Mint.zero }\n  end\n\
    \n  it \"//(other)\" do\n    a = Mint.new(3)\n    (a // 1).value.should eq 3\n\
    \    (a // 2).value.should eq mod // 2 + 2\n    (a // 3).value.should eq 1\n \
    \   expect_raises(DivisionByZeroError) { a // 0 }\n    expect_raises(DivisionByZeroError)\
    \ { a // 0i8 }\n    expect_raises(DivisionByZeroError) { a // mod }\n    expect_raises(DivisionByZeroError)\
    \ { a // Mint.zero }\n  end\n\n  it \"**(other)\" do\n    a = Mint.new(3)\n  \
    \  (a ** 0).value.should eq 1\n    (a ** 1).value.should eq 3\n    (a ** 2).value.should\
    \ eq 9\n    (a ** 20).value.should eq 486784380\n    (a ** (10i64**18)).value.should\
    \ eq 246336683\n    (a.pred ** (10i64**18)).value.should eq 719476260\n  end\n\
    \n  it \"==(other)\" do\n    a = Mint.new(3)\n    (a == a).should be_true\n  \
    \  expect_raises(NotImplementedError) { a == 3 }\n    (a == Mint.new(mod + 3)).should\
    \ be_true\n  end\n\n  it \"!=(other)\" do\n    a = Mint.new(3)\n    (a != a).should\
    \ be_false\n    expect_raises(NotImplementedError) { a != 3 }\n    (a != Mint.new(mod\
    \ + 3)).should be_false\n  end\n\n  it \"succ\" do\n    Mint.new(0).succ.value.should\
    \ eq 1\n    Mint.new(3).succ.value.should eq 4\n    Mint.new(mod).succ.value.should\
    \ eq 1\n    x.succ.value.should eq 0\n  end\n\n  it \"pred\" do\n    Mint.new(0).pred.value.should\
    \ eq mod - 1\n    Mint.new(3).pred.value.should eq 2\n    Mint.new(mod).pred.value.should\
    \ eq mod - 1\n    x.pred.value.should eq mod - 2\n  end\n\n  it \"abs\" do\n \
    \   Mint.new(0).abs.value.should eq 0\n    Mint.new(3).abs.value.should eq 3\n\
    \    Mint.new(mod).abs.value.should eq 0\n    x.abs.value.should eq mod - 1\n\
    \  end\n\n  it \"value\" do\n    Mint.new(0).value.should eq 0\n    Mint.new(3).value.should\
    \ eq 3\n    Mint.new(mod).value.should eq 0\n    x.value.should eq mod - 1\n \
    \ end\n\n  it \"to_s\" do\n    Mint.new(0).to_s.should eq \"0\"\n    Mint.new(3).to_s.should\
    \ eq \"3\"\n    Mint.new(mod).to_s.should eq \"0\"\n    x.to_s.should eq (mod\
    \ - 1).to_s\n  end\n\n  it \"inspect\" do\n    Mint.new(0).inspect.should eq \"\
    0\"\n    Mint.new(3).inspect.should eq \"3\"\n    Mint.new(mod).inspect.should\
    \ eq \"0\"\n    x.inspect.should eq (mod - 1).to_s\n  end\n\n  it \"Int#+\" do\n\
    \    a = Mint.new(1)\n    (3 + a).value.should eq 4\n    (3i64 + a).value.should\
    \ eq 4\n    (3i8 + a).value.should eq 4\n    (mod + a).value.should eq 1\n   \
    \ (mod * 2 + a).value.should eq 1\n  end\n\n  it \"Int#-\" do\n    a = Mint.new(3)\n\
    \    (3 - a).value.should eq 0\n    (3i64 - a).value.should eq 0\n    (3i8 - a).value.should\
    \ eq 0\n    (4 - a).value.should eq 1\n    (mod - a).value.should eq mod - 3\n\
    \    (0 - x).value.should eq 1\n  end\n\n  it \"Int#*\" do\n    a = Mint.new(3)\n\
    \    (3 * a).value.should eq 9\n    (mod * a).value.should eq 0\n    (Int64::MAX\
    \ * x).value.should eq mod.pred * max % mod\n  end\n\n  it \"Int#/\" do\n    a\
    \ = Mint.new(3)\n    (3 / Mint.new(1)).value.should eq 3\n    (3 / Mint.new(2)).value.should\
    \ eq mod // 2 + 2\n    (3 / Mint.new(3)).value.should eq 1\n    expect_raises(DivisionByZeroError)\
    \ { 0 / Mint.zero }\n    expect_raises(DivisionByZeroError) { mod / Mint.new mod\
    \ }\n  end\n\n  it \"Int#//\" do\n    a = Mint.new(3)\n    (3 // Mint.new(1)).value.should\
    \ eq 3\n    (3 // Mint.new(2)).value.should eq mod // 2 + 2\n    (3 // Mint.new(3)).value.should\
    \ eq 1\n    expect_raises(DivisionByZeroError) { 0 // Mint.zero }\n    expect_raises(DivisionByZeroError)\
    \ { mod // Mint.new mod }\n  end\n\n  it \"Int#to_m\" do\n    (-1).to_m.value.should\
    \ eq mod - 1\n    (-1i8).to_m.value.should eq mod - 1\n    0.to_m.value.should\
    \ eq 0\n    1i64.to_m.value.should eq 1\n    mod.to_m.value.should eq 0\n  end\n\
    \n  it \"String#to_m\" do\n    \"-1\".to_m.value.should eq mod - 1\n    \"0\"\
    .to_m.value.should eq 0\n    \"1\".to_m.value.should eq 1\n    (mod - 1).to_s.to_m.value.should\
    \ eq mod - 1\n    mod.to_s.to_m.value.should eq 0\n  end\n\n  it \"compare\" do\n\
    \    a = Mint.new(3)\n    expect_raises(NotImplementedError) { a < 1 }\n    expect_raises(NotImplementedError)\
    \ { a <= 1 }\n    expect_raises(NotImplementedError) { a > 1 }\n    expect_raises(NotImplementedError)\
    \ { a >= 1 }\n    expect_raises(NotImplementedError) { 1 == a }\n    expect_raises(NotImplementedError)\
    \ { 1 != a }\n    expect_raises(NotImplementedError) { 1 < a }\n    expect_raises(NotImplementedError)\
    \ { 1 <= a }\n    expect_raises(NotImplementedError) { 1 > a }\n    expect_raises(NotImplementedError)\
    \ { 1 >= a }\n  end\nend\n"
  code: "require \"../math/Mint\"\nstatic_modint(Mint, 1000000007)\nmod = 10i64**9\
    \ + 7\nx = Mint.new(mod - 1)\nmax = Int64::MAX % mod\n\ndescribe \"Mint\" do\n\
    \  it \"mod\" do\n    Mint::MOD.should eq mod\n  end\n\n  it \"self.zero\" do\n\
    \    Mint.zero.value.should eq 0\n  end\n\n  it \"initialize\" do\n    Mint.new.value.should\
    \ eq 0\n    Mint.new(Int64::MIN).value.should eq Int64::MIN % mod\n    Mint.new(0).value.should\
    \ eq 0\n    Mint.new(42).value.should eq 42\n    Mint.new(42i64).value.should\
    \ eq 42\n    Mint.new(42i8).value.should eq 42\n    Mint.new(mod).value.should\
    \ eq 0\n    Mint.new(mod + 1).value.should eq 1\n    Mint.new(mod * mod).value.should\
    \ eq 0\n    Mint.new(Int64::MAX).value.should eq max\n  end\n\n  it \"+\" do\n\
    \    (+Mint.new).value.should eq 0\n    (+Mint.new(12)).value.should eq 12\n \
    \ end\n\n  it \"-\" do\n    (-Mint.new).value.should eq 0\n    (-Mint.new(12)).value.should\
    \ eq mod - 12\n  end\n\n  it \"+(other)\" do\n    a = Mint.new(1)\n    (a + a).value.should\
    \ eq 2\n    (a + 3).value.should eq 4\n    (a + 3i64).value.should eq 4\n    (a\
    \ + 3i8).value.should eq 4\n    (a + mod).value.should eq 1\n    (a + mod * 2).value.should\
    \ eq 1\n    (x + x).value.should eq mod - 2\n  end\n\n  it \"-(other)\" do\n \
    \   a = Mint.new(3)\n    (a - Mint.new(4)).value.should eq mod - 1\n    (a - 3).value.should\
    \ eq 0\n    (a - 3i64).value.should eq 0\n    (a - 3i8).value.should eq 0\n  \
    \  (a - 4).value.should eq mod - 1\n    (a - mod).value.should eq 3\n    (Mint.zero\
    \ - x).value.should eq 1\n  end\n\n  it \"*(other)\" do\n    a = Mint.new(3)\n\
    \    (a * 3).value.should eq 9\n    (a * a).value.should eq 9\n    (a * mod).value.should\
    \ eq 0\n    (x * mod).value.should eq 0\n    (x * x).value.should eq 1\n    (x\
    \ * Int64::MAX).value.should eq mod.pred * max % mod\n  end\n\n  it \"/(other)\"\
    \ do\n    a = Mint.new(3)\n    (a / 1).value.should eq 3\n    (a / 2).value.should\
    \ eq mod // 2 + 2\n    (a / 3).value.should eq 1\n    expect_raises(DivisionByZeroError)\
    \ { a / 0 }\n    expect_raises(DivisionByZeroError) { a / 0i8 }\n    expect_raises(DivisionByZeroError)\
    \ { a / mod }\n    expect_raises(DivisionByZeroError) { a / Mint.zero }\n  end\n\
    \n  it \"//(other)\" do\n    a = Mint.new(3)\n    (a // 1).value.should eq 3\n\
    \    (a // 2).value.should eq mod // 2 + 2\n    (a // 3).value.should eq 1\n \
    \   expect_raises(DivisionByZeroError) { a // 0 }\n    expect_raises(DivisionByZeroError)\
    \ { a // 0i8 }\n    expect_raises(DivisionByZeroError) { a // mod }\n    expect_raises(DivisionByZeroError)\
    \ { a // Mint.zero }\n  end\n\n  it \"**(other)\" do\n    a = Mint.new(3)\n  \
    \  (a ** 0).value.should eq 1\n    (a ** 1).value.should eq 3\n    (a ** 2).value.should\
    \ eq 9\n    (a ** 20).value.should eq 486784380\n    (a ** (10i64**18)).value.should\
    \ eq 246336683\n    (a.pred ** (10i64**18)).value.should eq 719476260\n  end\n\
    \n  it \"==(other)\" do\n    a = Mint.new(3)\n    (a == a).should be_true\n  \
    \  expect_raises(NotImplementedError) { a == 3 }\n    (a == Mint.new(mod + 3)).should\
    \ be_true\n  end\n\n  it \"!=(other)\" do\n    a = Mint.new(3)\n    (a != a).should\
    \ be_false\n    expect_raises(NotImplementedError) { a != 3 }\n    (a != Mint.new(mod\
    \ + 3)).should be_false\n  end\n\n  it \"succ\" do\n    Mint.new(0).succ.value.should\
    \ eq 1\n    Mint.new(3).succ.value.should eq 4\n    Mint.new(mod).succ.value.should\
    \ eq 1\n    x.succ.value.should eq 0\n  end\n\n  it \"pred\" do\n    Mint.new(0).pred.value.should\
    \ eq mod - 1\n    Mint.new(3).pred.value.should eq 2\n    Mint.new(mod).pred.value.should\
    \ eq mod - 1\n    x.pred.value.should eq mod - 2\n  end\n\n  it \"abs\" do\n \
    \   Mint.new(0).abs.value.should eq 0\n    Mint.new(3).abs.value.should eq 3\n\
    \    Mint.new(mod).abs.value.should eq 0\n    x.abs.value.should eq mod - 1\n\
    \  end\n\n  it \"value\" do\n    Mint.new(0).value.should eq 0\n    Mint.new(3).value.should\
    \ eq 3\n    Mint.new(mod).value.should eq 0\n    x.value.should eq mod - 1\n \
    \ end\n\n  it \"to_s\" do\n    Mint.new(0).to_s.should eq \"0\"\n    Mint.new(3).to_s.should\
    \ eq \"3\"\n    Mint.new(mod).to_s.should eq \"0\"\n    x.to_s.should eq (mod\
    \ - 1).to_s\n  end\n\n  it \"inspect\" do\n    Mint.new(0).inspect.should eq \"\
    0\"\n    Mint.new(3).inspect.should eq \"3\"\n    Mint.new(mod).inspect.should\
    \ eq \"0\"\n    x.inspect.should eq (mod - 1).to_s\n  end\n\n  it \"Int#+\" do\n\
    \    a = Mint.new(1)\n    (3 + a).value.should eq 4\n    (3i64 + a).value.should\
    \ eq 4\n    (3i8 + a).value.should eq 4\n    (mod + a).value.should eq 1\n   \
    \ (mod * 2 + a).value.should eq 1\n  end\n\n  it \"Int#-\" do\n    a = Mint.new(3)\n\
    \    (3 - a).value.should eq 0\n    (3i64 - a).value.should eq 0\n    (3i8 - a).value.should\
    \ eq 0\n    (4 - a).value.should eq 1\n    (mod - a).value.should eq mod - 3\n\
    \    (0 - x).value.should eq 1\n  end\n\n  it \"Int#*\" do\n    a = Mint.new(3)\n\
    \    (3 * a).value.should eq 9\n    (mod * a).value.should eq 0\n    (Int64::MAX\
    \ * x).value.should eq mod.pred * max % mod\n  end\n\n  it \"Int#/\" do\n    a\
    \ = Mint.new(3)\n    (3 / Mint.new(1)).value.should eq 3\n    (3 / Mint.new(2)).value.should\
    \ eq mod // 2 + 2\n    (3 / Mint.new(3)).value.should eq 1\n    expect_raises(DivisionByZeroError)\
    \ { 0 / Mint.zero }\n    expect_raises(DivisionByZeroError) { mod / Mint.new mod\
    \ }\n  end\n\n  it \"Int#//\" do\n    a = Mint.new(3)\n    (3 // Mint.new(1)).value.should\
    \ eq 3\n    (3 // Mint.new(2)).value.should eq mod // 2 + 2\n    (3 // Mint.new(3)).value.should\
    \ eq 1\n    expect_raises(DivisionByZeroError) { 0 // Mint.zero }\n    expect_raises(DivisionByZeroError)\
    \ { mod // Mint.new mod }\n  end\n\n  it \"Int#to_m\" do\n    (-1).to_m.value.should\
    \ eq mod - 1\n    (-1i8).to_m.value.should eq mod - 1\n    0.to_m.value.should\
    \ eq 0\n    1i64.to_m.value.should eq 1\n    mod.to_m.value.should eq 0\n  end\n\
    \n  it \"String#to_m\" do\n    \"-1\".to_m.value.should eq mod - 1\n    \"0\"\
    .to_m.value.should eq 0\n    \"1\".to_m.value.should eq 1\n    (mod - 1).to_s.to_m.value.should\
    \ eq mod - 1\n    mod.to_s.to_m.value.should eq 0\n  end\n\n  it \"compare\" do\n\
    \    a = Mint.new(3)\n    expect_raises(NotImplementedError) { a < 1 }\n    expect_raises(NotImplementedError)\
    \ { a <= 1 }\n    expect_raises(NotImplementedError) { a > 1 }\n    expect_raises(NotImplementedError)\
    \ { a >= 1 }\n    expect_raises(NotImplementedError) { 1 == a }\n    expect_raises(NotImplementedError)\
    \ { 1 != a }\n    expect_raises(NotImplementedError) { 1 < a }\n    expect_raises(NotImplementedError)\
    \ { 1 <= a }\n    expect_raises(NotImplementedError) { 1 > a }\n    expect_raises(NotImplementedError)\
    \ { 1 >= a }\n  end\nend\n"
  dependsOn:
  - math/Mint.cr
  isVerificationFile: false
  path: spec/Mint_spec.cr
  requiredBy: []
  timestamp: '2021-06-24 10:02:07+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/Mint_spec.cr
layout: document
redirect_from:
- /library/spec/Mint_spec.cr
- /library/spec/Mint_spec.cr.html
title: spec/Mint_spec.cr
---
