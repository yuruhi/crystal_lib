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
  path: template/template.cr
  requiredBy: []
  timestamp: '2021-06-24 10:22:55+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: template/template.cr
layout: document
redirect_from:
- /library/template/template.cr
- /library/template/template.cr.html
title: template/template.cr
---
