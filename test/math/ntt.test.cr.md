---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/math/mint.cr
    title: src/math/mint.cr
  - icon: ':heavy_check_mark:'
    path: src/math/ntt.cr
    title: src/math/ntt.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/convolution_mod
  bundledCode: "# verification-helper: PROBLEM https://judge.yosupo.jp/problem/convolution_mod\n\
    # require \"../../src/math/ntt\"\n# reference : https://kopricky.github.io/code/FFTs/ntt.html\n\
    class NTT\n  ROOT = 3\n\n  private def self.ntt(a : Array(T), rev = false) forall\
    \ T\n    return a if a.size == 1\n    b = Array.new(a.size, T.zero)\n    r = T::MOD.pred\
    \ // a.size\n    r = T::MOD.pred - r if rev\n    s = T.new(ROOT) ** r\n    kp\
    \ = Array.new(a.size // 2 + 1, T.new(1))\n    (1...kp.size).each { |i| kp[i] =\
    \ kp[i - 1] * s }\n\n    i, l = 1, a.size // 2\n    while i < a.size\n      r\
    \ = 0\n      (0...l).each do |j|\n        s = kp[i * j]\n        (0...i).each\
    \ do |k|\n          p, q = a[k + r], a[k + r + a.size // 2]\n          b[k + 2\
    \ * r] = p + q\n          b[k + 2 * r + i] = (p - q) * s\n        end\n      \
    \  r += i\n      end\n      a, b = b, a\n      i <<= 1; l >>= 1\n    end\n   \
    \ if rev\n      s = T.new(a.size).inv\n      a.map! { |x| x * s }\n    end\n \
    \   a\n  end\n\n  def self.convolution(a : Array(T), b : Array(T)) forall T\n\
    \    size = a.size + b.size - 1\n    t = Math.pw2ceil(size)\n    aa = a + Array.new(t\
    \ - a.size, T.zero)\n    bb = b + Array.new(t - b.size, T.zero)\n    c = ntt(aa).zip(ntt(bb)).map\
    \ { |x, y| x * y }\n    ntt(c, true).first(size)\n  end\nend\n\n# require \"../../src/math/mint\"\
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
    \ 998244353)\n\n_, _ = read_line.split.map(&.to_i)\na = read_line.split.map(&.to_m2)\n\
    b = read_line.split.map(&.to_m2)\nputs NTT.convolution(a, b).join(' ')\n"
  code: '# verification-helper: PROBLEM https://judge.yosupo.jp/problem/convolution_mod

    require "../../src/math/ntt"

    require "../../src/math/mint"

    _, _ = read_line.split.map(&.to_i)

    a = read_line.split.map(&.to_m2)

    b = read_line.split.map(&.to_m2)

    puts NTT.convolution(a, b).join('' '')

    '
  dependsOn:
  - src/math/ntt.cr
  - src/math/mint.cr
  isVerificationFile: true
  path: test/math/ntt.test.cr
  requiredBy: []
  timestamp: '2021-07-18 13:52:56+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/math/ntt.test.cr
layout: document
redirect_from:
- /verify/test/math/ntt.test.cr
- /verify/test/math/ntt.test.cr.html
title: test/math/ntt.test.cr
---
