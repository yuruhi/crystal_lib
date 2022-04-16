---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/datastructure/smultiset/bucket.cr
    title: src/datastructure/smultiset/bucket.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../../src/datastructure/smultiset/bucket\"\
    \n# reference: https://github.com/tatyam-prime/SortedSet/blob/main/SortedSet.py\n\
    class SMultiSet::Bucket(T, BUCKET_RATIO, REBUILD_RATIO, BSEARCH)\n  include Enumerable(T)\n\
    \  include Iterable(T)\n  include Indexable(T)\n\n  getter size = 0\n  @buckets\
    \ = [] of Array(T)\n\n  def initialize\n  end\n\n  def initialize(a : Enumerable(T))\n\
    \    build a.to_a.sort!\n  end\n\n  private def build(a : Array(T)) : Nil\n  \
    \  @size = a.size\n    bucket_size = Math.sqrt(size / BUCKET_RATIO).ceil.to_i\n\
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
    \      index -= bucket.size\n    end\n    raise \"Bug\"\n  end\n\n  def add(object\
    \ : T) : self\n    if size == 0\n      @buckets = [[object]]\n      @size = 1\n\
    \      return self\n    end\n\n    a = find_bucket(object)\n    i = a.bsearch_index\
    \ { |x| x >= object }\n    i ? a.insert(i, object) : a.push(object)\n    @size\
    \ += 1\n    build if a.size > @buckets.size * REBUILD_RATIO\n    self\n  end\n\
    \n  def <<(object : T) : self\n    add(object)\n  end\n\n  def concat(elems) :\
    \ self\n    elems.each { |object| add(object) }\n    self\n  end\n\n  def delete(object\
    \ : T) : Bool\n    return false if empty?\n    a = find_bucket(object)\n    i\
    \ = a.bsearch_index { |x| x >= object }\n    return false if i.nil? || a[i] !=\
    \ object\n    a.delete_at(i)\n    @size -= 1\n    build if a.empty?\n    true\n\
    \  end\n\n  def count(object : T) : Int32?\n    index_right(object) - index_left(object)\n\
    \  end\n\n  def index(object : T) : Int32?\n    offset = 0\n    @buckets.each\
    \ do |bucket|\n      if bucket.last >= object\n        i = bucket.bsearch_index\
    \ { |x| x >= object }.not_nil!\n        return offset + i if bucket[i] == object\n\
    \      end\n    end\n  end\n\n  def index_left(object : T) : Int32\n    @buckets.reduce(0)\
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
    \ : self\n      SMultiSet::Bucket(T, BUCKET_RATIO, REBUILD_RATIO, BSEARCH).new\
    \ (self.to_set {{op.id}} other.to_set)\n    end\n  {% end %}\n\n  def to_a : Array(T)\n\
    \    @buckets.each_with_object(Array(T).new size) do |bucket, a|\n      a.concat\
    \ bucket\n    end\n  end\n\n  def to_s(io : IO) : Nil\n    io << \"SMultiSet::Bucket{\"\
    \n    join(\", \", io)\n    io << \"}\"\n  end\n\n  def inspect(io : IO) : Nil\n\
    \    @buckets.inspect(io)\n  end\nend\n\nprivate alias S = SMultiSet::Bucket(Int32,\
    \ 1, 170, 1)\n\ndescribe \"SMultiSet::Bucket(Int32)\" do\n  it \"{}\" do\n   \
    \ S{3, 1, 4, 1, 5}.to_a.should eq [1, 1, 3, 4, 5]\n  end\n\n  it \".new\" do\n\
    \    s = S.new [1, 2, 1, 3, 4]\n    s.to_a.should eq [1, 1, 2, 3, 4]\n  end\n\n\
    \  it \"#size\" do\n    s = S.new\n    s.size.should eq 0\n    s.add 1\n    s.size.should\
    \ eq 1\n    s.add 1\n    s.size.should eq 2\n    s.delete 1\n    s.size.should\
    \ eq 1\n  end\n\n  it \"#empty?\" do\n    s = S.new\n    s.empty?.should be_true\n\
    \    s.add 1\n    s.empty?.should be_false\n  end\n\n  it \"#clear\" do\n    s\
    \ = S.new\n    s.add 1\n    s.clear.size.should eq 0\n  end\n\n  it \"#add, #<<\"\
    \ do\n    s = S.new\n    s.add(1).add(2).add(1)\n    s.size.should eq 3\n    s\
    \ << 3 << 4 << 3\n    s.size.should eq 6\n  end\n\n  it \"#min?, #min, #max?,\
    \ #max\" do\n    s = S.new\n    s.min?.should be_nil\n    s.max?.should be_nil\n\
    \    expect_raises(S::EmptyError) { s.min }\n    expect_raises(S::EmptyError)\
    \ { s.max }\n    s << 1 << 2\n    s.min?.should eq 1\n    s.max?.should eq 2\n\
    \    s.min.should eq 1\n    s.max.should eq 2\n  end\n\n  it \"#each\" do\n  \
    \  s = S{3, 1, 4, 1, 5}\n\n    a = [] of Int32\n    s.each { |x| a << x }\n  \
    \  a.should eq [1, 1, 3, 4, 5]\n\n    a.each.to_a.should eq [1, 1, 3, 4, 5]\n\
    \  end\n\n  it \"#reverse_each\" do\n    s = S{3, 1, 4, 1, 5}\n\n    a = [] of\
    \ Int32\n    s.reverse_each { |x| a << x }\n    a.should eq [5, 4, 3, 1, 1]\n\
    \  end\n\n  it \"#[]\" do\n    s = S{3, 1, 4, 1, 5}\n    [1, 1, 3, 4, 5, 1, 1,\
    \ 3, 4, 5].each_with_index(-5) do |x, i|\n      s[i].should eq x\n    end\n  \
    \  expect_raises(IndexError) { s[5] }\n    expect_raises(IndexError) { s[-6] }\n\
    \  end\n\n  it \"#includes?\" do\n    s = S{1, 3, 3, 5}\n    {1, 3, 5}.each {\
    \ |x| s.includes?(x).should be_true }\n    {0, 2, 4}.each { |x| s.includes?(x).should\
    \ be_false }\n  end\n\n  it \"#index\" do\n    s = S{1, 1, 2, 3, 4}\n    [nil,\
    \ 0, 2, 3, 4, nil].each_with_index do |expected, x|\n      s.index(x).should eq\
    \ expected\n    end\n  end\n\n  it \"#index_left, #index_right\" do\n    s = S{1,\
    \ 1, 2, 3, 4}\n    [{0, 0}, {0, 2}, {2, 3}, {3, 4}, {4, 5}, {5, 5}].each_with_index\
    \ do |(l, r), x|\n      s.index_left(x).should eq l\n      s.index_right(x).should\
    \ eq r\n    end\n  end\n\n  it \"#count\" do\n    s = S{1, 1, 2, 3, 4}\n    [0,\
    \ 2, 1, 1, 1, 0].each_with_index do |c, x|\n      s.count(x).should eq c\n   \
    \ end\n  end\n\n  it \"#le, #le!\" do\n    s = S{1, 3, 3}\n    [nil, 1, 1, 3,\
    \ 3].each_with_index { |e, x| s.le(x).should eq e }\n    expect_raises(NilAssertionError)\
    \ { s.le!(0) }\n    [1, 1, 3, 3].each_with_index(1) { |e, x| s.le!(x).should eq\
    \ e }\n  end\n\n  it \"#lt, #lt!\" do\n    s = S{1, 3, 3}\n    [nil, nil, 1, 1,\
    \ 3, 3].each_with_index { |e, x| s.lt(x).should eq e }\n    expect_raises(NilAssertionError)\
    \ { s.lt!(0) }\n    expect_raises(NilAssertionError) { s.lt!(1) }\n    [1, 1,\
    \ 3, 3].each_with_index(2) { |e, x| s.lt!(x).should eq e }\n  end\n\n  it \"#ge,\
    \ #ge!\" do\n    s = S{1, 3, 3}\n    [1, 1, 3, 3, nil].each_with_index { |e, x|\
    \ s.ge(x).should eq e }\n    expect_raises(NilAssertionError) { s.ge!(4) }\n \
    \   [1, 1, 3, 3].each_with_index { |e, x| s.ge!(x).should eq e }\n  end\n\n  it\
    \ \"#gt, #gt!\" do\n    s = S{1, 3, 3}\n    [1, 3, 3, nil, nil].each_with_index\
    \ { |e, x| s.gt(x).should eq e }\n    expect_raises(NilAssertionError) { s.gt!(3)\
    \ }\n    expect_raises(NilAssertionError) { s.gt!(4) }\n    [1, 3, 3].each_with_index\
    \ { |e, x| s.gt!(x).should eq e }\n  end\n\n  {% for op in [:&, :|, :+, :-] %}\n\
    \    it \"\\#{{op.id}}\" do\n      a = S{0, 1, 2, 2, 3}\n      b = {1, 1, 2, 3,\
    \ 4, 5}\n      expected = a.to_set {{op.id}} b.to_set\n      (a {{op.id}} b).to_a.should\
    \ eq expected.to_a\n    end\n  {% end %}\n\n  it \"#to_a\" do\n    s = S{1, 3,\
    \ 2, 4, 2}\n    s.to_a.should eq [1, 2, 2, 3, 4]\n  end\n\n  it \"#to_s\" do\n\
    \    s = S{1, 2, 3, 4, 2}\n    s.to_s.should eq \"SMultiSet::Bucket{1, 2, 2, 3,\
    \ 4}\"\n  end\n\n  it \"includes Enumerable\" do\n    s = S{1, 2, 3, 4, 2}\n \
    \   s.all? { |x| x > 0 }.should be_true\n  end\n\n  it \"includes Iterable\" do\n\
    \    s = S{1, 2, 3, 4, 2}\n    s.cycle(2).to_a.should eq [1, 2, 2, 3, 4, 1, 2,\
    \ 2, 3, 4]\n  end\n\n  it \"includes Indexable\" do\n    s = S{1, 2, 3, 4, 2}\n\
    \    s.values_at(0, 1, 2, 3, 4).should eq({1, 2, 2, 3, 4})\n  end\nend\n"
  code: "require \"spec\"\nrequire \"../../../src/datastructure/smultiset/bucket\"\
    \n\nprivate alias S = SMultiSet::Bucket(Int32, 1, 170, 1)\n\ndescribe \"SMultiSet::Bucket(Int32)\"\
    \ do\n  it \"{}\" do\n    S{3, 1, 4, 1, 5}.to_a.should eq [1, 1, 3, 4, 5]\n  end\n\
    \n  it \".new\" do\n    s = S.new [1, 2, 1, 3, 4]\n    s.to_a.should eq [1, 1,\
    \ 2, 3, 4]\n  end\n\n  it \"#size\" do\n    s = S.new\n    s.size.should eq 0\n\
    \    s.add 1\n    s.size.should eq 1\n    s.add 1\n    s.size.should eq 2\n  \
    \  s.delete 1\n    s.size.should eq 1\n  end\n\n  it \"#empty?\" do\n    s = S.new\n\
    \    s.empty?.should be_true\n    s.add 1\n    s.empty?.should be_false\n  end\n\
    \n  it \"#clear\" do\n    s = S.new\n    s.add 1\n    s.clear.size.should eq 0\n\
    \  end\n\n  it \"#add, #<<\" do\n    s = S.new\n    s.add(1).add(2).add(1)\n \
    \   s.size.should eq 3\n    s << 3 << 4 << 3\n    s.size.should eq 6\n  end\n\n\
    \  it \"#min?, #min, #max?, #max\" do\n    s = S.new\n    s.min?.should be_nil\n\
    \    s.max?.should be_nil\n    expect_raises(S::EmptyError) { s.min }\n    expect_raises(S::EmptyError)\
    \ { s.max }\n    s << 1 << 2\n    s.min?.should eq 1\n    s.max?.should eq 2\n\
    \    s.min.should eq 1\n    s.max.should eq 2\n  end\n\n  it \"#each\" do\n  \
    \  s = S{3, 1, 4, 1, 5}\n\n    a = [] of Int32\n    s.each { |x| a << x }\n  \
    \  a.should eq [1, 1, 3, 4, 5]\n\n    a.each.to_a.should eq [1, 1, 3, 4, 5]\n\
    \  end\n\n  it \"#reverse_each\" do\n    s = S{3, 1, 4, 1, 5}\n\n    a = [] of\
    \ Int32\n    s.reverse_each { |x| a << x }\n    a.should eq [5, 4, 3, 1, 1]\n\
    \  end\n\n  it \"#[]\" do\n    s = S{3, 1, 4, 1, 5}\n    [1, 1, 3, 4, 5, 1, 1,\
    \ 3, 4, 5].each_with_index(-5) do |x, i|\n      s[i].should eq x\n    end\n  \
    \  expect_raises(IndexError) { s[5] }\n    expect_raises(IndexError) { s[-6] }\n\
    \  end\n\n  it \"#includes?\" do\n    s = S{1, 3, 3, 5}\n    {1, 3, 5}.each {\
    \ |x| s.includes?(x).should be_true }\n    {0, 2, 4}.each { |x| s.includes?(x).should\
    \ be_false }\n  end\n\n  it \"#index\" do\n    s = S{1, 1, 2, 3, 4}\n    [nil,\
    \ 0, 2, 3, 4, nil].each_with_index do |expected, x|\n      s.index(x).should eq\
    \ expected\n    end\n  end\n\n  it \"#index_left, #index_right\" do\n    s = S{1,\
    \ 1, 2, 3, 4}\n    [{0, 0}, {0, 2}, {2, 3}, {3, 4}, {4, 5}, {5, 5}].each_with_index\
    \ do |(l, r), x|\n      s.index_left(x).should eq l\n      s.index_right(x).should\
    \ eq r\n    end\n  end\n\n  it \"#count\" do\n    s = S{1, 1, 2, 3, 4}\n    [0,\
    \ 2, 1, 1, 1, 0].each_with_index do |c, x|\n      s.count(x).should eq c\n   \
    \ end\n  end\n\n  it \"#le, #le!\" do\n    s = S{1, 3, 3}\n    [nil, 1, 1, 3,\
    \ 3].each_with_index { |e, x| s.le(x).should eq e }\n    expect_raises(NilAssertionError)\
    \ { s.le!(0) }\n    [1, 1, 3, 3].each_with_index(1) { |e, x| s.le!(x).should eq\
    \ e }\n  end\n\n  it \"#lt, #lt!\" do\n    s = S{1, 3, 3}\n    [nil, nil, 1, 1,\
    \ 3, 3].each_with_index { |e, x| s.lt(x).should eq e }\n    expect_raises(NilAssertionError)\
    \ { s.lt!(0) }\n    expect_raises(NilAssertionError) { s.lt!(1) }\n    [1, 1,\
    \ 3, 3].each_with_index(2) { |e, x| s.lt!(x).should eq e }\n  end\n\n  it \"#ge,\
    \ #ge!\" do\n    s = S{1, 3, 3}\n    [1, 1, 3, 3, nil].each_with_index { |e, x|\
    \ s.ge(x).should eq e }\n    expect_raises(NilAssertionError) { s.ge!(4) }\n \
    \   [1, 1, 3, 3].each_with_index { |e, x| s.ge!(x).should eq e }\n  end\n\n  it\
    \ \"#gt, #gt!\" do\n    s = S{1, 3, 3}\n    [1, 3, 3, nil, nil].each_with_index\
    \ { |e, x| s.gt(x).should eq e }\n    expect_raises(NilAssertionError) { s.gt!(3)\
    \ }\n    expect_raises(NilAssertionError) { s.gt!(4) }\n    [1, 3, 3].each_with_index\
    \ { |e, x| s.gt!(x).should eq e }\n  end\n\n  {% for op in [:&, :|, :+, :-] %}\n\
    \    it \"\\#{{op.id}}\" do\n      a = S{0, 1, 2, 2, 3}\n      b = {1, 1, 2, 3,\
    \ 4, 5}\n      expected = a.to_set {{op.id}} b.to_set\n      (a {{op.id}} b).to_a.should\
    \ eq expected.to_a\n    end\n  {% end %}\n\n  it \"#to_a\" do\n    s = S{1, 3,\
    \ 2, 4, 2}\n    s.to_a.should eq [1, 2, 2, 3, 4]\n  end\n\n  it \"#to_s\" do\n\
    \    s = S{1, 2, 3, 4, 2}\n    s.to_s.should eq \"SMultiSet::Bucket{1, 2, 2, 3,\
    \ 4}\"\n  end\n\n  it \"includes Enumerable\" do\n    s = S{1, 2, 3, 4, 2}\n \
    \   s.all? { |x| x > 0 }.should be_true\n  end\n\n  it \"includes Iterable\" do\n\
    \    s = S{1, 2, 3, 4, 2}\n    s.cycle(2).to_a.should eq [1, 2, 2, 3, 4, 1, 2,\
    \ 2, 3, 4]\n  end\n\n  it \"includes Indexable\" do\n    s = S{1, 2, 3, 4, 2}\n\
    \    s.values_at(0, 1, 2, 3, 4).should eq({1, 2, 2, 3, 4})\n  end\nend\n"
  dependsOn:
  - src/datastructure/smultiset/bucket.cr
  isVerificationFile: false
  path: spec/datastructure/smultiset/bucket_spec.cr
  requiredBy: []
  timestamp: '2022-01-22 15:32:00+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/datastructure/smultiset/bucket_spec.cr
layout: document
redirect_from:
- /library/spec/datastructure/smultiset/bucket_spec.cr
- /library/spec/datastructure/smultiset/bucket_spec.cr.html
title: spec/datastructure/smultiset/bucket_spec.cr
---
