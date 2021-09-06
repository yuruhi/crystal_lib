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
  bundledCode: "require \"benchmark\"\n\n# require \"../../src/datastructure/binary_heap\"\
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
    \ { pop }\n  end\n\n  def each(&block)\n    @heap.sort { |a, b| @compare_proc.call(a,\
    \ b) }.each do |x|\n      yield x\n    end\n  end\n\n  def to_s(io : IO) : Nil\n\
    \    io << \"BinaryHeap{\"\n    each_with_index do |x, i|\n      io << \", \"\
    \ if i > 0\n      io << x\n    end\n    io << '}'\n  end\n\n  def inspect(io :\
    \ IO) : Nil\n    to_s(io)\n  end\nend\n\ndef benchmark(label, values : Array(T))\
    \ forall T\n  Benchmark.ips do |x|\n    x.report(label) do\n      a = BinaryHeap(T).new\n\
    \      values.each { |x| a.add x }\n      values.size.times { a.pop }\n    end\n\
    \  end\nend\n\nbenchmark \"Int32 10^2 sparse\", Array.new(10**2) { |i| i }\nbenchmark\
    \ \"Int32 10^2 dence\", Array.new(10**2) { |i| i % 10 }\nbenchmark \"Int32 10^6\
    \ sparse\", Array.new(10**6) { |i| i }\nbenchmark \"Int32 10^6 dence\", Array.new(10**6)\
    \ { |i| i % 100 }\n\nr = Random.new(12345)\nbenchmark \"Array 10^5 * 10^2\", Array.new(10**5)\
    \ { Array.new(10**2) { r.rand(100) } }\n"
  code: "require \"benchmark\"\nrequire \"../../src/datastructure/binary_heap\"\n\n\
    def benchmark(label, values : Array(T)) forall T\n  Benchmark.ips do |x|\n   \
    \ x.report(label) do\n      a = BinaryHeap(T).new\n      values.each { |x| a.add\
    \ x }\n      values.size.times { a.pop }\n    end\n  end\nend\n\nbenchmark \"\
    Int32 10^2 sparse\", Array.new(10**2) { |i| i }\nbenchmark \"Int32 10^2 dence\"\
    , Array.new(10**2) { |i| i % 10 }\nbenchmark \"Int32 10^6 sparse\", Array.new(10**6)\
    \ { |i| i }\nbenchmark \"Int32 10^6 dence\", Array.new(10**6) { |i| i % 100 }\n\
    \nr = Random.new(12345)\nbenchmark \"Array 10^5 * 10^2\", Array.new(10**5) { Array.new(10**2)\
    \ { r.rand(100) } }\n"
  dependsOn:
  - src/datastructure/binary_heap.cr
  isVerificationFile: false
  path: benchmarks/datastructure/binary_heap.cr
  requiredBy: []
  timestamp: '2021-09-06 18:03:52+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: benchmarks/datastructure/binary_heap.cr
layout: document
redirect_from:
- /library/benchmarks/datastructure/binary_heap.cr
- /library/benchmarks/datastructure/binary_heap.cr.html
title: benchmarks/datastructure/binary_heap.cr
---