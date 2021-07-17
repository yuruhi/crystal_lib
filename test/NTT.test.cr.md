---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: math/Mint.cr
    title: math/Mint.cr
  - icon: ':heavy_check_mark:'
    path: math/NTT.cr
    title: math/NTT.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/convolution_mod
  bundledCode: "# verification-helper: PROBLEM https://judge.yosupo.jp/problem/convolution_mod\n\
    # require \"../math/NTT\"\n# reference : https://kopricky.github.io/code/FFTs/ntt.html\n\
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
    \   a\n  end\n\n  def self.multiple(a : Array(T), b : Array(T)) forall T\n   \
    \ size = a.size + b.size - 1\n    t = Math.pw2ceil(size)\n    aa = a + Array.new(t\
    \ - a.size, T.zero)\n    bb = b + Array.new(t - b.size, T.zero)\n    c = ntt(aa).zip(ntt(bb)).map\
    \ { |x, y| x * y }\n    ntt(c, true).first(size)\n  end\nend\n\n# require \"../math/Mint\"\
    \n# require \"../atcoder/src/Math\"\n# ac-library.cr by hakatashi https://github.com/google/ac-library.cr\n\
    #\n# Copyright 2021 Google LLC\n#\n# Licensed under the Apache License, Version\
    \ 2.0 (the \"License\");\n# you may not use this file except in compliance with\
    \ the License.\n# You may obtain a copy of the License at\n#\n#      https://www.apache.org/licenses/LICENSE-2.0\n\
    #\n# Unless required by applicable law or agreed to in writing, software\n# distributed\
    \ under the License is distributed on an \"AS IS\" BASIS,\n# WITHOUT WARRANTIES\
    \ OR CONDITIONS OF ANY KIND, either express or implied.\n# See the License for\
    \ the specific language governing permissions and\n# limitations under the License.\n\
    \nmodule AtCoder\n  # Implements [ACL's Math library](https://atcoder.github.io/ac-library/master/document_en/math.html)\n\
    \  module Math\n    def self.extended_gcd(a, b)\n      last_remainder, remainder\
    \ = a.abs, b.abs\n      x, last_x, y, last_y = 0_i64, 1_i64, 1_i64, 0_i64\n  \
    \    while remainder != 0\n        new_last_remainder = remainder\n        quotient,\
    \ remainder = last_remainder.divmod(remainder)\n        last_remainder = new_last_remainder\n\
    \        x, last_x = last_x - quotient * x, x\n        y, last_y = last_y - quotient\
    \ * y, y\n      end\n\n      return last_remainder, last_x * (a < 0 ? -1 : 1)\n\
    \    end\n\n    # Implements atcoder::inv_mod(value, modulo).\n    def self.inv_mod(value,\
    \ modulo)\n      gcd, inv = extended_gcd(value, modulo)\n      if gcd != 1\n \
    \       raise ArgumentError.new(\"#{value} and #{modulo} are not coprime\")\n\
    \      end\n      inv % modulo\n    end\n\n    # Simplified AtCoder::Math.pow_mod\
    \ with support of Int64\n    def self.pow_mod(base, exponent, modulo)\n      if\
    \ exponent == 0\n        return base.class.zero + 1\n      end\n      if base\
    \ == 0\n        return base\n      end\n      b = exponent > 0 ? base : inv_mod(base,\
    \ modulo)\n      e = exponent.abs\n      ret = 1_i64\n      while e > 0\n    \
    \    if e % 2 == 1\n          ret = mul_mod(ret, b, modulo)\n        end\n   \
    \     b = mul_mod(b, b, modulo)\n        e //= 2\n      end\n      ret\n    end\n\
    \n    # Caluculates a * b % mod without overflow detection\n    @[AlwaysInline]\n\
    \    def self.mul_mod(a : Int64, b : Int64, mod : Int64)\n      if mod < Int32::MAX\n\
    \        return a * b % mod\n      end\n\n      # 31-bit width\n      a_high =\
    \ (a >> 32).to_u64\n      # 32-bit width\n      a_low = (a & 0xFFFFFFFF).to_u64\n\
    \      # 31-bit width\n      b_high = (b >> 32).to_u64\n      # 32-bit width\n\
    \      b_low = (b & 0xFFFFFFFF).to_u64\n\n      # 31-bit + 32-bit + 1-bit = 64-bit\n\
    \      c = a_high * b_low + b_high * a_low\n      c_high = c >> 32\n      c_low\
    \ = c & 0xFFFFFFFF\n\n      # 31-bit + 31-bit\n      res_high = a_high * b_high\
    \ + c_high\n      # 32-bit + 32-bit\n      res_low = a_low * b_low\n      res_low_high\
    \ = res_low >> 32\n      res_low_low = res_low & 0xFFFFFFFF\n\n      # Overflow\n\
    \      if res_low_high + c_low >= 0x100000000\n        res_high += 1\n      end\n\
    \n      res_low = (((res_low_high + c_low) & 0xFFFFFFFF) << 32) | res_low_low\n\
    \n      (((res_high.to_i128 << 64) | res_low) % mod).to_i64\n    end\n\n    @[AlwaysInline]\n\
    \    def self.mul_mod(a, b, mod)\n      typeof(mod).new(a.to_i64 * b % mod)\n\
    \    end\n\n    # Implements atcoder::crt(remainders, modulos).\n    def self.crt(remainders,\
    \ modulos)\n      raise ArgumentError.new unless remainders.size == modulos.size\n\
    \n      total_modulo = 1_i64\n      answer = 0_i64\n\n      remainders.zip(modulos).each\
    \ do |(remainder, modulo)|\n        gcd, p = extended_gcd(total_modulo, modulo)\n\
    \        if (remainder - answer) % gcd != 0\n          return 0_i64, 0_i64\n \
    \       end\n        tmp = (remainder - answer) // gcd * p % (modulo // gcd)\n\
    \        answer += total_modulo * tmp\n        total_modulo *= modulo // gcd\n\
    \      end\n\n      return answer % total_modulo, total_modulo\n    end\n\n  \
    \  # Implements atcoder::floor_sum(n, m, a, b).\n    def self.floor_sum(n, m,\
    \ a, b)\n      n, m, a, b = n.to_i64, m.to_i64, a.to_i64, b.to_i64\n      res\
    \ = 0_i64\n\n      if a < 0\n        a2 = a % m\n        res -= n * (n - 1) //\
    \ 2 * ((a2 - a) // m)\n        a = a2\n      end\n\n      if b < 0\n        b2\
    \ = b % m\n        res -= n * ((b2 - b) // m)\n        b = b2\n      end\n\n \
    \     res + floor_sum_unsigned(n, m, a, b)\n    end\n\n    private def self.floor_sum_unsigned(n,\
    \ m, a, b)\n      res = 0_i64\n\n      loop do\n        if a >= m\n          res\
    \ += n * (n - 1) // 2 * (a // m)\n          a = a % m\n        end\n\n       \
    \ if b >= m\n          res += n * (b // m)\n          b = b % m\n        end\n\
    \n        y_max = a * n + b\n        break if y_max < m\n\n        n = y_max //\
    \ m\n        b = y_max % m\n        m, a = a, m\n      end\n\n      res\n    end\n\
    \  end\nend\n\nmacro static_modint(name, mod)\n  struct {{name}}\n    MOD = Int64.new({{mod}})\n\
    \n    def self.zero\n      new\n    end\n\n    def self.raw(value : Int64)\n \
    \     result = new\n      result.value = value\n      result\n    end\n\n    getter\
    \ value : Int64\n\n    def initialize\n      @value = 0i64\n    end\n\n    def\
    \ initialize(value)\n      @value = value.to_i64 % MOD\n    end\n\n    def initialize(m\
    \ : self)\n      @value = m.value\n    end\n\n    protected def value=(value :\
    \ Int64)\n      @value = value\n    end\n\n    def ==(m : self)\n      value ==\
    \ m.value\n    end\n\n    def ==(m)\n      value == m\n    end\n\n    def + :\
    \ self\n      self\n    end\n\n    def - : self\n      self.class.raw(value !=\
    \ 0 ? MOD &- value : 0i64)\n    end\n\n    def +(v)\n      self + self.class.new(v)\n\
    \    end\n\n    def +(m : self)\n      x = value &+ m.value\n      x &-= MOD if\
    \ x >= MOD\n      self.class.raw(x)\n    end\n\n    def -(v)\n      self - self.class.new(v)\n\
    \    end\n\n    def -(m : self)\n      x = value &- m.value\n      x &+= MOD if\
    \ x < 0\n      self.class.raw(x)\n    end\n\n    def *(v)\n      self * self.class.new(v)\n\
    \    end\n\n    def *(m : self)\n      self.class.new(value &* m.value)\n    end\n\
    \n    def /(v)\n      self / self.class.new(v)\n    end\n\n    def /(m : self)\n\
    \      raise DivisionByZeroError.new if m.value == 0\n      a, b, u, v = m.to_i64,\
    \ MOD, 1i64, 0i64\n      while b != 0\n        t = a // b\n        a &-= t &*\
    \ b\n        a, b = b, a\n        u &-= t &* v\n        u, v = v, u\n      end\n\
    \      self.class.new(value &* u)\n    end\n\n    def //(v)\n      self / v\n\
    \    end\n\n    def **(exponent : Int)\n      t, res = self, self.class.raw(1i64)\n\
    \      while exponent > 0\n        res *= t if exponent & 1 == 1\n        t *=\
    \ t\n        exponent >>= 1\n      end\n      res\n    end\n\n    {% for op in\
    \ %w[< <= > >=] %}\n      def {{op.id}}(other)\n        raise NotImplementedError.new({{op}})\n\
    \      end\n    {% end %}\n\n    def inv\n      self.class.raw AtCoder::Math.inv_mod(value,\
    \ MOD)\n    end\n\n    def succ\n      self.class.raw(value != MOD &- 1 ? value\
    \ &+ 1 : 0i64)\n    end\n\n    def pred\n      self.class.raw(value != 0 ? value\
    \ &- 1 : MOD &- 1)\n    end\n\n    def abs\n      self\n    end\n\n    def to_i64\
    \ : Int64\n      value\n    end\n\n    delegate to_s, to: @value\n    delegate\
    \ inspect, to: @value\n  end\n\n  {% to = (\"to_\" + name.stringify.downcase.gsub(/mint|modint/,\
    \ \"m\")).id %}\n\n  struct Int\n    {% for op in %w[+ - * / //] %}\n      def\
    \ {{op.id}}(value : {{name}})\n        {{to}} {{op.id}} value\n      end\n   \
    \ {% end %}\n\n    {% for op in %w[< <= > >=] %}\n      def {{op.id}}(m : {{name}})\n\
    \        raise NotImplementedError.new({{op}})\n      end\n    {% end %}\n\n \
    \   def {{to}} : {{name}}\n      {{name}}.new(self)\n    end\n  end\n\n  class\
    \ String\n    def {{to}} : {{name}}\n      {{name}}.new(self)\n    end\n  end\n\
    end\n\nstatic_modint(Mint, 10**9 + 7)\nstatic_modint(Mint2, 998244353)\n\nn, m\
    \ = read_line.split.map(&.to_i)\na = read_line.split.map(&.to_m2)\nb = read_line.split.map(&.to_m2)\n\
    puts NTT.multiple(a, b).join(' ')\n"
  code: '# verification-helper: PROBLEM https://judge.yosupo.jp/problem/convolution_mod

    require "../math/NTT"

    require "../math/Mint"

    n, m = read_line.split.map(&.to_i)

    a = read_line.split.map(&.to_m2)

    b = read_line.split.map(&.to_m2)

    puts NTT.multiple(a, b).join('' '')

    '
  dependsOn:
  - math/NTT.cr
  - math/Mint.cr
  isVerificationFile: true
  path: test/NTT.test.cr
  requiredBy: []
  timestamp: '2021-06-26 20:26:24+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/NTT.test.cr
layout: document
redirect_from:
- /verify/test/NTT.test.cr
- /verify/test/NTT.test.cr.html
title: test/NTT.test.cr
---