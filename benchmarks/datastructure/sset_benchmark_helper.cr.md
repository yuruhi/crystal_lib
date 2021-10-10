---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: benchmarks/datastructure/smultiset/red_black_tree.cr
    title: benchmarks/datastructure/smultiset/red_black_tree.cr
  - icon: ':warning:'
    path: benchmarks/datastructure/smultiset/treap.cr
    title: benchmarks/datastructure/smultiset/treap.cr
  - icon: ':warning:'
    path: benchmarks/datastructure/sset/red_black_tree.cr
    title: benchmarks/datastructure/sset/red_black_tree.cr
  - icon: ':warning:'
    path: benchmarks/datastructure/sset/treap.cr
    title: benchmarks/datastructure/sset/treap.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"benchmark\"\n\nprivate class Foo\n  getter x\n  include\
    \ Comparable(Foo)\n\n  def initialize(@x = 0)\n  end\n\n  def <=>(other : Foo)\n\
    \    x <=> other.x\n  end\nend\n\nprivate class SlowCmp\n  include Comparable(SlowCmp)\n\
    \n  def initialize(size)\n    @array = Array(Int32).new(size) { yield }\n  end\n\
    \n  def initialize\n    @array = [] of Int32\n  end\n\n  def <=>(other : SlowCmp)\n\
    \    @array.sum <=> other.@array.sum\n  end\nend\n\nprivate def benchmark_add_delete(label,\
    \ type : T.class, values) forall T\n  index = (0...values.size).to_a.shuffle Random.new(123)\n\
    \  Benchmark.ips do |x|\n    x.report(label) do\n      s = T.new\n      values.each\
    \ { |x| s.add x }\n      index.each { |i| s.delete values[i] }\n    end\n  end\n\
    end\n\nprivate def benchmark_split(label, type : T.class, values, split_key) forall\
    \ T\n  Benchmark.ips do |x|\n    x.report(label) do\n      s = T.new values\n\
    \      _, _ = s.split(split_key)\n    end\n  end\nend\n\ndef benchmark_sset(type\
    \ : S.class) forall S\n  r = Random.new(12345)\n  values3 = Array.new(10**3, &.itself)\n\
    \  values6 = Array.new(10**6, &.itself)\n\n  puts \"-------- add, delete --------\"\
    \n  benchmark_add_delete \"Int32 1e3 sorted\", S(Int32), values3\n  benchmark_add_delete\
    \ \"Int32 1e3       \", S(Int32), values3.shuffle(r)\n  benchmark_add_delete \"\
    Int32 1e6 sorted\", S(Int32), values6\n  benchmark_add_delete \"Int32 1e6    \
    \   \", S(Int32), values6.shuffle(r)\n  benchmark_add_delete \"Int32 1e3 * 1e3\
    \ \", S(Int32), values6.map { |x| x % 1000 }.shuffle!(r)\n  benchmark_add_delete\
    \ \"Array 1e6 * 1e2 \", S(Array(Int32)), Array.new(10**6) { Array.new(10**2) {\
    \ r.rand(100) } }\n  benchmark_add_delete \"class 1e6       \", S(Foo), Array.new(10**6)\
    \ { Foo.new r.rand(100) }\n  benchmark_add_delete \"SlowC 1e6 * 1e2 \", S(SlowCmp),\
    \ Array.new(10**6) { SlowCmp.new(100) { r.rand(100) } }\n  puts\n\n  puts \"--------\
    \ split --------\"\n  benchmark_split \"Int32 5e5+5e5\", S(Int32), values6, 5_000_000\n\
    \  benchmark_split \"Int32 1e5+9e5\", S(Int32), values6, 1_000_000\nend\n"
  code: "require \"benchmark\"\n\nprivate class Foo\n  getter x\n  include Comparable(Foo)\n\
    \n  def initialize(@x = 0)\n  end\n\n  def <=>(other : Foo)\n    x <=> other.x\n\
    \  end\nend\n\nprivate class SlowCmp\n  include Comparable(SlowCmp)\n\n  def initialize(size)\n\
    \    @array = Array(Int32).new(size) { yield }\n  end\n\n  def initialize\n  \
    \  @array = [] of Int32\n  end\n\n  def <=>(other : SlowCmp)\n    @array.sum <=>\
    \ other.@array.sum\n  end\nend\n\nprivate def benchmark_add_delete(label, type\
    \ : T.class, values) forall T\n  index = (0...values.size).to_a.shuffle Random.new(123)\n\
    \  Benchmark.ips do |x|\n    x.report(label) do\n      s = T.new\n      values.each\
    \ { |x| s.add x }\n      index.each { |i| s.delete values[i] }\n    end\n  end\n\
    end\n\nprivate def benchmark_split(label, type : T.class, values, split_key) forall\
    \ T\n  Benchmark.ips do |x|\n    x.report(label) do\n      s = T.new values\n\
    \      _, _ = s.split(split_key)\n    end\n  end\nend\n\ndef benchmark_sset(type\
    \ : S.class) forall S\n  r = Random.new(12345)\n  values3 = Array.new(10**3, &.itself)\n\
    \  values6 = Array.new(10**6, &.itself)\n\n  puts \"-------- add, delete --------\"\
    \n  benchmark_add_delete \"Int32 1e3 sorted\", S(Int32), values3\n  benchmark_add_delete\
    \ \"Int32 1e3       \", S(Int32), values3.shuffle(r)\n  benchmark_add_delete \"\
    Int32 1e6 sorted\", S(Int32), values6\n  benchmark_add_delete \"Int32 1e6    \
    \   \", S(Int32), values6.shuffle(r)\n  benchmark_add_delete \"Int32 1e3 * 1e3\
    \ \", S(Int32), values6.map { |x| x % 1000 }.shuffle!(r)\n  benchmark_add_delete\
    \ \"Array 1e6 * 1e2 \", S(Array(Int32)), Array.new(10**6) { Array.new(10**2) {\
    \ r.rand(100) } }\n  benchmark_add_delete \"class 1e6       \", S(Foo), Array.new(10**6)\
    \ { Foo.new r.rand(100) }\n  benchmark_add_delete \"SlowC 1e6 * 1e2 \", S(SlowCmp),\
    \ Array.new(10**6) { SlowCmp.new(100) { r.rand(100) } }\n  puts\n\n  puts \"--------\
    \ split --------\"\n  benchmark_split \"Int32 5e5+5e5\", S(Int32), values6, 5_000_000\n\
    \  benchmark_split \"Int32 1e5+9e5\", S(Int32), values6, 1_000_000\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: benchmarks/datastructure/sset_benchmark_helper.cr
  requiredBy:
  - benchmarks/datastructure/sset/treap.cr
  - benchmarks/datastructure/sset/red_black_tree.cr
  - benchmarks/datastructure/smultiset/treap.cr
  - benchmarks/datastructure/smultiset/red_black_tree.cr
  timestamp: '2021-10-10 09:12:20+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: benchmarks/datastructure/sset_benchmark_helper.cr
layout: document
redirect_from:
- /library/benchmarks/datastructure/sset_benchmark_helper.cr
- /library/benchmarks/datastructure/sset_benchmark_helper.cr.html
title: benchmarks/datastructure/sset_benchmark_helper.cr
---
