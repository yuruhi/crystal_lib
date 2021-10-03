---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: src/math/mint.cr
    title: src/math/mint.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://onlinejudge.u-aizu.ac.jp/courses/library/6/NTL/1/NTL_1_B
  bundledCode: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/library/6/NTL/1/NTL_1_B\n\
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
    \ 998244353)\n\na, b = read_line.split.map(&.to_i)\nputs Mint.new(a)**b\n"
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
  timestamp: '2021-08-04 13:11:57+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/math/powmod_test.cr
layout: document
redirect_from:
- /verify/test/math/powmod_test.cr
- /verify/test/math/powmod_test.cr.html
title: test/math/powmod_test.cr
---
