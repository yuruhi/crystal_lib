---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/datastructure/multi_set_spec.cr
    title: spec/datastructure/multi_set_spec.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "class MultiSet(T)\n  include Iterable(T)\n  include Enumerable(T)\n\
    \n  @count = Hash(T, Int32).new(0)\n  @size = 0\n\n  # Returns the additive identity\
    \ of this type.\n  #\n  # This is an empty multiset\n  def self.additive_identify\
    \ : self\n    new\n  end\n\n  # Creates a new, empty multiset.\n  def initialize\n\
    \  end\n\n  # Creates a new multiset from the elements in *enumerable*.\n  def\
    \ initialize(enumerable : Enumerable(T))\n    concat enumerable\n  end\n\n  #\
    \ Returns the number of elements in the set.\n  def size : Int32\n    @size\n\
    \  end\n\n  # Returns the number of kinds in the multiset.\n  def kind_count :\
    \ Int32\n    @count.size\n  end\n\n  # Returns `true` if the multiset is empty.\n\
    \  def empty? : Bool\n    size == 0\n  end\n\n  # Returns `true` if *object* exists\
    \ in the multiset.\n  def includes?(object : T) : Bool\n    @count[object] > 0\n\
    \  end\n\n  # Same as `includes?`\n  def ===(object : T) : Bool\n    includes?(object)\n\
    \  end\n\n  # Returns the number of times that the *object* is present in the\
    \ multiset.\n  def count(object : T)\n    @count[object]\n  end\n\n  # Adds *object*\
    \ to the multiset and returns self.\n  def add(object : T) : self\n    @count[object]\
    \ += 1\n    @size += 1\n    self\n  end\n\n  # Adds *object* to the multiset *count*\
    \ times and returns self.\n  def add(object : T, count : Int32) : self\n    raise\
    \ ArgumentError.new unless count >= 0\n    @count[object] += count\n    @size\
    \ += count\n    self\n  end\n\n  # Alias for `add`.\n  def <<(object : T) : self\n\
    \    add object\n  end\n\n  # Removes the *object* from the multiset and returns\
    \ `true` if it was present, otherwise returns `false`.\n  def delete(object :\
    \ T) : Bool\n    if flag = @count[object] > 0\n      @count[object] -= 1\n   \
    \   @count.delete(object) if @count[object] == 0\n    end\n    flag\n  end\n\n\
    \  # Removes the *object* from the multiset at most *count* times and returns\
    \ `true` if it was present, otherwise returns `false`.\n  def delete(object :\
    \ T, count : Int32) : Bool\n    raise ArgumentError.new unless count >= 0\n  \
    \  if flag = @count[object] > 0\n      @count[object] = {0, @count[object] - count}.max\n\
    \      @count.delete(object) if @count[object] == 0\n    end\n    flag\n  end\n\
    \n  # Adds `each` element of *elems* to the multisetset and returns self.\n  def\
    \ concat(elems) : self\n    elems.each { |elem| self << elem }\n    self\n  end\n\
    \n  # Removes all elements in the multiset and returns `self`.\n  def clear\n\
    \    @count.clear\n    @size = 0\n    self\n  end\n\n  private class MultiSetIterator(T)\n\
    \    include Iterator(T)\n    include IteratorWrapper\n\n    @iterator : Iterator({T,\
    \ Int32})\n    @value : Tuple(T?, Int32)\n\n    def initialize(count : Hash(T,\
    \ Int32))\n      @iterator = count.each\n      @value = {nil, 0}\n    end\n\n\
    \    def next\n      until @value[1] > 0\n        @value = wrapped_next\n    \
    \  end\n      @value = {@value[0], @value[1] - 1}\n      @value[0].not_nil!\n\
    \    end\n  end\n\n  # Returns an iterator for each element of the multiset.\n\
    \  def each\n    MultiSetIterator(T).new(@count)\n  end\n\n  # Yields each element\
    \ of the multiset, and returns `nil`.\n  def each(&) : Nil\n    @count.each do\
    \ |(elem, cnt)|\n      cnt.times { yield elem }\n    end\n  end\n\n  # Returns\
    \ `true` if the multiset and the given multiset have at least one element in common.\n\
    \  def intersects?(other : self)\n    if kind_count < other.kind_count\n     \
    \ any? { |o| other.includes?(o) }\n    else\n      other.any? { |o| includes?(o)\
    \ }\n    end\n  end\n\n  # Returns `true` if the multiset is a subset of the given\
    \ multiset.\n  def subset_of?(other : self)\n    return false if other.size <\
    \ size\n    all? { |o| other.includes?(o) }\n  end\n\n  # Returns true if the\
    \ multiset is a superset of the given multiset.\n  def superset_of?(other : self)\n\
    \    other.subset_of?(self)\n  end\n\n  # Returns an iterator for each tuple of\
    \ element and count of the multiset\n  def each_count\n    @count.each\n  end\n\
    \n  # Yields each pair of element and count of the multiset, and returns `nil`.\n\
    \  def each_count(&) : Nil\n    @count.each do |(elem, cnt)|\n      yield(elem,\
    \ cnt)\n    end\n  end\n\n  # Intersection\n  def &(other : MultiSet(T)) : self\n\
    \    small, large = self, other\n    if large.kind_count < small.kind_count\n\
    \      small, large = large, small\n    end\n\n    result = MultiSet(T).new\n\
    \    small.each_count do |elem, cnt|\n      result.add elem, Math.min(cnt, large.count(elem))\n\
    \    end\n    result\n  end\n\n  # Union\n  def |(other : MultiSet(U)) forall\
    \ U\n    result = MultiSet(T | U).new\n    each_count { |elem, cnt| result.add\
    \ elem, cnt }\n    other.each_count { |elem, cnt| result.add elem, cnt }\n   \
    \ result\n  end\n\n  # Addition\n  def +(other : MultiSet(U)) forall U\n    self\
    \ | other\n  end\n\n  # Writes a string representation of the multiset to *io*.\n\
    \  #\n  # ```\n  # set = MultiSet{3, 1, 4, 1, 5}\n  # set.to_s # => \"MultiSet{3,\
    \ 1, 1, 4, 5}\"\n  # ```\n  def to_s(io : IO)\n    io << \"MultiSet{\"\n    each.join(\"\
    , \", io)\n    io << '}'\n  end\n\n  # Writes a string representation of the multiset\
    \ to *io*.\n  #\n  # ```\n  # set = MultiSet{3, 1, 4, 1, 5}\n  # set.to_s # =>\
    \ \"{3(1), 1(2), 4(1), 5(1)}\"\n  # ```\n  def inspect(io : IO)\n    io << '{'\n\
    \    each_count.join(\", \", io) do |(elem, count), io|\n      io << elem << '('\
    \ << count << ')'\n    end\n    io << '}'\n  end\nend\n"
  code: "class MultiSet(T)\n  include Iterable(T)\n  include Enumerable(T)\n\n  @count\
    \ = Hash(T, Int32).new(0)\n  @size = 0\n\n  # Returns the additive identity of\
    \ this type.\n  #\n  # This is an empty multiset\n  def self.additive_identify\
    \ : self\n    new\n  end\n\n  # Creates a new, empty multiset.\n  def initialize\n\
    \  end\n\n  # Creates a new multiset from the elements in *enumerable*.\n  def\
    \ initialize(enumerable : Enumerable(T))\n    concat enumerable\n  end\n\n  #\
    \ Returns the number of elements in the set.\n  def size : Int32\n    @size\n\
    \  end\n\n  # Returns the number of kinds in the multiset.\n  def kind_count :\
    \ Int32\n    @count.size\n  end\n\n  # Returns `true` if the multiset is empty.\n\
    \  def empty? : Bool\n    size == 0\n  end\n\n  # Returns `true` if *object* exists\
    \ in the multiset.\n  def includes?(object : T) : Bool\n    @count[object] > 0\n\
    \  end\n\n  # Same as `includes?`\n  def ===(object : T) : Bool\n    includes?(object)\n\
    \  end\n\n  # Returns the number of times that the *object* is present in the\
    \ multiset.\n  def count(object : T)\n    @count[object]\n  end\n\n  # Adds *object*\
    \ to the multiset and returns self.\n  def add(object : T) : self\n    @count[object]\
    \ += 1\n    @size += 1\n    self\n  end\n\n  # Adds *object* to the multiset *count*\
    \ times and returns self.\n  def add(object : T, count : Int32) : self\n    raise\
    \ ArgumentError.new unless count >= 0\n    @count[object] += count\n    @size\
    \ += count\n    self\n  end\n\n  # Alias for `add`.\n  def <<(object : T) : self\n\
    \    add object\n  end\n\n  # Removes the *object* from the multiset and returns\
    \ `true` if it was present, otherwise returns `false`.\n  def delete(object :\
    \ T) : Bool\n    if flag = @count[object] > 0\n      @count[object] -= 1\n   \
    \   @count.delete(object) if @count[object] == 0\n    end\n    flag\n  end\n\n\
    \  # Removes the *object* from the multiset at most *count* times and returns\
    \ `true` if it was present, otherwise returns `false`.\n  def delete(object :\
    \ T, count : Int32) : Bool\n    raise ArgumentError.new unless count >= 0\n  \
    \  if flag = @count[object] > 0\n      @count[object] = {0, @count[object] - count}.max\n\
    \      @count.delete(object) if @count[object] == 0\n    end\n    flag\n  end\n\
    \n  # Adds `each` element of *elems* to the multisetset and returns self.\n  def\
    \ concat(elems) : self\n    elems.each { |elem| self << elem }\n    self\n  end\n\
    \n  # Removes all elements in the multiset and returns `self`.\n  def clear\n\
    \    @count.clear\n    @size = 0\n    self\n  end\n\n  private class MultiSetIterator(T)\n\
    \    include Iterator(T)\n    include IteratorWrapper\n\n    @iterator : Iterator({T,\
    \ Int32})\n    @value : Tuple(T?, Int32)\n\n    def initialize(count : Hash(T,\
    \ Int32))\n      @iterator = count.each\n      @value = {nil, 0}\n    end\n\n\
    \    def next\n      until @value[1] > 0\n        @value = wrapped_next\n    \
    \  end\n      @value = {@value[0], @value[1] - 1}\n      @value[0].not_nil!\n\
    \    end\n  end\n\n  # Returns an iterator for each element of the multiset.\n\
    \  def each\n    MultiSetIterator(T).new(@count)\n  end\n\n  # Yields each element\
    \ of the multiset, and returns `nil`.\n  def each(&) : Nil\n    @count.each do\
    \ |(elem, cnt)|\n      cnt.times { yield elem }\n    end\n  end\n\n  # Returns\
    \ `true` if the multiset and the given multiset have at least one element in common.\n\
    \  def intersects?(other : self)\n    if kind_count < other.kind_count\n     \
    \ any? { |o| other.includes?(o) }\n    else\n      other.any? { |o| includes?(o)\
    \ }\n    end\n  end\n\n  # Returns `true` if the multiset is a subset of the given\
    \ multiset.\n  def subset_of?(other : self)\n    return false if other.size <\
    \ size\n    all? { |o| other.includes?(o) }\n  end\n\n  # Returns true if the\
    \ multiset is a superset of the given multiset.\n  def superset_of?(other : self)\n\
    \    other.subset_of?(self)\n  end\n\n  # Returns an iterator for each tuple of\
    \ element and count of the multiset\n  def each_count\n    @count.each\n  end\n\
    \n  # Yields each pair of element and count of the multiset, and returns `nil`.\n\
    \  def each_count(&) : Nil\n    @count.each do |(elem, cnt)|\n      yield(elem,\
    \ cnt)\n    end\n  end\n\n  # Intersection\n  def &(other : MultiSet(T)) : self\n\
    \    small, large = self, other\n    if large.kind_count < small.kind_count\n\
    \      small, large = large, small\n    end\n\n    result = MultiSet(T).new\n\
    \    small.each_count do |elem, cnt|\n      result.add elem, Math.min(cnt, large.count(elem))\n\
    \    end\n    result\n  end\n\n  # Union\n  def |(other : MultiSet(U)) forall\
    \ U\n    result = MultiSet(T | U).new\n    each_count { |elem, cnt| result.add\
    \ elem, cnt }\n    other.each_count { |elem, cnt| result.add elem, cnt }\n   \
    \ result\n  end\n\n  # Addition\n  def +(other : MultiSet(U)) forall U\n    self\
    \ | other\n  end\n\n  # Writes a string representation of the multiset to *io*.\n\
    \  #\n  # ```\n  # set = MultiSet{3, 1, 4, 1, 5}\n  # set.to_s # => \"MultiSet{3,\
    \ 1, 1, 4, 5}\"\n  # ```\n  def to_s(io : IO)\n    io << \"MultiSet{\"\n    each.join(\"\
    , \", io)\n    io << '}'\n  end\n\n  # Writes a string representation of the multiset\
    \ to *io*.\n  #\n  # ```\n  # set = MultiSet{3, 1, 4, 1, 5}\n  # set.to_s # =>\
    \ \"{3(1), 1(2), 4(1), 5(1)}\"\n  # ```\n  def inspect(io : IO)\n    io << '{'\n\
    \    each_count.join(\", \", io) do |(elem, count), io|\n      io << elem << '('\
    \ << count << ')'\n    end\n    io << '}'\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/datastructure/multi_set.cr
  requiredBy:
  - spec/datastructure/multi_set_spec.cr
  timestamp: '2021-09-17 10:16:01+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/datastructure/multi_set.cr
layout: document
redirect_from:
- /library/src/datastructure/multi_set.cr
- /library/src/datastructure/multi_set.cr.html
title: src/datastructure/multi_set.cr
---
