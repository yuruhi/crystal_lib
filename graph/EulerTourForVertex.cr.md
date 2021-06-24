---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "class EulerTourForVertex\n  getter graph : UnweightedUndirectedGraph\n\
    \n  def initialize(@graph)\n    @ls = Array(Int32).new(size, 0)\n    @rs = Array(Int32).new(size,\
    \ 0)\n    @k = 0\n  end\n\n  delegate size, to: @graph\n  delegate :[], to: @graph\n\
    \  delegate add_edge, to: @graph\n\n  def dfs(v : Int32, p : Int32) : Nil\n  \
    \  @ls[v] = @k\n    @k += 1\n    @graph[v].each do |u|\n      dfs(u, v) if u !=\
    \ p\n    end\n    @rs[v] = @k\n  end\n\n  def run(root : Int32)\n    dfs(root,\
    \ -1)\n    {@ls, @rs}\n  end\nend\n"
  code: "class EulerTourForVertex\n  getter graph : UnweightedUndirectedGraph\n\n\
    \  def initialize(@graph)\n    @ls = Array(Int32).new(size, 0)\n    @rs = Array(Int32).new(size,\
    \ 0)\n    @k = 0\n  end\n\n  delegate size, to: @graph\n  delegate :[], to: @graph\n\
    \  delegate add_edge, to: @graph\n\n  def dfs(v : Int32, p : Int32) : Nil\n  \
    \  @ls[v] = @k\n    @k += 1\n    @graph[v].each do |u|\n      dfs(u, v) if u !=\
    \ p\n    end\n    @rs[v] = @k\n  end\n\n  def run(root : Int32)\n    dfs(root,\
    \ -1)\n    {@ls, @rs}\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: graph/EulerTourForVertex.cr
  requiredBy: []
  timestamp: '2021-06-24 10:22:55+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: graph/EulerTourForVertex.cr
layout: document
redirect_from:
- /library/graph/EulerTourForVertex.cr
- /library/graph/EulerTourForVertex.cr.html
title: graph/EulerTourForVertex.cr
---
