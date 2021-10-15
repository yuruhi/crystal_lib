---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/array/compress.cr
    title: src/array/compress.cr
  - icon: ':heavy_check_mark:'
    path: src/dp/inversion.cr
    title: src/dp/inversion.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://onlinejudge.u-aizu.ac.jp/courses/lesson/1/ALDS1/all/ALDS1_5_D
  bundledCode: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/lesson/1/ALDS1/all/ALDS1_5_D\n\
    # require \"../../src/dp/inversion\"\n# require \"../datastructure/fenwick_tree\"\
    \nclass FenwickTree(T)\n  getter size : Int32\n\n  def initialize(size : Int)\n\
    \    @size = size.to_i\n    @data = Array(T).new(@size + 1, T.zero)\n  end\n\n\
    \  def initialize(array : Array(T))\n    @data = [T.zero] + array\n    @size =\
    \ array.size\n    (1...size).each do |i|\n      j = i + (i & -i)\n      next if\
    \ j > size\n      @data[j] += @data[i]\n    end\n  end\n\n  # Adds *x* to *index*\
    \ th element.\n  def add(index : Int, x) : Nil\n    raise IndexError.new unless\
    \ 0 <= index < size\n    index += 1\n    while index <= size\n      @data[index]\
    \ += x\n      index += index & -index\n    end\n  end\n\n  # Set *x* to *index*\
    \ th element.\n  def set(index : Int, x) : Nil\n    add(index, x - self[index])\n\
    \  end\n\n  # :ditto:\n  def []=(i : Int, x) : Nil\n    set(i, x)\n  end\n\n \
    \ # Culculates sum of `a[0...i]`.\n  def left_sum(i : Int) : T\n    raise IndexError.new\
    \ unless 0 <= i <= size\n    sum = T.zero\n    while i > 0\n      sum += @data[i]\n\
    \      i -= i & -i\n    end\n    sum\n  end\n\n  # Returns *index* th element.\n\
    \  def [](index : Int)\n    left_sum(index + 1) - left_sum(index)\n  end\n\n \
    \ # Returns sum of `a[start, count]`\n  def [](start : Int, count : Int) : T\n\
    \    left_sum(start + count) - left_sum(start)\n  end\n\n  # Returns sum of `a[range]`\n\
    \  def [](range : Range) : T\n    self[*Indexable.range_to_index_and_count(range,\
    \ size) || raise IndexError.new]\n  end\n\n  # Returns the elements as an Array.\n\
    \  def to_a : Array(T)\n    Array.new(size) { |i| self[i] }\n  end\nend\n\nmodule\
    \ DP\n  extend self\n\n  def inversion(a : Array(T)) : Int64 forall T\n    bit\
    \ = FenwickTree(Int32).new(a.max + 1)\n    a.sum(0i64) do |x|\n      bit[x + 1..].tap\
    \ { bit.add(x, 1) }\n    end\n  end\nend\n\n# require \"../../src/array/compress\"\
    \nclass Array(T)\n  def compress(values : Array(T), *, index : Int = 0)\n    map\
    \ do |x|\n      index + values.bsearch_index { |y| y >= x }.not_nil!\n    end\n\
    \  end\n\n  def compress(*, index : Int = 0) : Array(Int32)\n    compress(uniq.sort!,\
    \ index: index)\n  end\nend\n\nread_line\na = read_line.split.map(&.to_i)\nputs\
    \ DP.inversion(a.compress)\n"
  code: '# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/lesson/1/ALDS1/all/ALDS1_5_D

    require "../../src/dp/inversion"

    require "../../src/array/compress"

    read_line

    a = read_line.split.map(&.to_i)

    puts DP.inversion(a.compress)

    '
  dependsOn:
  - src/dp/inversion.cr
  - src/array/compress.cr
  isVerificationFile: true
  path: test/dp/inversion_test.cr
  requiredBy: []
  timestamp: '2021-08-04 13:11:57+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/dp/inversion_test.cr
layout: document
redirect_from:
- /verify/test/dp/inversion_test.cr
- /verify/test/dp/inversion_test.cr.html
title: test/dp/inversion_test.cr
---
