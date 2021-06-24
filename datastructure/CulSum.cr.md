---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/CulSum.test.cr
    title: test/CulSum.test.cr
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
    \ end\n  end\n\n  def [](left : Int32, count : Int32)\n    @s[left + count] -\
    \ @s[left]\n  end\n\n  def [](range : Range)\n    self[*Indexable.range_to_index_and_count(range,\
    \ @n) || raise IndexError.new]\n  end\n\n  def to_a\n    (0...@n).map { |i| self[i..i]\
    \ }\n  end\nend\n"
  code: "class CulSum(T)\n  def self.build(a : Enumerable(T))\n    result = [T.zero]\n\
    \    a.each do |x|\n      result << result[-1] + x\n    end\n    result\n  end\n\
    \n  def initialize(a : Array(T))\n    @n = a.size\n    @s = Array(T).new(@n +\
    \ 1, T.zero)\n    @n.times do |i|\n      @s[i + 1] = @s[i] + a[i]\n    end\n \
    \ end\n\n  def initialize(@n : Int32, &f : Int32 -> T)\n    @s = Array(T).new(@n\
    \ + 1, T.zero)\n    @n.times do |i|\n      @s[i + 1] = @s[i] + yield(i)\n    end\n\
    \  end\n\n  def initialize(a, &f)\n    @n = a.size\n    @s = Array(T).new(@n +\
    \ 1, T.zero)\n    @n.times do |i|\n      @s[i + 1] = @s[i] + yield(a[i])\n   \
    \ end\n  end\n\n  def [](left : Int32, count : Int32)\n    @s[left + count] -\
    \ @s[left]\n  end\n\n  def [](range : Range)\n    self[*Indexable.range_to_index_and_count(range,\
    \ @n) || raise IndexError.new]\n  end\n\n  def to_a\n    (0...@n).map { |i| self[i..i]\
    \ }\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: datastructure/CulSum.cr
  requiredBy: []
  timestamp: '2021-06-24 10:11:13+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/CulSum.test.cr
documentation_of: datastructure/CulSum.cr
layout: document
redirect_from:
- /library/datastructure/CulSum.cr
- /library/datastructure/CulSum.cr.html
title: datastructure/CulSum.cr
---
