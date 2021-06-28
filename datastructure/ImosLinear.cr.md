---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/ImosLinear.test.cr
    title: test/ImosLinear.test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "class ImosLinear(T)\n  getter size : Int32\n  @builded = false\n\n\
    \  def initialize(@size : Int32)\n    @a = Array(T).new(@size + 1, T.zero)\n \
    \   @b = Array(T).new(@size + 1, T.zero)\n  end\n\n  # add `a + (i - l) * b` to\
    \ [l, r)\n  def add(start : Int, count : Int, val_a : T, val_b : T) : Nil\n  \
    \  raise \"self had been called `#build`\" if @builded\n    raise ArgumentError.new\
    \ \"Negative count: #{count}\" if count < 0\n    @a[start] += val_a - val_b *\
    \ start\n    @b[start] += val_b\n    @a[start + count] -= val_a - val_b * start\n\
    \    @b[start + count] -= val_b\n  end\n\n  def add(range : Range, val_a : T,\
    \ val_b : T)\n    start, count = Indexable.range_to_index_and_count(range, size)\
    \ || raise IndexError.new\n    add(start, count, val_a, val_b)\n  end\n\n  def\
    \ build : Array(T)\n    raise \"self had been called `#build`\" if @builded\n\
    \    @builded = true\n    (0...size).map do |i|\n      @a[i + 1] += @a[i]\n  \
    \    @b[i + 1] += @b[i]\n      @a[i] + @b[i] * i\n    end\n  end\nend\n"
  code: "class ImosLinear(T)\n  getter size : Int32\n  @builded = false\n\n  def initialize(@size\
    \ : Int32)\n    @a = Array(T).new(@size + 1, T.zero)\n    @b = Array(T).new(@size\
    \ + 1, T.zero)\n  end\n\n  # add `a + (i - l) * b` to [l, r)\n  def add(start\
    \ : Int, count : Int, val_a : T, val_b : T) : Nil\n    raise \"self had been called\
    \ `#build`\" if @builded\n    raise ArgumentError.new \"Negative count: #{count}\"\
    \ if count < 0\n    @a[start] += val_a - val_b * start\n    @b[start] += val_b\n\
    \    @a[start + count] -= val_a - val_b * start\n    @b[start + count] -= val_b\n\
    \  end\n\n  def add(range : Range, val_a : T, val_b : T)\n    start, count = Indexable.range_to_index_and_count(range,\
    \ size) || raise IndexError.new\n    add(start, count, val_a, val_b)\n  end\n\n\
    \  def build : Array(T)\n    raise \"self had been called `#build`\" if @builded\n\
    \    @builded = true\n    (0...size).map do |i|\n      @a[i + 1] += @a[i]\n  \
    \    @b[i + 1] += @b[i]\n      @a[i] + @b[i] * i\n    end\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: datastructure/ImosLinear.cr
  requiredBy: []
  timestamp: '2021-06-28 21:15:31+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/ImosLinear.test.cr
documentation_of: datastructure/ImosLinear.cr
layout: document
redirect_from:
- /library/datastructure/ImosLinear.cr
- /library/datastructure/ImosLinear.cr.html
title: datastructure/ImosLinear.cr
---
