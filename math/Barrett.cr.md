---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: math/DynamicMint.cr
    title: math/DynamicMint.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "struct Barrett\n  getter mod : UInt32\n  getter inv : UInt64\n\n \
    \ def initialize(@mod)\n    @inv = UInt64::MAX // @mod &+ 1\n  end\n\n  def mul(a\
    \ : UInt32, b : UInt32) : UInt32\n    z = a.to_u64 &* b\n    x = ((z.to_u128 &*\
    \ @inv) >> 64).to_u64!\n    v = (z &- x &* @mod).to_u32!\n    v &+= @mod if @mod\
    \ <= v\n    v\n  end\nend\n"
  code: "struct Barrett\n  getter mod : UInt32\n  getter inv : UInt64\n\n  def initialize(@mod)\n\
    \    @inv = UInt64::MAX // @mod &+ 1\n  end\n\n  def mul(a : UInt32, b : UInt32)\
    \ : UInt32\n    z = a.to_u64 &* b\n    x = ((z.to_u128 &* @inv) >> 64).to_u64!\n\
    \    v = (z &- x &* @mod).to_u32!\n    v &+= @mod if @mod <= v\n    v\n  end\n\
    end\n"
  dependsOn: []
  isVerificationFile: false
  path: math/Barrett.cr
  requiredBy:
  - math/DynamicMint.cr
  timestamp: '2021-06-24 10:34:19+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: math/Barrett.cr
layout: document
redirect_from:
- /library/math/Barrett.cr
- /library/math/Barrett.cr.html
title: math/Barrett.cr
---
