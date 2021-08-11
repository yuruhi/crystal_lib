---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: atcoder/src/Math.cr
    title: atcoder/src/Math.cr
  - icon: ':question:'
    path: src/math/mint.cr
    title: src/math/mint.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../src/math/mint\"\nmacro static_modint(name,\
    \ mod)\n  struct {{name}}\n    MOD = {{mod}}i64\n\n    def self.zero\n      new\n\
    \    end\n\n    def self.raw(value : Int64)\n      result = new\n      result.value\
    \ = value\n      result\n    end\n\n    macro [](*nums)\n      {% verbatim do\
    \ %}\n        Array({{@type}}).build({{nums.size}}) do |%buffer|\n          {%\
    \ for num, i in nums %}\n            %buffer[{{i}}] = {{@type}}.new({{num}})\n\
    \          {% end %}\n          {{nums.size}}\n        end\n      {% end %}\n\
    \    end\n\n    getter value : Int64\n\n    def initialize\n      @value = 0i64\n\
    \    end\n\n    def initialize(value)\n      @value = value.to_i64 % MOD\n   \
    \ end\n\n    def initialize(m : self)\n      @value = m.value\n    end\n\n   \
    \ protected def value=(value : Int64)\n      @value = value\n    end\n\n    def\
    \ ==(m : self)\n      value == m.value\n    end\n\n    def ==(m)\n      value\
    \ == m\n    end\n\n    def + : self\n      self\n    end\n\n    def - : self\n\
    \      self.class.raw(value != 0 ? MOD &- value : 0i64)\n    end\n\n    def +(v)\n\
    \      self + self.class.new(v)\n    end\n\n    def +(m : self)\n      x = value\
    \ &+ m.value\n      x &-= MOD if x >= MOD\n      self.class.raw(x)\n    end\n\n\
    \    def -(v)\n      self - self.class.new(v)\n    end\n\n    def -(m : self)\n\
    \      x = value &- m.value\n      x &+= MOD if x < 0\n      self.class.raw(x)\n\
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
    \ 998244353)\n\n# require \"../../atcoder/src/Math\"\n# ac-library.cr by hakatashi\
    \ https://github.com/google/ac-library.cr\n#\n# Copyright 2021 Google LLC\n#\n\
    # Licensed under the Apache License, Version 2.0 (the \"License\");\n# you may\
    \ not use this file except in compliance with the License.\n# You may obtain a\
    \ copy of the License at\n#\n#      https://www.apache.org/licenses/LICENSE-2.0\n\
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
    \  end\nend\n\nmod = 10i64**9 + 7\nx = Mint.new(mod - 1)\nmax = Int64::MAX % mod\n\
    \nmacro check_binary_operator(type, op)\n  %mod = {{type}}::MOD\n  0i64.step(to:\
    \ %mod, by: %mod // 1000).each do |x|\n    0i64.step(to: %mod, by: %mod // 999).each\
    \ do |y|\n      m = {{type}}.new(x) {{op.id}} {{type}}.new(y)\n      expect =\
    \ (x {{op.id}} y) % %mod\n      m.should eq expect\n    end\n  end\nend\n\nmacro\
    \ check_method(type, method)\n  %mod = {{type}}::MOD\n  0i64.step(to: %mod, by:\
    \ %mod // 1000000).each do |x|\n    {{type}}.new(x).{{method}}.should eq x.{{method}}\n\
    \  end\nend\n\nmacro check_method_mod(type, method)\n  %mod = {{type}}::MOD\n\
    \  0i64.step(to: %mod, by: %mod // 1000000).each do |x|\n    {{type}}.new(x).{{method}}.should\
    \ eq x.{{method}} % %mod\n  end\nend\n\ndescribe \"Mint\" do\n  it \".[]\" do\n\
    \    Mint[0, 1, 2, 3].should eq [0.to_m, 1.to_m, 2.to_m, 3.to_m]\n    Mint[0,\
    \ 1, mod, mod + 1, mod * 2].map(&.value).should eq [0, 1, 0, 1, 0]\n  end\n\n\
    \  it \"::MOD\" do\n    Mint::MOD.should eq mod\n  end\n\n  it \".zero\" do\n\
    \    Mint.zero.should eq 0\n  end\n\n  it \"#initialize\" do\n    Mint.new.should\
    \ eq 0\n    Mint.new(Int64::MIN).should eq Int64::MIN % mod\n    Mint.new(0).should\
    \ eq 0\n    Mint.new(42).should eq 42\n    Mint.new(42i64).should eq 42\n    Mint.new(42i8).should\
    \ eq 42\n    Mint.new(mod).should eq 0\n    Mint.new(mod + 1).should eq 1\n  \
    \  Mint.new(mod * mod).should eq 0\n    Mint.new(Int64::MAX).should eq max\n \
    \ end\n\n  it \"#+\" do\n    (+Mint.new).should eq 0\n    (+Mint.new(12)).should\
    \ eq 12\n  end\n\n  it \"#-\" do\n    (-Mint.new).should eq 0\n    (-Mint.new(12)).should\
    \ eq mod - 12\n  end\n\n  it \"#+(other)\" do\n    a = Mint.new(1)\n    (a + a).should\
    \ eq 2\n    (a + 3).should eq 4\n    (a + 3i64).should eq 4\n    (a + 3i8).should\
    \ eq 4\n    (a + mod).should eq 1\n    (a + mod * 2).should eq 1\n    (x + x).should\
    \ eq mod - 2\n    check_binary_operator(Mint, \"+\")\n    check_binary_operator(Mint2,\
    \ \"+\")\n  end\n\n  it \"#-(other)\" do\n    a = Mint.new(3)\n    (a - Mint.new(4)).should\
    \ eq mod - 1\n    (a - 3).should eq 0\n    (a - 3i64).should eq 0\n    (a - 3i8).should\
    \ eq 0\n    (a - 4).should eq mod - 1\n    (a - mod).should eq 3\n    (Mint.zero\
    \ - x).should eq 1\n    check_binary_operator(Mint, \"-\")\n    check_binary_operator(Mint2,\
    \ \"-\")\n  end\n\n  it \"#*(other)\" do\n    a = Mint.new(3)\n    (a * 3).should\
    \ eq 9\n    (a * a).should eq 9\n    (a * mod).should eq 0\n    (x * mod).should\
    \ eq 0\n    (x * x).should eq 1\n    (x * Int64::MAX).should eq mod.pred * max\
    \ % mod\n    check_binary_operator(Mint, \"*\")\n    check_binary_operator(Mint2,\
    \ \"*\")\n  end\n\n  it \"#/(other)\" do\n    a = Mint.new(3)\n    (a / 1).should\
    \ eq 3\n    (a / 2).should eq mod // 2 + 2\n    (a / 3).should eq 1\n\n    {%\
    \ for type in [Mint, Mint2] %}\n      %mod = {{type}}::MOD\n      0i64.step(by:\
    \ %mod, to: %mod // 1000) do |x|\n        0i64.step(by: %mod, to: %mod // 999)\
    \ do |y|\n          next unless y.gcd(%mod) == 1\n          z = {{type}}.new(x)\
    \ / y\n          (z * y).should eq x\n        end\n      end\n    {% end %}\n\n\
    \    expect_raises(DivisionByZeroError) { a / 0 }\n    expect_raises(DivisionByZeroError)\
    \ { a / 0i8 }\n    expect_raises(DivisionByZeroError) { a / mod }\n    expect_raises(DivisionByZeroError)\
    \ { a / Mint.zero }\n  end\n\n  it \"#//(other)\" do\n    a = Mint.new(3)\n  \
    \  (a // 1).should eq 3\n    (a // 2).should eq mod // 2 + 2\n    (a // 3).should\
    \ eq 1\n\n    {% for type in [Mint, Mint2] %}\n      %mod = {{type}}::MOD\n  \
    \    0i64.step(by: %mod, to: %mod // 1000) do |x|\n        0i64.step(by: %mod,\
    \ to: %mod // 999) do |y|\n          next unless y.gcd(%mod) == 1\n          z\
    \ = {{type}}.new(x) // y\n          (z * y).should eq x\n        end\n      end\n\
    \    {% end %}\n\n    expect_raises(DivisionByZeroError) { a // 0 }\n    expect_raises(DivisionByZeroError)\
    \ { a // 0i8 }\n    expect_raises(DivisionByZeroError) { a // mod }\n    expect_raises(DivisionByZeroError)\
    \ { a // Mint.zero }\n  end\n\n  it \"#**(other)\" do\n    a = Mint.new(3)\n \
    \   (a ** 0).should eq 1\n    (a ** 1).should eq 3\n    (a ** 2).should eq 9\n\
    \    (a ** 20).should eq 486784380\n    (a ** (10i64**18)).should eq 246336683\n\
    \    (a.pred ** (10i64**18)).should eq 719476260\n\n    {% for type in [Mint,\
    \ Mint2] %}\n      %mod = {{type}}::MOD\n      0i64.step(by: %mod, to: %mod //\
    \ 1000) do |x|\n        0i64.step(by: Int64::MAX, to: Int64::MAX // 1000) do |e|\n\
    \          m = {{type}}.new(x) ** e\n          expect = AtCoder::Math.pow_mod(x,\
    \ e, mod)\n          m.should eq expect\n        end\n      end\n    {% end %}\n\
    \  end\n\n  it \"#inv\" do\n    {% for type in [Mint, Mint2] %}\n      %mod =\
    \ {{type}}::MOD\n      0i64.step(by: %mod, to: %mod // 1000000) do |x|\n     \
    \   next unless x.gcd(%mod) == 1\n        ({{type}}.new(x).inv * x).should eq\
    \ 1\n      end\n    {% end %}\n  end\n\n  it \"#==(other)\" do\n    a = Mint.new(3)\n\
    \    (a == a).should be_true\n    (a == 3).should be_true\n    (a == mod + 3).should\
    \ be_false\n    (a == Mint.new(mod + 3)).should be_true\n  end\n\n  it \"#!=(other)\"\
    \ do\n    a = Mint.new(3)\n    (a != a).should be_false\n    (a != mod + 3).should\
    \ be_true\n    (a != Mint.new(mod + 3)).should be_false\n  end\n\n  it \"#succ\"\
    \ do\n    Mint.new(0).succ.should eq 1\n    Mint.new(3).succ.should eq 4\n   \
    \ Mint.new(mod).succ.should eq 1\n    x.succ.should eq 0\n    check_method_mod(Mint,\
    \ succ)\n    check_method_mod(Mint2, succ)\n  end\n\n  it \"#pred\" do\n    Mint.new(0).pred.should\
    \ eq mod - 1\n    Mint.new(3).pred.should eq 2\n    Mint.new(mod).pred.should\
    \ eq mod - 1\n    x.pred.should eq mod - 2\n    check_method_mod(Mint, pred)\n\
    \    check_method_mod(Mint2, pred)\n  end\n\n  it \"#abs\" do\n    Mint.new(0).abs.should\
    \ eq 0\n    Mint.new(3).abs.should eq 3\n    Mint.new(mod).abs.should eq 0\n \
    \   x.abs.should eq mod - 1\n    check_method_mod(Mint, abs)\n    check_method_mod(Mint2,\
    \ abs)\n  end\n\n  it \"#value\" do\n    Mint.new(0).value.should eq 0\n    Mint.new(3).value.should\
    \ eq 3\n    Mint.new(mod).value.should eq 0\n    x.value.should eq mod - 1\n \
    \ end\n\n  it \"#to_s\" do\n    Mint.new(0).to_s.should eq \"0\"\n    Mint.new(3).to_s.should\
    \ eq \"3\"\n    Mint.new(mod).to_s.should eq \"0\"\n    x.to_s.should eq (mod\
    \ - 1).to_s\n    check_method(Mint, to_s)\n    check_method(Mint2, to_s)\n  end\n\
    \n  it \"#inspect\" do\n    Mint.new(0).inspect.should eq \"0\"\n    Mint.new(3).inspect.should\
    \ eq \"3\"\n    Mint.new(mod).inspect.should eq \"0\"\n    x.inspect.should eq\
    \ (mod - 1).inspect\n    check_method(Mint, inspect)\n    check_method(Mint2,\
    \ inspect)\n  end\n\n  it \"compare\" do\n    a = Mint.new(3)\n    expect_raises(NotImplementedError)\
    \ { a < 1 }\n    expect_raises(NotImplementedError) { a <= 1 }\n    expect_raises(NotImplementedError)\
    \ { a > 1 }\n    expect_raises(NotImplementedError) { a >= 1 }\n    expect_raises(NotImplementedError)\
    \ { 1 < a }\n    expect_raises(NotImplementedError) { 1 <= a }\n    expect_raises(NotImplementedError)\
    \ { 1 > a }\n    expect_raises(NotImplementedError) { 1 >= a }\n  end\nend\n\n\
    describe Int do\n  it \"#+(Mint)\" do\n    a = Mint.new(1)\n    (3 + a).should\
    \ eq 4\n    (3i64 + a).should eq 4\n    (3i8 + a).should eq 4\n    (mod + a).should\
    \ eq 1\n    (mod * 2 + a).should eq 1\n  end\n\n  it \"#-(Mint)\" do\n    a =\
    \ Mint.new(3)\n    (3 - a).should eq 0\n    (3i64 - a).should eq 0\n    (3i8 -\
    \ a).should eq 0\n    (4 - a).should eq 1\n    (mod - a).should eq mod - 3\n \
    \   (0 - x).should eq 1\n  end\n\n  it \"#*(Mint)\" do\n    a = Mint.new(3)\n\
    \    (3 * a).should eq 9\n    (mod * a).should eq 0\n    (Int64::MAX * x).should\
    \ eq mod.pred * max % mod\n  end\n\n  it \"#/(Mint)\" do\n    a = Mint.new(3)\n\
    \    (3 / Mint.new(1)).should eq 3\n    (3 / Mint.new(2)).should eq mod // 2 +\
    \ 2\n    (3 / Mint.new(3)).should eq 1\n    expect_raises(DivisionByZeroError)\
    \ { 0 / Mint.zero }\n    expect_raises(DivisionByZeroError) { mod / Mint.new mod\
    \ }\n  end\n\n  it \"#//(Mint)\" do\n    a = Mint.new(3)\n    (3 // Mint.new(1)).should\
    \ eq 3\n    (3 // Mint.new(2)).should eq mod // 2 + 2\n    (3 // Mint.new(3)).should\
    \ eq 1\n    expect_raises(DivisionByZeroError) { 0 // Mint.zero }\n    expect_raises(DivisionByZeroError)\
    \ { mod // Mint.new mod }\n  end\n\n  it \"#to_m\" do\n    (-1).to_m.should eq\
    \ mod - 1\n    (-1i8).to_m.should eq mod - 1\n    0.to_m.should eq 0\n    1i64.to_m.should\
    \ eq 1\n    mod.to_m.should eq 0\n\n    (-1).to_m2.should eq Mint2::MOD - 1\n\
    \  end\nend\n\ndescribe String do\n  it \"#to_m\" do\n    \"-1\".to_m.should eq\
    \ mod - 1\n    \"0\".to_m.should eq 0\n    \"1\".to_m.should eq 1\n    (mod -\
    \ 1).to_s.to_m.should eq mod - 1\n    mod.to_s.to_m.should eq 0\n  end\nend\n"
  code: "require \"spec\"\nrequire \"../../src/math/mint\"\nrequire \"../../atcoder/src/Math\"\
    \nmod = 10i64**9 + 7\nx = Mint.new(mod - 1)\nmax = Int64::MAX % mod\n\nmacro check_binary_operator(type,\
    \ op)\n  %mod = {{type}}::MOD\n  0i64.step(to: %mod, by: %mod // 1000).each do\
    \ |x|\n    0i64.step(to: %mod, by: %mod // 999).each do |y|\n      m = {{type}}.new(x)\
    \ {{op.id}} {{type}}.new(y)\n      expect = (x {{op.id}} y) % %mod\n      m.should\
    \ eq expect\n    end\n  end\nend\n\nmacro check_method(type, method)\n  %mod =\
    \ {{type}}::MOD\n  0i64.step(to: %mod, by: %mod // 1000000).each do |x|\n    {{type}}.new(x).{{method}}.should\
    \ eq x.{{method}}\n  end\nend\n\nmacro check_method_mod(type, method)\n  %mod\
    \ = {{type}}::MOD\n  0i64.step(to: %mod, by: %mod // 1000000).each do |x|\n  \
    \  {{type}}.new(x).{{method}}.should eq x.{{method}} % %mod\n  end\nend\n\ndescribe\
    \ \"Mint\" do\n  it \".[]\" do\n    Mint[0, 1, 2, 3].should eq [0.to_m, 1.to_m,\
    \ 2.to_m, 3.to_m]\n    Mint[0, 1, mod, mod + 1, mod * 2].map(&.value).should eq\
    \ [0, 1, 0, 1, 0]\n  end\n\n  it \"::MOD\" do\n    Mint::MOD.should eq mod\n \
    \ end\n\n  it \".zero\" do\n    Mint.zero.should eq 0\n  end\n\n  it \"#initialize\"\
    \ do\n    Mint.new.should eq 0\n    Mint.new(Int64::MIN).should eq Int64::MIN\
    \ % mod\n    Mint.new(0).should eq 0\n    Mint.new(42).should eq 42\n    Mint.new(42i64).should\
    \ eq 42\n    Mint.new(42i8).should eq 42\n    Mint.new(mod).should eq 0\n    Mint.new(mod\
    \ + 1).should eq 1\n    Mint.new(mod * mod).should eq 0\n    Mint.new(Int64::MAX).should\
    \ eq max\n  end\n\n  it \"#+\" do\n    (+Mint.new).should eq 0\n    (+Mint.new(12)).should\
    \ eq 12\n  end\n\n  it \"#-\" do\n    (-Mint.new).should eq 0\n    (-Mint.new(12)).should\
    \ eq mod - 12\n  end\n\n  it \"#+(other)\" do\n    a = Mint.new(1)\n    (a + a).should\
    \ eq 2\n    (a + 3).should eq 4\n    (a + 3i64).should eq 4\n    (a + 3i8).should\
    \ eq 4\n    (a + mod).should eq 1\n    (a + mod * 2).should eq 1\n    (x + x).should\
    \ eq mod - 2\n    check_binary_operator(Mint, \"+\")\n    check_binary_operator(Mint2,\
    \ \"+\")\n  end\n\n  it \"#-(other)\" do\n    a = Mint.new(3)\n    (a - Mint.new(4)).should\
    \ eq mod - 1\n    (a - 3).should eq 0\n    (a - 3i64).should eq 0\n    (a - 3i8).should\
    \ eq 0\n    (a - 4).should eq mod - 1\n    (a - mod).should eq 3\n    (Mint.zero\
    \ - x).should eq 1\n    check_binary_operator(Mint, \"-\")\n    check_binary_operator(Mint2,\
    \ \"-\")\n  end\n\n  it \"#*(other)\" do\n    a = Mint.new(3)\n    (a * 3).should\
    \ eq 9\n    (a * a).should eq 9\n    (a * mod).should eq 0\n    (x * mod).should\
    \ eq 0\n    (x * x).should eq 1\n    (x * Int64::MAX).should eq mod.pred * max\
    \ % mod\n    check_binary_operator(Mint, \"*\")\n    check_binary_operator(Mint2,\
    \ \"*\")\n  end\n\n  it \"#/(other)\" do\n    a = Mint.new(3)\n    (a / 1).should\
    \ eq 3\n    (a / 2).should eq mod // 2 + 2\n    (a / 3).should eq 1\n\n    {%\
    \ for type in [Mint, Mint2] %}\n      %mod = {{type}}::MOD\n      0i64.step(by:\
    \ %mod, to: %mod // 1000) do |x|\n        0i64.step(by: %mod, to: %mod // 999)\
    \ do |y|\n          next unless y.gcd(%mod) == 1\n          z = {{type}}.new(x)\
    \ / y\n          (z * y).should eq x\n        end\n      end\n    {% end %}\n\n\
    \    expect_raises(DivisionByZeroError) { a / 0 }\n    expect_raises(DivisionByZeroError)\
    \ { a / 0i8 }\n    expect_raises(DivisionByZeroError) { a / mod }\n    expect_raises(DivisionByZeroError)\
    \ { a / Mint.zero }\n  end\n\n  it \"#//(other)\" do\n    a = Mint.new(3)\n  \
    \  (a // 1).should eq 3\n    (a // 2).should eq mod // 2 + 2\n    (a // 3).should\
    \ eq 1\n\n    {% for type in [Mint, Mint2] %}\n      %mod = {{type}}::MOD\n  \
    \    0i64.step(by: %mod, to: %mod // 1000) do |x|\n        0i64.step(by: %mod,\
    \ to: %mod // 999) do |y|\n          next unless y.gcd(%mod) == 1\n          z\
    \ = {{type}}.new(x) // y\n          (z * y).should eq x\n        end\n      end\n\
    \    {% end %}\n\n    expect_raises(DivisionByZeroError) { a // 0 }\n    expect_raises(DivisionByZeroError)\
    \ { a // 0i8 }\n    expect_raises(DivisionByZeroError) { a // mod }\n    expect_raises(DivisionByZeroError)\
    \ { a // Mint.zero }\n  end\n\n  it \"#**(other)\" do\n    a = Mint.new(3)\n \
    \   (a ** 0).should eq 1\n    (a ** 1).should eq 3\n    (a ** 2).should eq 9\n\
    \    (a ** 20).should eq 486784380\n    (a ** (10i64**18)).should eq 246336683\n\
    \    (a.pred ** (10i64**18)).should eq 719476260\n\n    {% for type in [Mint,\
    \ Mint2] %}\n      %mod = {{type}}::MOD\n      0i64.step(by: %mod, to: %mod //\
    \ 1000) do |x|\n        0i64.step(by: Int64::MAX, to: Int64::MAX // 1000) do |e|\n\
    \          m = {{type}}.new(x) ** e\n          expect = AtCoder::Math.pow_mod(x,\
    \ e, mod)\n          m.should eq expect\n        end\n      end\n    {% end %}\n\
    \  end\n\n  it \"#inv\" do\n    {% for type in [Mint, Mint2] %}\n      %mod =\
    \ {{type}}::MOD\n      0i64.step(by: %mod, to: %mod // 1000000) do |x|\n     \
    \   next unless x.gcd(%mod) == 1\n        ({{type}}.new(x).inv * x).should eq\
    \ 1\n      end\n    {% end %}\n  end\n\n  it \"#==(other)\" do\n    a = Mint.new(3)\n\
    \    (a == a).should be_true\n    (a == 3).should be_true\n    (a == mod + 3).should\
    \ be_false\n    (a == Mint.new(mod + 3)).should be_true\n  end\n\n  it \"#!=(other)\"\
    \ do\n    a = Mint.new(3)\n    (a != a).should be_false\n    (a != mod + 3).should\
    \ be_true\n    (a != Mint.new(mod + 3)).should be_false\n  end\n\n  it \"#succ\"\
    \ do\n    Mint.new(0).succ.should eq 1\n    Mint.new(3).succ.should eq 4\n   \
    \ Mint.new(mod).succ.should eq 1\n    x.succ.should eq 0\n    check_method_mod(Mint,\
    \ succ)\n    check_method_mod(Mint2, succ)\n  end\n\n  it \"#pred\" do\n    Mint.new(0).pred.should\
    \ eq mod - 1\n    Mint.new(3).pred.should eq 2\n    Mint.new(mod).pred.should\
    \ eq mod - 1\n    x.pred.should eq mod - 2\n    check_method_mod(Mint, pred)\n\
    \    check_method_mod(Mint2, pred)\n  end\n\n  it \"#abs\" do\n    Mint.new(0).abs.should\
    \ eq 0\n    Mint.new(3).abs.should eq 3\n    Mint.new(mod).abs.should eq 0\n \
    \   x.abs.should eq mod - 1\n    check_method_mod(Mint, abs)\n    check_method_mod(Mint2,\
    \ abs)\n  end\n\n  it \"#value\" do\n    Mint.new(0).value.should eq 0\n    Mint.new(3).value.should\
    \ eq 3\n    Mint.new(mod).value.should eq 0\n    x.value.should eq mod - 1\n \
    \ end\n\n  it \"#to_s\" do\n    Mint.new(0).to_s.should eq \"0\"\n    Mint.new(3).to_s.should\
    \ eq \"3\"\n    Mint.new(mod).to_s.should eq \"0\"\n    x.to_s.should eq (mod\
    \ - 1).to_s\n    check_method(Mint, to_s)\n    check_method(Mint2, to_s)\n  end\n\
    \n  it \"#inspect\" do\n    Mint.new(0).inspect.should eq \"0\"\n    Mint.new(3).inspect.should\
    \ eq \"3\"\n    Mint.new(mod).inspect.should eq \"0\"\n    x.inspect.should eq\
    \ (mod - 1).inspect\n    check_method(Mint, inspect)\n    check_method(Mint2,\
    \ inspect)\n  end\n\n  it \"compare\" do\n    a = Mint.new(3)\n    expect_raises(NotImplementedError)\
    \ { a < 1 }\n    expect_raises(NotImplementedError) { a <= 1 }\n    expect_raises(NotImplementedError)\
    \ { a > 1 }\n    expect_raises(NotImplementedError) { a >= 1 }\n    expect_raises(NotImplementedError)\
    \ { 1 < a }\n    expect_raises(NotImplementedError) { 1 <= a }\n    expect_raises(NotImplementedError)\
    \ { 1 > a }\n    expect_raises(NotImplementedError) { 1 >= a }\n  end\nend\n\n\
    describe Int do\n  it \"#+(Mint)\" do\n    a = Mint.new(1)\n    (3 + a).should\
    \ eq 4\n    (3i64 + a).should eq 4\n    (3i8 + a).should eq 4\n    (mod + a).should\
    \ eq 1\n    (mod * 2 + a).should eq 1\n  end\n\n  it \"#-(Mint)\" do\n    a =\
    \ Mint.new(3)\n    (3 - a).should eq 0\n    (3i64 - a).should eq 0\n    (3i8 -\
    \ a).should eq 0\n    (4 - a).should eq 1\n    (mod - a).should eq mod - 3\n \
    \   (0 - x).should eq 1\n  end\n\n  it \"#*(Mint)\" do\n    a = Mint.new(3)\n\
    \    (3 * a).should eq 9\n    (mod * a).should eq 0\n    (Int64::MAX * x).should\
    \ eq mod.pred * max % mod\n  end\n\n  it \"#/(Mint)\" do\n    a = Mint.new(3)\n\
    \    (3 / Mint.new(1)).should eq 3\n    (3 / Mint.new(2)).should eq mod // 2 +\
    \ 2\n    (3 / Mint.new(3)).should eq 1\n    expect_raises(DivisionByZeroError)\
    \ { 0 / Mint.zero }\n    expect_raises(DivisionByZeroError) { mod / Mint.new mod\
    \ }\n  end\n\n  it \"#//(Mint)\" do\n    a = Mint.new(3)\n    (3 // Mint.new(1)).should\
    \ eq 3\n    (3 // Mint.new(2)).should eq mod // 2 + 2\n    (3 // Mint.new(3)).should\
    \ eq 1\n    expect_raises(DivisionByZeroError) { 0 // Mint.zero }\n    expect_raises(DivisionByZeroError)\
    \ { mod // Mint.new mod }\n  end\n\n  it \"#to_m\" do\n    (-1).to_m.should eq\
    \ mod - 1\n    (-1i8).to_m.should eq mod - 1\n    0.to_m.should eq 0\n    1i64.to_m.should\
    \ eq 1\n    mod.to_m.should eq 0\n\n    (-1).to_m2.should eq Mint2::MOD - 1\n\
    \  end\nend\n\ndescribe String do\n  it \"#to_m\" do\n    \"-1\".to_m.should eq\
    \ mod - 1\n    \"0\".to_m.should eq 0\n    \"1\".to_m.should eq 1\n    (mod -\
    \ 1).to_s.to_m.should eq mod - 1\n    mod.to_s.to_m.should eq 0\n  end\nend\n"
  dependsOn:
  - src/math/mint.cr
  - atcoder/src/Math.cr
  isVerificationFile: false
  path: spec/math/mint_spec.cr
  requiredBy: []
  timestamp: '2021-08-04 20:45:42+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/math/mint_spec.cr
layout: document
redirect_from:
- /library/spec/math/mint_spec.cr
- /library/spec/math/mint_spec.cr.html
title: spec/math/mint_spec.cr
---
