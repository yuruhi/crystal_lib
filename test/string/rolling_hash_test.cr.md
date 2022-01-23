---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/string/rolling_hash.cr
    title: src/string/rolling_hash.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://onlinejudge.u-aizu.ac.jp/courses/lesson/1/ALDS1/all/ALDS1_14_B
  bundledCode: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/lesson/1/ALDS1/all/ALDS1_14_B\n\
    # require \"../../src/string/rolling_hash\"\nclass RollingHash\n  MOD = (1u64\
    \ << 61) - 1\n\n  private def mul(a : UInt64, b : UInt64)\n    t = a.to_u128 *\
    \ b\n    t = (t >> 61) + (t & MOD)\n    (t < MOD ? t : t - MOD).to_u64\n  end\n\
    \n  getter size : Int32\n\n  def initialize(s : String, base : UInt64 = 10007u64)\n\
    \    initialize(s.size, s.each_char, base, &.ord)\n  end\n\n  def initialize(a\
    \ : Array(Int), base : UInt64 = 10007u64)\n    initialize(a.size, a, base, &.itself)\n\
    \  end\n\n  def initialize(@size, a : Enumerable, base : UInt64 = 10007u64, &)\n\
    \    @pow = Array(UInt64).new(size + 1, 1)\n    @hash = Array(UInt64).new(size\
    \ + 1, 0)\n    a.each_with_index do |x, i|\n      @pow[i + 1] = mul(@pow[i], base)\n\
    \      @hash[i + 1] = mul(@hash[i], base) + yield(x)\n      @hash[i + 1] -= MOD\
    \ if @hash[i + 1] >= MOD\n    end\n  end\n\n  def [](start : Int, count : Int)\
    \ : UInt64\n    res = @hash[start + count] + MOD - mul(@hash[start], @pow[count])\n\
    \    res < MOD ? res : res - MOD\n  end\n\n  def [](range : Range) : UInt64\n\
    \    self[*Indexable.range_to_index_and_count(range, size) || raise IndexError.new]\n\
    \  end\nend\n\ns = RollingHash.new read_line\nt = RollingHash.new read_line\n\
    (0..s.size - t.size).each do |i|\n  puts i if s[i, t.size] == t[0, t.size]\nend\n"
  code: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/lesson/1/ALDS1/all/ALDS1_14_B\n\
    require \"../../src/string/rolling_hash\"\ns = RollingHash.new read_line\nt =\
    \ RollingHash.new read_line\n(0..s.size - t.size).each do |i|\n  puts i if s[i,\
    \ t.size] == t[0, t.size]\nend\n"
  dependsOn:
  - src/string/rolling_hash.cr
  isVerificationFile: true
  path: test/string/rolling_hash_test.cr
  requiredBy: []
  timestamp: '2021-08-04 18:11:49+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/string/rolling_hash_test.cr
layout: document
redirect_from:
- /verify/test/string/rolling_hash_test.cr
- /verify/test/string/rolling_hash_test.cr.html
title: test/string/rolling_hash_test.cr
---
