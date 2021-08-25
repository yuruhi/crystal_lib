---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/datastructure/imos_linear_test.cr
    title: test/datastructure/imos_linear_test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "class ImosLinear(T)\n  getter size : Int32\n  @builded = false\n\n\
    \  def initialize(@size : Int32)\n    @a = Array(T).new(@size + 1, T.zero)\n \
    \   @b = Array(T).new(@size + 1, T.zero)\n  end\n\n  # Add `a + (i - l) * b` to\
    \ `[l, r)`.\n  def add(start : Int, count : Int, val_a : T, val_b : T) : Nil\n\
    \    raise \"self had been called `#build`\" if @builded\n    raise ArgumentError.new\
    \ \"Negative count: #{count}\" if count < 0\n    @a[start] += val_a - val_b *\
    \ start\n    @b[start] += val_b\n    @a[start + count] -= val_a - val_b * start\n\
    \    @b[start + count] -= val_b\n  end\n\n  def add(range : Range, val_a : T,\
    \ val_b : T) : Nil\n    start, count = Indexable.range_to_index_and_count(range,\
    \ size) || raise IndexError.new\n    add(start, count, val_a, val_b)\n  end\n\n\
    \  def build : Array(T)\n    raise \"self had been called `#build`\" if @builded\n\
    \    @builded = true\n    (0...size).map do |i|\n      @a[i + 1] += @a[i]\n  \
    \    @b[i + 1] += @b[i]\n      @a[i] + @b[i] * i\n    end\n  end\nend\n"
  code: "class ImosLinear(T)\n  getter size : Int32\n  @builded = false\n\n  def initialize(@size\
    \ : Int32)\n    @a = Array(T).new(@size + 1, T.zero)\n    @b = Array(T).new(@size\
    \ + 1, T.zero)\n  end\n\n  # Add `a + (i - l) * b` to `[l, r)`.\n  def add(start\
    \ : Int, count : Int, val_a : T, val_b : T) : Nil\n    raise \"self had been called\
    \ `#build`\" if @builded\n    raise ArgumentError.new \"Negative count: #{count}\"\
    \ if count < 0\n    @a[start] += val_a - val_b * start\n    @b[start] += val_b\n\
    \    @a[start + count] -= val_a - val_b * start\n    @b[start + count] -= val_b\n\
    \  end\n\n  def add(range : Range, val_a : T, val_b : T) : Nil\n    start, count\
    \ = Indexable.range_to_index_and_count(range, size) || raise IndexError.new\n\
    \    add(start, count, val_a, val_b)\n  end\n\n  def build : Array(T)\n    raise\
    \ \"self had been called `#build`\" if @builded\n    @builded = true\n    (0...size).map\
    \ do |i|\n      @a[i + 1] += @a[i]\n      @b[i + 1] += @b[i]\n      @a[i] + @b[i]\
    \ * i\n    end\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/datastructure/imos_linear.cr
  requiredBy: []
  timestamp: '2021-08-25 10:11:40+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/datastructure/imos_linear_test.cr
documentation_of: src/datastructure/imos_linear.cr
layout: document
redirect_from:
- /library/src/datastructure/imos_linear.cr
- /library/src/datastructure/imos_linear.cr.html
title: src/datastructure/imos_linear.cr
---
