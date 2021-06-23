---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: datastructure/UnionFind.cr
    title: datastructure/UnionFind.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/unionfind
  bundledCode: "# verification-helper: PROBLEM https://judge.yosupo.jp/problem/unionfind\n\
    # require \"../datastructure/UnionFind\"\nclass UnionFind\n  @d : Array(Int32)\n\
    \n  def initialize(n : Int32)\n    @d = Array.new(n, -1)\n  end\n\n  def root(x\
    \ : Int32)\n    @d[x] < 0 ? x : (@d[x] = root(@d[x]))\n  end\n\n  def unite(x\
    \ : Int32, y : Int32)\n    x = root(x)\n    y = root(y)\n    return false if x\
    \ == y\n    x, y = y, x if @d[x] > @d[y]\n    @d[x] += @d[y]\n    @d[y] = x\n\
    \    true\n  end\n\n  def same?(x : Int32, y : Int32)\n    root(x) == root(y)\n\
    \  end\n\n  def size(x : Int32)\n    -@d[root(x)]\n  end\n\n  def groups\n   \
    \ groups = Hash(Int32, Set(Int32)).new { |h, k| h[k] = Set(Int32).new }\n    @d.size.times\
    \ do |i|\n      groups[root(i)] << i\n    end\n    groups.values.to_set\n  end\n\
    end\n\nn, q = read_line.split.map(&.to_i)\nuf = UnionFind.new(n)\nq.times do\n\
    \  t, u, v = read_line.split.map(&.to_i)\n  if t == 0\n    uf.unite(u, v)\n  else\n\
    \    puts uf.same?(u, v) ? 1 : 0\n  end\nend\n"
  code: "# verification-helper: PROBLEM https://judge.yosupo.jp/problem/unionfind\n\
    require \"../datastructure/UnionFind\"\nn, q = read_line.split.map(&.to_i)\nuf\
    \ = UnionFind.new(n)\nq.times do\n  t, u, v = read_line.split.map(&.to_i)\n  if\
    \ t == 0\n    uf.unite(u, v)\n  else\n    puts uf.same?(u, v) ? 1 : 0\n  end\n\
    end\n"
  dependsOn:
  - datastructure/UnionFind.cr
  isVerificationFile: true
  path: test/UnionFind.test.cr
  requiredBy: []
  timestamp: '2021-06-20 21:15:01+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/UnionFind.test.cr
layout: document
redirect_from:
- /verify/test/UnionFind.test.cr
- /verify/test/UnionFind.test.cr.html
title: test/UnionFind.test.cr
---
