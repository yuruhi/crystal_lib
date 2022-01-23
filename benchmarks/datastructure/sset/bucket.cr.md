---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: benchmarks/datastructure/sset_benchmark_helper.cr
    title: benchmarks/datastructure/sset_benchmark_helper.cr
  - icon: ':warning:'
    path: src/datastructure/sset/bucket.cr
    title: src/datastructure/sset/bucket.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "# require \"../sset_benchmark_helper\"\nrequire \"benchmark\"\n\n\
    private class Foo\n  getter x\n  include Comparable(Foo)\n\n  def initialize(@x\
    \ = 0)\n  end\n\n  def <=>(other : Foo)\n    x <=> other.x\n  end\nend\n\nprivate\
    \ class SlowCmp\n  include Comparable(SlowCmp)\n\n  def initialize(size)\n   \
    \ @array = Array(Int32).new(size) { yield }\n  end\n\n  def initialize\n    @array\
    \ = [] of Int32\n  end\n\n  def <=>(other : SlowCmp)\n    @array.sum <=> other.@array.sum\n\
    \  end\nend\n\nprivate def add_delete(x, type : S.class, label, values) forall\
    \ S\n  index = (0...values.size).to_a.shuffle Random.new(123)\n  x.report(label)\
    \ do\n    s = S(typeof(values.first)).new\n    values.each { |x| s.add x }\n \
    \   index.each { |i| s.delete values[i] }\n  end\nend\n\nprivate def split(x,\
    \ type : T.class, label, values, split_key) forall T\n  x.report(label) do\n \
    \   s = T.new values\n    _, _ = s.split(split_key)\n  end\nend\n\ndef benchmark_sset_add_delete(type\
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
    \ 1e5+9e5\", values6, 1_000_000\n  end\nend\n\n# require \"../../../src/datastructure/sset/bucket\"\
    \n# reference: https://github.com/tatyam-prime/SortedSet/blob/main/SortedSet.py\n\
    class SSet::Bucket(T, BUCKET_RATIO, REBUILD_RATIO, BSEARCH)\n  include Enumerable(T)\n\
    \  include Iterable(T)\n  include Indexable(T)\n\n  getter size = 0\n  @buckets\
    \ = [] of Array(T)\n\n  def initialize\n  end\n\n  def initialize(a : Enumerable(T))\n\
    \    build a.to_a.sort!.uniq!\n  end\n\n  private def build(a : Array(T)) : Nil\n\
    \    @size = a.size\n    bucket_size = Math.sqrt(size / BUCKET_RATIO).ceil.to_i\n\
    \    @buckets = Array.new(bucket_size) { |i| a[size * i // bucket_size...size\
    \ * (i + 1) // bucket_size] }\n  end\n\n  private def build\n    build to_a\n\
    \  end\n\n  def empty? : Bool\n    @size == 0\n  end\n\n  def clear\n    @size\
    \ = 0\n    @buckets.clear\n  end\n\n  def min? : T?\n    empty? ? nil : @buckets.first.first\n\
    \  end\n\n  def min : T\n    min? || raise EmptyError.new\n  end\n\n  def max?\
    \ : T?\n    empty? ? nil : @buckets.last.last\n  end\n\n  def max : T\n    max?\
    \ || raise EmptyError.new\n  end\n\n  def each(&) : Nil\n    @buckets.each do\
    \ |bucket|\n      bucket.each do |object|\n        yield object\n      end\n \
    \   end\n  end\n\n  private class ItemIterator(T)\n    include Iterator(T)\n\n\
    \    def initialize(@buckets : Array(Array(T)))\n      @i, @j = 0, 0\n    end\n\
    \n    def next\n      if @buckets.size == @i\n        stop\n      else\n     \
    \   @buckets[@i][@j].tap do\n          @j += 1\n          @i, @j = @i + 1, 0 if\
    \ @buckets[@i].size == @j\n        end\n      end\n    end\n  end\n\n  def each\n\
    \    ItemIterator(T).new(@buckets)\n  end\n\n  def reverse_each(&) : Nil\n   \
    \ @buckets.reverse_each do |bucket|\n      bucket.reverse_each do |object|\n \
    \       yield object\n      end\n    end\n  end\n\n  private def find_bucket(object\
    \ : T)\n    {% if BSEARCH > 0 %}\n      @buckets.bsearch { |bucket| object <=\
    \ bucket.last } || @buckets.last\n    {% else %}\n      @buckets.find(@buckets.last)\
    \ { |bucket| object <= bucket.last }\n    {% end %}\n  end\n\n  def includes?(object\
    \ : T) : Bool\n    false if empty?\n    find_bucket(object).bsearch { |x| x >=\
    \ object } == object\n  end\n\n  def unsafe_fetch(index : Int) : T\n    @buckets.each\
    \ do |bucket|\n      return bucket.unsafe_fetch(index) if index < bucket.size\n\
    \      index -= bucket.size\n    end\n    raise \"Bug\"\n  end\n\n  def add?(object\
    \ : T) : Bool\n    if size == 0\n      @buckets = [[object]]\n      @size = 1\n\
    \      return true\n    end\n\n    a = find_bucket(object)\n    i = a.bsearch_index\
    \ { |x| x >= object }\n    return false if i && a[i] == object\n    i ? a.insert(i,\
    \ object) : a.push(object)\n    @size += 1\n    build if a.size > @buckets.size\
    \ * REBUILD_RATIO\n    true\n  end\n\n  def add(object : T) : self\n    add?(object)\n\
    \    self\n  end\n\n  def <<(object : T) : self\n    add(object)\n  end\n\n  def\
    \ concat(elems) : self\n    elems.each { |object| add(object) }\n    self\n  end\n\
    \n  def delete(object : T) : Bool\n    return false if empty?\n    a = find_bucket(object)\n\
    \    i = a.bsearch_index { |x| x >= object }\n    return false if i.nil? || a[i]\
    \ != object\n    a.delete_at(i)\n    @size -= 1\n    build if a.empty?\n    true\n\
    \  end\n\n  def count(object : T) : Int32\n    includes?(object) ? 1 : 0\n  end\n\
    \n  def index(object : T) : Int32?\n    offset = 0\n    @buckets.each do |bucket|\n\
    \      if bucket.last >= object\n        i = bucket.bsearch_index { |x| x >= object\
    \ }.not_nil!\n        return offset + i if bucket[i] == object\n      end\n  \
    \  end\n  end\n\n  def index_left(object : T) : Int32\n    @buckets.reduce(0)\
    \ do |offset, bucket|\n      if bucket.last >= object\n        return offset +\
    \ bucket.bsearch_index { |x| x >= object }.not_nil!\n      end\n      offset +\
    \ bucket.size\n    end\n  end\n\n  def index_right(object : T) : Int32?\n    @buckets.reduce(0)\
    \ do |offset, bucket|\n      if bucket.last > object\n        return offset +\
    \ bucket.bsearch_index { |x| x > object }.not_nil!\n      end\n      offset +\
    \ bucket.size\n    end\n  end\n\n  def le(object : T) : T?\n    @buckets.reverse_each\
    \ do |bucket|\n      if bucket.first <= object\n        i = bucket.bsearch_index\
    \ { |x| x > object } || bucket.size\n        return bucket[i - 1]\n      end\n\
    \    end\n  end\n\n  def lt(object : T) : T?\n    @buckets.reverse_each do |bucket|\n\
    \      if bucket.first < object\n        i = bucket.bsearch_index { |x| x >= object\
    \ } || bucket.size\n        return bucket[i - 1]\n      end\n    end\n  end\n\n\
    \  def ge(object : T) : T?\n    {% if BSEARCH > 0 %}\n      @buckets.bsearch {\
    \ |bucket| bucket.last >= object }.try do |bucket|\n        bucket.bsearch { |x|\
    \ x >= object }.not_nil!\n      end\n    {% else %}\n      @buckets.each do |bucket|\n\
    \        if bucket.last >= object\n          return bucket.bsearch { |x| x >=\
    \ object }.not_nil!\n        end\n      end\n    {% end %}\n  end\n\n  def gt(object\
    \ : T) : T?\n    @buckets.each do |bucket|\n      if bucket.last > object\n  \
    \      return bucket.bsearch { |x| x > object }.not_nil!\n      end\n    end\n\
    \  end\n\n  {% for method in [:le, :lt, :ge, :gt] %}\n    def {{method.id}}!(object\
    \ : T) : T\n      {{method.id}}(object).not_nil!\n    end\n  {% end %}\n\n  {%\
    \ for op in [:&, :|, :^, :+, :-] %}\n    def {{op.id}}(other : Enumerable(T))\
    \ : self\n      SSet::Bucket(T, BUCKET_RATIO, REBUILD_RATIO, BSEARCH).new (self.to_set\
    \ {{op.id}} other.to_set)\n    end\n  {% end %}\n\n  def to_a : Array(T)\n   \
    \ @buckets.each_with_object(Array(T).new size) do |bucket, a|\n      a.concat\
    \ bucket\n    end\n  end\n\n  def to_s(io : IO) : Nil\n    io << \"SSet::Bucket{\"\
    \n    join(\", \", io)\n    io << \"}\"\n  end\n\n  def inspect(io : IO) : Nil\n\
    \    @buckets.inspect(io)\n  end\nend\n\nbenchmark_sset_add_delete(SSet::Bucket)\n"
  code: 'require "../sset_benchmark_helper"

    require "../../../src/datastructure/sset/bucket"

    benchmark_sset_add_delete(SSet::Bucket)

    '
  dependsOn:
  - benchmarks/datastructure/sset_benchmark_helper.cr
  - src/datastructure/sset/bucket.cr
  isVerificationFile: false
  path: benchmarks/datastructure/sset/bucket.cr
  requiredBy: []
  timestamp: '2022-01-22 15:32:00+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: benchmarks/datastructure/sset/bucket.cr
layout: document
redirect_from:
- /library/benchmarks/datastructure/sset/bucket.cr
- /library/benchmarks/datastructure/sset/bucket.cr.html
title: benchmarks/datastructure/sset/bucket.cr
---
