---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: src/math/dynamic_mint.cr
    title: src/math/dynamic_mint.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "struct Barrett\n  getter mod : UInt32, inv : UInt64\n\n  def initialize(@mod)\n\
    \    @inv = UInt64::MAX // @mod &+ 1\n  end\n\n  # Caluclates `a * b % mod`.\n\
    \  def mul(a : UInt32, b : UInt32) : UInt32\n    z = a.to_u64 &* b\n    x = ((z.to_u128\
    \ &* @inv) >> 64).to_u64!\n    v = (z &- x &* @mod).to_u32!\n    v &+= @mod if\
    \ @mod <= v\n    v\n  end\nend\n"
  code: "struct Barrett\n  getter mod : UInt32, inv : UInt64\n\n  def initialize(@mod)\n\
    \    @inv = UInt64::MAX // @mod &+ 1\n  end\n\n  # Caluclates `a * b % mod`.\n\
    \  def mul(a : UInt32, b : UInt32) : UInt32\n    z = a.to_u64 &* b\n    x = ((z.to_u128\
    \ &* @inv) >> 64).to_u64!\n    v = (z &- x &* @mod).to_u32!\n    v &+= @mod if\
    \ @mod <= v\n    v\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/math/barrett.cr
  requiredBy:
  - src/math/dynamic_mint.cr
  timestamp: '2021-08-03 17:34:10+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/math/barrett.cr
layout: document
redirect_from:
- /library/src/math/barrett.cr
- /library/src/math/barrett.cr.html
title: src/math/barrett.cr
---
