---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':heavy_check_mark:'
    path: src/graph/components.cr
    title: src/graph/components.cr
  - icon: ':question:'
    path: src/graph/decompose.cr
    title: src/graph/decompose.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/kruskal.cr
    title: src/graph/kruskal.cr
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/datastructure/union_find_test.cr
    title: test/datastructure/union_find_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/compress_degree_test.cr
    title: test/graph/compress_degree_test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "class UnionFind\n  @d : Array(Int32)\n\n  def initialize(n : Int)\n\
    \    @d = Array.new(n, -1)\n  end\n\n  def initialize(n : Int, edges : Enumerable({Int32,\
    \ Int32}))\n    initialize(n)\n    edges.each { |u, v| unite(u, v) }\n  end\n\n\
    \  def root(x : Int)\n    @d[x] < 0 ? x : (@d[x] = root(@d[x]))\n  end\n\n  def\
    \ unite(x : Int, y : Int)\n    x = root(x)\n    y = root(y)\n    return false\
    \ if x == y\n    x, y = y, x if @d[x] > @d[y]\n    @d[x] += @d[y]\n    @d[y] =\
    \ x\n    true\n  end\n\n  def same?(x : Int, y : Int)\n    root(x) == root(y)\n\
    \  end\n\n  def size(x : Int)\n    -@d[root(x)]\n  end\n\n  def groups\n    groups\
    \ = Hash(Int32, Set(Int32)).new { |h, k| h[k] = Set(Int32).new }\n    @d.size.times\
    \ do |i|\n      groups[root(i)] << i\n    end\n    groups.values.to_set\n  end\n\
    end\n"
  code: "class UnionFind\n  @d : Array(Int32)\n\n  def initialize(n : Int)\n    @d\
    \ = Array.new(n, -1)\n  end\n\n  def initialize(n : Int, edges : Enumerable({Int32,\
    \ Int32}))\n    initialize(n)\n    edges.each { |u, v| unite(u, v) }\n  end\n\n\
    \  def root(x : Int)\n    @d[x] < 0 ? x : (@d[x] = root(@d[x]))\n  end\n\n  def\
    \ unite(x : Int, y : Int)\n    x = root(x)\n    y = root(y)\n    return false\
    \ if x == y\n    x, y = y, x if @d[x] > @d[y]\n    @d[x] += @d[y]\n    @d[y] =\
    \ x\n    true\n  end\n\n  def same?(x : Int, y : Int)\n    root(x) == root(y)\n\
    \  end\n\n  def size(x : Int)\n    -@d[root(x)]\n  end\n\n  def groups\n    groups\
    \ = Hash(Int32, Set(Int32)).new { |h, k| h[k] = Set(Int32).new }\n    @d.size.times\
    \ do |i|\n      groups[root(i)] << i\n    end\n    groups.values.to_set\n  end\n\
    end\n"
  dependsOn: []
  isVerificationFile: false
  path: src/datastructure/union_find.cr
  requiredBy:
  - src/graph/components.cr
  - src/graph/decompose.cr
  - src/graph/kruskal.cr
  timestamp: '2021-08-18 04:01:03+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/graph/compress_degree_test.cr
  - test/datastructure/union_find_test.cr
documentation_of: src/datastructure/union_find.cr
layout: document
redirect_from:
- /library/src/datastructure/union_find.cr
- /library/src/datastructure/union_find.cr.html
title: src/datastructure/union_find.cr
---
