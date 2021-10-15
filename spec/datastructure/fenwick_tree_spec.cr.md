---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/datastructure/fenwick_tree.cr
    title: src/datastructure/fenwick_tree.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../src/datastructure/fenwick_tree\"\
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
    \  def to_a : Array(T)\n    Array.new(size) { |i| self[i] }\n  end\nend\n\ndescribe\
    \ FenwickTree do\n  it \".new(size)\" do\n    a = FenwickTree(Int32).new(3)\n\
    \    a.to_a.should eq [0, 0, 0]\n  end\n\n  it \".new(array)\" do\n    a = FenwickTree.new\
    \ [1, 2, 3]\n    a.to_a.should eq [1, 2, 3]\n  end\n\n  it \"#add\" do\n    a\
    \ = FenwickTree(Int32).new(3)\n    a.add(0, 3)\n    a.to_a.should eq [3, 0, 0]\n\
    \    a.add(1, 4)\n    a.to_a.should eq [3, 4, 0]\n    a.add(2, 5)\n    a.to_a.should\
    \ eq [3, 4, 5]\n    a.add(1, 2i64)\n    a.to_a.should eq [3, 6, 5]\n    expect_raises(IndexError)\
    \ { a.add(-1, 0) }\n    expect_raises(IndexError) { a.add(3, 0) }\n  end\n\n \
    \ it \"#set, #[]=\" do\n    a = FenwickTree(Int32).new(3)\n    a.set(0, 3)\n \
    \   a.to_a.should eq [3, 0, 0]\n    a[1] = 4\n    a.to_a.should eq [3, 4, 0]\n\
    \    a.set(2, 5)\n    a.to_a.should eq [3, 4, 5]\n    a[1] = 2i64\n    a.to_a.should\
    \ eq [3, 2, 5]\n    expect_raises(IndexError) { a.set(-1, 0) }\n    expect_raises(IndexError)\
    \ { a.set(3, 0) }\n    expect_raises(IndexError) { a[-1] = 0 }\n    expect_raises(IndexError)\
    \ { a[3] = 0 }\n  end\n\n  it \"#left_sum\" do\n    a = FenwickTree.new [1, 2,\
    \ 3]\n    a.left_sum(0).should eq 0\n    a.left_sum(1).should eq 1\n    a.left_sum(2).should\
    \ eq 3\n    a.left_sum(3).should eq 6\n    expect_raises(IndexError) { a.left_sum(-1)\
    \ }\n    expect_raises(IndexError) { a.left_sum(4) }\n  end\n\n  it \"#[](index)\"\
    \ do\n    a = FenwickTree.new [1, 2, 3]\n    a[0].should eq 1\n    a[1].should\
    \ eq 2\n    a[2].should eq 3\n    expect_raises(IndexError) { a[-1] }\n    expect_raises(IndexError)\
    \ { a[4] }\n  end\n\n  it \"#[](start, count)\" do\n    a = FenwickTree.new [1,\
    \ 2, 3]\n    [\n      [0, 1, 3, 6],\n      [0, 2, 5],\n      [0, 3],\n      [0],\n\
    \    ].each_with_index do |sums, start|\n      sums.each_with_index do |sum, count|\n\
    \        a[start, count].should eq sum\n      end\n    end\n  end\n\n  it \"#[](range)\"\
    \ do\n    a = FenwickTree.new [1, 2, 3]\n    [\n      {0..0, 1}, {0..1, 3}, {0..2,\
    \ 6},\n      {1..1, 2}, {1..2, 5},\n      {2..2, 3},\n    ].each do |range, sum|\n\
    \      a[range].should eq sum\n    end\n  end\n\n  it \"#to_a\" do\n    a = FenwickTree.new\
    \ [1, 2, 3]\n    a.to_a.should eq [1, 2, 3]\n  end\nend\n"
  code: "require \"spec\"\nrequire \"../../src/datastructure/fenwick_tree\"\n\ndescribe\
    \ FenwickTree do\n  it \".new(size)\" do\n    a = FenwickTree(Int32).new(3)\n\
    \    a.to_a.should eq [0, 0, 0]\n  end\n\n  it \".new(array)\" do\n    a = FenwickTree.new\
    \ [1, 2, 3]\n    a.to_a.should eq [1, 2, 3]\n  end\n\n  it \"#add\" do\n    a\
    \ = FenwickTree(Int32).new(3)\n    a.add(0, 3)\n    a.to_a.should eq [3, 0, 0]\n\
    \    a.add(1, 4)\n    a.to_a.should eq [3, 4, 0]\n    a.add(2, 5)\n    a.to_a.should\
    \ eq [3, 4, 5]\n    a.add(1, 2i64)\n    a.to_a.should eq [3, 6, 5]\n    expect_raises(IndexError)\
    \ { a.add(-1, 0) }\n    expect_raises(IndexError) { a.add(3, 0) }\n  end\n\n \
    \ it \"#set, #[]=\" do\n    a = FenwickTree(Int32).new(3)\n    a.set(0, 3)\n \
    \   a.to_a.should eq [3, 0, 0]\n    a[1] = 4\n    a.to_a.should eq [3, 4, 0]\n\
    \    a.set(2, 5)\n    a.to_a.should eq [3, 4, 5]\n    a[1] = 2i64\n    a.to_a.should\
    \ eq [3, 2, 5]\n    expect_raises(IndexError) { a.set(-1, 0) }\n    expect_raises(IndexError)\
    \ { a.set(3, 0) }\n    expect_raises(IndexError) { a[-1] = 0 }\n    expect_raises(IndexError)\
    \ { a[3] = 0 }\n  end\n\n  it \"#left_sum\" do\n    a = FenwickTree.new [1, 2,\
    \ 3]\n    a.left_sum(0).should eq 0\n    a.left_sum(1).should eq 1\n    a.left_sum(2).should\
    \ eq 3\n    a.left_sum(3).should eq 6\n    expect_raises(IndexError) { a.left_sum(-1)\
    \ }\n    expect_raises(IndexError) { a.left_sum(4) }\n  end\n\n  it \"#[](index)\"\
    \ do\n    a = FenwickTree.new [1, 2, 3]\n    a[0].should eq 1\n    a[1].should\
    \ eq 2\n    a[2].should eq 3\n    expect_raises(IndexError) { a[-1] }\n    expect_raises(IndexError)\
    \ { a[4] }\n  end\n\n  it \"#[](start, count)\" do\n    a = FenwickTree.new [1,\
    \ 2, 3]\n    [\n      [0, 1, 3, 6],\n      [0, 2, 5],\n      [0, 3],\n      [0],\n\
    \    ].each_with_index do |sums, start|\n      sums.each_with_index do |sum, count|\n\
    \        a[start, count].should eq sum\n      end\n    end\n  end\n\n  it \"#[](range)\"\
    \ do\n    a = FenwickTree.new [1, 2, 3]\n    [\n      {0..0, 1}, {0..1, 3}, {0..2,\
    \ 6},\n      {1..1, 2}, {1..2, 5},\n      {2..2, 3},\n    ].each do |range, sum|\n\
    \      a[range].should eq sum\n    end\n  end\n\n  it \"#to_a\" do\n    a = FenwickTree.new\
    \ [1, 2, 3]\n    a.to_a.should eq [1, 2, 3]\n  end\nend\n"
  dependsOn:
  - src/datastructure/fenwick_tree.cr
  isVerificationFile: false
  path: spec/datastructure/fenwick_tree_spec.cr
  requiredBy: []
  timestamp: '2021-10-15 17:24:58+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/datastructure/fenwick_tree_spec.cr
layout: document
redirect_from:
- /library/spec/datastructure/fenwick_tree_spec.cr
- /library/spec/datastructure/fenwick_tree_spec.cr.html
title: spec/datastructure/fenwick_tree_spec.cr
---
