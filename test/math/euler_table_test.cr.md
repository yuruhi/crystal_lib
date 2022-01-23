---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/src/Math.cr
    title: atcoder/src/Math.cr
  - icon: ':heavy_check_mark:'
    path: atcoder/src/Prime.cr
    title: atcoder/src/Prime.cr
  - icon: ':heavy_check_mark:'
    path: src/math/euler.cr
    title: src/math/euler.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://onlinejudge.u-aizu.ac.jp/challenges/sources/VPC/RUPC/2286?year=2011
  bundledCode: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/challenges/sources/VPC/RUPC/2286?year=2011\n\
    # require \"../../src/math/euler\"\n# require \"../../atcoder/src/Prime\"\n# ac-library.cr\
    \ by hakatashi https://github.com/google/ac-library.cr\n#\n# Copyright 2021 Google\
    \ LLC\n#\n# Licensed under the Apache License, Version 2.0 (the \"License\");\n\
    # you may not use this file except in compliance with the License.\n# You may\
    \ obtain a copy of the License at\n#\n#      https://www.apache.org/licenses/LICENSE-2.0\n\
    #\n# Unless required by applicable law or agreed to in writing, software\n# distributed\
    \ under the License is distributed on an \"AS IS\" BASIS,\n# WITHOUT WARRANTIES\
    \ OR CONDITIONS OF ANY KIND, either express or implied.\n# See the License for\
    \ the specific language governing permissions and\n# limitations under the License.\n\
    \n# require \"./Math.cr\"\n# ac-library.cr by hakatashi https://github.com/google/ac-library.cr\n\
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
    \  end\nend\n\nmodule AtCoder\n  # Implements [Ruby's Prime library](https://ruby-doc.com/stdlib/libdoc/prime/rdoc/Prime.html).\n\
    \  #\n  # ```\n  # AtCoder::Prime.first(7) # => [2, 3, 5, 7, 11, 13, 17]\n  #\
    \ ```\n  module Prime\n    extend self\n    include Enumerable(Int64)\n\n    @@primes\
    \ = [\n      2_i64, 3_i64, 5_i64, 7_i64, 11_i64, 13_i64, 17_i64, 19_i64,\n   \
    \   23_i64, 29_i64, 31_i64, 37_i64, 41_i64, 43_i64, 47_i64,\n      53_i64, 59_i64,\
    \ 61_i64, 67_i64, 71_i64, 73_i64, 79_i64,\n      83_i64, 89_i64, 97_i64, 101_i64,\n\
    \    ]\n\n    def each\n      index = 0\n      loop do\n        yield get_nth_prime(index)\n\
    \        index += 1\n      end\n    end\n\n    def prime_division(value : Int)\n\
    \      raise DivisionByZeroError.new if value == 0\n\n      int = typeof(value)\n\
    \n      factors = [] of Tuple(typeof(value), typeof(value))\n\n      if value\
    \ < 0\n        value = value.abs\n        factors << {int.new(-1), int.new(1)}\n\
    \      end\n\n      until prime?(value) || value == 1\n        factor = value\n\
    \        until prime?(factor)\n          factor = find_factor(factor)\n      \
    \  end\n        count = 0\n        while value % factor == 0\n          value\
    \ //= factor\n          count += 1\n        end\n        factors << {int.new(factor),\
    \ int.new(count)}\n      end\n\n      if value > 1\n        factors << {value,\
    \ int.new(1)}\n      end\n\n      factors.sort_by! { |(factor, _)| factor }\n\
    \    end\n\n    private def find_factor(n : Int)\n      # Factor of 4 cannot be\
    \ discovered by Pollard's Rho with f(x) = x^x+1\n      if n == 4\n        typeof(n).new(2)\n\
    \      else\n        pollard_rho(n).not_nil!\n      end\n    end\n\n    # Get\
    \ single factor by Pollard's Rho Algorithm\n    private def pollard_rho(n : Int)\n\
    \      typeof(n).new(1).upto(n) do |i|\n        x = i\n        y = pollard_random_f(x,\
    \ n)\n\n        loop do\n          x = pollard_random_f(x, n)\n          y = pollard_random_f(pollard_random_f(y,\
    \ n), n)\n          gcd = (x - y).gcd(n)\n\n          if gcd == n\n          \
    \  break\n          end\n\n          if gcd != 1\n            return gcd\n   \
    \       end\n        end\n      end\n    end\n\n    private def pollard_random_f(n\
    \ : Int, mod : Int)\n      (AtCoder::Math.mul_mod(n, n, mod) + 1) % mod\n    end\n\
    \n    private def extract_prime_division_base(prime_divisions_class : Array({T,\
    \ T}).class) forall T\n      T\n    end\n\n    def int_from_prime_division(prime_divisions\
    \ : Array({Int, Int}))\n      int_class = extract_prime_division_base(prime_divisions.class)\n\
    \      prime_divisions.reduce(int_class.new(1)) { |i, (factor, exponent)| i *\
    \ factor ** exponent }\n    end\n\n    def prime?(value : Int)\n      # Obvious\
    \ patterns\n      return false if value < 2\n      return true if value <= 3\n\
    \      return false if value.even?\n      return true if value < 9\n\n      if\
    \ value < 0xffff\n        return false unless typeof(value).new(30).gcd(value\
    \ % 30) == 1\n\n        7.step(by: 30, to: value) do |base|\n          break if\
    \ base * base > value\n\n          if {0, 4, 6, 10, 12, 16, 22, 24}.any? { |i|\
    \ value % (base + i) == 0 }\n            return false\n          end\n       \
    \ end\n\n        return true\n      end\n\n      miller_rabin(value.to_i64)\n\
    \    end\n\n    private def miller_rabin(value)\n      d = value - 1\n      s\
    \ = 0_i64\n      until d.odd?\n        d >>= 1\n        s += 1\n      end\n\n\
    \      miller_rabin_bases(value).each do |base|\n        next if base == value\n\
    \n        x = AtCoder::Math.pow_mod(base.to_i64, d, value)\n        next if x\
    \ == 1 || x == value - 1\n\n        is_composite = s.times.all? do\n         \
    \ x = AtCoder::Math.mul_mod(x, x, value)\n          x != value - 1\n        end\n\
    \n        return false if is_composite\n      end\n\n      true\n    end\n\n \
    \   # We can reduce time complexity of Miller-Rabin tests by testing against\n\
    \    # predefined bases which is enough to test against primarity in the given\
    \ range.\n    # https://en.wikipedia.org/wiki/Miller%E2%80%93Rabin_primality_test\n\
    \    # ameba:disable Metrics/CyclomaticComplexity\n    private def miller_rabin_bases(value)\n\
    \      case\n      when value < 1_373_653_i64\n        [2, 3]\n      when value\
    \ < 9_080_191_i64\n        [31, 73]\n      when value < 25_326_001_i64\n     \
    \   [2, 3, 5]\n      when value < 3_215_031_751_i64\n        [2, 3, 5, 7]\n  \
    \    when value < 4_759_123_141_i64\n        [2, 7, 61]\n      when value < 1_122_004_669_633_i64\n\
    \        [2, 13, 23, 1662803]\n      when value < 2_152_302_898_747_i64\n    \
    \    [2, 3, 5, 7, 11]\n      when value < 3_474_749_660_383_i64\n        [2, 3,\
    \ 5, 7, 11, 13]\n      when value < 341_550_071_728_321_i64\n        [2, 3, 5,\
    \ 7, 11, 13, 17]\n      when value < 3_825_123_056_546_413_051_i64\n        [2,\
    \ 3, 5, 7, 11, 13, 17, 19, 23]\n      else\n        [2, 3, 5, 7, 11, 13, 17, 19,\
    \ 23, 29, 31, 37]\n      end\n    end\n\n    private def get_nth_prime(n)\n  \
    \    while @@primes.size <= n\n        generate_primes\n      end\n\n      @@primes[n]\n\
    \    end\n\n    # Doubles the size of the cached prime array and performs the\n\
    \    # Sieve of Eratosthenes on it.\n    private def generate_primes\n      new_primes_size\
    \ = @@primes.size < 1_000_000 ? @@primes.size : 1_000_000\n      new_primes =\
    \ Array(Int64).new(new_primes_size) { |i| @@primes.last + (i + 1) * 2 }\n    \
    \  new_primes_max = new_primes.last\n\n      @@primes.each do |prime|\n      \
    \  next if prime == 2\n        break if prime * prime > new_primes_max\n\n   \
    \     # Here I use the technique of the Sieve of Sundaram. We can\n        # only\
    \ test against the odd multiple of the given prime.\n        # min_composite is\
    \ the minimum number that is greater than\n        # the last confirmed prime,\
    \ and is an odd multiple of\n        # the given prime.\n        min_multiple\
    \ = ((@@primes.last // prime + 1) // 2 * 2 + 1) * prime\n        min_multiple.step(by:\
    \ prime * 2, to: new_primes_max) do |multiple|\n          index = new_primes_size\
    \ - (new_primes_max - multiple) // 2 - 1\n          new_primes[index] = 0_i64\n\
    \        end\n      end\n\n      @@primes.concat(new_primes.reject(0_i64))\n \
    \   end\n\n    private struct EachDivisor(T)\n      include Enumerable(T)\n\n\
    \      def initialize(@exponential_factors : Array(Array(T)))\n      end\n\n \
    \     def each\n        Array.each_product(@exponential_factors) do |factors|\n\
    \          yield factors.reduce { |a, b| a * b }\n        end\n      end\n   \
    \ end\n\n    # Returns an enumerator that iterates through the all positive divisors\
    \ of\n    # the given number. **The order is not guaranteed.**\n    # Not in the\
    \ original Ruby's Prime library.\n    #\n    # ```\n    # AtCoder::Prime.each_divisor(20)\
    \ do |n|\n    #   puts n\n    # end # => Puts 1, 2, 4, 5, 10, and 20\n    #\n\
    \    # AtCoder::Prime.each_divisor(10).map { |n| 1.0 / n }.to_a # => [1.0, 0.5,\
    \ 0.2, 0.1]\n    # ```\n    def each_divisor(value : Int)\n      raise ArgumentError.new\
    \ unless value > 0\n\n      factors = prime_division(value)\n\n      if value\
    \ == 1\n        exponential_factors = [[value]]\n      else\n        exponential_factors\
    \ = factors.map do |(factor, count)|\n          cnt = typeof(value).zero + 1\n\
    \          Array(typeof(value)).new(count + 1) do |i|\n            cnt_copy =\
    \ cnt\n            if i < count\n              cnt *= factor\n            end\n\
    \            cnt_copy\n          end\n        end\n      end\n\n      EachDivisor(typeof(value)).new(exponential_factors)\n\
    \    end\n\n    # :ditto:\n    def each_divisor(value : T, &block : T ->)\n  \
    \    each_divisor(value).each(&block)\n    end\n  end\nend\n\nstruct Int\n  def\
    \ prime?\n    AtCoder::Prime.prime?(self)\n  end\nend\n\nmodule Math\n  def euler(x\
    \ : Int)\n    AtCoder::Prime.prime_division(x).reduce(x) do |euler, (p, e)|\n\
    \      euler // p * (p - 1)\n    end\n  end\n\n  def euler_table(x : Int)\n  \
    \  euler = (0..x).to_a\n    (2..x).each do |i|\n      i.step(to: x, by: i) do\
    \ |j|\n        euler[j] = euler[j] // i * i.pred\n      end if euler[i] == i\n\
    \    end\n    euler\n  end\nend\n\nMAX_A = 1000000\neuler = Math.euler_table(MAX_A)\n\
    ans = [1i64]\n(1..MAX_A).each do |i|\n  ans << ans.last + euler[i]\nend\n\nread_line.to_i.times\
    \ do\n  x = read_line.to_i\n  puts ans[x]\nend\n"
  code: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/challenges/sources/VPC/RUPC/2286?year=2011\n\
    require \"../../src/math/euler\"\n\nMAX_A = 1000000\neuler = Math.euler_table(MAX_A)\n\
    ans = [1i64]\n(1..MAX_A).each do |i|\n  ans << ans.last + euler[i]\nend\n\nread_line.to_i.times\
    \ do\n  x = read_line.to_i\n  puts ans[x]\nend\n"
  dependsOn:
  - src/math/euler.cr
  - atcoder/src/Prime.cr
  - atcoder/src/Math.cr
  isVerificationFile: true
  path: test/math/euler_table_test.cr
  requiredBy: []
  timestamp: '2021-08-25 19:08:41+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/math/euler_table_test.cr
layout: document
redirect_from:
- /verify/test/math/euler_table_test.cr
- /verify/test/math/euler_table_test.cr.html
title: test/math/euler_table_test.cr
---
