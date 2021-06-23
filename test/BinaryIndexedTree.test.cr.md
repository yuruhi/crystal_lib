---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: datastructure/BinaryIndexedTree.cr
    title: datastructure/BinaryIndexedTree.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/point_add_range_sum
  bundledCode: "# verification-helper: PROBLEM https://judge.yosupo.jp/problem/point_add_range_sum\n\
    # require \"../datastructure/BinaryIndexedTree\"\nclass BinaryIndexedTree(T)\n\
    \  getter size : Int32\n\n  def initialize(@size)\n    @a = Array(T).new(@size\
    \ + 1, T.zero)\n  end\n\n  def initialize(a : Array(T))\n    @a = [T.zero]\n \
    \   @a.concat a\n    @size = a.size\n    (1...size).each do |i|\n      j = i +\
    \ (i & -i)\n      next if j > size\n      @a[j] += @a[i]\n    end\n  end\n\n \
    \ def add(i : Int32, x)\n    raise IndexError.new unless 0 <= i < size\n    i\
    \ += 1\n    while i <= size\n      @a[i] += x\n      i += i & -i\n    end\n  end\n\
    \n  # sum of a[0...i]\n  def left_sum(i : Int32)\n    raise IndexError.new unless\
    \ 0 <= i <= size\n    sum = T.zero\n    while i > 0\n      sum += @a[i]\n    \
    \  i -= i & -i\n    end\n    sum\n  end\n\n  def [](start : Int32, count : Int32)\n\
    \    left_sum(start + count) - left_sum(start)\n  end\n\n  def [](range : Range)\n\
    \    self[*Indexable.range_to_index_and_count(range, size) || raise IndexError.new]\n\
    \  end\n\n  def to_a\n    (0...size).map { |i| self[i..i] }\n  end\nend\n\nn,\
    \ q = read_line.split.map(&.to_i)\na = read_line.split.map(&.to_i64)\nseg = BinaryIndexedTree.new(a)\n\
    q.times do\n  t, x, y = read_line.split.map(&.to_i)\n  if t == 0\n    seg.add(x,\
    \ y)\n  else\n    puts seg[x...y]\n  end\nend\n"
  code: "# verification-helper: PROBLEM https://judge.yosupo.jp/problem/point_add_range_sum\n\
    require \"../datastructure/BinaryIndexedTree\"\nn, q = read_line.split.map(&.to_i)\n\
    a = read_line.split.map(&.to_i64)\nseg = BinaryIndexedTree.new(a)\nq.times do\n\
    \  t, x, y = read_line.split.map(&.to_i)\n  if t == 0\n    seg.add(x, y)\n  else\n\
    \    puts seg[x...y]\n  end\nend\n"
  dependsOn:
  - datastructure/BinaryIndexedTree.cr
  isVerificationFile: true
  path: test/BinaryIndexedTree.test.cr
  requiredBy: []
  timestamp: '2021-06-01 18:35:28+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/BinaryIndexedTree.test.cr
layout: document
redirect_from:
- /verify/test/BinaryIndexedTree.test.cr
- /verify/test/BinaryIndexedTree.test.cr.html
title: test/BinaryIndexedTree.test.cr
---
