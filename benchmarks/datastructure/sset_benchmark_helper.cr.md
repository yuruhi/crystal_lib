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
    path: benchmarks/datastructure/sset/bucket.cr
    title: benchmarks/datastructure/sset/bucket.cr
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
    \    @array.sum <=> other.@array.sum\n  end\nend\n\nprivate def add_delete(x,\
    \ type : S.class, label, values) forall S\n  index = (0...values.size).to_a.shuffle\
    \ Random.new(123)\n  x.report(label) do\n    s = S(typeof(values.first)).new\n\
    \    values.each { |x| s.add x }\n    index.each { |i| s.delete values[i] }\n\
    \  end\nend\n\nprivate def split(x, type : T.class, label, values, split_key)\
    \ forall T\n  x.report(label) do\n    s = T.new values\n    _, _ = s.split(split_key)\n\
    \  end\nend\n\ndef benchmark_sset_add_delete(type : S.class) forall S\n  r = Random.new(12345)\n\
    \  values3 = Array.new(10**3, &.itself)\n  values6 = Array.new(10**6, &.itself)\n\
    \n  puts \"-------- add, delete --------\"\n  Benchmark.ips do |x|\n    add_delete\
    \ x, S, \"Int32 1e3 sorted\", values3\n    add_delete x, S, \"Int32 1e3      \
    \ \", values3.shuffle(r)\n    add_delete x, S, \"Int32 1e6 sorted\", values6\n\
    \    add_delete x, S, \"Int32 1e6       \", values6.shuffle(r)\n    add_delete\
    \ x, S, \"Int32 1e3 * 1e3 \", values6.map { |x| x % 1000 }.shuffle!(r)\n    add_delete\
    \ x, S, \"Array 1e6 * 1e2 \", Array.new(10**6) { Array.new(10**2) { r.rand(100)\
    \ } }\n    add_delete x, S, \"class 1e6       \", Array.new(10**6) { Foo.new r.rand(100)\
    \ }\n    add_delete x, S, \"SlowC 1e6 * 1e2 \", Array.new(10**6) { SlowCmp.new(100)\
    \ { r.rand(100) } }\n  end\nend\n\ndef benchmark_sset_split(type : S.class) forall\
    \ S\n  values6 = Array.new(10**6, &.itself)\n\n  puts \"-------- split --------\"\
    \n  Benchmark.ips do |x|\n    split x, S, \"Int32 5e5+5e5\", values6, 5_000_000\n\
    \    split x, S, \"Int32 1e5+9e5\", values6, 1_000_000\n  end\nend\n"
  code: "require \"benchmark\"\n\nprivate class Foo\n  getter x\n  include Comparable(Foo)\n\
    \n  def initialize(@x = 0)\n  end\n\n  def <=>(other : Foo)\n    x <=> other.x\n\
    \  end\nend\n\nprivate class SlowCmp\n  include Comparable(SlowCmp)\n\n  def initialize(size)\n\
    \    @array = Array(Int32).new(size) { yield }\n  end\n\n  def initialize\n  \
    \  @array = [] of Int32\n  end\n\n  def <=>(other : SlowCmp)\n    @array.sum <=>\
    \ other.@array.sum\n  end\nend\n\nprivate def add_delete(x, type : S.class, label,\
    \ values) forall S\n  index = (0...values.size).to_a.shuffle Random.new(123)\n\
    \  x.report(label) do\n    s = S(typeof(values.first)).new\n    values.each {\
    \ |x| s.add x }\n    index.each { |i| s.delete values[i] }\n  end\nend\n\nprivate\
    \ def split(x, type : T.class, label, values, split_key) forall T\n  x.report(label)\
    \ do\n    s = T.new values\n    _, _ = s.split(split_key)\n  end\nend\n\ndef benchmark_sset_add_delete(type\
    \ : S.class) forall S\n  r = Random.new(12345)\n  values3 = Array.new(10**3, &.itself)\n\
    \  values6 = Array.new(10**6, &.itself)\n\n  puts \"-------- add, delete --------\"\
    \n  Benchmark.ips do |x|\n    add_delete x, S, \"Int32 1e3 sorted\", values3\n\
    \    add_delete x, S, \"Int32 1e3       \", values3.shuffle(r)\n    add_delete\
    \ x, S, \"Int32 1e6 sorted\", values6\n    add_delete x, S, \"Int32 1e6      \
    \ \", values6.shuffle(r)\n    add_delete x, S, \"Int32 1e3 * 1e3 \", values6.map\
    \ { |x| x % 1000 }.shuffle!(r)\n    add_delete x, S, \"Array 1e6 * 1e2 \", Array.new(10**6)\
    \ { Array.new(10**2) { r.rand(100) } }\n    add_delete x, S, \"class 1e6     \
    \  \", Array.new(10**6) { Foo.new r.rand(100) }\n    add_delete x, S, \"SlowC\
    \ 1e6 * 1e2 \", Array.new(10**6) { SlowCmp.new(100) { r.rand(100) } }\n  end\n\
    end\n\ndef benchmark_sset_split(type : S.class) forall S\n  values6 = Array.new(10**6,\
    \ &.itself)\n\n  puts \"-------- split --------\"\n  Benchmark.ips do |x|\n  \
    \  split x, S, \"Int32 5e5+5e5\", values6, 5_000_000\n    split x, S, \"Int32\
    \ 1e5+9e5\", values6, 1_000_000\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: benchmarks/datastructure/sset_benchmark_helper.cr
  requiredBy:
  - benchmarks/datastructure/smultiset/treap.cr
  - benchmarks/datastructure/smultiset/red_black_tree.cr
  - benchmarks/datastructure/sset/treap.cr
  - benchmarks/datastructure/sset/bucket.cr
  - benchmarks/datastructure/sset/red_black_tree.cr
  timestamp: '2022-01-23 00:45:43+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: benchmarks/datastructure/sset_benchmark_helper.cr
layout: document
redirect_from:
- /library/benchmarks/datastructure/sset_benchmark_helper.cr
- /library/benchmarks/datastructure/sset_benchmark_helper.cr.html
title: benchmarks/datastructure/sset_benchmark_helper.cr
---
