---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "struct Int\n  def powmod(exp : T, mod : self) forall T\n    n = self\
    \ % mod\n    res = typeof(self).new(1)\n    while exp > 0\n      res = res * n\
    \ % mod if exp.odd?\n      n = n * n % mod\n      exp >>= 1\n    end\n    res\n\
    \  end\nend\n"
  code: "struct Int\n  def powmod(exp : T, mod : self) forall T\n    n = self % mod\n\
    \    res = typeof(self).new(1)\n    while exp > 0\n      res = res * n % mod if\
    \ exp.odd?\n      n = n * n % mod\n      exp >>= 1\n    end\n    res\n  end\n\
    end\n"
  dependsOn: []
  isVerificationFile: false
  path: math/powmod.cr
  requiredBy: []
  timestamp: '2021-06-23 22:18:21+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: math/powmod.cr
layout: document
redirect_from:
- /library/math/powmod.cr
- /library/math/powmod.cr.html
title: math/powmod.cr
---
