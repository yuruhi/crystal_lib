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
  bundledCode: "require \"benchmark\"\n\n# require \"../../src/math/barrett\"\nstruct\
    \ Barrett\n  getter mod : UInt32, inv : UInt64\n\n  # Requires `1 <= mod < 2^31`\n\
    \  def initialize(@mod)\n    @inv = UInt64::MAX // @mod &+ 1\n  end\n\n  # Caluclates\
    \ `a * b % mod`.\n  #\n  # Requires `0 <= a < mod` and `0 <= b < mod`\n  def mul(a\
    \ : UInt32, b : UInt32) : UInt32\n    z = a.to_u64! &* b\n    x = ((z.to_u128!\
    \ &* @inv) >> 64).to_u64!\n    v = (z &- x &* @mod).to_u32!\n    v &+= @mod if\
    \ @mod <= v\n    v\n  end\nend\n\nN = 1000000\n\nprivate macro benchmark(mod)\n\
    \  mod = {{mod}}u32\n\n  b = rand(mod)\n  expect = N.times.reduce(1u64) { |acc|\
    \ acc * b % {{mod}} }\n\n  puts \"-------- mod: {{mod}} --------\"\n  Benchmark.ips\
    \ do |x|\n    x.report(\"a * b % mod\") do\n      a = 1u64\n      N.times { a\
    \ = a * b % mod }\n      raise \"\" unless expect == a\n    end\n\n    x.report(\"\
    a &* b % mod\") do\n      a = 1u64\n      N.times { a = a * b % mod }\n      raise\
    \ \"\" unless expect == a\n    end\n\n    x.report(\"a * b % MOD\") do\n     \
    \ a = 1u64\n      N.times { a = a * b % {{mod}} }\n      raise \"\" unless expect\
    \ == a\n    end\n\n    x.report(\"a &* b % MOD\") do\n      a = 1u64\n      N.times\
    \ { a = a * b % {{mod}} }\n      raise \"\" unless expect == a\n    end\n\n  \
    \  x.report(\"bt.mul(a, b)\") do\n      bt = Barrett.new(mod)\n      a = 1u32\n\
    \      N.times { a = bt.mul(a, b) }\n      raise \"\" unless expect == a\n   \
    \ end\n  end\n  puts\nend\n\nbenchmark 1\nbenchmark 100000\nbenchmark 1000000000\n\
    benchmark 1000000007\nbenchmark 2147483647\n"
  code: "require \"benchmark\"\nrequire \"../../src/math/barrett\"\n\nN = 1000000\n\
    \nprivate macro benchmark(mod)\n  mod = {{mod}}u32\n\n  b = rand(mod)\n  expect\
    \ = N.times.reduce(1u64) { |acc| acc * b % {{mod}} }\n\n  puts \"-------- mod:\
    \ {{mod}} --------\"\n  Benchmark.ips do |x|\n    x.report(\"a * b % mod\") do\n\
    \      a = 1u64\n      N.times { a = a * b % mod }\n      raise \"\" unless expect\
    \ == a\n    end\n\n    x.report(\"a &* b % mod\") do\n      a = 1u64\n      N.times\
    \ { a = a * b % mod }\n      raise \"\" unless expect == a\n    end\n\n    x.report(\"\
    a * b % MOD\") do\n      a = 1u64\n      N.times { a = a * b % {{mod}} }\n   \
    \   raise \"\" unless expect == a\n    end\n\n    x.report(\"a &* b % MOD\") do\n\
    \      a = 1u64\n      N.times { a = a * b % {{mod}} }\n      raise \"\" unless\
    \ expect == a\n    end\n\n    x.report(\"bt.mul(a, b)\") do\n      bt = Barrett.new(mod)\n\
    \      a = 1u32\n      N.times { a = bt.mul(a, b) }\n      raise \"\" unless expect\
    \ == a\n    end\n  end\n  puts\nend\n\nbenchmark 1\nbenchmark 100000\nbenchmark\
    \ 1000000000\nbenchmark 1000000007\nbenchmark 2147483647\n"
  dependsOn:
  - src/math/barrett.cr
  isVerificationFile: false
  path: benchmarks/math/barrett.cr
  requiredBy: []
  timestamp: '2021-10-16 11:24:12+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: benchmarks/math/barrett.cr
layout: document
redirect_from:
- /library/benchmarks/math/barrett.cr
- /library/benchmarks/math/barrett.cr.html
title: benchmarks/math/barrett.cr
---
