---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/array/change_spec.cr
    title: spec/array/change_spec.cr
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
  path: src/array/change.cr
  requiredBy:
  - src/template.cr
  - spec/array/change_spec.cr
  timestamp: '2021-10-25 10:41:22+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/array/change.cr
layout: document
redirect_from:
- /library/src/array/change.cr
- /library/src/array/change.cr.html
title: src/array/change.cr
---
