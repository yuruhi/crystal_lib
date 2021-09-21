---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/datastructure/cul_sum_test.cr
    title: test/datastructure/cul_sum_test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "class CulSum(T)\n  def self.build(a : Enumerable(T))\n    result =\
    \ [T.zero]\n    a.each do |x|\n      result << result[-1] + x\n    end\n    result\n\
    \  end\n\n  def initialize(a : Array(T))\n    @n = a.size\n    @s = Array(T).new(@n\
    \ + 1, T.zero)\n    @n.times do |i|\n      @s[i + 1] = @s[i] + a[i]\n    end\n\
    \  end\n\n  def initialize(@n : Int32, &f : Int32 -> T)\n    @s = Array(T).new(@n\
    \ + 1, T.zero)\n    @n.times do |i|\n      @s[i + 1] = @s[i] + yield(i)\n    end\n\
    \  end\n\n  def initialize(a, &f)\n    @n = a.size\n    @s = Array(T).new(@n +\
    \ 1, T.zero)\n    @n.times do |i|\n      @s[i + 1] = @s[i] + yield(a[i])\n   \
    \ end\n  end\n\n  def [](left : Int32, count : Int32) : T\n    @s[left + count]\
    \ - @s[left]\n  end\n\n  def [](range : Range) : T\n    self[*Indexable.range_to_index_and_count(range,\
    \ @n) || raise IndexError.new]\n  end\n\n  def to_a : Array(T)\n    (0...@n).map\
    \ { |i| self[i..i] }\n  end\nend\n"
  code: "class CulSum(T)\n  def self.build(a : Enumerable(T))\n    result = [T.zero]\n\
    \    a.each do |x|\n      result << result[-1] + x\n    end\n    result\n  end\n\
    \n  def initialize(a : Array(T))\n    @n = a.size\n    @s = Array(T).new(@n +\
    \ 1, T.zero)\n    @n.times do |i|\n      @s[i + 1] = @s[i] + a[i]\n    end\n \
    \ end\n\n  def initialize(@n : Int32, &f : Int32 -> T)\n    @s = Array(T).new(@n\
    \ + 1, T.zero)\n    @n.times do |i|\n      @s[i + 1] = @s[i] + yield(i)\n    end\n\
    \  end\n\n  def initialize(a, &f)\n    @n = a.size\n    @s = Array(T).new(@n +\
    \ 1, T.zero)\n    @n.times do |i|\n      @s[i + 1] = @s[i] + yield(a[i])\n   \
    \ end\n  end\n\n  def [](left : Int32, count : Int32) : T\n    @s[left + count]\
    \ - @s[left]\n  end\n\n  def [](range : Range) : T\n    self[*Indexable.range_to_index_and_count(range,\
    \ @n) || raise IndexError.new]\n  end\n\n  def to_a : Array(T)\n    (0...@n).map\
    \ { |i| self[i..i] }\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/datastructure/cul_sum.cr
  requiredBy: []
  timestamp: '2021-09-21 18:47:12+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/datastructure/cul_sum_test.cr
documentation_of: src/datastructure/cul_sum.cr
layout: document
redirect_from:
- /library/src/datastructure/cul_sum.cr
- /library/src/datastructure/cul_sum.cr.html
title: src/datastructure/cul_sum.cr
---
