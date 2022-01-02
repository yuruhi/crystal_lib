---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/datastructure/multi_set.cr
    title: src/datastructure/multi_set.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../src/datastructure/multi_set\"\
    \nclass MultiSet(T)\n  include Iterable(T)\n  include Enumerable(T)\n\n  @count\
    \ = Hash(T, Int32).new(0)\n  @size = 0\n\n  # Returns the additive identity of\
    \ this type.\n  #\n  # This is an empty multiset\n  def self.additive_identify\
    \ : self\n    new\n  end\n\n  # Creates a new, empty multiset.\n  def initialize(initial_capacity\
    \ = nil)\n    @count = Hash(T, Int32).new(0, initial_capacity: initial_capacity)\n\
    \  end\n\n  # Creates a new multiset from the elements in *enumerable*.\n  def\
    \ initialize(enumerable : Enumerable(T))\n    @count = Hash(T, Int32).new(0)\n\
    \    concat enumerable\n  end\n\n  protected def initialize(*, @count : Hash(T,\
    \ Int32), @size : Int32)\n  end\n\n  # Returns the number of elements in the set.\n\
    \  def size : Int32\n    @size\n  end\n\n  # Returns the number of kinds in the\
    \ multiset.\n  def kind_count : Int32\n    @count.size\n  end\n\n  # Returns `true`\
    \ if the multiset is empty.\n  def empty? : Bool\n    size == 0\n  end\n\n  #\
    \ Compares with *other*.\n  def ==(other : MultiSet) : Bool\n    @count == other.@count\n\
    \  end\n\n  # Returns `true` if *object* exists in the multiset.\n  def includes?(object\
    \ : T) : Bool\n    @count[object] > 0\n  end\n\n  # :ditto:\n  def ===(object\
    \ : T) : Bool\n    includes?(object)\n  end\n\n  # Returns the number of times\
    \ that the *object* is present in the multiset.\n  def count(object : T)\n   \
    \ @count[object]\n  end\n\n  # Adds *object* to the multiset and returns `self`.\n\
    \  def add(object : T) : self\n    @count[object] += 1\n    @size += 1\n    self\n\
    \  end\n\n  # :ditto:\n  def <<(object : T) : self\n    add object\n  end\n\n\
    \  # Adds *object* to the multiset *count* times and returns `self`.\n  def add(object\
    \ : T, count : Int32) : self\n    raise ArgumentError.new unless count >= 0\n\
    \    @count[object] += count\n    @size += count\n    self\n  end\n\n  # Removes\
    \ the *object* from the multiset and returns `true` if it was present, otherwise\
    \ returns `false`.\n  def delete(object : T) : Bool\n    if flag = @count[object]\
    \ > 0\n      @count[object] -= 1\n      @count.delete(object) if @count[object]\
    \ == 0\n    end\n    flag\n  end\n\n  # Removes the *object* from the multiset\
    \ at most *count* times and returns `true`\n  # if it was present, otherwise returns\
    \ `false`.\n  def delete(object : T, count : Int32) : Bool\n    raise ArgumentError.new\
    \ unless count >= 0\n    if flag = @count[object] > 0\n      @count[object] =\
    \ {0, @count[object] - count}.max\n      @count.delete(object) if @count[object]\
    \ == 0\n    end\n    flag\n  end\n\n  # Adds `each` element of *elems* to the\
    \ multisetset and returns `self`.\n  def concat(elems) : self\n    elems.each\
    \ { |elem| self << elem }\n    self\n  end\n\n  # Removes all elements in the\
    \ multiset and returns `self`.\n  def clear : self\n    @count.clear\n    @size\
    \ = 0\n    self\n  end\n\n  private class MultiSetIterator(T)\n    include Iterator(T)\n\
    \    include IteratorWrapper\n\n    @iterator : Iterator({T, Int32})\n    @value\
    \ : Tuple(T?, Int32)\n\n    def initialize(count : Hash(T, Int32))\n      @iterator\
    \ = count.each\n      @value = {nil, 0}\n    end\n\n    def next\n      until\
    \ @value[1] > 0\n        @value = wrapped_next\n      end\n      @value = {@value[0],\
    \ @value[1] - 1}\n      @value[0].not_nil!\n    end\n  end\n\n  # Returns an iterator\
    \ for each element of the multiset.\n  def each\n    MultiSetIterator(T).new(@count)\n\
    \  end\n\n  # Yields each element of the multiset, and returns `nil`.\n  def each(&)\
    \ : Nil\n    @count.each do |(elem, cnt)|\n      cnt.times { yield elem }\n  \
    \  end\n  end\n\n  # Returns `true` if the multiset and the given multiset have\
    \ at least one element in common.\n  def intersects?(other : self) : Bool\n  \
    \  if kind_count < other.kind_count\n      any? { |o| other.includes?(o) }\n \
    \   else\n      other.any? { |o| includes?(o) }\n    end\n  end\n\n  # Returns\
    \ `true` if the multiset is a subset of the given multiset.\n  def subset_of?(other\
    \ : self) : Bool\n    return false if other.size < size\n    all? { |o| other.includes?(o)\
    \ }\n  end\n\n  # Returns true if the multiset is a superset of the given multiset.\n\
    \  def superset_of?(other : self) : Bool\n    other.subset_of?(self)\n  end\n\n\
    \  # Returns an iterator for each tuple of element and count of the multiset\n\
    \  def each_count\n    @count.each\n  end\n\n  # Yields each pair of element and\
    \ count of the multiset, and returns `nil`.\n  def each_count(&) : Nil\n    @count.each\
    \ do |(elem, cnt)|\n      yield(elem, cnt)\n    end\n  end\n\n  # Intersection.\n\
    \  #\n  # ```\n  # MultiSet{1, 2, 2, 3} & MultiSet{2, 3, 3, 4} # => MultiSet{2,\
    \ 3}\n  # ```\n  def &(other : MultiSet(T)) : self\n    small, large = self, other\n\
    \    if large.kind_count < small.kind_count\n      small, large = large, small\n\
    \    end\n\n    result = MultiSet(T).new\n    small.each_count do |elem, small_cnt|\n\
    \      large_cnt = large.count(elem)\n      result.add elem, Math.min(small_cnt,\
    \ large_cnt) if large_cnt > 0\n    end\n    result\n  end\n\n  # Union.\n  #\n\
    \  # ```\n  # MultiSet{1, 2, 2} | MultiSet{2, 3} # => MultiSet{1, 2, 2, 3}\n \
    \ # ```\n  def |(other : MultiSet(U)) : MultiSet(T | U) forall U\n    result =\
    \ MultiSet(T | U).new\n    each_count { |elem, cnt| result.add elem, cnt }\n \
    \   other.each_count { |elem, cnt| result.add elem, cnt }\n    result\n  end\n\
    \n  # Addition. Same as `#|`.\n  def +(other : MultiSet(U)) : MultiSet(T | U)\
    \ forall U\n    self | other\n  end\n\n  # Difference.\n  #\n  # ```\n  # MultiSet{1,\
    \ 2, 2, 3} - MultiSet{1, 2} # => MultiSet{2, 3}\n  # MultiSet{1, 2, 2, 3} - [1,\
    \ 2]         # => MultiSet{2, 3}\n  # ```\n  def -(other : MultiSet) : self\n\
    \    dup.subtract other\n  end\n\n  # :ditto:\n  def -(other : Enumerable) : self\n\
    \    dup.subtract other\n  end\n\n  # Repetition\n  #\n  # ```\n  # MultiSet{1,\
    \ 2, 2} * 2 # => MultiSet{1, 1, 2, 2, 2, 2}\n  # ```\n  def *(times : Int) : self\n\
    \    if times == 0 || empty?\n      MultiSet(T).new\n    elsif times == 1\n  \
    \    dup\n    else\n      set = MultiSet(T).new(@count.size)\n      each_count\
    \ do |elem, cnt|\n        set.add elem, cnt * times\n      end\n      set\n  \
    \  end\n  end\n\n  # Returns `self` after removing *other* elements.\n  #\n  #\
    \ ```\n  # MultiSet{1, 2, 2, 3}.subtract MultiSet{1, 2} # => MultiSet{2, 3}\n\
    \  # MultiSet{1, 2, 2, 3}.subtract [1, 2]         # => MultiSet{2, 3}\n  # ```\n\
    \  def subtract(other : MultiSet(U)) : self forall U\n    other.each_count do\
    \ |elem, cnt|\n      delete elem, cnt\n    end\n    self\n  end\n\n  # :ditto:\n\
    \  def subtract(other : Enumerable) : self forall U\n    other.each do |elem|\n\
    \      delete elem\n    end\n    self\n  end\n\n  # Returns a new multiset with\
    \ all of the same elements.\n  def dup : self\n    MultiSet(T).new count: @count.dup,\
    \ size: @size\n  end\n\n  # Returns a new multiset with all of the elements cloned.\n\
    \  def clone : self\n    set = MultiSet(T).new(@count.size)\n    each_count do\
    \ |elem, cnt|\n      set.add elem.clone, cnt\n    end\n    set\n  end\n\n  # Writes\
    \ a string representation of the multiset to *io*.\n  #\n  # ```\n  # set = MultiSet{3,\
    \ 1, 4, 1, 5}\n  # set.to_s # => \"MultiSet{3, 1, 1, 4, 5}\"\n  # ```\n  def to_s(io\
    \ : IO) : Nil\n    io << \"MultiSet{\"\n    each.join(\", \", io)\n    io << '}'\n\
    \  end\n\n  # Writes a string representation of the multiset to *io*.\n  #\n \
    \ # ```\n  # set = MultiSet{3, 1, 4, 1, 5}\n  # set.inspect # => \"{3(1), 1(2),\
    \ 4(1), 5(1)}\"\n  # ```\n  def inspect(io : IO) : Nil\n    io << '{'\n    each_count.join(\"\
    , \", io) do |(elem, count), io|\n      io << elem << '(' << count << ')'\n  \
    \  end\n    io << '}'\n  end\nend\n\ndescribe MultiSet do\n  it \"#initialize\"\
    \ do\n    MultiSet(Int32).new.to_s.should eq \"MultiSet{}\"\n    MultiSet.new([0,\
    \ 1, 2, 2]).to_s.should eq \"MultiSet{0, 1, 2, 2}\"\n    MultiSet{0, 1, 2, 2}.to_s.should\
    \ eq \"MultiSet{0, 1, 2, 2}\"\n  end\n\n  it \"#size\" do\n    MultiSet{0, 0,\
    \ 0, 1, 1, 2}.size.should eq 6\n    MultiSet(Int32).new.size.should eq 0\n  end\n\
    \n  it \"#kind_count\" do\n    MultiSet{0, 0, 1, 2}.kind_count.should eq 3\n \
    \   MultiSet(Int32).new.kind_count.should eq 0\n  end\n\n  it \"#==\" do\n   \
    \ a = MultiSet{1, 2, 2}\n    (a == MultiSet{1, 2, 2}).should be_true\n    (a ==\
    \ MultiSet{1, 2}).should be_false\n    (a == MultiSet{1i64, 2i64, 2i64}).should\
    \ be_true\n  end\n\n  it \"#add\" do\n    a = MultiSet(Int32).new\n    a.add 1\n\
    \    a.add 2\n    a << 1\n    a.inspect.should eq \"{1(2), 2(1)}\"\n\n    a.add\
    \ 3, 5\n    a.add 2, 3\n    a.inspect.should eq \"{1(2), 2(4), 3(5)}\"\n  end\n\
    \n  it \"#delete\" do\n    a = MultiSet{1, 1, 1, 1, 1, 2, 2, 3}\n    a.delete\
    \ 2\n    a.inspect.should eq \"{1(5), 2(1), 3(1)}\"\n    a.delete 1, 3\n    a.inspect.should\
    \ eq \"{1(2), 2(1), 3(1)}\"\n    a.delete 3, 128\n    a.inspect.should eq \"{1(2),\
    \ 2(1)}\"\n  end\n\n  it \"#concat\" do\n    a = MultiSet{1, 1, 1, 1, 1, 2, 2,\
    \ 3}\n    a.concat a\n    a.inspect.should eq \"{1(10), 2(4), 3(2)}\"\n    a.concat({0,\
    \ 0, 0, 1, 2, 3})\n    a.inspect.should eq \"{1(11), 2(5), 3(3), 0(3)}\"\n  end\n\
    \n  it \"#clear\" do\n    a = MultiSet{0, 0, 1, 1}\n    a.clear\n  end\n\n  it\
    \ \"#count\" do\n    a = MultiSet{0, 0, 0, 1, 1, 2}\n    a.count(0).should eq\
    \ 3\n    a.count(1).should eq 2\n    a.count(2).should eq 1\n    a.count(3).should\
    \ eq 0\n  end\n\n  it \"#includes?\" do\n    a = MultiSet{0, 0, 0, 1, 1, 2}\n\
    \    a.includes?(0).should eq true\n    a.includes?(1).should eq true\n    a.includes?(2).should\
    \ eq true\n    a.includes?(3).should eq false\n  end\n\n  it \"#empty?\" do\n\
    \    MultiSet{0, 0, 0, 1, 1, 2}.empty?.should eq false\n    MultiSet(Int32).new.empty?.should\
    \ eq true\n  end\n\n  it \"#intersects?\" do\n    a = MultiSet{0, 0, 0, 1, 1,\
    \ 2}\n    b = MultiSet{2, 3}\n    c = MultiSet{3, 3, 3, 4, 4, 5}\n    a.intersects?(b).should\
    \ eq true\n    b.intersects?(c).should eq true\n    a.intersects?(c).should eq\
    \ false\n  end\n\n  it \"#subset_of?\" do\n    a = MultiSet{0, 0, 0, 1, 1, 2}\n\
    \    b = MultiSet{0, 1, 0}\n    c = MultiSet{-1, 0, 0, 1}\n    a.subset_of?(b).should\
    \ eq false\n    b.subset_of?(a).should eq true\n    c.subset_of?(a).should eq\
    \ false\n  end\n\n  it \"#superset_of?\" do\n    a = MultiSet{0, 0, 0, 1, 1, 2}\n\
    \    b = MultiSet{0, 1, 0}\n    c = MultiSet{-1, 0, 0, 1}\n    a.superset_of?(b).should\
    \ eq true\n    b.superset_of?(a).should eq false\n    c.superset_of?(a).should\
    \ eq false\n  end\n\n  it \"#each\" do\n    a = MultiSet{0, 0, 0, 1, 1, 2}\n \
    \   a.each.to_a.should eq [0, 0, 0, 1, 1, 2]\n    a.each.max.should eq 2\n  end\n\
    \n  it \"#each(&)\" do\n    a = [] of Int32\n    MultiSet{0, 0, 0, 1, 1, 2}.each\
    \ do |elem|\n      a << elem\n    end\n    a.should eq [0, 0, 0, 1, 1, 2]\n  end\n\
    \n  it \"#each_count\" do\n    MultiSet{0, 0, 0, 1, 1, 2}.each_count.max.should\
    \ eq({2, 1})\n  end\n\n  it \"#each_count(&)\" do\n    a = [] of {Int32, Int32}\n\
    \    MultiSet{0, 0, 0, 1, 1, 2}.each_count do |elem, cnt|\n      a << {elem, cnt}\n\
    \    end\n    a.should eq [{0, 3}, {1, 2}, {2, 1}]\n  end\n\n  it \"#&\" do\n\
    \    a = MultiSet{0, 0, 0, 1, 1, 2, 3}\n    b = MultiSet{0, 1, 1, 2, 2, 2}\n \
    \   (a & b).inspect.should eq \"{0(1), 1(2), 2(1)}\"\n    a = MultiSet{1, 2, 2,\
    \ 3, 3, 3}\n    b = MultiSet{2, 3, 3, 4}\n    (a & b).inspect.should eq \"{2(1),\
    \ 3(2)}\"\n  end\n\n  it \"#|, #+\" do\n    a = MultiSet{0, 0, 0, 1, 1, 2, 3}\n\
    \    b = MultiSet{0, 1, 1, 2, 2, 2}\n    (a | b).inspect.should eq \"{0(4), 1(4),\
    \ 2(4), 3(1)}\"\n    (a + b).inspect.should eq \"{0(4), 1(4), 2(4), 3(1)}\"\n\
    \  end\n\n  it \"#-\" do\n    a = MultiSet{0, 1, 2, 2, 3, 3}\n    b = MultiSet{1,\
    \ 2, 3, 3, 3, 4}\n    (a - b).inspect.should eq \"{0(1), 2(1)}\"\n    (a - b.to_a).inspect.should\
    \ eq \"{0(1), 2(1)}\"\n  end\n\n  it \"#*\" do\n    a = MultiSet{1, 2, 2}\n  \
    \  (a * 10).inspect.should eq \"{1(10), 2(20)}\"\n    (a * 0).inspect.should eq\
    \ \"{}\"\n    expect_raises(ArgumentError) { a * -1 }\n  end\n\n  it \"#subtract\"\
    \ do\n    a = MultiSet{1, 2, 2, 3}\n    a.subtract(MultiSet{1, 1, 2}).should be\
    \ a\n    a.inspect.should eq \"{2(1), 3(1)}\"\n    a = MultiSet{1, 2, 2, 3}\n\
    \    a.subtract([1, 1, 2]).should be a\n    a.inspect.should eq \"{2(1), 3(1)}\"\
    \n  end\n\n  it \"#dup\" do\n    a = MultiSet{1, 2, 2, 3}\n    b = a.dup\n   \
    \ b.should eq a\n    b.should_not be a\n  end\n\n  it \"#clone\" do\n    a = MultiSet{[1,\
    \ 2, 3]}\n    b = a.clone\n    b.should eq a\n    b.should_not be a\n    a.to_a[0].should_not\
    \ be b.to_a[0]\n  end\n\n  it \"#to_s\" do\n    MultiSet{0, 0, 0, 1, 1, 2}.to_s.should\
    \ eq \"MultiSet{0, 0, 0, 1, 1, 2}\"\n  end\n\n  it \"#inspect\" do\n    io = IO::Memory.new\n\
    \    MultiSet{0, 0, 0, 1, 1, 2}.inspect(io)\n    io.to_s.should eq \"{0(3), 1(2),\
    \ 2(1)}\"\n  end\n\n  it \"includes Iterable\" do\n    MultiSet{0, 0, 0, 1, 1,\
    \ 2}.each_slice(3).to_a.should eq [[0, 0, 0], [1, 1, 2]]\n    MultiSet{0, 0, 0,\
    \ 1, 1, 2}.each_cons(2).select { |(i, j)| i != j }.to_a.should eq [[0, 1], [1,\
    \ 2]]\n  end\n\n  it \"includes Enumeratable\" do\n    MultiSet{0, 0, 0, 1, 1,\
    \ 2}.all?(&.even?).should eq false\n    MultiSet{0, 0, 0, 1, 1, 2}.all? { |i|\
    \ i >= 0 }.should eq true\n    MultiSet{0, 0, 0, 1, 1, 2}.max.should eq 2\n  \
    \  MultiSet{\"a\", \"ab\", \"abc\", \"abcd\"}.max_by(&.size).should eq \"abcd\"\
    \n    MultiSet{0, 0, 0, 1, 1, 2}.first.should eq 0\n    MultiSet{0, 0, 0, 1, 1,\
    \ 2}.index(1).should eq 3\n    MultiSet{0, 0, 0, 1, 1, 2}.join.should eq \"000112\"\
    \n  end\nend\n"
  code: "require \"spec\"\nrequire \"../../src/datastructure/multi_set\"\n\ndescribe\
    \ MultiSet do\n  it \"#initialize\" do\n    MultiSet(Int32).new.to_s.should eq\
    \ \"MultiSet{}\"\n    MultiSet.new([0, 1, 2, 2]).to_s.should eq \"MultiSet{0,\
    \ 1, 2, 2}\"\n    MultiSet{0, 1, 2, 2}.to_s.should eq \"MultiSet{0, 1, 2, 2}\"\
    \n  end\n\n  it \"#size\" do\n    MultiSet{0, 0, 0, 1, 1, 2}.size.should eq 6\n\
    \    MultiSet(Int32).new.size.should eq 0\n  end\n\n  it \"#kind_count\" do\n\
    \    MultiSet{0, 0, 1, 2}.kind_count.should eq 3\n    MultiSet(Int32).new.kind_count.should\
    \ eq 0\n  end\n\n  it \"#==\" do\n    a = MultiSet{1, 2, 2}\n    (a == MultiSet{1,\
    \ 2, 2}).should be_true\n    (a == MultiSet{1, 2}).should be_false\n    (a ==\
    \ MultiSet{1i64, 2i64, 2i64}).should be_true\n  end\n\n  it \"#add\" do\n    a\
    \ = MultiSet(Int32).new\n    a.add 1\n    a.add 2\n    a << 1\n    a.inspect.should\
    \ eq \"{1(2), 2(1)}\"\n\n    a.add 3, 5\n    a.add 2, 3\n    a.inspect.should\
    \ eq \"{1(2), 2(4), 3(5)}\"\n  end\n\n  it \"#delete\" do\n    a = MultiSet{1,\
    \ 1, 1, 1, 1, 2, 2, 3}\n    a.delete 2\n    a.inspect.should eq \"{1(5), 2(1),\
    \ 3(1)}\"\n    a.delete 1, 3\n    a.inspect.should eq \"{1(2), 2(1), 3(1)}\"\n\
    \    a.delete 3, 128\n    a.inspect.should eq \"{1(2), 2(1)}\"\n  end\n\n  it\
    \ \"#concat\" do\n    a = MultiSet{1, 1, 1, 1, 1, 2, 2, 3}\n    a.concat a\n \
    \   a.inspect.should eq \"{1(10), 2(4), 3(2)}\"\n    a.concat({0, 0, 0, 1, 2,\
    \ 3})\n    a.inspect.should eq \"{1(11), 2(5), 3(3), 0(3)}\"\n  end\n\n  it \"\
    #clear\" do\n    a = MultiSet{0, 0, 1, 1}\n    a.clear\n  end\n\n  it \"#count\"\
    \ do\n    a = MultiSet{0, 0, 0, 1, 1, 2}\n    a.count(0).should eq 3\n    a.count(1).should\
    \ eq 2\n    a.count(2).should eq 1\n    a.count(3).should eq 0\n  end\n\n  it\
    \ \"#includes?\" do\n    a = MultiSet{0, 0, 0, 1, 1, 2}\n    a.includes?(0).should\
    \ eq true\n    a.includes?(1).should eq true\n    a.includes?(2).should eq true\n\
    \    a.includes?(3).should eq false\n  end\n\n  it \"#empty?\" do\n    MultiSet{0,\
    \ 0, 0, 1, 1, 2}.empty?.should eq false\n    MultiSet(Int32).new.empty?.should\
    \ eq true\n  end\n\n  it \"#intersects?\" do\n    a = MultiSet{0, 0, 0, 1, 1,\
    \ 2}\n    b = MultiSet{2, 3}\n    c = MultiSet{3, 3, 3, 4, 4, 5}\n    a.intersects?(b).should\
    \ eq true\n    b.intersects?(c).should eq true\n    a.intersects?(c).should eq\
    \ false\n  end\n\n  it \"#subset_of?\" do\n    a = MultiSet{0, 0, 0, 1, 1, 2}\n\
    \    b = MultiSet{0, 1, 0}\n    c = MultiSet{-1, 0, 0, 1}\n    a.subset_of?(b).should\
    \ eq false\n    b.subset_of?(a).should eq true\n    c.subset_of?(a).should eq\
    \ false\n  end\n\n  it \"#superset_of?\" do\n    a = MultiSet{0, 0, 0, 1, 1, 2}\n\
    \    b = MultiSet{0, 1, 0}\n    c = MultiSet{-1, 0, 0, 1}\n    a.superset_of?(b).should\
    \ eq true\n    b.superset_of?(a).should eq false\n    c.superset_of?(a).should\
    \ eq false\n  end\n\n  it \"#each\" do\n    a = MultiSet{0, 0, 0, 1, 1, 2}\n \
    \   a.each.to_a.should eq [0, 0, 0, 1, 1, 2]\n    a.each.max.should eq 2\n  end\n\
    \n  it \"#each(&)\" do\n    a = [] of Int32\n    MultiSet{0, 0, 0, 1, 1, 2}.each\
    \ do |elem|\n      a << elem\n    end\n    a.should eq [0, 0, 0, 1, 1, 2]\n  end\n\
    \n  it \"#each_count\" do\n    MultiSet{0, 0, 0, 1, 1, 2}.each_count.max.should\
    \ eq({2, 1})\n  end\n\n  it \"#each_count(&)\" do\n    a = [] of {Int32, Int32}\n\
    \    MultiSet{0, 0, 0, 1, 1, 2}.each_count do |elem, cnt|\n      a << {elem, cnt}\n\
    \    end\n    a.should eq [{0, 3}, {1, 2}, {2, 1}]\n  end\n\n  it \"#&\" do\n\
    \    a = MultiSet{0, 0, 0, 1, 1, 2, 3}\n    b = MultiSet{0, 1, 1, 2, 2, 2}\n \
    \   (a & b).inspect.should eq \"{0(1), 1(2), 2(1)}\"\n    a = MultiSet{1, 2, 2,\
    \ 3, 3, 3}\n    b = MultiSet{2, 3, 3, 4}\n    (a & b).inspect.should eq \"{2(1),\
    \ 3(2)}\"\n  end\n\n  it \"#|, #+\" do\n    a = MultiSet{0, 0, 0, 1, 1, 2, 3}\n\
    \    b = MultiSet{0, 1, 1, 2, 2, 2}\n    (a | b).inspect.should eq \"{0(4), 1(4),\
    \ 2(4), 3(1)}\"\n    (a + b).inspect.should eq \"{0(4), 1(4), 2(4), 3(1)}\"\n\
    \  end\n\n  it \"#-\" do\n    a = MultiSet{0, 1, 2, 2, 3, 3}\n    b = MultiSet{1,\
    \ 2, 3, 3, 3, 4}\n    (a - b).inspect.should eq \"{0(1), 2(1)}\"\n    (a - b.to_a).inspect.should\
    \ eq \"{0(1), 2(1)}\"\n  end\n\n  it \"#*\" do\n    a = MultiSet{1, 2, 2}\n  \
    \  (a * 10).inspect.should eq \"{1(10), 2(20)}\"\n    (a * 0).inspect.should eq\
    \ \"{}\"\n    expect_raises(ArgumentError) { a * -1 }\n  end\n\n  it \"#subtract\"\
    \ do\n    a = MultiSet{1, 2, 2, 3}\n    a.subtract(MultiSet{1, 1, 2}).should be\
    \ a\n    a.inspect.should eq \"{2(1), 3(1)}\"\n    a = MultiSet{1, 2, 2, 3}\n\
    \    a.subtract([1, 1, 2]).should be a\n    a.inspect.should eq \"{2(1), 3(1)}\"\
    \n  end\n\n  it \"#dup\" do\n    a = MultiSet{1, 2, 2, 3}\n    b = a.dup\n   \
    \ b.should eq a\n    b.should_not be a\n  end\n\n  it \"#clone\" do\n    a = MultiSet{[1,\
    \ 2, 3]}\n    b = a.clone\n    b.should eq a\n    b.should_not be a\n    a.to_a[0].should_not\
    \ be b.to_a[0]\n  end\n\n  it \"#to_s\" do\n    MultiSet{0, 0, 0, 1, 1, 2}.to_s.should\
    \ eq \"MultiSet{0, 0, 0, 1, 1, 2}\"\n  end\n\n  it \"#inspect\" do\n    io = IO::Memory.new\n\
    \    MultiSet{0, 0, 0, 1, 1, 2}.inspect(io)\n    io.to_s.should eq \"{0(3), 1(2),\
    \ 2(1)}\"\n  end\n\n  it \"includes Iterable\" do\n    MultiSet{0, 0, 0, 1, 1,\
    \ 2}.each_slice(3).to_a.should eq [[0, 0, 0], [1, 1, 2]]\n    MultiSet{0, 0, 0,\
    \ 1, 1, 2}.each_cons(2).select { |(i, j)| i != j }.to_a.should eq [[0, 1], [1,\
    \ 2]]\n  end\n\n  it \"includes Enumeratable\" do\n    MultiSet{0, 0, 0, 1, 1,\
    \ 2}.all?(&.even?).should eq false\n    MultiSet{0, 0, 0, 1, 1, 2}.all? { |i|\
    \ i >= 0 }.should eq true\n    MultiSet{0, 0, 0, 1, 1, 2}.max.should eq 2\n  \
    \  MultiSet{\"a\", \"ab\", \"abc\", \"abcd\"}.max_by(&.size).should eq \"abcd\"\
    \n    MultiSet{0, 0, 0, 1, 1, 2}.first.should eq 0\n    MultiSet{0, 0, 0, 1, 1,\
    \ 2}.index(1).should eq 3\n    MultiSet{0, 0, 0, 1, 1, 2}.join.should eq \"000112\"\
    \n  end\nend\n"
  dependsOn:
  - src/datastructure/multi_set.cr
  isVerificationFile: false
  path: spec/datastructure/multi_set_spec.cr
  requiredBy: []
  timestamp: '2021-10-25 19:38:35+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/datastructure/multi_set_spec.cr
layout: document
redirect_from:
- /library/spec/datastructure/multi_set_spec.cr
- /library/spec/datastructure/multi_set_spec.cr.html
title: spec/datastructure/multi_set_spec.cr
---
