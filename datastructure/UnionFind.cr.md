---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':heavy_check_mark:'
    path: graph/kruskal.cr
    title: graph/kruskal.cr
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/UnionFind.test.cr
    title: test/UnionFind.test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "class UnionFind\n  @d : Array(Int32)\n\n  def initialize(n : Int32)\n\
    \    @d = Array.new(n, -1)\n  end\n\n  def root(x : Int32)\n    @d[x] < 0 ? x\
    \ : (@d[x] = root(@d[x]))\n  end\n\n  def unite(x : Int32, y : Int32)\n    x =\
    \ root(x)\n    y = root(y)\n    return false if x == y\n    x, y = y, x if @d[x]\
    \ > @d[y]\n    @d[x] += @d[y]\n    @d[y] = x\n    true\n  end\n\n  def same?(x\
    \ : Int32, y : Int32)\n    root(x) == root(y)\n  end\n\n  def size(x : Int32)\n\
    \    -@d[root(x)]\n  end\n\n  def groups\n    groups = Hash(Int32, Set(Int32)).new\
    \ { |h, k| h[k] = Set(Int32).new }\n    @d.size.times do |i|\n      groups[root(i)]\
    \ << i\n    end\n    groups.values.to_set\n  end\nend\n"
  code: "class UnionFind\n  @d : Array(Int32)\n\n  def initialize(n : Int32)\n   \
    \ @d = Array.new(n, -1)\n  end\n\n  def root(x : Int32)\n    @d[x] < 0 ? x : (@d[x]\
    \ = root(@d[x]))\n  end\n\n  def unite(x : Int32, y : Int32)\n    x = root(x)\n\
    \    y = root(y)\n    return false if x == y\n    x, y = y, x if @d[x] > @d[y]\n\
    \    @d[x] += @d[y]\n    @d[y] = x\n    true\n  end\n\n  def same?(x : Int32,\
    \ y : Int32)\n    root(x) == root(y)\n  end\n\n  def size(x : Int32)\n    -@d[root(x)]\n\
    \  end\n\n  def groups\n    groups = Hash(Int32, Set(Int32)).new { |h, k| h[k]\
    \ = Set(Int32).new }\n    @d.size.times do |i|\n      groups[root(i)] << i\n \
    \   end\n    groups.values.to_set\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: datastructure/UnionFind.cr
  requiredBy:
  - graph/kruskal.cr
  timestamp: '2021-06-23 21:16:54+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/UnionFind.test.cr
documentation_of: datastructure/UnionFind.cr
layout: document
redirect_from:
- /library/datastructure/UnionFind.cr
- /library/datastructure/UnionFind.cr.html
title: datastructure/UnionFind.cr
---
