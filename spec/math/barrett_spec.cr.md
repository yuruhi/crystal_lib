---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/math/barrett.cr
    title: src/math/barrett.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../src/math/barrett\"\nstruct Barrett\n\
    \  getter mod : UInt32, inv : UInt64\n\n  # Requires `1 <= mod < 2^31`\n  def\
    \ initialize(@mod)\n    @inv = UInt64::MAX // @mod &+ 1\n  end\n\n  # Caluclates\
    \ `a * b % mod`.\n  #\n  # Requires `0 <= a < mod` and `0 <= b < mod`\n  def mul(a\
    \ : UInt32, b : UInt32) : UInt32\n    z = a.to_u64! &* b\n    x = ((z.to_u128!\
    \ &* @inv) >> 64).to_u64!\n    v = (z &- x &* @mod).to_u32!\n    v &+= @mod if\
    \ @mod <= v\n    v\n  end\nend\n\nprivate def check_all(mod : UInt32)\n  bt =\
    \ Barrett.new(mod)\n  (0u32...mod).each do |x|\n    (0u32...mod).each do |y|\n\
    \      bt.mul(x, y).should eq x * y % mod\n    end\n  end\nend\n\nprivate def\
    \ check(mod : UInt32, trial : Int32)\n  bt = Barrett.new(mod)\n  trial.times do\n\
    \    a, b = rand(mod), rand(mod)\n    mul = a.to_u64 * b % mod\n    if bt.mul(a,\
    \ b) != mul\n      p [a, b, mod, mul, bt.mul(a, b)]\n    end\n    bt.mul(a, b).should\
    \ eq mul\n  end\nend\n\ndescribe Barrett do\n  it \"#mul\" do\n    (1u32..1000u32).each\
    \ { |mod| check_all(mod) }\n    (1000u32..10000u32).step(by: 1000) { |mod| check_all(mod)\
    \ }\n    max = 2u32**31 - 1\n    {\n      10u32**5, 10u32**6, 10u32**7, 10u32**8,\
    \ 10u32**9,\n      2u32**26, 2u32**27, 2u32**28, 2u32**29, 2u32**30,\n      max\
    \ - 5, max - 4, max - 3, max - 2, max - 1, max,\n    }.each do |mod|\n      check(mod,\
    \ 10000000)\n    end\n  end\nend\n"
  code: "require \"spec\"\nrequire \"../../src/math/barrett\"\n\nprivate def check_all(mod\
    \ : UInt32)\n  bt = Barrett.new(mod)\n  (0u32...mod).each do |x|\n    (0u32...mod).each\
    \ do |y|\n      bt.mul(x, y).should eq x * y % mod\n    end\n  end\nend\n\nprivate\
    \ def check(mod : UInt32, trial : Int32)\n  bt = Barrett.new(mod)\n  trial.times\
    \ do\n    a, b = rand(mod), rand(mod)\n    mul = a.to_u64 * b % mod\n    if bt.mul(a,\
    \ b) != mul\n      p [a, b, mod, mul, bt.mul(a, b)]\n    end\n    bt.mul(a, b).should\
    \ eq mul\n  end\nend\n\ndescribe Barrett do\n  it \"#mul\" do\n    (1u32..1000u32).each\
    \ { |mod| check_all(mod) }\n    (1000u32..10000u32).step(by: 1000) { |mod| check_all(mod)\
    \ }\n    max = 2u32**31 - 1\n    {\n      10u32**5, 10u32**6, 10u32**7, 10u32**8,\
    \ 10u32**9,\n      2u32**26, 2u32**27, 2u32**28, 2u32**29, 2u32**30,\n      max\
    \ - 5, max - 4, max - 3, max - 2, max - 1, max,\n    }.each do |mod|\n      check(mod,\
    \ 10000000)\n    end\n  end\nend\n"
  dependsOn:
  - src/math/barrett.cr
  isVerificationFile: false
  path: spec/math/barrett_spec.cr
  requiredBy: []
  timestamp: '2021-10-15 18:18:19+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/math/barrett_spec.cr
layout: document
redirect_from:
- /library/spec/math/barrett_spec.cr
- /library/spec/math/barrett_spec.cr.html
title: spec/math/barrett_spec.cr
---
