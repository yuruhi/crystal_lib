---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: benchmarks/datastructure/binary_heap.cr
    title: benchmarks/datastructure/binary_heap.cr
  - icon: ':warning:'
    path: spec/datastructure/binary_heap_spec.cr
    title: spec/datastructure/binary_heap_spec.cr
  - icon: ':warning:'
    path: src/datastructure/slope_trick.cr
    title: src/datastructure/slope_trick.cr
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/datastructure/binary_heap_test.cr
    title: test/datastructure/binary_heap_test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "class BinaryHeap(T)\n  # Creates a new empty heap.\n  def initialize\n\
    \    @heap = Array(T).new\n    @compare_proc = nil\n  end\n\n  # Creates a new\
    \ empty heap backed by a buffer that is initially *initial_capacity* big (default:\
    \ `0`).\n  #\n  # ```\n  # a = BinaryHeap.new(3)\n  # a << 3 << 1 << 2\n  # a.pop\
    \ # => 1\n  # a.pop # => 2\n  # a.pop # => 3\n  # ```\n  def initialize(initial_capacity\
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
    \ : IO) : Nil\n    to_s(io)\n  end\nend\n"
  code: "class BinaryHeap(T)\n  # Creates a new empty heap.\n  def initialize\n  \
    \  @heap = Array(T).new\n    @compare_proc = nil\n  end\n\n  # Creates a new empty\
    \ heap backed by a buffer that is initially *initial_capacity* big (default: `0`).\n\
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
    \ : IO) : Nil\n    to_s(io)\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/datastructure/binary_heap.cr
  requiredBy:
  - benchmarks/datastructure/binary_heap.cr
  - src/datastructure/slope_trick.cr
  - spec/datastructure/binary_heap_spec.cr
  timestamp: '2021-11-14 01:52:04+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/datastructure/binary_heap_test.cr
documentation_of: src/datastructure/binary_heap.cr
layout: document
redirect_from:
- /library/src/datastructure/binary_heap.cr
- /library/src/datastructure/binary_heap.cr.html
title: src/datastructure/binary_heap.cr
---
