---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/math/combination.cr
    title: src/math/combination.cr
  - icon: ':question:'
    path: src/math/mint.cr
    title: src/math/mint.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://yukicoder.me/problems/no/117
  bundledCode: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/117\n\
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
    alias Mint2 = ModInt(998244353i64)\n\n# require \"../../src/math/combination\"\
    \nclass Combination(T)\n  def initialize(initial_capacity : Int = 2)\n    initial_capacity\
    \ += 1\n    @size = 2\n    @factorial = Array(T).new(initial_capacity)\n    @factorial\
    \ << T.new(1) << T.new(1)\n    @inv = Array(T).new(initial_capacity)\n    @inv\
    \ << T.zero << T.new(1)\n    @finv = Array(T).new(initial_capacity)\n    @finv\
    \ << T.new(1) << T.new(1)\n    expand_until(initial_capacity)\n  end\n\n  private\
    \ def expand_until(n : Int)\n    while @size <= n\n      @factorial << @factorial[-1]\
    \ * @size\n      @inv << -@inv[T.mod % @size] * (T.mod // @size)\n      @finv\
    \ << @finv[-1] * @inv[@size]\n      @size += 1\n    end\n  end\n\n  def factorial(n\
    \ : Int)\n    raise IndexError.new if n < 0\n    expand_until(n)\n    @factorial.unsafe_fetch(n)\n\
    \  end\n\n  def inv(n : Int)\n    raise DivisionByZeroError.new if n == 0\n  \
    \  raise IndexError.new if n < 0\n    expand_until(n)\n    @inv.unsafe_fetch(n)\n\
    \  end\n\n  def finv(n : Int)\n    raise IndexError.new if n < 0\n    expand_until(n)\n\
    \    @finv.unsafe_fetch(n)\n  end\n\n  def permutation(n : Int, r : Int)\n   \
    \ (n < r || n < 0 || r < 0) ? T.zero : factorial(n) * finv(n - r)\n  end\n\n \
    \ def combination(n : Int, r : Int)\n    (n < r || n < 0 || r < 0) ? T.zero :\
    \ factorial(n) * finv(r) * finv(n - r)\n  end\n\n  def repeated_combination(n\
    \ : Int, r : Int)\n    (n < 0 || r < 0) ? T.zero : r == 0 ? T.new(1) : combination(n\
    \ + r - 1, r)\n  end\n\n  def self.table(n : Int)\n    table = Array.new(n + 1)\
    \ { Array.new(n + 1, T.zero) }\n    (0..n).each do |i|\n      table[i][0] = table[i][i]\
    \ = 1\n    end\n    (1..n).each do |i|\n      (1...i).each do |j|\n        table[i][j]\
    \ = table[i - 1][j - 1] + table[i - 1][j]\n      end\n    end\n    table\n  end\n\
    end\n\nC = Combination(Mint).new\n\nread_line.to_i.times do\n  read_line =~ /(.).(\\\
    d+).(\\d+)./\n  c, n, r = $1[-1], $2.to_i, $3.to_i\n  puts case c\n  when 'C'\n\
    \    C.combination(n, r)\n  when 'P'\n    C.permutation(n, r)\n  when 'H'\n  \
    \  C.repeated_combination(n, r)\n  end\nend\n"
  code: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/117\nrequire\
    \ \"../../src/math/mint\"\nrequire \"../../src/math/combination\"\nC = Combination(Mint).new\n\
    \nread_line.to_i.times do\n  read_line =~ /(.).(\\d+).(\\d+)./\n  c, n, r = $1[-1],\
    \ $2.to_i, $3.to_i\n  puts case c\n  when 'C'\n    C.combination(n, r)\n  when\
    \ 'P'\n    C.permutation(n, r)\n  when 'H'\n    C.repeated_combination(n, r)\n\
    \  end\nend\n"
  dependsOn:
  - src/math/mint.cr
  - src/math/combination.cr
  isVerificationFile: true
  path: test/math/combination_test.cr
  requiredBy: []
  timestamp: '2022-01-23 11:59:02+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/math/combination_test.cr
layout: document
redirect_from:
- /verify/test/math/combination_test.cr
- /verify/test/math/combination_test.cr.html
title: test/math/combination_test.cr
---
