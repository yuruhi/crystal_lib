---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/datastructure/imos_test.cr
    title: test/datastructure/imos_test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "class Imos(T)\n  getter size : Int32\n  @builded = false\n\n  def\
    \ initialize(@size : Int32)\n    @a = Array(T).new(@size + 1, T.zero)\n  end\n\
    \n  def add(start : Int, count : Int, val : T) : Nil\n    raise \"self had been\
    \ called `#build`\" if @builded\n    raise ArgumentError.new \"Negative count:\
    \ #{count}\" if count < 0\n    start += size if start < 0\n    if 0 <= start <=\
    \ size\n      count = Math.min(count, size - start)\n      @a[start] += val\n\
    \      @a[start + count] -= val\n    end\n  end\n\n  def add(range : Range, val\
    \ : T) : Nil\n    start, count = Indexable.range_to_index_and_count(range, size)\
    \ || raise IndexError.new\n    add(start, count, val)\n  end\n\n  def build :\
    \ Array(T)\n    raise \"self had been called `#build`\" if @builded\n    @builded\
    \ = true\n    (0...size).map do |i|\n      @a[i].tap { |x| @a[i + 1] += x }\n\
    \    end\n  end\nend\n"
  code: "class Imos(T)\n  getter size : Int32\n  @builded = false\n\n  def initialize(@size\
    \ : Int32)\n    @a = Array(T).new(@size + 1, T.zero)\n  end\n\n  def add(start\
    \ : Int, count : Int, val : T) : Nil\n    raise \"self had been called `#build`\"\
    \ if @builded\n    raise ArgumentError.new \"Negative count: #{count}\" if count\
    \ < 0\n    start += size if start < 0\n    if 0 <= start <= size\n      count\
    \ = Math.min(count, size - start)\n      @a[start] += val\n      @a[start + count]\
    \ -= val\n    end\n  end\n\n  def add(range : Range, val : T) : Nil\n    start,\
    \ count = Indexable.range_to_index_and_count(range, size) || raise IndexError.new\n\
    \    add(start, count, val)\n  end\n\n  def build : Array(T)\n    raise \"self\
    \ had been called `#build`\" if @builded\n    @builded = true\n    (0...size).map\
    \ do |i|\n      @a[i].tap { |x| @a[i + 1] += x }\n    end\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/datastructure/imos.cr
  requiredBy: []
  timestamp: '2021-09-11 20:32:40+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/datastructure/imos_test.cr
documentation_of: src/datastructure/imos.cr
layout: document
redirect_from:
- /library/src/datastructure/imos.cr
- /library/src/datastructure/imos.cr.html
title: src/datastructure/imos.cr
---
