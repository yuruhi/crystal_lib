---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: math/DynamicMint.cr
    title: math/DynamicMint.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "# require \"../math/DynamicMint\"\n# require \"./Barrett\"\nstruct\
    \ Barrett\n  getter mod : UInt32\n  getter inv : UInt64\n\n  def initialize(@mod)\n\
    \    @inv = UInt64::MAX // @mod &+ 1\n  end\n\n  def mul(a : UInt32, b : UInt32)\
    \ : UInt32\n    z = a.to_u64 &* b\n    x = ((z.to_u128 &* @inv) >> 64).to_u64!\n\
    \    v = (z &- x &* @mod).to_u32!\n    v &+= @mod if @mod <= v\n    v\n  end\n\
    end\n\n# require \"../atcoder/src/Math\"\n# ac-library.cr by hakatashi https://github.com/google/ac-library.cr\n\
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
    \  end\nend\n\nstruct DynamicMint\n  @@bt : Barrett = Barrett.new(998244353u32)\n\
    \  alias Mint = DynamicMint\n\n  def self.mod : Int32\n    @@bt.mod.to_i\n  end\n\
    \n  def self.mod=(m : Int32)\n    raise ArgumentError.new unless 1 <= m\n    @@bt\
    \ = Barrett.new(m.to_u32)\n  end\n\n  def self.raw(v : Int32)\n    result = Mint.new\n\
    \    result.value = v\n    result\n  end\n\n  def self.raw(v)\n    result = Mint.new\n\
    \    result.value = v.to_i!\n    result\n  end\n\n  def self.zero\n    Mint.new\n\
    \  end\n\n  getter value : Int32\n\n  protected def value=(v : Int32)\n    @value\
    \ = v\n  end\n\n  def initialize\n    @value = 0\n  end\n\n  def initialize(x\
    \ : self)\n    @value = x.value\n  end\n\n  def initialize(x : Int)\n    @value\
    \ = x.to_i % Mint.mod\n  end\n\n  def ==(v : self)\n    value == v.value\n  end\n\
    \n  def ==(v)\n    value == v\n  end\n\n  def +\n    self\n  end\n\n  def -\n\
    \    Mint.raw value == 0 ? 0 : Mint.mod &- value\n  end\n\n  def +(v)\n    x =\
    \ value &+ Mint.new(v).value\n    x &-= Mint.mod if x >= Mint.mod\n    Mint.raw\
    \ x\n  end\n\n  def -(v)\n    x = value &- Mint.new(v).value\n    x &+= Mint.mod\
    \ if x < 0\n    Mint.raw x\n  end\n\n  def *(v)\n    Mint.raw @@bt.mul(value.to_u!,\
    \ Mint.new(v).value.to_u!)\n  end\n\n  def /(v)\n    self * Mint.new(v).inv\n\
    \  end\n\n  def //(v)\n    self / v\n  end\n\n  def **(exponent : Int)\n    t,\
    \ res = self, Mint.raw(1)\n    while exponent > 0\n      res *= t if exponent\
    \ & 1 == 1\n      t *= t\n      exponent >>= 1\n    end\n    res\n  end\n\n  def\
    \ inv\n    Mint.raw AtCoder::Math.inv_mod(value, Mint.mod)\n  end\n\n  def succ\n\
    \    Mint.raw value == Mint.mod &- 1 ? 0 : value &+ 1\n  end\n\n  def pred\n \
    \   Mint.raw value == 0 ? Mint.mod &- 1 : value &- 1\n  end\n\n  def abs\n   \
    \ self\n  end\n\n  def to_i64 : Int64\n    value.to_i64\n  end\n\n  delegate to_s,\
    \ to: @value\n  delegate inspect, to: @value\n\n  {% for op in %w[< <= > >=] %}\n\
    \    def {{op.id}}(other)\n      raise NotImplementedError.new({{op}})\n    end\n\
    \  {% end %}\nend\n\nalias M = DynamicMint\ninit = 998244353\n\nmacro check_binary_operator(mod,\
    \ op)\n\t%mod = {{mod}}\n\tM.mod = %mod\n\t(0...%mod).each do |x|\n\t\t(0...%mod).each\
    \ do |y|\n\t\t\t(M.new(x) {{op.id}} M.new(y)).should eq (x {{op.id}} y) % %mod\n\
    \t\tend\n\tend\nend\n\nmacro check_method(mod, method)\n  %mod = {{mod}}\n  M.mod\
    \ = %mod\n  (0...%mod).each do |x|\n    M.new(x).{{method}}.should eq x.{{method}}\n\
    \  end\nend\n\nmacro check_method_mod(mod, method)\n  %mod = {{mod}}\n  M.mod\
    \ = %mod\n  (0...%mod).each do |x|\n    M.new(x).{{method}}.should eq x.{{method}}\
    \ % %mod\n  end\nend\n\ndescribe \"DynamicModint\" do\n  it \".mod and .setmod\"\
    \ do\n    M.mod.should eq init\n    M.mod = 42\n    M.mod.should eq 42\n    M.mod\
    \ = Int32::MAX\n    M.mod.should eq Int32::MAX\n    expect_raises(ArgumentError)\
    \ { M.mod = 0 }\n    expect_raises(ArgumentError) { M.mod = -1 }\n  end\n\n  it\
    \ \".zero\" do\n    M.mod = 60\n    M.zero.should eq 0\n  end\n\n  it \"#==(x)\"\
    \ do\n    M.mod = 60\n    (M.new(0) == M.new(0)).should be_true\n    (M.new(0)\
    \ == M.new(60)).should be_true\n    (M.new(0) == 0).should be_true\n    (M.new(0)\
    \ == 1).should be_false\n    (M.new(60) == 0).should be_true\n    (M.new(60) ==\
    \ 60).should be_false\n  end\n\n  it \"#+\" do\n    M.mod = init\n    (+M.new(1)).should\
    \ eq 1\n    (+M.new(init)).should eq 0\n  end\n\n  it \"#-\" do\n    M.mod = init\n\
    \    x = M.new(1)\n    (-x).should eq init - 1\n    x = M.new(0)\n    (-x).value.should\
    \ eq 0\n\n    M.mod = 3\n    (-M.new(1)).should eq 2\n  end\n\n  it \"#+(x)\"\
    \ do\n    check_binary_operator(1, \"+\")\n    check_binary_operator(60, \"+\"\
    )\n    check_binary_operator(1009, \"+\")\n  end\n\n  it \"#-(x)\" do\n    check_binary_operator(1,\
    \ \"-\")\n    check_binary_operator(60, \"-\")\n    check_binary_operator(1009,\
    \ \"-\")\n  end\n\n  it \"#*(x)\" do\n    check_binary_operator(1, \"*\")\n  \
    \  check_binary_operator(60, \"*\")\n    check_binary_operator(1009, \"*\")\n\
    \  end\n\n  it \"#/(x)\" do\n    {1, 60, 1009}.each do |mod|\n      M.mod = mod\n\
    \      (0...mod).each do |x|\n        (0...mod).each do |y|\n          next unless\
    \ y.gcd(mod) == 1\n          z = M.new(x) / y\n          (z * y).should eq x\n\
    \        end\n      end\n    end\n  end\n\n  it \"#//(x)\" do\n    {1, 60, 1009}.each\
    \ do |mod|\n      M.mod = mod\n      (0...mod).each do |x|\n        (0...mod).each\
    \ do |y|\n          next unless y.gcd(mod) == 1\n          z = M.new(x) // y\n\
    \          (z * y).should eq x\n        end\n      end\n    end\n  end\n\n  it\
    \ \"#**(x)\" do\n    {1, 60, 1009}.each do |mod|\n      M.mod = mod\n      (0i64...mod.to_i64).each\
    \ do |x|\n        0i64.step(to: 10i64**18, by: 10i64**16) do |e|\n          (M.new(x)\
    \ ** e).should eq AtCoder::Math.pow_mod(x, e, mod)\n        end\n      end\n \
    \   end\n  end\n\n  it \"#inv\" do\n    {1, 60, 1009, 1000003}.each do |mod|\n\
    \      M.mod = mod\n      (1...mod).each do |x|\n        next unless x.gcd(mod)\
    \ == 1\n        (M.new(x).inv * x).should eq 1\n      end\n    end\n  end\n\n\
    \  it \"#succ\" do\n    check_method_mod(1, succ)\n    check_method_mod(60, succ)\n\
    \    check_method_mod(1009, succ)\n    check_method_mod(1000003, succ)\n  end\n\
    \n  it \"#pred\" do\n    check_method_mod(1, pred)\n    check_method_mod(60, pred)\n\
    \    check_method_mod(1009, pred)\n    check_method_mod(1000003, pred)\n  end\n\
    \n  it \"#abs\" do\n    check_method_mod(1, abs)\n    check_method_mod(60, abs)\n\
    \    check_method_mod(1009, abs)\n    check_method_mod(1000003, abs)\n  end\n\n\
    \  it \"#to_i64\" do\n    check_method_mod(1, to_i64)\n    check_method_mod(60,\
    \ to_i64)\n    check_method_mod(1009, to_i64)\n    check_method_mod(1000003, to_i64)\n\
    \  end\n\n  it \"#to_s\" do\n    check_method(1, to_s)\n    check_method(60, to_s)\n\
    \    check_method(1009, to_s)\n    check_method(1000003, to_s)\n  end\n\n  it\
    \ \"#inspect\" do\n    check_method(1, inspect)\n    check_method(60, inspect)\n\
    \    check_method(1009, inspect)\n    check_method(1000003, inspect)\n  end\n\n\
    \  it \"compare\" do\n    expect_raises(NotImplementedError) { M.new(0) < 0 }\n\
    \    expect_raises(NotImplementedError) { M.new(0) <= 0 }\n    expect_raises(NotImplementedError)\
    \ { M.new(0) > 0 }\n    expect_raises(NotImplementedError) { M.new(0) >= 0 }\n\
    \  end\nend\n"
  code: "require \"../math/DynamicMint\"\n\nalias M = DynamicMint\ninit = 998244353\n\
    \nmacro check_binary_operator(mod, op)\n\t%mod = {{mod}}\n\tM.mod = %mod\n\t(0...%mod).each\
    \ do |x|\n\t\t(0...%mod).each do |y|\n\t\t\t(M.new(x) {{op.id}} M.new(y)).should\
    \ eq (x {{op.id}} y) % %mod\n\t\tend\n\tend\nend\n\nmacro check_method(mod, method)\n\
    \  %mod = {{mod}}\n  M.mod = %mod\n  (0...%mod).each do |x|\n    M.new(x).{{method}}.should\
    \ eq x.{{method}}\n  end\nend\n\nmacro check_method_mod(mod, method)\n  %mod =\
    \ {{mod}}\n  M.mod = %mod\n  (0...%mod).each do |x|\n    M.new(x).{{method}}.should\
    \ eq x.{{method}} % %mod\n  end\nend\n\ndescribe \"DynamicModint\" do\n  it \"\
    .mod and .setmod\" do\n    M.mod.should eq init\n    M.mod = 42\n    M.mod.should\
    \ eq 42\n    M.mod = Int32::MAX\n    M.mod.should eq Int32::MAX\n    expect_raises(ArgumentError)\
    \ { M.mod = 0 }\n    expect_raises(ArgumentError) { M.mod = -1 }\n  end\n\n  it\
    \ \".zero\" do\n    M.mod = 60\n    M.zero.should eq 0\n  end\n\n  it \"#==(x)\"\
    \ do\n    M.mod = 60\n    (M.new(0) == M.new(0)).should be_true\n    (M.new(0)\
    \ == M.new(60)).should be_true\n    (M.new(0) == 0).should be_true\n    (M.new(0)\
    \ == 1).should be_false\n    (M.new(60) == 0).should be_true\n    (M.new(60) ==\
    \ 60).should be_false\n  end\n\n  it \"#+\" do\n    M.mod = init\n    (+M.new(1)).should\
    \ eq 1\n    (+M.new(init)).should eq 0\n  end\n\n  it \"#-\" do\n    M.mod = init\n\
    \    x = M.new(1)\n    (-x).should eq init - 1\n    x = M.new(0)\n    (-x).value.should\
    \ eq 0\n\n    M.mod = 3\n    (-M.new(1)).should eq 2\n  end\n\n  it \"#+(x)\"\
    \ do\n    check_binary_operator(1, \"+\")\n    check_binary_operator(60, \"+\"\
    )\n    check_binary_operator(1009, \"+\")\n  end\n\n  it \"#-(x)\" do\n    check_binary_operator(1,\
    \ \"-\")\n    check_binary_operator(60, \"-\")\n    check_binary_operator(1009,\
    \ \"-\")\n  end\n\n  it \"#*(x)\" do\n    check_binary_operator(1, \"*\")\n  \
    \  check_binary_operator(60, \"*\")\n    check_binary_operator(1009, \"*\")\n\
    \  end\n\n  it \"#/(x)\" do\n    {1, 60, 1009}.each do |mod|\n      M.mod = mod\n\
    \      (0...mod).each do |x|\n        (0...mod).each do |y|\n          next unless\
    \ y.gcd(mod) == 1\n          z = M.new(x) / y\n          (z * y).should eq x\n\
    \        end\n      end\n    end\n  end\n\n  it \"#//(x)\" do\n    {1, 60, 1009}.each\
    \ do |mod|\n      M.mod = mod\n      (0...mod).each do |x|\n        (0...mod).each\
    \ do |y|\n          next unless y.gcd(mod) == 1\n          z = M.new(x) // y\n\
    \          (z * y).should eq x\n        end\n      end\n    end\n  end\n\n  it\
    \ \"#**(x)\" do\n    {1, 60, 1009}.each do |mod|\n      M.mod = mod\n      (0i64...mod.to_i64).each\
    \ do |x|\n        0i64.step(to: 10i64**18, by: 10i64**16) do |e|\n          (M.new(x)\
    \ ** e).should eq AtCoder::Math.pow_mod(x, e, mod)\n        end\n      end\n \
    \   end\n  end\n\n  it \"#inv\" do\n    {1, 60, 1009, 1000003}.each do |mod|\n\
    \      M.mod = mod\n      (1...mod).each do |x|\n        next unless x.gcd(mod)\
    \ == 1\n        (M.new(x).inv * x).should eq 1\n      end\n    end\n  end\n\n\
    \  it \"#succ\" do\n    check_method_mod(1, succ)\n    check_method_mod(60, succ)\n\
    \    check_method_mod(1009, succ)\n    check_method_mod(1000003, succ)\n  end\n\
    \n  it \"#pred\" do\n    check_method_mod(1, pred)\n    check_method_mod(60, pred)\n\
    \    check_method_mod(1009, pred)\n    check_method_mod(1000003, pred)\n  end\n\
    \n  it \"#abs\" do\n    check_method_mod(1, abs)\n    check_method_mod(60, abs)\n\
    \    check_method_mod(1009, abs)\n    check_method_mod(1000003, abs)\n  end\n\n\
    \  it \"#to_i64\" do\n    check_method_mod(1, to_i64)\n    check_method_mod(60,\
    \ to_i64)\n    check_method_mod(1009, to_i64)\n    check_method_mod(1000003, to_i64)\n\
    \  end\n\n  it \"#to_s\" do\n    check_method(1, to_s)\n    check_method(60, to_s)\n\
    \    check_method(1009, to_s)\n    check_method(1000003, to_s)\n  end\n\n  it\
    \ \"#inspect\" do\n    check_method(1, inspect)\n    check_method(60, inspect)\n\
    \    check_method(1009, inspect)\n    check_method(1000003, inspect)\n  end\n\n\
    \  it \"compare\" do\n    expect_raises(NotImplementedError) { M.new(0) < 0 }\n\
    \    expect_raises(NotImplementedError) { M.new(0) <= 0 }\n    expect_raises(NotImplementedError)\
    \ { M.new(0) > 0 }\n    expect_raises(NotImplementedError) { M.new(0) >= 0 }\n\
    \  end\nend\n"
  dependsOn:
  - math/DynamicMint.cr
  isVerificationFile: false
  path: spec/DynamicMint_spec.cr
  requiredBy: []
  timestamp: '2021-06-20 17:06:37+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/DynamicMint_spec.cr
layout: document
redirect_from:
- /library/spec/DynamicMint_spec.cr
- /library/spec/DynamicMint_spec.cr.html
title: spec/DynamicMint_spec.cr
---
