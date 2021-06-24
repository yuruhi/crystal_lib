---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: datastructure/MultiSet.cr
    title: datastructure/MultiSet.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../datastructure/MultiSet\"\nclass\
    \ MultiSet(T)\n  include Iterable(T)\n  include Enumerable(T)\n\n  @count = Hash(T,\
    \ Int32).new(0)\n  getter size = 0\n\n  def initialize\n  end\n\n  def initialize(enumerable\
    \ : Enumerable(T))\n    concat enumerable\n  end\n\n  def kind_count\n    @count.size\n\
    \  end\n\n  def add(object : T)\n    @count[object] += 1\n    @size += 1\n   \
    \ self\n  end\n\n  def add(object : T, count : Int32)\n    raise ArgumentError.new\
    \ unless count >= 0\n    return self if count == 0\n    @count[object] += count\n\
    \    @size += count\n    self\n  end\n\n  def <<(object : T)\n    add object\n\
    \  end\n\n  def delete(object : T)\n    if flag = @count[object] > 0\n      @count[object]\
    \ -= 1\n      @count.delete(object) if @count[object] == 0\n    end\n    flag\n\
    \  end\n\n  def delete(object : T, count : Int32)\n    raise ArgumentError.new\
    \ unless count >= 0\n    if flag = @count[object] > 0\n      @count[object] =\
    \ {0, @count[object] - count}.max\n      @count.delete(object) if @count[object]\
    \ == 0\n    end\n  end\n\n  def concat(elems)\n    elems.each { |elem| self <<\
    \ elem }\n    self\n  end\n\n  def clear\n    @count.clear\n    @size = 0\n  end\n\
    \n  def count(object : T)\n    @count[object]\n  end\n\n  def empty?\n    size\
    \ == 0\n  end\n\n  def includes?(object : T)\n    @count[object] > 0\n  end\n\n\
    \  def intersects?(other : MultiSet(T))\n    if kind_count < other.kind_count\n\
    \      any? { |o| other.includes?(o) }\n    else\n      other.any? { |o| includes?(o)\
    \ }\n    end\n  end\n\n  def subset_of?(other : MultiSet(T))\n    return false\
    \ if other.size < size\n    all? { |o| other.includes?(o) }\n  end\n\n  def superset_of?(other\
    \ : MultiSet(T))\n    other.subset_of?(self)\n  end\n\n  private class MultiSetIterator(T)\n\
    \    include Iterator(T)\n    include IteratorWrapper\n\n    @iterator : Iterator({T,\
    \ Int32})\n    @value : Tuple(T?, Int32)\n\n    def initialize(count : Hash(T,\
    \ Int32))\n      @iterator = count.each\n      @value = {nil, 0}\n    end\n\n\
    \    def next\n      until @value[1] > 0\n        @value = wrapped_next\n    \
    \  end\n      @value = {@value[0], @value[1] - 1}\n      @value[0].not_nil!\n\
    \    end\n  end\n\n  def each\n    MultiSetIterator(T).new(@count)\n  end\n\n\
    \  def each(&) : Nil\n    @count.each do |(elem, cnt)|\n      cnt.times { yield\
    \ elem }\n    end\n  end\n\n  def each_count\n    @count.each\n  end\n\n  def\
    \ each_count(&) : Nil\n    @count.each do |(elem, cnt)|\n      yield({elem, cnt})\n\
    \    end\n  end\n\n  def &(other : MultiSet(T))\n    small, large = self, other\n\
    \    if large.kind_count < small.kind_count\n      small, large = large, small\n\
    \    end\n\n    result = MultiSet(T).new\n    small.each_count do |elem, cnt|\n\
    \      result.add elem, Math.min(cnt, large.count(elem))\n    end\n    result\n\
    \  end\n\n  def |(other : MultiSet(U)) forall U\n    result = MultiSet(T | U).new\n\
    \    each_count { |(elem, cnt)| result.add elem, cnt }\n    other.each_count {\
    \ |(elem, cnt)| result.add elem, cnt }\n    result\n  end\n\n  def +(other : MultiSet(U))\
    \ forall U\n    self | other\n  end\n\n  def to_s(io : IO)\n    io << @count\n\
    \  end\n\n  def inspect(io : IO)\n    io << '['\n    each.join(\", \", io)\n \
    \   io << ']'\n  end\nend\n\ndescribe \"MultiSet\" do\n  it \"initialize\" do\n\
    \    MultiSet(Int32).new.to_s.should eq \"{}\"\n    MultiSet.new([0, 1, 2, 2]).to_s.should\
    \ eq \"{0 => 1, 1 => 1, 2 => 2}\"\n    MultiSet{0, 1, 2, 2}.to_s.should eq \"\
    {0 => 1, 1 => 1, 2 => 2}\"\n  end\n\n  it \"size\" do\n    MultiSet{0, 0, 0, 1,\
    \ 1, 2}.size.should eq 6\n    MultiSet(Int32).new.size.should eq 0\n  end\n\n\
    \  it \"kind_count\" do\n    MultiSet{0, 0, 1, 2}.kind_count.should eq 3\n   \
    \ MultiSet(Int32).new.kind_count.should eq 0\n  end\n\n  it \"add\" do\n    a\
    \ = MultiSet(Int32).new\n    a.add 1\n    a.add 2\n    a << 1\n    a.to_s.should\
    \ eq \"{1 => 2, 2 => 1}\"\n\n    a.add 3, 5\n    a.add 2, 3\n    a.to_s.should\
    \ eq \"{1 => 2, 2 => 4, 3 => 5}\"\n  end\n\n  it \"delete\" do\n    a = MultiSet{1,\
    \ 1, 1, 1, 1, 2, 2, 3}\n    a.delete 2\n    a.to_s.should eq \"{1 => 5, 2 => 1,\
    \ 3 => 1}\"\n    a.delete 1, 3\n    a.to_s.should eq \"{1 => 2, 2 => 1, 3 => 1}\"\
    \n  end\n\n  it \"concat\" do\n    a = MultiSet{1, 1, 1, 1, 1, 2, 2, 3}\n    a.concat\
    \ a\n    a.to_s.should eq \"{1 => 10, 2 => 4, 3 => 2}\"\n    a.concat({0, 0, 0,\
    \ 1, 2, 3})\n    a.to_s.should eq \"{1 => 11, 2 => 5, 3 => 3, 0 => 3}\"\n  end\n\
    \n  it \"clear\" do\n    a = MultiSet{0, 0, 1, 1}\n    a.clear\n  end\n\n  it\
    \ \"count\" do\n    a = MultiSet{0, 0, 0, 1, 1, 2}\n    a.count(0).should eq 3\n\
    \    a.count(1).should eq 2\n    a.count(2).should eq 1\n    a.count(3).should\
    \ eq 0\n  end\n\n  it \"includes?\" do\n    a = MultiSet{0, 0, 0, 1, 1, 2}\n \
    \   a.includes?(0).should eq true\n    a.includes?(1).should eq true\n    a.includes?(2).should\
    \ eq true\n    a.includes?(3).should eq false\n  end\n\n  it \"empty?\" do\n \
    \   MultiSet{0, 0, 0, 1, 1, 2}.empty?.should eq false\n    MultiSet(Int32).new.empty?.should\
    \ eq true\n  end\n\n  it \"intersects?\" do\n    a = MultiSet{0, 0, 0, 1, 1, 2}\n\
    \    b = MultiSet{2, 3}\n    c = MultiSet{3, 3, 3, 4, 4, 5}\n    a.intersects?(b).should\
    \ eq true\n    b.intersects?(c).should eq true\n    a.intersects?(c).should eq\
    \ false\n  end\n\n  it \"subset_of?\" do\n    a = MultiSet{0, 0, 0, 1, 1, 2}\n\
    \    b = MultiSet{0, 1, 0}\n    c = MultiSet{-1, 0, 0, 1}\n    a.subset_of?(b).should\
    \ eq false\n    b.subset_of?(a).should eq true\n    c.subset_of?(a).should eq\
    \ false\n  end\n\n  it \"superset_of?\" do\n    a = MultiSet{0, 0, 0, 1, 1, 2}\n\
    \    b = MultiSet{0, 1, 0}\n    c = MultiSet{-1, 0, 0, 1}\n    a.superset_of?(b).should\
    \ eq true\n    b.superset_of?(a).should eq false\n    c.superset_of?(a).should\
    \ eq false\n  end\n\n  it \"each\" do\n    a = MultiSet{0, 0, 0, 1, 1, 2}\n  \
    \  a.each.to_a.should eq [0, 0, 0, 1, 1, 2]\n    a.each.max.should eq 2\n  end\n\
    \n  it \"each(&)\" do\n    a = [] of Int32\n    MultiSet{0, 0, 0, 1, 1, 2}.each\
    \ do |elem|\n      a << elem\n    end\n    a.should eq [0, 0, 0, 1, 1, 2]\n  end\n\
    \n  it \"each_count\" do\n    MultiSet{0, 0, 0, 1, 1, 2}.each_count.max.should\
    \ eq({2, 1})\n  end\n\n  it \"each_count(&)\" do\n    a = [] of {Int32, Int32}\n\
    \    MultiSet{0, 0, 0, 1, 1, 2}.each_count do |(elem, cnt)|\n      a << {elem,\
    \ cnt}\n    end\n    a.should eq [{0, 3}, {1, 2}, {2, 1}]\n  end\n\n  it \"&\"\
    \ do\n    a = MultiSet{0, 0, 0, 1, 1, 2, 3}\n    b = MultiSet{0, 1, 1, 2, 2, 2}\n\
    \    (a & b).to_s.should eq \"{0 => 1, 1 => 2, 2 => 1}\"\n  end\n\n  it \"|\"\
    \ do\n    a = MultiSet{0, 0, 0, 1, 1, 2, 3}\n    b = MultiSet{0, 1, 1, 2, 2, 2}\n\
    \    (a | b).to_s.should eq \"{0 => 4, 1 => 4, 2 => 4, 3 => 1}\"\n    (a + b).to_s.should\
    \ eq \"{0 => 4, 1 => 4, 2 => 4, 3 => 1}\"\n  end\n\n  it \"to_s\" do\n    MultiSet{0,\
    \ 0, 0, 1, 1, 2}.to_s.should eq \"{0 => 3, 1 => 2, 2 => 1}\"\n  end\n\n  it \"\
    inspect\" do\n    io = IO::Memory.new\n    MultiSet{0, 0, 0, 1, 1, 2}.inspect(io)\n\
    \    io.to_s.should eq \"[0, 0, 0, 1, 1, 2]\"\n  end\n\n  it \"Iterable\" do\n\
    \    MultiSet{0, 0, 0, 1, 1, 2}.each_slice(3).to_a.should eq [[0, 0, 0], [1, 1,\
    \ 2]]\n    MultiSet{0, 0, 0, 1, 1, 2}.each_cons(2).select { |(i, j)| i != j }.to_a.should\
    \ eq [[0, 1], [1, 2]]\n  end\n\n  it \"Enumeratable\" do\n    MultiSet{0, 0, 0,\
    \ 1, 1, 2}.all?(&.even?).should eq false\n    MultiSet{0, 0, 0, 1, 1, 2}.all?\
    \ { |i| i >= 0 }.should eq true\n    MultiSet{0, 0, 0, 1, 1, 2}.max.should eq\
    \ 2\n    MultiSet{\"a\", \"ab\", \"abc\", \"abcd\"}.max_by(&.size).should eq \"\
    abcd\"\n    MultiSet{0, 0, 0, 1, 1, 2}.first.should eq 0\n    MultiSet{0, 0, 0,\
    \ 1, 1, 2}.index(1).should eq 3\n    MultiSet{0, 0, 0, 1, 1, 2}.join.should eq\
    \ \"000112\"\n  end\nend\n"
  code: "require \"spec\"\nrequire \"../datastructure/MultiSet\"\n\ndescribe \"MultiSet\"\
    \ do\n  it \"initialize\" do\n    MultiSet(Int32).new.to_s.should eq \"{}\"\n\
    \    MultiSet.new([0, 1, 2, 2]).to_s.should eq \"{0 => 1, 1 => 1, 2 => 2}\"\n\
    \    MultiSet{0, 1, 2, 2}.to_s.should eq \"{0 => 1, 1 => 1, 2 => 2}\"\n  end\n\
    \n  it \"size\" do\n    MultiSet{0, 0, 0, 1, 1, 2}.size.should eq 6\n    MultiSet(Int32).new.size.should\
    \ eq 0\n  end\n\n  it \"kind_count\" do\n    MultiSet{0, 0, 1, 2}.kind_count.should\
    \ eq 3\n    MultiSet(Int32).new.kind_count.should eq 0\n  end\n\n  it \"add\"\
    \ do\n    a = MultiSet(Int32).new\n    a.add 1\n    a.add 2\n    a << 1\n    a.to_s.should\
    \ eq \"{1 => 2, 2 => 1}\"\n\n    a.add 3, 5\n    a.add 2, 3\n    a.to_s.should\
    \ eq \"{1 => 2, 2 => 4, 3 => 5}\"\n  end\n\n  it \"delete\" do\n    a = MultiSet{1,\
    \ 1, 1, 1, 1, 2, 2, 3}\n    a.delete 2\n    a.to_s.should eq \"{1 => 5, 2 => 1,\
    \ 3 => 1}\"\n    a.delete 1, 3\n    a.to_s.should eq \"{1 => 2, 2 => 1, 3 => 1}\"\
    \n  end\n\n  it \"concat\" do\n    a = MultiSet{1, 1, 1, 1, 1, 2, 2, 3}\n    a.concat\
    \ a\n    a.to_s.should eq \"{1 => 10, 2 => 4, 3 => 2}\"\n    a.concat({0, 0, 0,\
    \ 1, 2, 3})\n    a.to_s.should eq \"{1 => 11, 2 => 5, 3 => 3, 0 => 3}\"\n  end\n\
    \n  it \"clear\" do\n    a = MultiSet{0, 0, 1, 1}\n    a.clear\n  end\n\n  it\
    \ \"count\" do\n    a = MultiSet{0, 0, 0, 1, 1, 2}\n    a.count(0).should eq 3\n\
    \    a.count(1).should eq 2\n    a.count(2).should eq 1\n    a.count(3).should\
    \ eq 0\n  end\n\n  it \"includes?\" do\n    a = MultiSet{0, 0, 0, 1, 1, 2}\n \
    \   a.includes?(0).should eq true\n    a.includes?(1).should eq true\n    a.includes?(2).should\
    \ eq true\n    a.includes?(3).should eq false\n  end\n\n  it \"empty?\" do\n \
    \   MultiSet{0, 0, 0, 1, 1, 2}.empty?.should eq false\n    MultiSet(Int32).new.empty?.should\
    \ eq true\n  end\n\n  it \"intersects?\" do\n    a = MultiSet{0, 0, 0, 1, 1, 2}\n\
    \    b = MultiSet{2, 3}\n    c = MultiSet{3, 3, 3, 4, 4, 5}\n    a.intersects?(b).should\
    \ eq true\n    b.intersects?(c).should eq true\n    a.intersects?(c).should eq\
    \ false\n  end\n\n  it \"subset_of?\" do\n    a = MultiSet{0, 0, 0, 1, 1, 2}\n\
    \    b = MultiSet{0, 1, 0}\n    c = MultiSet{-1, 0, 0, 1}\n    a.subset_of?(b).should\
    \ eq false\n    b.subset_of?(a).should eq true\n    c.subset_of?(a).should eq\
    \ false\n  end\n\n  it \"superset_of?\" do\n    a = MultiSet{0, 0, 0, 1, 1, 2}\n\
    \    b = MultiSet{0, 1, 0}\n    c = MultiSet{-1, 0, 0, 1}\n    a.superset_of?(b).should\
    \ eq true\n    b.superset_of?(a).should eq false\n    c.superset_of?(a).should\
    \ eq false\n  end\n\n  it \"each\" do\n    a = MultiSet{0, 0, 0, 1, 1, 2}\n  \
    \  a.each.to_a.should eq [0, 0, 0, 1, 1, 2]\n    a.each.max.should eq 2\n  end\n\
    \n  it \"each(&)\" do\n    a = [] of Int32\n    MultiSet{0, 0, 0, 1, 1, 2}.each\
    \ do |elem|\n      a << elem\n    end\n    a.should eq [0, 0, 0, 1, 1, 2]\n  end\n\
    \n  it \"each_count\" do\n    MultiSet{0, 0, 0, 1, 1, 2}.each_count.max.should\
    \ eq({2, 1})\n  end\n\n  it \"each_count(&)\" do\n    a = [] of {Int32, Int32}\n\
    \    MultiSet{0, 0, 0, 1, 1, 2}.each_count do |(elem, cnt)|\n      a << {elem,\
    \ cnt}\n    end\n    a.should eq [{0, 3}, {1, 2}, {2, 1}]\n  end\n\n  it \"&\"\
    \ do\n    a = MultiSet{0, 0, 0, 1, 1, 2, 3}\n    b = MultiSet{0, 1, 1, 2, 2, 2}\n\
    \    (a & b).to_s.should eq \"{0 => 1, 1 => 2, 2 => 1}\"\n  end\n\n  it \"|\"\
    \ do\n    a = MultiSet{0, 0, 0, 1, 1, 2, 3}\n    b = MultiSet{0, 1, 1, 2, 2, 2}\n\
    \    (a | b).to_s.should eq \"{0 => 4, 1 => 4, 2 => 4, 3 => 1}\"\n    (a + b).to_s.should\
    \ eq \"{0 => 4, 1 => 4, 2 => 4, 3 => 1}\"\n  end\n\n  it \"to_s\" do\n    MultiSet{0,\
    \ 0, 0, 1, 1, 2}.to_s.should eq \"{0 => 3, 1 => 2, 2 => 1}\"\n  end\n\n  it \"\
    inspect\" do\n    io = IO::Memory.new\n    MultiSet{0, 0, 0, 1, 1, 2}.inspect(io)\n\
    \    io.to_s.should eq \"[0, 0, 0, 1, 1, 2]\"\n  end\n\n  it \"Iterable\" do\n\
    \    MultiSet{0, 0, 0, 1, 1, 2}.each_slice(3).to_a.should eq [[0, 0, 0], [1, 1,\
    \ 2]]\n    MultiSet{0, 0, 0, 1, 1, 2}.each_cons(2).select { |(i, j)| i != j }.to_a.should\
    \ eq [[0, 1], [1, 2]]\n  end\n\n  it \"Enumeratable\" do\n    MultiSet{0, 0, 0,\
    \ 1, 1, 2}.all?(&.even?).should eq false\n    MultiSet{0, 0, 0, 1, 1, 2}.all?\
    \ { |i| i >= 0 }.should eq true\n    MultiSet{0, 0, 0, 1, 1, 2}.max.should eq\
    \ 2\n    MultiSet{\"a\", \"ab\", \"abc\", \"abcd\"}.max_by(&.size).should eq \"\
    abcd\"\n    MultiSet{0, 0, 0, 1, 1, 2}.first.should eq 0\n    MultiSet{0, 0, 0,\
    \ 1, 1, 2}.index(1).should eq 3\n    MultiSet{0, 0, 0, 1, 1, 2}.join.should eq\
    \ \"000112\"\n  end\nend\n"
  dependsOn:
  - datastructure/MultiSet.cr
  isVerificationFile: false
  path: spec/MultiSet_spec.cr
  requiredBy: []
  timestamp: '2021-06-24 10:02:07+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/MultiSet_spec.cr
layout: document
redirect_from:
- /library/spec/MultiSet_spec.cr
- /library/spec/MultiSet_spec.cr.html
title: spec/MultiSet_spec.cr
---
