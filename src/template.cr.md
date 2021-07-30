---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "lib C\n  fun strtoll(s : UInt8*, p : UInt8**, b : Int32) : Int64\n\
    end\n\nclass String\n  def to_i64\n    C.strtoll(self, nil, 10)\n  end\nend\n"
  code: "lib C\n  fun strtoll(s : UInt8*, p : UInt8**, b : Int32) : Int64\nend\n\n\
    class String\n  def to_i64\n    C.strtoll(self, nil, 10)\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/template.cr
  requiredBy: []
  timestamp: '2021-07-30 20:25:59+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/template.cr
layout: document
redirect_from:
- /library/src/template.cr
- /library/src/template.cr.html
title: src/template.cr
---
