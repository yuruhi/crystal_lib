---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/datastructure/fenwick_tree.cr
    title: src/datastructure/fenwick_tree.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/dp/inversion_test.cr
    title: test/dp/inversion_test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "# require \"../datastructure/fenwick_tree\"\nclass FenwickTree(T)\n\
    \  getter size : Int32\n\n  def initialize(size : Int)\n    @size = size.to_i\n\
    \    @data = Array(T).new(@size + 1, T.zero)\n  end\n\n  def initialize(array\
    \ : Array(T))\n    @data = [T.zero] + array\n    @size = array.size\n    (1...size).each\
    \ do |i|\n      j = i + (i & -i)\n      next if j > size\n      @data[j] += @data[i]\n\
    \    end\n  end\n\n  # Adds *x* to *index* th element.\n  def add(index : Int,\
    \ x) : Nil\n    raise IndexError.new unless 0 <= index < size\n    index += 1\n\
    \    while index <= size\n      @data[index] += x\n      index += index & -index\n\
    \    end\n  end\n\n  # Set *x* to *index* th element.\n  def set(index : Int,\
    \ x) : Nil\n    add(index, x - self[index])\n  end\n\n  # :ditto:\n  def []=(i\
    \ : Int, x) : Nil\n    set(i, x)\n  end\n\n  # Culculates sum of `a[0...i]`.\n\
    \  def left_sum(i : Int) : T\n    raise IndexError.new unless 0 <= i <= size\n\
    \    sum = T.zero\n    while i > 0\n      sum += @data[i]\n      i -= i & -i\n\
    \    end\n    sum\n  end\n\n  # Returns *index* th element.\n  def [](index :\
    \ Int)\n    left_sum(index + 1) - left_sum(index)\n  end\n\n  # Returns sum of\
    \ `a[start, count]`\n  def [](start : Int, count : Int) : T\n    left_sum(start\
    \ + count) - left_sum(start)\n  end\n\n  # Returns sum of `a[range]`\n  def [](range\
    \ : Range) : T\n    self[*Indexable.range_to_index_and_count(range, size) || raise\
    \ IndexError.new]\n  end\n\n  # Returns the elements as an Array.\n  def to_a\
    \ : Array(T)\n    Array.new(size) { |i| self[i] }\n  end\nend\n\nmodule DP\n \
    \ extend self\n\n  def inversion(a : Array(T)) : Int64 forall T\n    bit = FenwickTree(Int32).new(a.max\
    \ + 1)\n    a.sum(0i64) do |x|\n      bit[x + 1..].tap { bit.add(x, 1) }\n   \
    \ end\n  end\nend\n"
  code: "require \"../datastructure/fenwick_tree\"\n\nmodule DP\n  extend self\n\n\
    \  def inversion(a : Array(T)) : Int64 forall T\n    bit = FenwickTree(Int32).new(a.max\
    \ + 1)\n    a.sum(0i64) do |x|\n      bit[x + 1..].tap { bit.add(x, 1) }\n   \
    \ end\n  end\nend\n"
  dependsOn:
  - src/datastructure/fenwick_tree.cr
  isVerificationFile: false
  path: src/dp/inversion.cr
  requiredBy: []
  timestamp: '2021-10-15 17:24:58+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/dp/inversion_test.cr
documentation_of: src/dp/inversion.cr
layout: document
redirect_from:
- /library/src/dp/inversion.cr
- /library/src/dp/inversion.cr.html
title: src/dp/inversion.cr
---
