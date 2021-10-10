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
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/point_add_range_sum
  bundledCode: "# verification-helper: PROBLEM https://judge.yosupo.jp/problem/point_add_range_sum\n\
    # require \"../../src/datastructure/fenwick_tree\"\nclass FenwickTree(T)\n  getter\
    \ size : Int32\n\n  def initialize(@size)\n    @a = Array(T).new(@size + 1, T.zero)\n\
    \  end\n\n  def initialize(a : Array(T))\n    @a = [T.zero]\n    @a.concat a\n\
    \    @size = a.size\n    (1...size).each do |i|\n      j = i + (i & -i)\n    \
    \  next if j > size\n      @a[j] += @a[i]\n    end\n  end\n\n  # Add *x* to `a[i]`.\n\
    \  def add(i : Int, x) : Nil\n    raise IndexError.new unless 0 <= i < size\n\
    \    i += 1\n    while i <= size\n      @a[i] += x\n      i += i & -i\n    end\n\
    \  end\n\n  # Set *x* to `a[i]`.\n  def set(i : Int, x) : Nil\n    add(i, x -\
    \ self[i, 1])\n  end\n\n  # Alias for `set`\n  def []=(i : Int, x) : Nil\n   \
    \ set(i, x)\n  end\n\n  # Culculates sum of `a[0...i]`.\n  def left_sum(i : Int)\
    \ : T\n    raise IndexError.new unless 0 <= i <= size\n    sum = T.zero\n    while\
    \ i > 0\n      sum += @a[i]\n      i -= i & -i\n    end\n    sum\n  end\n\n  def\
    \ [](i : Int)\n    left_sum(i + 1) - left_sum(i)\n  end\n\n  def [](start : Int,\
    \ count : Int) : T\n    left_sum(start + count) - left_sum(start)\n  end\n\n \
    \ def [](range : Range) : T\n    self[*Indexable.range_to_index_and_count(range,\
    \ size) || raise IndexError.new]\n  end\n\n  def to_a : Array(T)\n    (0...size).map\
    \ { |i| self[i..i] }\n  end\nend\n\n_, q = read_line.split.map(&.to_i)\na = read_line.split.map(&.to_i64)\n\
    seg = FenwickTree.new(a)\nq.times do\n  t, x, y = read_line.split.map(&.to_i)\n\
    \  if t == 0\n    seg.add(x, y)\n  else\n    puts seg[x...y]\n  end\nend\n"
  code: "# verification-helper: PROBLEM https://judge.yosupo.jp/problem/point_add_range_sum\n\
    require \"../../src/datastructure/fenwick_tree\"\n_, q = read_line.split.map(&.to_i)\n\
    a = read_line.split.map(&.to_i64)\nseg = FenwickTree.new(a)\nq.times do\n  t,\
    \ x, y = read_line.split.map(&.to_i)\n  if t == 0\n    seg.add(x, y)\n  else\n\
    \    puts seg[x...y]\n  end\nend\n"
  dependsOn:
  - src/datastructure/fenwick_tree.cr
  isVerificationFile: true
  path: test/datastructure/fewnick_tree_test.cr
  requiredBy: []
  timestamp: '2021-08-04 13:11:57+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/datastructure/fewnick_tree_test.cr
layout: document
redirect_from:
- /verify/test/datastructure/fewnick_tree_test.cr
- /verify/test/datastructure/fewnick_tree_test.cr.html
title: test/datastructure/fewnick_tree_test.cr
---
