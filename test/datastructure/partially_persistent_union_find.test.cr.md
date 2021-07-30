---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/datastructure/partially_persistent_union_find.cr
    title: src/datastructure/partially_persistent_union_find.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://yukicoder.me/problems/no/416
  bundledCode: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/416\n\
    # require \"../../src/datastructure/partially_persistent_union_find\"\nclass PartiallyPersistentUnionFind\n\
    \  getter size : Int32, now : Int32\n\n  def initialize(size : Int)\n    @size\
    \ = size.to_i\n    @now = 0\n    @parent = Array(Int32).new(size, &.itself)\n\
    \    @rank = Array(Int32).new(size, 0)\n    @time = Array(Int32).new(size, Int32::MAX)\n\
    \    @num = Array(Array({Int32, Int32})).new(size) { [{0, 1}] }\n  end\n\n  def\
    \ root(x : Int, time : Int) : Int32\n    time < @time[x] ? x : root(@parent[x],\
    \ time)\n  end\n\n  def same?(x : Int, y : Int, time : Int) : Bool\n    root(x,\
    \ time) == root(y, time)\n  end\n\n  def unite(x : Int, y : Int) : Bool\n    @now\
    \ += 1\n    x, y = root(x, now), root(y, now)\n    return false if x == y\n  \
    \  x, y = y, x if @rank[x] < @rank[y]\n    @num[x] << {now, size(x, now) + size(y,\
    \ now)}\n    @parent[y] = x\n    @time[y] = now\n    @rank[x] += 1 if @rank[x]\
    \ == @rank[y]\n    true\n  end\n\n  def size(x : Int, time : Int) : Int\n    x\
    \ = root(x, time)\n    pos = @num[x].bsearch_index { |(t, s), _| t > time } ||\
    \ @num[x].size\n    @num[x][pos - 1][1]\n  end\nend\n\nn, m, q = read_line.split.map(&.to_i)\n\
    ab = Array.new(m) {\n  {Int32, Int32}.from read_line.split.map(&.to_i.pred)\n\
    }\ncd = Array.new(q) {\n  {Int32, Int32}.from read_line.split.map(&.to_i.pred)\n\
    }\nab -= cd\n\nuf = PartiallyPersistentUnionFind.new(n)\n(ab - cd).each do |a,\
    \ b|\n  uf.unite(a, b)\nend\nbegin_time = uf.now\ncd.reverse_each do |c, d|\n\
    \  uf.unite(c, d)\nend\nend_time = uf.now\n\n(1...n).each do |i|\n  t = (begin_time..end_time).bsearch\
    \ { |t| uf.same?(0, i, t) }\n  if t.nil?\n    puts 0\n  elsif t == begin_time\n\
    \    puts -1\n  else\n    puts end_time - t + 1\n  end\nend\n"
  code: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/416\nrequire\
    \ \"../../src/datastructure/partially_persistent_union_find\"\nn, m, q = read_line.split.map(&.to_i)\n\
    ab = Array.new(m) {\n  {Int32, Int32}.from read_line.split.map(&.to_i.pred)\n\
    }\ncd = Array.new(q) {\n  {Int32, Int32}.from read_line.split.map(&.to_i.pred)\n\
    }\nab -= cd\n\nuf = PartiallyPersistentUnionFind.new(n)\n(ab - cd).each do |a,\
    \ b|\n  uf.unite(a, b)\nend\nbegin_time = uf.now\ncd.reverse_each do |c, d|\n\
    \  uf.unite(c, d)\nend\nend_time = uf.now\n\n(1...n).each do |i|\n  t = (begin_time..end_time).bsearch\
    \ { |t| uf.same?(0, i, t) }\n  if t.nil?\n    puts 0\n  elsif t == begin_time\n\
    \    puts -1\n  else\n    puts end_time - t + 1\n  end\nend\n"
  dependsOn:
  - src/datastructure/partially_persistent_union_find.cr
  isVerificationFile: true
  path: test/datastructure/partially_persistent_union_find.test.cr
  requiredBy: []
  timestamp: '2021-07-18 13:52:56+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/datastructure/partially_persistent_union_find.test.cr
layout: document
redirect_from:
- /verify/test/datastructure/partially_persistent_union_find.test.cr
- /verify/test/datastructure/partially_persistent_union_find.test.cr.html
title: test/datastructure/partially_persistent_union_find.test.cr
---
