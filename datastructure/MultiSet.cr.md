---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/MultiSet_spec.cr
    title: spec/MultiSet_spec.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "class MultiSet(T)\n  include Iterable(T)\n  include Enumerable(T)\n\
    \n  @count = Hash(T, Int32).new(0)\n  getter size = 0\n\n  def initialize\n  end\n\
    \n  def initialize(enumerable : Enumerable(T))\n    concat enumerable\n  end\n\
    \n  def kind_count\n    @count.size\n  end\n\n  def add(object : T)\n    @count[object]\
    \ += 1\n    @size += 1\n    self\n  end\n\n  def add(object : T, count : Int32)\n\
    \    raise ArgumentError.new unless count >= 0\n    return self if count == 0\n\
    \    @count[object] += count\n    @size += count\n    self\n  end\n\n  def <<(object\
    \ : T)\n    add object\n  end\n\n  def delete(object : T)\n    if flag = @count[object]\
    \ > 0\n      @count[object] -= 1\n      @count.delete(object) if @count[object]\
    \ == 0\n    end\n    flag\n  end\n\n  def delete(object : T, count : Int32)\n\
    \    raise ArgumentError.new unless count >= 0\n    if flag = @count[object] >\
    \ 0\n      @count[object] = {0, @count[object] - count}.max\n      @count.delete(object)\
    \ if @count[object] == 0\n    end\n  end\n\n  def concat(elems)\n    elems.each\
    \ { |elem| self << elem }\n    self\n  end\n\n  def clear\n    @count.clear\n\
    \    @size = 0\n  end\n\n  def count(object : T)\n    @count[object]\n  end\n\n\
    \  def empty?\n    size == 0\n  end\n\n  def includes?(object : T)\n    @count[object]\
    \ > 0\n  end\n\n  def intersects?(other : MultiSet(T))\n    if kind_count < other.kind_count\n\
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
    \  end\n\n  def inspect(io : IO)\n    io << '['\n    each.join(io, \", \")\n \
    \   io << ']'\n  end\nend\n"
  code: "class MultiSet(T)\n  include Iterable(T)\n  include Enumerable(T)\n\n  @count\
    \ = Hash(T, Int32).new(0)\n  getter size = 0\n\n  def initialize\n  end\n\n  def\
    \ initialize(enumerable : Enumerable(T))\n    concat enumerable\n  end\n\n  def\
    \ kind_count\n    @count.size\n  end\n\n  def add(object : T)\n    @count[object]\
    \ += 1\n    @size += 1\n    self\n  end\n\n  def add(object : T, count : Int32)\n\
    \    raise ArgumentError.new unless count >= 0\n    return self if count == 0\n\
    \    @count[object] += count\n    @size += count\n    self\n  end\n\n  def <<(object\
    \ : T)\n    add object\n  end\n\n  def delete(object : T)\n    if flag = @count[object]\
    \ > 0\n      @count[object] -= 1\n      @count.delete(object) if @count[object]\
    \ == 0\n    end\n    flag\n  end\n\n  def delete(object : T, count : Int32)\n\
    \    raise ArgumentError.new unless count >= 0\n    if flag = @count[object] >\
    \ 0\n      @count[object] = {0, @count[object] - count}.max\n      @count.delete(object)\
    \ if @count[object] == 0\n    end\n  end\n\n  def concat(elems)\n    elems.each\
    \ { |elem| self << elem }\n    self\n  end\n\n  def clear\n    @count.clear\n\
    \    @size = 0\n  end\n\n  def count(object : T)\n    @count[object]\n  end\n\n\
    \  def empty?\n    size == 0\n  end\n\n  def includes?(object : T)\n    @count[object]\
    \ > 0\n  end\n\n  def intersects?(other : MultiSet(T))\n    if kind_count < other.kind_count\n\
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
    \  end\n\n  def inspect(io : IO)\n    io << '['\n    each.join(io, \", \")\n \
    \   io << ']'\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: datastructure/MultiSet.cr
  requiredBy:
  - spec/MultiSet_spec.cr
  timestamp: '2021-06-23 22:18:21+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: datastructure/MultiSet.cr
layout: document
redirect_from:
- /library/datastructure/MultiSet.cr
- /library/datastructure/MultiSet.cr.html
title: datastructure/MultiSet.cr
---
