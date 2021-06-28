---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/BinaryIndexedTree.test.cr
    title: test/BinaryIndexedTree.test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "class BinaryIndexedTree(T)\n  getter size : Int32\n\n  def initialize(@size)\n\
    \    @a = Array(T).new(@size + 1, T.zero)\n  end\n\n  def initialize(a : Array(T))\n\
    \    @a = [T.zero]\n    @a.concat a\n    @size = a.size\n    (1...size).each do\
    \ |i|\n      j = i + (i & -i)\n      next if j > size\n      @a[j] += @a[i]\n\
    \    end\n  end\n\n  def add(i : Int32, x)\n    raise IndexError.new unless 0\
    \ <= i < size\n    i += 1\n    while i <= size\n      @a[i] += x\n      i += i\
    \ & -i\n    end\n  end\n\n  # sum of a[0...i]\n  def left_sum(i : Int32)\n   \
    \ raise IndexError.new unless 0 <= i <= size\n    sum = T.zero\n    while i >\
    \ 0\n      sum += @a[i]\n      i -= i & -i\n    end\n    sum\n  end\n\n  def [](start\
    \ : Int32, count : Int32)\n    left_sum(start + count) - left_sum(start)\n  end\n\
    \n  def [](range : Range)\n    self[*Indexable.range_to_index_and_count(range,\
    \ size) || raise IndexError.new]\n  end\n\n  def to_a\n    (0...size).map { |i|\
    \ self[i..i] }\n  end\nend\n"
  code: "class BinaryIndexedTree(T)\n  getter size : Int32\n\n  def initialize(@size)\n\
    \    @a = Array(T).new(@size + 1, T.zero)\n  end\n\n  def initialize(a : Array(T))\n\
    \    @a = [T.zero]\n    @a.concat a\n    @size = a.size\n    (1...size).each do\
    \ |i|\n      j = i + (i & -i)\n      next if j > size\n      @a[j] += @a[i]\n\
    \    end\n  end\n\n  def add(i : Int32, x)\n    raise IndexError.new unless 0\
    \ <= i < size\n    i += 1\n    while i <= size\n      @a[i] += x\n      i += i\
    \ & -i\n    end\n  end\n\n  # sum of a[0...i]\n  def left_sum(i : Int32)\n   \
    \ raise IndexError.new unless 0 <= i <= size\n    sum = T.zero\n    while i >\
    \ 0\n      sum += @a[i]\n      i -= i & -i\n    end\n    sum\n  end\n\n  def [](start\
    \ : Int32, count : Int32)\n    left_sum(start + count) - left_sum(start)\n  end\n\
    \n  def [](range : Range)\n    self[*Indexable.range_to_index_and_count(range,\
    \ size) || raise IndexError.new]\n  end\n\n  def to_a\n    (0...size).map { |i|\
    \ self[i..i] }\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: datastructure/BinaryIndexedTree.cr
  requiredBy: []
  timestamp: '2021-06-28 21:15:31+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/BinaryIndexedTree.test.cr
documentation_of: datastructure/BinaryIndexedTree.cr
layout: document
redirect_from:
- /library/datastructure/BinaryIndexedTree.cr
- /library/datastructure/BinaryIndexedTree.cr.html
title: datastructure/BinaryIndexedTree.cr
---
