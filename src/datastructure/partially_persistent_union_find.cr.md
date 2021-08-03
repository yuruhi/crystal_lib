---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/datastructure/partially_persistent_union_find.test.cr
    title: test/datastructure/partially_persistent_union_find.test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "class PartiallyPersistentUnionFind\n  getter size : Int32, now : Int32\n\
    \n  def initialize(size : Int)\n    @size = size.to_i\n    @now = 0\n    @parent\
    \ = Array(Int32).new(size, &.itself)\n    @rank = Array(Int32).new(size, 0)\n\
    \    @time = Array(Int32).new(size, Int32::MAX)\n    @num = Array(Array({Int32,\
    \ Int32})).new(size) { [{0, 1}] }\n  end\n\n  def root(x : Int, time : Int) :\
    \ Int32\n    time < @time[x] ? x : root(@parent[x], time)\n  end\n\n  def same?(x\
    \ : Int, y : Int, time : Int) : Bool\n    root(x, time) == root(y, time)\n  end\n\
    \n  def unite(x : Int, y : Int) : Bool\n    @now += 1\n    x, y = root(x, now),\
    \ root(y, now)\n    return false if x == y\n    x, y = y, x if @rank[x] < @rank[y]\n\
    \    @num[x] << {now, size(x, now) + size(y, now)}\n    @parent[y] = x\n    @time[y]\
    \ = now\n    @rank[x] += 1 if @rank[x] == @rank[y]\n    true\n  end\n\n  def size(x\
    \ : Int, time : Int) : Int\n    x = root(x, time)\n    pos = @num[x].bsearch_index\
    \ { |(t, s), _| t > time } || @num[x].size\n    @num[x][pos - 1][1]\n  end\nend\n"
  code: "class PartiallyPersistentUnionFind\n  getter size : Int32, now : Int32\n\n\
    \  def initialize(size : Int)\n    @size = size.to_i\n    @now = 0\n    @parent\
    \ = Array(Int32).new(size, &.itself)\n    @rank = Array(Int32).new(size, 0)\n\
    \    @time = Array(Int32).new(size, Int32::MAX)\n    @num = Array(Array({Int32,\
    \ Int32})).new(size) { [{0, 1}] }\n  end\n\n  def root(x : Int, time : Int) :\
    \ Int32\n    time < @time[x] ? x : root(@parent[x], time)\n  end\n\n  def same?(x\
    \ : Int, y : Int, time : Int) : Bool\n    root(x, time) == root(y, time)\n  end\n\
    \n  def unite(x : Int, y : Int) : Bool\n    @now += 1\n    x, y = root(x, now),\
    \ root(y, now)\n    return false if x == y\n    x, y = y, x if @rank[x] < @rank[y]\n\
    \    @num[x] << {now, size(x, now) + size(y, now)}\n    @parent[y] = x\n    @time[y]\
    \ = now\n    @rank[x] += 1 if @rank[x] == @rank[y]\n    true\n  end\n\n  def size(x\
    \ : Int, time : Int) : Int\n    x = root(x, time)\n    pos = @num[x].bsearch_index\
    \ { |(t, s), _| t > time } || @num[x].size\n    @num[x][pos - 1][1]\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/datastructure/partially_persistent_union_find.cr
  requiredBy: []
  timestamp: '2021-08-03 16:29:52+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/datastructure/partially_persistent_union_find.test.cr
documentation_of: src/datastructure/partially_persistent_union_find.cr
layout: document
redirect_from:
- /library/src/datastructure/partially_persistent_union_find.cr
- /library/src/datastructure/partially_persistent_union_find.cr.html
title: src/datastructure/partially_persistent_union_find.cr
---
