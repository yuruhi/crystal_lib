---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/datastructure/union_find.cr
    title: src/datastructure/union_find.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/unionfind
  bundledCode: "# verification-helper: PROBLEM https://judge.yosupo.jp/problem/unionfind\n\
    # require \"../../src/datastructure/union_find\"\nclass UnionFind\n  @d : Array(Int32)\n\
    \  getter count_components : Int32\n\n  def initialize(n : Int)\n    @d = Array.new(n,\
    \ -1)\n    @count_components = n\n  end\n\n  def initialize(n : Int, edges : Enumerable({Int32,\
    \ Int32}))\n    initialize(n)\n    edges.each { |u, v| unite(u, v) }\n  end\n\n\
    \  def root(x : Int)\n    @d[x] < 0 ? x : (@d[x] = root(@d[x]))\n  end\n\n  def\
    \ unite(x : Int, y : Int)\n    x = root(x)\n    y = root(y)\n    return false\
    \ if x == y\n    x, y = y, x if @d[x] > @d[y]\n    @d[x] += @d[y]\n    @d[y] =\
    \ x\n    @count_components -= 1\n    true\n  end\n\n  def same?(x : Int, y : Int)\n\
    \    root(x) == root(y)\n  end\n\n  def size(x : Int)\n    -@d[root(x)]\n  end\n\
    \n  def groups\n    groups = Hash(Int32, Set(Int32)).new { |h, k| h[k] = Set(Int32).new\
    \ }\n    @d.size.times do |i|\n      groups[root(i)] << i\n    end\n    groups.values.to_set\n\
    \  end\nend\n\nn, q = read_line.split.map(&.to_i)\nuf = UnionFind.new(n)\nq.times\
    \ do\n  t, u, v = read_line.split.map(&.to_i)\n  if t == 0\n    uf.unite(u, v)\n\
    \  else\n    puts uf.same?(u, v) ? 1 : 0\n  end\nend\n"
  code: "# verification-helper: PROBLEM https://judge.yosupo.jp/problem/unionfind\n\
    require \"../../src/datastructure/union_find\"\nn, q = read_line.split.map(&.to_i)\n\
    uf = UnionFind.new(n)\nq.times do\n  t, u, v = read_line.split.map(&.to_i)\n \
    \ if t == 0\n    uf.unite(u, v)\n  else\n    puts uf.same?(u, v) ? 1 : 0\n  end\n\
    end\n"
  dependsOn:
  - src/datastructure/union_find.cr
  isVerificationFile: true
  path: test/datastructure/union_find_test.cr
  requiredBy: []
  timestamp: '2022-01-23 09:37:07+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/datastructure/union_find_test.cr
layout: document
redirect_from:
- /verify/test/datastructure/union_find_test.cr
- /verify/test/datastructure/union_find_test.cr.html
title: test/datastructure/union_find_test.cr
---
