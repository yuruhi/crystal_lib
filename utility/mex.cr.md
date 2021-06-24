---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "class Array(T)\n  def mex\n    result = T.zero\n    self.sort.each\
    \ do |i|\n      return result if result < i\n      result = i.succ\n    end\n\
    \    return result\n  end\nend\n"
  code: "class Array(T)\n  def mex\n    result = T.zero\n    self.sort.each do |i|\n\
    \      return result if result < i\n      result = i.succ\n    end\n    return\
    \ result\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: utility/mex.cr
  requiredBy: []
  timestamp: '2021-06-24 10:46:20+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: utility/mex.cr
layout: document
redirect_from:
- /library/utility/mex.cr
- /library/utility/mex.cr.html
title: utility/mex.cr
---
