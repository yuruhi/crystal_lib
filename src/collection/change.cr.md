---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/collection/change_spec.cr
    title: spec/collection/change_spec.cr
  - icon: ':warning:'
    path: src/template.cr
    title: src/template.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "class Array(T)\n  def chmin(i : Int, value : T)\n    f = self[i] >\
    \ value\n    self[i] = value if f\n    f\n  end\n\n  protected def chmin(i : Int,\
    \ *indexes, value)\n    self[i].chmin(*indexes, value: value)\n  end\n\n  def\
    \ chmin(indexes : Tuple, value)\n    chmin(*indexes, value: value)\n  end\n\n\
    \  def chmax(i : Int, value : T)\n    f = self[i] < value\n    self[i] = value\
    \ if f\n    f\n  end\n\n  protected def chmax(i : Int, *indexes, value)\n    self[i].chmax(*indexes,\
    \ value: value)\n  end\n\n  def chmax(indexes : Tuple, value)\n    chmax(*indexes,\
    \ value: value)\n  end\nend\n"
  code: "class Array(T)\n  def chmin(i : Int, value : T)\n    f = self[i] > value\n\
    \    self[i] = value if f\n    f\n  end\n\n  protected def chmin(i : Int, *indexes,\
    \ value)\n    self[i].chmin(*indexes, value: value)\n  end\n\n  def chmin(indexes\
    \ : Tuple, value)\n    chmin(*indexes, value: value)\n  end\n\n  def chmax(i :\
    \ Int, value : T)\n    f = self[i] < value\n    self[i] = value if f\n    f\n\
    \  end\n\n  protected def chmax(i : Int, *indexes, value)\n    self[i].chmax(*indexes,\
    \ value: value)\n  end\n\n  def chmax(indexes : Tuple, value)\n    chmax(*indexes,\
    \ value: value)\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/collection/change.cr
  requiredBy:
  - spec/collection/change_spec.cr
  - src/template.cr
  timestamp: '2022-04-14 18:17:07+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/collection/change.cr
layout: document
redirect_from:
- /library/src/collection/change.cr
- /library/src/collection/change.cr.html
title: src/collection/change.cr
---
