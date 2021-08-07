---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/datastructure/cul_sum.cr
    title: src/datastructure/cul_sum.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/static_range_sum
  bundledCode: "# verification-helper: PROBLEM https://judge.yosupo.jp/problem/static_range_sum\n\
    # require \"../../src/datastructure/cul_sum\"\nclass CulSum(T)\n  def self.build(a\
    \ : Enumerable(T))\n    result = [T.zero]\n    a.each do |x|\n      result <<\
    \ result[-1] + x\n    end\n    result\n  end\n\n  def initialize(a : Array(T))\n\
    \    @n = a.size\n    @s = Array(T).new(@n + 1, T.zero)\n    @n.times do |i|\n\
    \      @s[i + 1] = @s[i] + a[i]\n    end\n  end\n\n  def initialize(@n : Int32,\
    \ &f : Int32 -> T)\n    @s = Array(T).new(@n + 1, T.zero)\n    @n.times do |i|\n\
    \      @s[i + 1] = @s[i] + yield(i)\n    end\n  end\n\n  def initialize(a, &f)\n\
    \    @n = a.size\n    @s = Array(T).new(@n + 1, T.zero)\n    @n.times do |i|\n\
    \      @s[i + 1] = @s[i] + yield(a[i])\n    end\n  end\n\n  def [](left : Int32,\
    \ count : Int32) : T\n    @s[left + count] - @s[left]\n  end\n\n  def [](range\
    \ : Range) : T\n    self[*Indexable.range_to_index_and_count(range, @n) || raise\
    \ IndexError.new]\n  end\n\n  def to_a : Array(T)\n    (0...@n).map { |i| self[i..i]\
    \ }\n  end\nend\n\n_, q = read_line.split.map(&.to_i)\na = read_line.split.map(&.to_i64)\n\
    sum = CulSum.new(a)\nq.times do\n  l, r = read_line.split.map(&.to_i)\n  puts\
    \ sum[l...r]\nend\n"
  code: "# verification-helper: PROBLEM https://judge.yosupo.jp/problem/static_range_sum\n\
    require \"../../src/datastructure/cul_sum\"\n_, q = read_line.split.map(&.to_i)\n\
    a = read_line.split.map(&.to_i64)\nsum = CulSum.new(a)\nq.times do\n  l, r = read_line.split.map(&.to_i)\n\
    \  puts sum[l...r]\nend\n"
  dependsOn:
  - src/datastructure/cul_sum.cr
  isVerificationFile: true
  path: test/datastructure/cul_sum_test.cr
  requiredBy: []
  timestamp: '2021-08-04 13:11:57+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/datastructure/cul_sum_test.cr
layout: document
redirect_from:
- /verify/test/datastructure/cul_sum_test.cr
- /verify/test/datastructure/cul_sum_test.cr.html
title: test/datastructure/cul_sum_test.cr
---
