---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/math/gcd.cr
    title: src/math/gcd.cr
  - icon: ':question:'
    path: src/math/mint.cr
    title: src/math/mint.cr
  - icon: ':heavy_check_mark:'
    path: src/math/prime.cr
    title: src/math/prime.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://yukicoder.me/problems/no/886
  bundledCode: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/886\n\
    # require \"../../src/math/gcd\"\n# require \"../../src/math/prime\"\nmodule Prime\n\
    \  extend self\n  include Indexable(Int32)\n\n  @@primes = [\n    2, 3, 5, 7,\
    \ 11, 13, 17, 19, 23, 29,\n    31, 37, 41, 43, 47, 53, 59, 61, 67, 71,\n    73,\
    \ 79, 83, 89, 97, 101, 103, 107, 109, 113,\n    127, 131, 137, 139, 149, 151,\
    \ 157, 163, 167, 173,\n    179, 181, 191, 193, 197, 199, 211, 223, 227, 229,\n\
    \    233, 239, 241, 251, 257, 263, 269, 271, 277, 281,\n    283, 293, 307, 311,\
    \ 313, 317, 331, 337, 347, 349,\n    353, 359, 367, 373, 379, 383, 389, 397, 401,\
    \ 409,\n    419, 421, 431, 433, 439, 443, 449, 457, 461, 463,\n    467, 479, 487,\
    \ 491, 499, 503, 509, 521, 523, 541,\n    547, 557, 563, 569, 571, 577, 587, 593,\
    \ 599, 601,\n    607, 613, 617, 619, 631, 641, 643, 647, 653, 659,\n    661, 673,\
    \ 677, 683, 691, 701, 709, 719, 727, 733,\n    739, 743, 751, 757, 761, 769, 773,\
    \ 787, 797, 809,\n    811, 821, 823, 827, 829, 839, 853, 857, 859, 863,\n    877,\
    \ 881, 883, 887, 907, 911, 919, 929, 937, 941,\n    947, 953, 967, 971, 977, 983,\
    \ 991, 997,\n  ]\n\n  private def generate_primes : Nil\n    size = @@primes.size\n\
    \    primes = Array.new(size) { |i| @@primes.last + (i + 1) * 2 }\n    last =\
    \ primes.last\n\n    @@primes.each do |prime|\n      next if prime == 2\n    \
    \  break if prime * prime > last\n      from = prime * ((@@primes.last // prime\
    \ + 1) // 2 * 2 + 1)\n      from.step(to: last, by: prime * 2) do |x|\n      \
    \  primes[~((last - x) // 2)] = 0\n      end\n    end\n\n    @@primes.concat primes.reject(0)\n\
    \  end\n\n  private def generate_until(*, index : Int)\n    while @@primes.size\
    \ <= index\n      generate_primes\n    end\n  end\n\n  private def generate_until(*,\
    \ value : Int)\n    while @@primes.last < value\n      generate_primes\n    end\n\
    \  end\n\n  private def check_index_out_of_bounds(index)\n    if 0 <= index <\
    \ size\n      index\n    else\n      yield\n    end\n  end\n\n  # Returns the\
    \ *index* th prime, without doing any bounds check.\n  def unsafe_fetch(index\
    \ : Int) : Int32\n    generate_until(index: index)\n    @@primes.unsafe_fetch(index)\n\
    \  end\n\n  # Returns the limit of size.\n  def size : Int32\n    10**9\n  end\n\
    \n  def []?(start : Int, count : Int) : Array(Int32)?\n    raise ArgumentError.new\
    \ \"Negative count: #{count}\" if count < 0\n    return [] of Int32 if start ==\
    \ size\n\n    if 0 <= start <= size\n      return [] of Int32 if count == 0\n\n\
    \      count = Math.min(count, size - start)\n      generate_until(index: start\
    \ + count)\n\n      Array(Int32).build(count) do |buffer|\n        buffer.copy_from(@@primes.to_unsafe\
    \ + start, count)\n        count\n      end\n    end\n  end\n\n  def [](start\
    \ : Int, count : Int) : Array(Int32)\n    self[start, count]? || raise IndexError.new\n\
    \  end\n\n  private def self.range_to_index_and_count(range : Range, size : Int)\n\
    \    end_index = range.end || raise ArgumentError.new\n    end_index -= 1 if range.excludes_end?\n\
    \    start_index = range.begin || 0\n    raise IndexError.new unless start_index\
    \ >= 0\n    count = Math.max(end_index - start_index + 1, 0)\n    {start_index,\
    \ count}\n  end\n\n  def []?(range : Range) : Array(Int32)?\n    self[*range_to_index_and_count(range,\
    \ size)]?\n  end\n\n  def [](range : Range) : Array(Int32)\n    self[*range_to_index_and_count(range,\
    \ size)]\n  end\n\n  def includes?(x : Int) : Bool\n    generate_until(value:\
    \ x)\n    @@primes.bsearch { |y| y >= x } == x\n  end\n\n  def index(x : Int)\
    \ : Int32?\n    generate_until(value: x)\n    i = @@primes.bsearch_index { |y|\
    \ y >= x }.not_nil!\n    @@primes[i] == x ? i : nil\n  end\n\n  def each(x : Int,\
    \ &) : Nil\n    i = 0\n    loop do\n      generate_primes if @@primes.size ==\
    \ i\n      prime = @@primes.unsafe_fetch(i)\n      break if prime > x\n      yield\
    \ prime\n      i += 1\n    end\n  end\n\n  def each(x : Int)\n    each.take_while\
    \ { |prime| prime <= x }\n  end\nend\n\nclass Array(T)\n  # `result[i] = Sum_{n\
    \ | i} a[i]` (inplace)\n  def gcd_zeta!\n    Prime.each(size - 1) do |p|\n   \
    \   i, k = size.pred // p, size.pred // p * p\n      while k > 0\n        self[i]\
    \ += self[i * p]\n        i -= 1; k -= p\n      end\n    end\n    self\n  end\n\
    \n  # `result[i] = Sum_{n | i} a[i]`\n  def gcd_zeta\n    dup.gcd_zeta!\n  end\n\
    \n  # `a[i] = Sum_{n | i} result[i]` (inplace)\n  def gcd_mobius!\n    Prime.each(size\
    \ - 1) do |p|\n      i, k = 1, p\n      while k < size\n        self[i] -= self[k]\n\
    \        i += 1; k += p\n      end\n    end\n    self\n  end\n\n  # `a[i] = Sum_{n\
    \ | i} result[i]`\n  def gcd_mobius\n    dup.gcd_mobius!\n  end\nend\n\nmodule\
    \ GCD\n  extend self\n\n  # `result[n] = Sum_{gcd(i, j) = n} f[i] * g[j]`\n  def\
    \ convolution(f : Array(T), g : Array(T)) forall T\n    f.gcd_zeta.zip?(g.gcd_zeta).map\
    \ { |x, y| (x || T.zero) * (y || T.zero) }.gcd_mobius!\n  end\nend\n\n# require\
    \ \"../../src/math/mint\"\nmacro static_modint(name, mod)\n  struct {{name}}\n\
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
    \    end\n\n    def to_i64 : Int64\n      value\n    end\n\n    def to_s(io :\
    \ IO) : Nil\n      value.to_s(io)\n    end\n\n    def inspect(io : IO) : Nil\n\
    \      value.inspect(io)\n    end\n  end\n\n  {% to = (\"to_\" + name.stringify.downcase.gsub(/mint|modint/,\
    \ \"m\")).id %}\n\n  struct Int\n    {% for op in %w[+ - * / //] %}\n      def\
    \ {{op.id}}(value : {{name}})\n        {{to}} {{op.id}} value\n      end\n   \
    \ {% end %}\n\n    {% for op in %w[< <= > >=] %}\n      def {{op.id}}(m : {{name}})\n\
    \        raise NotImplementedError.new({{op}})\n      end\n    {% end %}\n\n \
    \   def {{to}} : {{name}}\n      {{name}}.new(self)\n    end\n  end\n\n  class\
    \ String\n    def {{to}} : {{name}}\n      {{name}}.new(self)\n    end\n  end\n\
    end\n\nstatic_modint(Mint, 1000000007)\nstatic_modint(Mint2, 998244353)\n\nh,\
    \ w = read_line.split.map(&.to_i)\nhh = (0...h).map { |i| (h - i).to_m }\nww =\
    \ (0...w).map { |i| (w - i).to_m }\none = h.to_m * w.pred + w.to_m * h.pred\n\
    puts GCD.convolution(hh, ww).fetch(1, Mint.zero) * 2 + one\n"
  code: '# verification-helper: PROBLEM https://yukicoder.me/problems/no/886

    require "../../src/math/gcd"

    require "../../src/math/mint"

    h, w = read_line.split.map(&.to_i)

    hh = (0...h).map { |i| (h - i).to_m }

    ww = (0...w).map { |i| (w - i).to_m }

    one = h.to_m * w.pred + w.to_m * h.pred

    puts GCD.convolution(hh, ww).fetch(1, Mint.zero) * 2 + one

    '
  dependsOn:
  - src/math/gcd.cr
  - src/math/prime.cr
  - src/math/mint.cr
  isVerificationFile: true
  path: test/math/gcd_convolution_test.cr
  requiredBy: []
  timestamp: '2021-10-17 22:03:11+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/math/gcd_convolution_test.cr
layout: document
redirect_from:
- /verify/test/math/gcd_convolution_test.cr
- /verify/test/math/gcd_convolution_test.cr.html
title: test/math/gcd_convolution_test.cr
---
