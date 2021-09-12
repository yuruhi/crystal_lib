---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':heavy_check_mark:'
    path: src/dp/inversion.cr
    title: src/dp/inversion.cr
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/datastructure/fewnick_tree_test.cr
    title: test/datastructure/fewnick_tree_test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "class FenwickTree(T)\n  getter size : Int32\n\n  def initialize(@size)\n\
    \    @a = Array(T).new(@size + 1, T.zero)\n  end\n\n  def initialize(a : Array(T))\n\
    \    @a = [T.zero]\n    @a.concat a\n    @size = a.size\n    (1...size).each do\
    \ |i|\n      j = i + (i & -i)\n      next if j > size\n      @a[j] += @a[i]\n\
    \    end\n  end\n\n  # Add *x* to `a[i]`.\n  def add(i : Int, x) : Nil\n    raise\
    \ IndexError.new unless 0 <= i < size\n    i += 1\n    while i <= size\n     \
    \ @a[i] += x\n      i += i & -i\n    end\n  end\n\n  # Set *x* to `a[i]`.\n  def\
    \ set(i : Int, x) : Nil\n    add(i, x - self[i, 1])\n  end\n\n  # Alias for `set`\n\
    \  def []=(i : Int, x) : Nil\n    set(i, x)\n  end\n\n  # Culculates sum of `a[0...i]`.\n\
    \  def left_sum(i : Int) : T\n    raise IndexError.new unless 0 <= i <= size\n\
    \    sum = T.zero\n    while i > 0\n      sum += @a[i]\n      i -= i & -i\n  \
    \  end\n    sum\n  end\n\n  def [](i : Int)\n    left_sum(i + 1) - left_sum(i)\n\
    \  end\n\n  def [](start : Int, count : Int) : T\n    left_sum(start + count)\
    \ - left_sum(start)\n  end\n\n  def [](range : Range) : T\n    self[*Indexable.range_to_index_and_count(range,\
    \ size) || raise IndexError.new]\n  end\n\n  def to_a : Array(T)\n    (0...size).map\
    \ { |i| self[i..i] }\n  end\nend\n"
  code: "class FenwickTree(T)\n  getter size : Int32\n\n  def initialize(@size)\n\
    \    @a = Array(T).new(@size + 1, T.zero)\n  end\n\n  def initialize(a : Array(T))\n\
    \    @a = [T.zero]\n    @a.concat a\n    @size = a.size\n    (1...size).each do\
    \ |i|\n      j = i + (i & -i)\n      next if j > size\n      @a[j] += @a[i]\n\
    \    end\n  end\n\n  # Add *x* to `a[i]`.\n  def add(i : Int, x) : Nil\n    raise\
    \ IndexError.new unless 0 <= i < size\n    i += 1\n    while i <= size\n     \
    \ @a[i] += x\n      i += i & -i\n    end\n  end\n\n  # Set *x* to `a[i]`.\n  def\
    \ set(i : Int, x) : Nil\n    add(i, x - self[i, 1])\n  end\n\n  # Alias for `set`\n\
    \  def []=(i : Int, x) : Nil\n    set(i, x)\n  end\n\n  # Culculates sum of `a[0...i]`.\n\
    \  def left_sum(i : Int) : T\n    raise IndexError.new unless 0 <= i <= size\n\
    \    sum = T.zero\n    while i > 0\n      sum += @a[i]\n      i -= i & -i\n  \
    \  end\n    sum\n  end\n\n  def [](i : Int)\n    left_sum(i + 1) - left_sum(i)\n\
    \  end\n\n  def [](start : Int, count : Int) : T\n    left_sum(start + count)\
    \ - left_sum(start)\n  end\n\n  def [](range : Range) : T\n    self[*Indexable.range_to_index_and_count(range,\
    \ size) || raise IndexError.new]\n  end\n\n  def to_a : Array(T)\n    (0...size).map\
    \ { |i| self[i..i] }\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/datastructure/fenwick_tree.cr
  requiredBy:
  - src/dp/inversion.cr
  timestamp: '2021-09-12 11:14:23+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/datastructure/fewnick_tree_test.cr
documentation_of: src/datastructure/fenwick_tree.cr
layout: document
redirect_from:
- /library/src/datastructure/fenwick_tree.cr
- /library/src/datastructure/fenwick_tree.cr.html
title: src/datastructure/fenwick_tree.cr
---
