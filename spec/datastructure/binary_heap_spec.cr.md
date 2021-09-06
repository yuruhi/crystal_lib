---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: src/datastructure/binary_heap.cr
    title: src/datastructure/binary_heap.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../src/datastructure/binary_heap\"\
    \nclass BinaryHeap(T)\n  def initialize\n    initialize { |a, b| a <=> b }\n \
    \ end\n\n  def initialize(enumerable : Enumerable(T))\n    initialize\n    enumerable.each\
    \ { |x| add(x) }\n  end\n\n  def initialize(&block : T, T -> Int32?)\n    @heap\
    \ = Array(T).new\n    @compare_proc = block\n  end\n\n  def initialize(enumerable\
    \ : Enumerable(T), &block : T, T -> Int32?)\n    initialize &block\n    enumerable.each\
    \ { |x| add(x) }\n  end\n\n  include Enumerable(T)\n\n  delegate size, to: @heap\n\
    \  delegate empty?, to: @heap\n  def_clone\n\n  def ==(other : BinaryHeap(T))\n\
    \    @heap.sort == other.@heap.sort\n  end\n\n  private def compare(index1 : Int32,\
    \ index2 : Int32)\n    v = @compare_proc.call(@heap[index1], @heap[index2])\n\
    \    raise ArgumentError.new(\"Comparison of #{@heap[index1]} and #{@heap[index2]}\
    \ failed\") if v.nil?\n    v > 0\n  end\n\n  # Removes all elements from the heap\
    \ and returns `self`.\n  def clear : self\n    @heap.clear\n    self\n  end\n\n\
    \  # Returns the lowest value in the `self`.\n  # If the `self` is empty, calls\
    \ the block and returns its value.\n  def top(&block)\n    @heap.first { yield\
    \ }\n  end\n\n  # Returns the lowest value in the `self`.\n  # If the `self` is\
    \ empty, returns `nil`.\n  def top? : T?\n    top { nil }\n  end\n\n  # Returns\
    \ the lowest value in the `self`.\n  # If the `self` is empty, raises `IndexError`.\n\
    \  def top : T\n    top { raise IndexError.new }\n  end\n\n  # Adds *object* to\
    \ the heap and returns `self`.\n  def add(object : T) : self\n    @heap << object\n\
    \    i = size - 1\n    parent = i.pred // 2\n    while i > 0 && compare(parent,\
    \ i)\n      @heap.swap(parent, i)\n      i, parent = parent, parent.pred // 2\n\
    \    end\n    self\n  end\n\n  # Alias for `#add`.\n  def <<(object : T) : self\n\
    \    add(object)\n  end\n\n  # Removes the lowest value from `self` and returns\
    \ the removed value.\n  # If the array is empty, the given block is called.\n\
    \  def pop(&block)\n    case size\n    when 0\n      yield\n    when 1\n     \
    \ @heap.pop\n    else\n      result = @heap.unsafe_fetch(0)\n      @heap[0] =\
    \ @heap.pop\n      i = 0\n      loop do\n        left, right = i * 2 + 1, i *\
    \ 2 + 2\n        j = if right < size && compare(i, right)\n              compare(left,\
    \ right) ? right : left\n            elsif left < size && compare(i, left)\n \
    \             left\n            else\n              break\n            end\n \
    \       @heap.swap(i, j)\n        i = j\n      end\n      result\n    end\n  end\n\
    \n  # Like `#pop`, but returns `nil` if `self` is empty.\n  def pop? : T?\n  \
    \  pop { nil }\n  end\n\n  # Removes the lowest value from `self` and returns\
    \ the removed value.\n  # Raises `IndexError` if heap is of 0 size.\n  def pop\
    \ : T\n    pop { raise IndexError.new }\n  end\n\n  def pop(n : Int) : Array(T)\n\
    \    raise ArgumentError.new unless n >= 0\n    n = Math.min(n, size)\n    Array.new(n)\
    \ { |i| pop }\n  end\n\n  def each(&block)\n    @heap.sort { |a, b| @compare_proc.call(a,\
    \ b) }.each do |x|\n      yield x\n    end\n  end\n\n  def to_s(io : IO) : Nil\n\
    \    io << \"BinaryHeap{\"\n    each_with_index do |x, i|\n      io << \", \"\
    \ if i > 0\n      io << x\n    end\n    io << '}'\n  end\n\n  def inspect(io :\
    \ IO) : Nil\n    to_s(io)\n  end\nend\n\ndescribe BinaryHeap do\n  it \"new\"\
    \ do\n    a = BinaryHeap(Int32).new\n    a << 1 << 2 << 3\n    a.to_a.should eq\
    \ [1, 2, 3]\n  end\n\n  it \"new(enumerable)\" do\n    a = BinaryHeap.new 1..10\n\
    \    a.to_a.should eq (1..10).to_a\n  end\n\n  it \"new(&block)\" do\n    a =\
    \ BinaryHeap(Int32).new { |a, b| b <=> a }\n    a << 3 << 1 << 4 << 1 << 5\n \
    \   a.to_a.should eq [5, 4, 3, 1, 1]\n  end\n\n  it \"new(enumerable, &block)\"\
    \ do\n    a = BinaryHeap.new(1..10) { |a, b| b <=> a }\n    a.to_a.should eq (1..10).to_a.reverse\n\
    \  end\n\n  it \"{}\" do\n    BinaryHeap{3, 1, 4}.top.should eq 1\n  end\n\n \
    \ it \"#size\" do\n    BinaryHeap(Int32).new.size.should eq 0\n    BinaryHeap{1,\
    \ 2, 3}.size.should eq 3\n  end\n\n  it \"#empty\" do\n    BinaryHeap(Int32).new.empty?.should\
    \ be_true\n    BinaryHeap{1, 2, 3}.empty?.should be_false\n  end\n\n  it \"#clear\"\
    \ do\n    a = BinaryHeap{1, 2, 3}\n    a.clear.should eq BinaryHeap(Int32).new\n\
    \    a.empty?.should be_true\n  end\n\n  it \"#clone\" do\n    a = BinaryHeap{1,\
    \ 2, 3}\n    b = a.clone\n    b.pop\n    b.should eq BinaryHeap{2, 3}\n    a.should\
    \ eq BinaryHeap{1, 2, 3}\n  end\n\n  it \"#==, #!=\" do\n    a = BinaryHeap{1,\
    \ 2, 3}\n    b = BinaryHeap{3, 2, 1}\n    c = BinaryHeap{1, 2}\n    (a == b).should\
    \ be_true\n    (a != b).should be_false\n    (a == c).should be_false\n    (a\
    \ != c).should be_true\n  end\n\n  it \"#top(&block), #top?, #top\" do\n    a\
    \ = BinaryHeap{3, 1, 4}\n    a.top.should eq 1\n    a.top?.should eq 1\n    a.top\
    \ { \"none\" }.should eq 1\n\n    a = BinaryHeap(Int32).new\n    expect_raises(IndexError)\
    \ { a.top }\n    a.top?.should be_nil\n    a.top { \"none\" }.should eq \"none\"\
    \n  end\n\n  it \"#add, #<<\" do\n    a = BinaryHeap(Int32).new\n    a.add(1).add(2)\n\
    \    a << 1 << 2 << 3\n    a == BinaryHeap{1, 1, 2, 2, 3}\n  end\n\n  it \"#pop(&block),\
    \ #pop?, #pop\" do\n    a = BinaryHeap{1, 2, 3}\n    a.pop.should eq 1\n    a.pop?.should\
    \ eq 2\n    a.pop { \"none\" }.should eq 3\n    expect_raises(IndexError) { a.pop\
    \ }\n    a.pop?.should be_nil\n    a.pop { \"none\" }.should eq \"none\"\n  end\n\
    \n  it \"#pop(n)\" do\n    a = BinaryHeap{1, 2, 3, 4, 5}\n    a.pop(3).should\
    \ eq [1, 2, 3]\n    a.pop(1).should eq [4]\n    a.pop(3).should eq [5]\n    a.pop(0).should\
    \ eq [] of Int32\n    a.pop(9).should eq [] of Int32\n    expect_raises(ArgumentError)\
    \ { a.pop(-1) }\n  end\n\n  it \"#to_s, #inspect\" do\n    a = BinaryHeap{3, 1,\
    \ 4}\n    a.to_s.should eq \"BinaryHeap{1, 3, 4}\"\n    a.inspect.should eq \"\
    BinaryHeap{1, 3, 4}\"\n  end\n\n  it \"include Enumerable\" do\n    a = BinaryHeap{1,\
    \ 2, 3}\n    a.to_a.should eq [1, 2, 3]\n    a.min.should eq 1\n    a.max.should\
    \ eq 3\n  end\n\n  it \"big test\" do\n    test = ->(values : Array(Int32)) {\n\
    \      a = BinaryHeap(Int32).new\n      values.each { |x| a << x }\n      a.to_a.should\
    \ eq values.sort\n    }\n    n = 1000\n    test.call Array.new(n) { rand(Int32)\
    \ }\n    test.call Array.new(n) { rand(100) }\n    test.call (1..n).to_a\n   \
    \ test.call (1..n).to_a.reverse\n  end\n\n  it \"(Float64)\" do\n    BinaryHeap{1.1,\
    \ 2.2, 3.3}.to_a.should eq [1.1, 2.2, 3.3]\n  end\n\n  it \"(String)\" do\n  \
    \  BinaryHeap.new(%w[D C B A]).to_a.should eq %w[A B C D]\n  end\nend\n"
  code: "require \"spec\"\nrequire \"../../src/datastructure/binary_heap\"\n\ndescribe\
    \ BinaryHeap do\n  it \"new\" do\n    a = BinaryHeap(Int32).new\n    a << 1 <<\
    \ 2 << 3\n    a.to_a.should eq [1, 2, 3]\n  end\n\n  it \"new(enumerable)\" do\n\
    \    a = BinaryHeap.new 1..10\n    a.to_a.should eq (1..10).to_a\n  end\n\n  it\
    \ \"new(&block)\" do\n    a = BinaryHeap(Int32).new { |a, b| b <=> a }\n    a\
    \ << 3 << 1 << 4 << 1 << 5\n    a.to_a.should eq [5, 4, 3, 1, 1]\n  end\n\n  it\
    \ \"new(enumerable, &block)\" do\n    a = BinaryHeap.new(1..10) { |a, b| b <=>\
    \ a }\n    a.to_a.should eq (1..10).to_a.reverse\n  end\n\n  it \"{}\" do\n  \
    \  BinaryHeap{3, 1, 4}.top.should eq 1\n  end\n\n  it \"#size\" do\n    BinaryHeap(Int32).new.size.should\
    \ eq 0\n    BinaryHeap{1, 2, 3}.size.should eq 3\n  end\n\n  it \"#empty\" do\n\
    \    BinaryHeap(Int32).new.empty?.should be_true\n    BinaryHeap{1, 2, 3}.empty?.should\
    \ be_false\n  end\n\n  it \"#clear\" do\n    a = BinaryHeap{1, 2, 3}\n    a.clear.should\
    \ eq BinaryHeap(Int32).new\n    a.empty?.should be_true\n  end\n\n  it \"#clone\"\
    \ do\n    a = BinaryHeap{1, 2, 3}\n    b = a.clone\n    b.pop\n    b.should eq\
    \ BinaryHeap{2, 3}\n    a.should eq BinaryHeap{1, 2, 3}\n  end\n\n  it \"#==,\
    \ #!=\" do\n    a = BinaryHeap{1, 2, 3}\n    b = BinaryHeap{3, 2, 1}\n    c =\
    \ BinaryHeap{1, 2}\n    (a == b).should be_true\n    (a != b).should be_false\n\
    \    (a == c).should be_false\n    (a != c).should be_true\n  end\n\n  it \"#top(&block),\
    \ #top?, #top\" do\n    a = BinaryHeap{3, 1, 4}\n    a.top.should eq 1\n    a.top?.should\
    \ eq 1\n    a.top { \"none\" }.should eq 1\n\n    a = BinaryHeap(Int32).new\n\
    \    expect_raises(IndexError) { a.top }\n    a.top?.should be_nil\n    a.top\
    \ { \"none\" }.should eq \"none\"\n  end\n\n  it \"#add, #<<\" do\n    a = BinaryHeap(Int32).new\n\
    \    a.add(1).add(2)\n    a << 1 << 2 << 3\n    a == BinaryHeap{1, 1, 2, 2, 3}\n\
    \  end\n\n  it \"#pop(&block), #pop?, #pop\" do\n    a = BinaryHeap{1, 2, 3}\n\
    \    a.pop.should eq 1\n    a.pop?.should eq 2\n    a.pop { \"none\" }.should\
    \ eq 3\n    expect_raises(IndexError) { a.pop }\n    a.pop?.should be_nil\n  \
    \  a.pop { \"none\" }.should eq \"none\"\n  end\n\n  it \"#pop(n)\" do\n    a\
    \ = BinaryHeap{1, 2, 3, 4, 5}\n    a.pop(3).should eq [1, 2, 3]\n    a.pop(1).should\
    \ eq [4]\n    a.pop(3).should eq [5]\n    a.pop(0).should eq [] of Int32\n   \
    \ a.pop(9).should eq [] of Int32\n    expect_raises(ArgumentError) { a.pop(-1)\
    \ }\n  end\n\n  it \"#to_s, #inspect\" do\n    a = BinaryHeap{3, 1, 4}\n    a.to_s.should\
    \ eq \"BinaryHeap{1, 3, 4}\"\n    a.inspect.should eq \"BinaryHeap{1, 3, 4}\"\n\
    \  end\n\n  it \"include Enumerable\" do\n    a = BinaryHeap{1, 2, 3}\n    a.to_a.should\
    \ eq [1, 2, 3]\n    a.min.should eq 1\n    a.max.should eq 3\n  end\n\n  it \"\
    big test\" do\n    test = ->(values : Array(Int32)) {\n      a = BinaryHeap(Int32).new\n\
    \      values.each { |x| a << x }\n      a.to_a.should eq values.sort\n    }\n\
    \    n = 1000\n    test.call Array.new(n) { rand(Int32) }\n    test.call Array.new(n)\
    \ { rand(100) }\n    test.call (1..n).to_a\n    test.call (1..n).to_a.reverse\n\
    \  end\n\n  it \"(Float64)\" do\n    BinaryHeap{1.1, 2.2, 3.3}.to_a.should eq\
    \ [1.1, 2.2, 3.3]\n  end\n\n  it \"(String)\" do\n    BinaryHeap.new(%w[D C B\
    \ A]).to_a.should eq %w[A B C D]\n  end\nend\n"
  dependsOn:
  - src/datastructure/binary_heap.cr
  isVerificationFile: false
  path: spec/datastructure/binary_heap_spec.cr
  requiredBy: []
  timestamp: '2021-09-06 17:48:00+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/datastructure/binary_heap_spec.cr
layout: document
redirect_from:
- /library/spec/datastructure/binary_heap_spec.cr
- /library/spec/datastructure/binary_heap_spec.cr.html
title: spec/datastructure/binary_heap_spec.cr
---
