---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/string/rolling_hash_test.cr
    title: test/string/rolling_hash_test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "class RollingHash\n  MOD = (1u64 << 61) - 1\n\n  private def mul(a\
    \ : UInt64, b : UInt64)\n    t = a.to_u128 * b\n    t = (t >> 61) + (t & MOD)\n\
    \    (t < MOD ? t : t - MOD).to_u64\n  end\n\n  getter size : Int32\n\n  def initialize(s\
    \ : String, base : UInt64 = 10007u64)\n    initialize(s.size, s.each_char, base,\
    \ &.ord)\n  end\n\n  def initialize(a : Array(Int), base : UInt64 = 10007u64)\n\
    \    initialize(a.size, a, base, &.itself)\n  end\n\n  def initialize(@size, a\
    \ : Enumerable, base : UInt64 = 10007u64, &)\n    @pow = Array(UInt64).new(size\
    \ + 1, 1)\n    @hash = Array(UInt64).new(size + 1, 0)\n    a.each_with_index do\
    \ |x, i|\n      @pow[i + 1] = mul(@pow[i], base)\n      @hash[i + 1] = mul(@hash[i],\
    \ base) + yield(x)\n      @hash[i + 1] -= MOD if @hash[i + 1] >= MOD\n    end\n\
    \  end\n\n  def [](start : Int, count : Int) : UInt64\n    res = @hash[start +\
    \ count] + MOD - mul(@hash[start], @pow[count])\n    res < MOD ? res : res - MOD\n\
    \  end\n\n  def [](range : Range) : UInt64\n    self[*Indexable.range_to_index_and_count(range,\
    \ size) || raise IndexError.new]\n  end\nend\n"
  code: "class RollingHash\n  MOD = (1u64 << 61) - 1\n\n  private def mul(a : UInt64,\
    \ b : UInt64)\n    t = a.to_u128 * b\n    t = (t >> 61) + (t & MOD)\n    (t <\
    \ MOD ? t : t - MOD).to_u64\n  end\n\n  getter size : Int32\n\n  def initialize(s\
    \ : String, base : UInt64 = 10007u64)\n    initialize(s.size, s.each_char, base,\
    \ &.ord)\n  end\n\n  def initialize(a : Array(Int), base : UInt64 = 10007u64)\n\
    \    initialize(a.size, a, base, &.itself)\n  end\n\n  def initialize(@size, a\
    \ : Enumerable, base : UInt64 = 10007u64, &)\n    @pow = Array(UInt64).new(size\
    \ + 1, 1)\n    @hash = Array(UInt64).new(size + 1, 0)\n    a.each_with_index do\
    \ |x, i|\n      @pow[i + 1] = mul(@pow[i], base)\n      @hash[i + 1] = mul(@hash[i],\
    \ base) + yield(x)\n      @hash[i + 1] -= MOD if @hash[i + 1] >= MOD\n    end\n\
    \  end\n\n  def [](start : Int, count : Int) : UInt64\n    res = @hash[start +\
    \ count] + MOD - mul(@hash[start], @pow[count])\n    res < MOD ? res : res - MOD\n\
    \  end\n\n  def [](range : Range) : UInt64\n    self[*Indexable.range_to_index_and_count(range,\
    \ size) || raise IndexError.new]\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/string/rolling_hash.cr
  requiredBy: []
  timestamp: '2022-03-25 11:37:47+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/string/rolling_hash_test.cr
documentation_of: src/string/rolling_hash.cr
layout: document
redirect_from:
- /library/src/string/rolling_hash.cr
- /library/src/string/rolling_hash.cr.html
title: src/string/rolling_hash.cr
---
