---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/Mint_spec.cr
    title: spec/Mint_spec.cr
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/Combination.test.cr
    title: test/Combination.test.cr
  - icon: ':heavy_check_mark:'
    path: test/Matrix.test.cr
    title: test/Matrix.test.cr
  - icon: ':heavy_check_mark:'
    path: test/powmod.test.cr
    title: test/powmod.test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "macro static_modint(name, mod)\n  struct {{name}}\n    MOD = Int64.new({{mod}})\n\
    \n    def self.zero\n      new\n    end\n\n    def self.raw(value : Int64)\n \
    \     result = new\n      result.value = value\n      result\n    end\n\n    @value\
    \ : Int64\n\n    def initialize\n      @value = 0i64\n    end\n\n    def initialize(value)\n\
    \      @value = value.to_i64 % MOD\n    end\n\n    def initialize(m : self)\n\
    \      @value = m.value\n    end\n\n    protected def value=(value : Int64)\n\
    \      @value = value\n    end\n\n    getter value : Int64\n\n    def + : self\n\
    \      self\n    end\n\n    def - : self\n      self.class.raw(value != 0 ? MOD\
    \ &- value : 0i64)\n    end\n\n    def +(v)\n      self + v.to_m\n    end\n\n\
    \    def +(m : self)\n      x = value &+ m.value\n      x &-= MOD if x >= MOD\n\
    \      self.class.raw(x)\n    end\n\n    def -(v)\n      self - v.to_m\n    end\n\
    \n    def -(m : self)\n      x = value &- m.value\n      x &+= MOD if x < 0\n\
    \      self.class.raw(x)\n    end\n\n    def *(v)\n      self * v.to_m\n    end\n\
    \n    def *(m : self)\n      self.class.new(value &* m.value)\n    end\n\n   \
    \ def /(v)\n      self / v.to_m\n    end\n\n    def /(m : self)\n      raise DivisionByZeroError.new\
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
    \    def to_m : {{name}}\n      {{name}}.new(self)\n    end\n  end\nend\n"
  code: "macro static_modint(name, mod)\n  struct {{name}}\n    MOD = Int64.new({{mod}})\n\
    \n    def self.zero\n      new\n    end\n\n    def self.raw(value : Int64)\n \
    \     result = new\n      result.value = value\n      result\n    end\n\n    @value\
    \ : Int64\n\n    def initialize\n      @value = 0i64\n    end\n\n    def initialize(value)\n\
    \      @value = value.to_i64 % MOD\n    end\n\n    def initialize(m : self)\n\
    \      @value = m.value\n    end\n\n    protected def value=(value : Int64)\n\
    \      @value = value\n    end\n\n    getter value : Int64\n\n    def + : self\n\
    \      self\n    end\n\n    def - : self\n      self.class.raw(value != 0 ? MOD\
    \ &- value : 0i64)\n    end\n\n    def +(v)\n      self + v.to_m\n    end\n\n\
    \    def +(m : self)\n      x = value &+ m.value\n      x &-= MOD if x >= MOD\n\
    \      self.class.raw(x)\n    end\n\n    def -(v)\n      self - v.to_m\n    end\n\
    \n    def -(m : self)\n      x = value &- m.value\n      x &+= MOD if x < 0\n\
    \      self.class.raw(x)\n    end\n\n    def *(v)\n      self * v.to_m\n    end\n\
    \n    def *(m : self)\n      self.class.new(value &* m.value)\n    end\n\n   \
    \ def /(v)\n      self / v.to_m\n    end\n\n    def /(m : self)\n      raise DivisionByZeroError.new\
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
    \    def to_m : {{name}}\n      {{name}}.new(self)\n    end\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: math/Mint.cr
  requiredBy:
  - spec/Mint_spec.cr
  timestamp: '2021-06-24 10:22:55+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/Matrix.test.cr
  - test/powmod.test.cr
  - test/Combination.test.cr
documentation_of: math/Mint.cr
layout: document
redirect_from:
- /library/math/Mint.cr
- /library/math/Mint.cr.html
title: math/Mint.cr
---
