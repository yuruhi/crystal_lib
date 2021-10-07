---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "struct Int\n  # Caluclates `self ** exp % mod`.\n  def powmod(exp\
    \ : Int, mod : self)\n    n = self % mod\n    res = typeof(self).new(1)\n    while\
    \ exp > 0\n      res = res * n % mod if exp.odd?\n      n = n * n % mod\n    \
    \  exp >>= 1\n    end\n    res\n  end\nend\n"
  code: "struct Int\n  # Caluclates `self ** exp % mod`.\n  def powmod(exp : Int,\
    \ mod : self)\n    n = self % mod\n    res = typeof(self).new(1)\n    while exp\
    \ > 0\n      res = res * n % mod if exp.odd?\n      n = n * n % mod\n      exp\
    \ >>= 1\n    end\n    res\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/math/powmod.cr
  requiredBy: []
  timestamp: '2021-10-07 10:29:41+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/math/powmod.cr
layout: document
redirect_from:
- /library/src/math/powmod.cr
- /library/src/math/powmod.cr.html
title: src/math/powmod.cr
---
