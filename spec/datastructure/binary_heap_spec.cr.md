---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/datastructure/binary_heap.cr
    title: src/datastructure/binary_heap.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../src/datastructure/binary_heap\"\
    \nclass BinaryHeap(T)\n  # Creates a new empty heap.\n  def initialize\n    @heap\
    \ = Array(T).new\n    @compare_proc = nil\n  end\n\n  # Creates a new empty heap\
    \ backed by a buffer that is initially *initial_capacity* big (default: `0`).\n\
    \  #\n  # ```\n  # a = BinaryHeap.new(3)\n  # a << 3 << 1 << 2\n  # a.pop # =>\
    \ 1\n  # a.pop # => 2\n  # a.pop # => 3\n  # ```\n  def initialize(initial_capacity\
    \ : Int = 0)\n    @heap = Array(T).new(initial_capacity)\n    @compare_proc =\
    \ nil\n  end\n\n  # Creates a new heap from the elements in *enumerable*.\n  #\n\
    \  # ```\n  # a = BinaryHeap.new [3, 1, 2]\n  # a.pop # => 1\n  # a.pop # => 2\n\
    \  # a.pop # => 3\n  # ```\n  def initialize(enumerable : Enumerable(T))\n   \
    \ initialize\n    enumerable.each { |x| add(x) }\n  end\n\n  # Creates a new empty\
    \ heap with the custom comperator.\n  #\n  # The block must implement a comparison\
    \ between two elements *a* and *b*, where `a < b` returns `-1`,\n  # `a == b`\
    \ returns `0`, and `a > b` returns `1`. The comparison operator `#<=>` can be\
    \ used for this.\n  #\n  # ```\n  # a = BinaryHeap.new [3, 1, 2]\n  # a.pop #\
    \ => 1\n  # b = BinaryHeap.new [3, 1, 2] { |a, b| b <=> a }\n  # b.pop # => 3\n\
    \  # ```\n  def initialize(initial_capacity : Int = 0, &block : T, T -> Int32?)\n\
    \    @heap = Array(T).new(initial_capacity)\n    @compare_proc = block\n  end\n\
    \n  # :ditto:\n  def initialize(enumerable : Enumerable(T), &block : T, T -> Int32?)\n\
    \    initialize &block\n    enumerable.each { |x| add(x) }\n  end\n\n  include\
    \ Enumerable(T)\n  include Iterable(T)\n\n  def_clone\n\n  # Returns true if both\
    \ heap have the same elements.\n  def ==(other : BinaryHeap(T)) : Bool\n    return\
    \ false if size != other.size\n    @heap.sort == other.@heap.sort\n  end\n\n \
    \ # Returns the number of elements in the heap.\n  def size : Int32\n    @heap.size\n\
    \  end\n\n  # Returns `true` if `self` is empty, `false` otherwise.\n  def empty?\
    \ : Bool\n    @heap.empty?\n  end\n\n  # Removes all elements from the heap and\
    \ returns `self`.\n  def clear : self\n    @heap.clear\n    self\n  end\n\n  #\
    \ Returns the lowest value in the `self`.\n  # If the `self` is empty, calls the\
    \ block and returns its value.\n  def top(&block)\n    @heap.first { yield }\n\
    \  end\n\n  # Returns the lowest value in the `self`.\n  # If the `self` is empty,\
    \ returns `nil`.\n  def top? : T?\n    top { nil }\n  end\n\n  # Returns the lowest\
    \ value in the `self`.\n  # If the `self` is empty, raises `IndexError`.\n  def\
    \ top : T\n    top { raise IndexError.new }\n  end\n\n  # Requires `0 <= i < size`,\
    \ `0 <= j < size`.\n  private def compare(i : Int32, j : Int32)\n    x, y = @heap.unsafe_fetch(i),\
    \ @heap.unsafe_fetch(j)\n    if @compare_proc\n      v = @compare_proc.not_nil!.call(x,\
    \ y)\n      raise ArgumentError.new(\"Comparison of #{x} and #{y} failed\") if\
    \ v.nil?\n      v > 0\n    else\n      x > y\n    end\n  end\n\n  # Adds *object*\
    \ to the heap and returns `self`.\n  def add(object : T) : self\n    @heap <<\
    \ object\n    i = size - 1\n    parent = i.pred // 2\n    while i > 0 && compare(parent,\
    \ i)\n      @heap.swap(parent, i)\n      i, parent = parent, parent.pred // 2\n\
    \    end\n    self\n  end\n\n  # :ditto:\n  def <<(object : T) : self\n    add(object)\n\
    \  end\n\n  # Removes the lowest value from `self` and returns the removed value.\n\
    \  # If the array is empty, the given block is called.\n  def pop(&block)\n  \
    \  case size\n    when 0\n      yield\n    when 1\n      @heap.pop\n    else\n\
    \      value = @heap.unsafe_fetch(0)\n      @heap[0] = @heap.pop\n      i = 0\n\
    \      loop do\n        left, right = i * 2 + 1, i * 2 + 2\n        j = if right\
    \ < size && compare(i, right)\n              compare(left, right) ? right : left\n\
    \            elsif left < size && compare(i, left)\n              left\n     \
    \       else\n              break\n            end\n        @heap.swap(i, j)\n\
    \        i = j\n      end\n      value\n    end\n  end\n\n  # Like `#pop`, but\
    \ returns `nil` if `self` is empty.\n  def pop? : T?\n    pop { nil }\n  end\n\
    \n  # Removes the lowest value from `self` and returns the removed value.\n  #\
    \ Raises `IndexError` if heap is of 0 size.\n  def pop : T\n    pop { raise IndexError.new\
    \ }\n  end\n\n  # Removes the last *n* values from `self` ahd returns the removed\
    \ values.\n  def pop(n : Int) : Array(T)\n    raise ArgumentError.new unless n\
    \ >= 0\n    n = Math.min(n, size)\n    Array.new(n) { pop }\n  end\n\n  # Yields\
    \ each element of the heap, and returns `nil`.\n  def each(&) : Nil\n    @heap.each\
    \ { |elem| yield elem }\n  end\n\n  # Returns an iterator for each element of\
    \ the heap.\n  def each\n    @heap.each\n  end\n\n  # Returns a new array with\
    \ all elements sorted.\n  #\n  # ```\n  # a = BinaryHeap.new [3, 1, 2]\n  # a.sort\
    \ # => [1, 2, 3]\n  # b = BinaryHeap.new [3, 1, 2] { |a, b| b <=> a }\n  # b.sort\
    \ # => [3, 2, 1]\n  # ```\n  def sort : Array(T)\n    if @compare_proc\n     \
    \ @heap.sort { |a, b| @compare_proc.not_nil!.call(a, b) }\n    else\n      @heap.sort\n\
    \    end\n  end\n\n  # Returns the elements as an Array.\n  #\n  # ```\n  # BinaryHeap{3,\
    \ 1, 2}.to_a # => [1, 3, 2]\n  # ```\n  def to_a : Array(T)\n    @heap.dup\n \
    \ end\n\n  # Writes a string representation of the heap to `io`.\n  #\n  # ```\n\
    \  # BinaryHeap{1, 2}.to_s # => \"BinaryHeap{1, 2}\"\n  # ```\n  def to_s(io :\
    \ IO) : Nil\n    io << \"BinaryHeap{\"\n    # TODO: use join\n    each_with_index\
    \ do |x, i|\n      io << \", \" if i > 0\n      io << x\n    end\n    io << '}'\n\
    \  end\n\n  # Writes a string representation of the heap to `io`.\n  #\n  # ```\n\
    \  # BinaryHeap{1, 2}.inspect # => \"BinaryHeap{1, 2}\"\n  # ```\n  def inspect(io\
    \ : IO) : Nil\n    to_s(io)\n  end\nend\n\ndescribe BinaryHeap do\n  describe\
    \ \".new\" do\n    it \"creates empty heap\" do\n      a = BinaryHeap(Int32).new\n\
    \      a << 3 << 1 << 2\n      a.sort.should eq [1, 2, 3]\n    end\n\n    it \"\
    creates with enumerable\" do\n      a = BinaryHeap(Int32).new(1..9)\n      a.sort.should\
    \ eq (1..9).to_a\n    end\n\n    it \"creates with compare block\" do\n      a\
    \ = BinaryHeap(Int32).new { |a, b| b <=> a }\n      a << 3 << 1 << 2\n      a.sort.should\
    \ eq [3, 2, 1]\n    end\n\n    it \"creates with enumerable and compare block\"\
    \ do\n      a = BinaryHeap(Int32).new(1..9) { |a, b| b <=> a }\n      a.sort.should\
    \ eq (1..9).reverse_each.to_a\n    end\n  end\n\n  it \"BinaryHeap{}\" do\n  \
    \  a = BinaryHeap{3, 1, 2}\n    a.sort.should eq [1, 2, 3]\n  end\n\n  it \"#size\"\
    \ do\n    BinaryHeap(Int32).new.size.should eq 0\n    BinaryHeap{1, 2, 3}.size.should\
    \ eq 3\n  end\n\n  it \"#empty?\" do\n    BinaryHeap(Int32).new.should be_empty\n\
    \    BinaryHeap{1, 2, 3}.should_not be_empty\n  end\n\n  it \"#clear\" do\n  \
    \  a = BinaryHeap{1, 2, 3}\n    a.clear.should be a\n    a.should be_empty\n \
    \ end\n\n  it \"#dup\" do\n    a = BinaryHeap{[1], [2], [3]}\n    b = a.dup\n\
    \    b.should eq a\n    b.should_not be a\n    a.top.should be b.top\n  end\n\n\
    \  it \"#clone\" do\n    a = BinaryHeap{[1], [2], [3]}\n    b = a.clone\n    b.should\
    \ eq a\n    b.should_not be a\n    a.top.should_not be b.top\n  end\n\n  describe\
    \ \"compare\" do\n    a = BinaryHeap{1, 2, 3}\n    b = BinaryHeap{3, 2, 1}\n \
    \   c = BinaryHeap{1, 2}\n\n    it \"#==\" do\n      (a == b).should be_true\n\
    \      (a == c).should be_false\n    end\n\n    it \"#!=\" do\n      (a != b).should\
    \ be_false\n      (a != c).should be_true\n    end\n  end\n\n  describe \"#top\"\
    \ do\n    context \"when heap is not empty\" do\n      it \"returns top element\"\
    \ do\n        a = BinaryHeap{3, 1, 2}\n        a.top.should eq 1\n        a.top?.should\
    \ eq 1\n        a.top { \"none\" }.should eq 1\n      end\n    end\n\n    context\
    \ \"when heap is empty\" do\n      it \"returns top element\" do\n        a =\
    \ BinaryHeap(Int32).new\n        expect_raises(IndexError) { a.top }\n       \
    \ a.top?.should be_nil\n        a.top { \"none\" }.should eq \"none\"\n      end\n\
    \    end\n  end\n\n  it \"#add, #<<\" do\n    a = BinaryHeap(Int32).new\n    a.add(1).add(2).should\
    \ be a\n    (a << 1 << 2 << 3).should be a\n    a.sort.should eq [1, 1, 2, 2,\
    \ 3]\n  end\n\n  describe \"#pop\" do\n    it \"pops when heap is not empty\"\
    \ do\n      a = BinaryHeap{1, 2, 3}\n      a.pop.should eq 1\n      a.pop?.should\
    \ eq 2\n      a.pop { \"none\" }.should eq 3\n    end\n\n    it \"pops when heap\
    \ is empty\" do\n      a = BinaryHeap(Int32).new\n      expect_raises(IndexError)\
    \ { a.pop }\n      a.pop?.should be_nil\n      a.pop { \"none\" }.should eq \"\
    none\"\n    end\n\n    it \"pops many elements\" do\n      a = BinaryHeap{1, 2,\
    \ 3, 4, 5}\n      a.pop(3).should eq [1, 2, 3]\n      a.sort.should eq [4, 5]\n\
    \      a.pop(2).should eq [4, 5]\n      a.sort.should eq [] of Int32\n    end\n\
    \n    it \"pops more elements that what is available\" do\n      a = BinaryHeap{1,\
    \ 2, 3, 4, 5}\n      a.pop(9).should eq [1, 2, 3, 4, 5]\n      a.should be_empty\n\
    \      a.pop(1).should eq [] of Int32\n    end\n\n    it \"raises if pops negative\
    \ number of elements\" do\n      a = BinaryHeap{1, 2}\n      expect_raises(ArgumentError)\
    \ { a.pop(-1) }\n    end\n  end\n\n  describe \"#each\" do\n    a = BinaryHeap{3,\
    \ 1, 2}\n\n    it \"receives block\" do\n      b = [] of Int32\n      a.each {\
    \ |x| b << x }\n      b.sort.should eq [1, 2, 3]\n    end\n\n    it \"returns\
    \ Iterator\" do\n      a.each.should be_a Iterator(Int32)\n      a.each.min.should\
    \ eq 1\n      a.each.max.should eq 3\n      a.each.cycle(2).to_a.sort.should eq\
    \ [1, 1, 2, 2, 3, 3]\n    end\n  end\n\n  it \"#sort\" do\n    a = BinaryHeap{3,\
    \ 1, 2}\n    a.sort.should eq [1, 2, 3]\n    b = BinaryHeap.new([1, 2, 3]) { |a,\
    \ b| b <=> a }\n    b.sort.should eq [3, 2, 1]\n  end\n\n  it \"#to_a\" do\n \
    \   a = BinaryHeap{3, 1, 2}\n    a.to_a.sort.should eq [1, 2, 3]\n    a = BinaryHeap{3,\
    \ 1, 4, 1, 5}\n    a.to_a.sort.should eq [1, 1, 3, 4, 5]\n  end\n\n  it \"#to_s,\
    \ #inspect\" do\n    a = BinaryHeap{3, 1, 4}\n    a.to_s.should eq \"BinaryHeap{1,\
    \ 3, 4}\"\n    a.inspect.should eq \"BinaryHeap{1, 3, 4}\"\n  end\n\n  it \"includes\
    \ Enumerable(T)\" do\n    a = BinaryHeap{1, 2, 3}\n    a.sort.should eq [1, 2,\
    \ 3]\n    a.min.should eq 1\n    a.max.should eq 3\n  end\n\n  it \"includes Iterable(T)\"\
    \ do\n    a = BinaryHeap{1, 2, 3}\n    a.cycle(2).should be_a Iterator(Int32)\n\
    \    a.cycle(2).to_a.should eq [1, 2, 3, 1, 2, 3]\n    a.each_cons(2).to_a.should\
    \ eq [[1, 2], [2, 3]]\n  end\n\n  describe \"big test\" do\n    it \"hasn't compare\
    \ proc\" do\n      n = 100000\n      [\n        Array.new(n) { rand(Int32) },\n\
    \        Array.new(n) { rand(100) },\n        (1..n).to_a,\n        (1..n).to_a.reverse,\n\
    \      ].each do |values|\n        a = BinaryHeap(Int32).new\n        values.each\
    \ { |x| a << x }\n        a.sort.should eq values.sort\n      end\n    end\n\n\
    \    it \"has compare proc\" do\n      n = 100000\n      [\n        Array.new(n)\
    \ { rand(Int32) },\n        Array.new(n) { rand(100) },\n        (1..n).to_a,\n\
    \        (1..n).to_a.reverse,\n      ].each do |values|\n        a = BinaryHeap(Int32).new\
    \ { |a, b| b <=> a }\n        values.each { |x| a << x }\n        a.sort.should\
    \ eq values.sort_by(&.-)\n      end\n    end\n  end\n\n  describe \"generics\"\
    \ do\n    it \"Float64\" do\n      BinaryHeap{1.1, 2.2, 3.3}.to_a.should eq [1.1,\
    \ 2.2, 3.3]\n    end\n\n    it \"String\" do\n      BinaryHeap.new(%w[D C B A]).to_a.should\
    \ eq %w[A B C D]\n    end\n  end\nend\n"
  code: "require \"spec\"\nrequire \"../../src/datastructure/binary_heap\"\n\ndescribe\
    \ BinaryHeap do\n  describe \".new\" do\n    it \"creates empty heap\" do\n  \
    \    a = BinaryHeap(Int32).new\n      a << 3 << 1 << 2\n      a.sort.should eq\
    \ [1, 2, 3]\n    end\n\n    it \"creates with enumerable\" do\n      a = BinaryHeap(Int32).new(1..9)\n\
    \      a.sort.should eq (1..9).to_a\n    end\n\n    it \"creates with compare\
    \ block\" do\n      a = BinaryHeap(Int32).new { |a, b| b <=> a }\n      a << 3\
    \ << 1 << 2\n      a.sort.should eq [3, 2, 1]\n    end\n\n    it \"creates with\
    \ enumerable and compare block\" do\n      a = BinaryHeap(Int32).new(1..9) { |a,\
    \ b| b <=> a }\n      a.sort.should eq (1..9).reverse_each.to_a\n    end\n  end\n\
    \n  it \"BinaryHeap{}\" do\n    a = BinaryHeap{3, 1, 2}\n    a.sort.should eq\
    \ [1, 2, 3]\n  end\n\n  it \"#size\" do\n    BinaryHeap(Int32).new.size.should\
    \ eq 0\n    BinaryHeap{1, 2, 3}.size.should eq 3\n  end\n\n  it \"#empty?\" do\n\
    \    BinaryHeap(Int32).new.should be_empty\n    BinaryHeap{1, 2, 3}.should_not\
    \ be_empty\n  end\n\n  it \"#clear\" do\n    a = BinaryHeap{1, 2, 3}\n    a.clear.should\
    \ be a\n    a.should be_empty\n  end\n\n  it \"#dup\" do\n    a = BinaryHeap{[1],\
    \ [2], [3]}\n    b = a.dup\n    b.should eq a\n    b.should_not be a\n    a.top.should\
    \ be b.top\n  end\n\n  it \"#clone\" do\n    a = BinaryHeap{[1], [2], [3]}\n \
    \   b = a.clone\n    b.should eq a\n    b.should_not be a\n    a.top.should_not\
    \ be b.top\n  end\n\n  describe \"compare\" do\n    a = BinaryHeap{1, 2, 3}\n\
    \    b = BinaryHeap{3, 2, 1}\n    c = BinaryHeap{1, 2}\n\n    it \"#==\" do\n\
    \      (a == b).should be_true\n      (a == c).should be_false\n    end\n\n  \
    \  it \"#!=\" do\n      (a != b).should be_false\n      (a != c).should be_true\n\
    \    end\n  end\n\n  describe \"#top\" do\n    context \"when heap is not empty\"\
    \ do\n      it \"returns top element\" do\n        a = BinaryHeap{3, 1, 2}\n \
    \       a.top.should eq 1\n        a.top?.should eq 1\n        a.top { \"none\"\
    \ }.should eq 1\n      end\n    end\n\n    context \"when heap is empty\" do\n\
    \      it \"returns top element\" do\n        a = BinaryHeap(Int32).new\n    \
    \    expect_raises(IndexError) { a.top }\n        a.top?.should be_nil\n     \
    \   a.top { \"none\" }.should eq \"none\"\n      end\n    end\n  end\n\n  it \"\
    #add, #<<\" do\n    a = BinaryHeap(Int32).new\n    a.add(1).add(2).should be a\n\
    \    (a << 1 << 2 << 3).should be a\n    a.sort.should eq [1, 1, 2, 2, 3]\n  end\n\
    \n  describe \"#pop\" do\n    it \"pops when heap is not empty\" do\n      a =\
    \ BinaryHeap{1, 2, 3}\n      a.pop.should eq 1\n      a.pop?.should eq 2\n   \
    \   a.pop { \"none\" }.should eq 3\n    end\n\n    it \"pops when heap is empty\"\
    \ do\n      a = BinaryHeap(Int32).new\n      expect_raises(IndexError) { a.pop\
    \ }\n      a.pop?.should be_nil\n      a.pop { \"none\" }.should eq \"none\"\n\
    \    end\n\n    it \"pops many elements\" do\n      a = BinaryHeap{1, 2, 3, 4,\
    \ 5}\n      a.pop(3).should eq [1, 2, 3]\n      a.sort.should eq [4, 5]\n    \
    \  a.pop(2).should eq [4, 5]\n      a.sort.should eq [] of Int32\n    end\n\n\
    \    it \"pops more elements that what is available\" do\n      a = BinaryHeap{1,\
    \ 2, 3, 4, 5}\n      a.pop(9).should eq [1, 2, 3, 4, 5]\n      a.should be_empty\n\
    \      a.pop(1).should eq [] of Int32\n    end\n\n    it \"raises if pops negative\
    \ number of elements\" do\n      a = BinaryHeap{1, 2}\n      expect_raises(ArgumentError)\
    \ { a.pop(-1) }\n    end\n  end\n\n  describe \"#each\" do\n    a = BinaryHeap{3,\
    \ 1, 2}\n\n    it \"receives block\" do\n      b = [] of Int32\n      a.each {\
    \ |x| b << x }\n      b.sort.should eq [1, 2, 3]\n    end\n\n    it \"returns\
    \ Iterator\" do\n      a.each.should be_a Iterator(Int32)\n      a.each.min.should\
    \ eq 1\n      a.each.max.should eq 3\n      a.each.cycle(2).to_a.sort.should eq\
    \ [1, 1, 2, 2, 3, 3]\n    end\n  end\n\n  it \"#sort\" do\n    a = BinaryHeap{3,\
    \ 1, 2}\n    a.sort.should eq [1, 2, 3]\n    b = BinaryHeap.new([1, 2, 3]) { |a,\
    \ b| b <=> a }\n    b.sort.should eq [3, 2, 1]\n  end\n\n  it \"#to_a\" do\n \
    \   a = BinaryHeap{3, 1, 2}\n    a.to_a.sort.should eq [1, 2, 3]\n    a = BinaryHeap{3,\
    \ 1, 4, 1, 5}\n    a.to_a.sort.should eq [1, 1, 3, 4, 5]\n  end\n\n  it \"#to_s,\
    \ #inspect\" do\n    a = BinaryHeap{3, 1, 4}\n    a.to_s.should eq \"BinaryHeap{1,\
    \ 3, 4}\"\n    a.inspect.should eq \"BinaryHeap{1, 3, 4}\"\n  end\n\n  it \"includes\
    \ Enumerable(T)\" do\n    a = BinaryHeap{1, 2, 3}\n    a.sort.should eq [1, 2,\
    \ 3]\n    a.min.should eq 1\n    a.max.should eq 3\n  end\n\n  it \"includes Iterable(T)\"\
    \ do\n    a = BinaryHeap{1, 2, 3}\n    a.cycle(2).should be_a Iterator(Int32)\n\
    \    a.cycle(2).to_a.should eq [1, 2, 3, 1, 2, 3]\n    a.each_cons(2).to_a.should\
    \ eq [[1, 2], [2, 3]]\n  end\n\n  describe \"big test\" do\n    it \"hasn't compare\
    \ proc\" do\n      n = 100000\n      [\n        Array.new(n) { rand(Int32) },\n\
    \        Array.new(n) { rand(100) },\n        (1..n).to_a,\n        (1..n).to_a.reverse,\n\
    \      ].each do |values|\n        a = BinaryHeap(Int32).new\n        values.each\
    \ { |x| a << x }\n        a.sort.should eq values.sort\n      end\n    end\n\n\
    \    it \"has compare proc\" do\n      n = 100000\n      [\n        Array.new(n)\
    \ { rand(Int32) },\n        Array.new(n) { rand(100) },\n        (1..n).to_a,\n\
    \        (1..n).to_a.reverse,\n      ].each do |values|\n        a = BinaryHeap(Int32).new\
    \ { |a, b| b <=> a }\n        values.each { |x| a << x }\n        a.sort.should\
    \ eq values.sort_by(&.-)\n      end\n    end\n  end\n\n  describe \"generics\"\
    \ do\n    it \"Float64\" do\n      BinaryHeap{1.1, 2.2, 3.3}.to_a.should eq [1.1,\
    \ 2.2, 3.3]\n    end\n\n    it \"String\" do\n      BinaryHeap.new(%w[D C B A]).to_a.should\
    \ eq %w[A B C D]\n    end\n  end\nend\n"
  dependsOn:
  - src/datastructure/binary_heap.cr
  isVerificationFile: false
  path: spec/datastructure/binary_heap_spec.cr
  requiredBy: []
  timestamp: '2022-04-14 22:03:16+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/datastructure/binary_heap_spec.cr
layout: document
redirect_from:
- /library/spec/datastructure/binary_heap_spec.cr
- /library/spec/datastructure/binary_heap_spec.cr.html
title: spec/datastructure/binary_heap_spec.cr
---
