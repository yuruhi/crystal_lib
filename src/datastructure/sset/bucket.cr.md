---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: benchmarks/datastructure/sset.cr
    title: benchmarks/datastructure/sset.cr
  - icon: ':warning:'
    path: benchmarks/datastructure/sset/bucket.cr
    title: benchmarks/datastructure/sset/bucket.cr
  - icon: ':warning:'
    path: spec/datastructure/sset/bucket_spec.cr
    title: spec/datastructure/sset/bucket_spec.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "# reference: https://github.com/tatyam-prime/SortedSet/blob/main/SortedSet.py\n\
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
    \  end\n\n  def index(object : T, offset : Int = 0)\n    @buckets.each do |bucket|\n\
    \      if bucket.last >= x\n        i = bucket.bsearch_index { |x| x >= object\
    \ }\n        return i ? offset + i : nil\n      end\n      offset += bucket.size\n\
    \    end\n  end\n\n  def le(object : T) : T?\n    @buckets.reverse_each do |bucket|\n\
    \      if bucket.first <= object\n        i = bucket.bsearch_index { |x| x > object\
    \ } || bucket.size\n        return bucket[i - 1]\n      end\n    end\n  end\n\n\
    \  def lt(object : T) : T?\n    @buckets.reverse_each do |bucket|\n      if bucket.first\
    \ < object\n        i = bucket.bsearch_index { |x| x >= object } || bucket.size\n\
    \        return bucket[i - 1]\n      end\n    end\n  end\n\n  def ge(object :\
    \ T) : T?\n    {% if BSEARCH > 0 %}\n      @buckets.bsearch { |bucket| bucket.last\
    \ >= object }.try do |bucket|\n        bucket.bsearch { |x| x >= object }.not_nil!\n\
    \      end\n    {% else %}\n      @buckets.each do |bucket|\n        if bucket.last\
    \ >= object\n          return bucket.bsearch { |x| x >= object }.not_nil!\n  \
    \      end\n      end\n    {% end %}\n  end\n\n  def gt(object : T) : T?\n   \
    \ @buckets.each do |bucket|\n      if bucket.last > object\n        return bucket.bsearch\
    \ { |x| x > object }.not_nil!\n      end\n    end\n  end\n\n  {% for method in\
    \ [:le, :lt, :ge, :gt] %}\n    def {{method.id}}!(object : T) : T\n      {{method.id}}(object).not_nil!\n\
    \    end\n  {% end %}\n\n  {% for op in [:&, :|, :^, :+, :-] %}\n    def {{op.id}}(other\
    \ : Enumerable(T)) : self\n      SSet::Bucket(T, BUCKET_RATIO, REBUILD_RATIO,\
    \ BSEARCH).new (self.to_set {{op.id}} other.to_set)\n    end\n  {% end %}\n\n\
    \  def to_a : Array(T)\n    @buckets.each_with_object(Array(T).new size) do |bucket,\
    \ a|\n      a.concat bucket\n    end\n  end\n\n  def to_s(io : IO) : Nil\n   \
    \ io << \"Bucket{\"\n    join(\", \", io)\n    io << \"}\"\n  end\n\n  def inspect(io\
    \ : IO) : Nil\n    @buckets.inspect(io)\n  end\nend\n"
  code: "# reference: https://github.com/tatyam-prime/SortedSet/blob/main/SortedSet.py\n\
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
    \  end\n\n  def index(object : T, offset : Int = 0)\n    @buckets.each do |bucket|\n\
    \      if bucket.last >= x\n        i = bucket.bsearch_index { |x| x >= object\
    \ }\n        return i ? offset + i : nil\n      end\n      offset += bucket.size\n\
    \    end\n  end\n\n  def le(object : T) : T?\n    @buckets.reverse_each do |bucket|\n\
    \      if bucket.first <= object\n        i = bucket.bsearch_index { |x| x > object\
    \ } || bucket.size\n        return bucket[i - 1]\n      end\n    end\n  end\n\n\
    \  def lt(object : T) : T?\n    @buckets.reverse_each do |bucket|\n      if bucket.first\
    \ < object\n        i = bucket.bsearch_index { |x| x >= object } || bucket.size\n\
    \        return bucket[i - 1]\n      end\n    end\n  end\n\n  def ge(object :\
    \ T) : T?\n    {% if BSEARCH > 0 %}\n      @buckets.bsearch { |bucket| bucket.last\
    \ >= object }.try do |bucket|\n        bucket.bsearch { |x| x >= object }.not_nil!\n\
    \      end\n    {% else %}\n      @buckets.each do |bucket|\n        if bucket.last\
    \ >= object\n          return bucket.bsearch { |x| x >= object }.not_nil!\n  \
    \      end\n      end\n    {% end %}\n  end\n\n  def gt(object : T) : T?\n   \
    \ @buckets.each do |bucket|\n      if bucket.last > object\n        return bucket.bsearch\
    \ { |x| x > object }.not_nil!\n      end\n    end\n  end\n\n  {% for method in\
    \ [:le, :lt, :ge, :gt] %}\n    def {{method.id}}!(object : T) : T\n      {{method.id}}(object).not_nil!\n\
    \    end\n  {% end %}\n\n  {% for op in [:&, :|, :^, :+, :-] %}\n    def {{op.id}}(other\
    \ : Enumerable(T)) : self\n      SSet::Bucket(T, BUCKET_RATIO, REBUILD_RATIO,\
    \ BSEARCH).new (self.to_set {{op.id}} other.to_set)\n    end\n  {% end %}\n\n\
    \  def to_a : Array(T)\n    @buckets.each_with_object(Array(T).new size) do |bucket,\
    \ a|\n      a.concat bucket\n    end\n  end\n\n  def to_s(io : IO) : Nil\n   \
    \ io << \"Bucket{\"\n    join(\", \", io)\n    io << \"}\"\n  end\n\n  def inspect(io\
    \ : IO) : Nil\n    @buckets.inspect(io)\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/datastructure/sset/bucket.cr
  requiredBy:
  - spec/datastructure/sset/bucket_spec.cr
  - benchmarks/datastructure/sset.cr
  - benchmarks/datastructure/sset/bucket.cr
  timestamp: '2022-01-16 04:07:26+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/datastructure/sset/bucket.cr
layout: document
redirect_from:
- /library/src/datastructure/sset/bucket.cr
- /library/src/datastructure/sset/bucket.cr.html
title: src/datastructure/sset/bucket.cr
---
