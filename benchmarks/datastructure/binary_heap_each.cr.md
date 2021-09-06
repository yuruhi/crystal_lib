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
    \ { |i| pop }\n  end\n\n  def each(&block)\n    @heap.sort { |a, b| @compare_proc.call(a,\
    \ b) }.each do |x|\n      yield x\n    end\n  end\n\n  def to_s(io : IO) : Nil\n\
    \    io << \"BinaryHeap{\"\n    each_with_index do |x, i|\n      io << \", \"\
    \ if i > 0\n      io << x\n    end\n    io << '}'\n  end\n\n  def inspect(io :\
    \ IO) : Nil\n    to_s(io)\n  end\nend\n\nclass BinaryHeap(T)\n  def each_clone\n\
    \    heap = clone\n    while v = heap.pop?\n      yield v\n    end\n  end\n\n\
    \  def each_sort\n    @heap.sort.each do |x|\n      yield x\n    end\n  end\n\
    end\n\ndef benchmark_each(label, a : Array)\n  n = a.size\n  heap = BinaryHeap.new\
    \ a\n\n  puts \"#{label}: \"\n  Benchmark.ips do |x|\n    x.report(\"each_clone\"\
    ) do\n      heap.each_clone { |x| }\n    end\n    x.report(\"each_sort\") do\n\
    \      heap.each_sort { |x| }\n    end\n  end\n  puts\n\n  raise \"\" unless a.size\
    \ == n\nend\n\nbenchmark_each \"Int32 10^2 sparse\", Array.new(10**2) { |i| i\
    \ }\nbenchmark_each \"Int32 10^2 dence\", Array.new(10**2) { |i| i % 10 }\nbenchmark_each\
    \ \"Int32 10^6 sparse\", Array.new(10**6) { |i| i }\nbenchmark_each \"Int32 10^6\
    \ dence\", Array.new(10**6) { |i| i % 100 }\n\nr = Random.new(12345)\nbenchmark_each\
    \ \"Array 10^5 * 10^1\", Array.new(10**5) { Array.new(10**1) { r.rand(Int32) }\
    \ }\nbenchmark_each \"Array 10^4 * 10^2\", Array.new(10**4) { Array.new(10**2)\
    \ { r.rand(Int32) } }\nbenchmark_each \"Array 10^2 * 10^4\", Array.new(10**2)\
    \ { Array.new(10**4) { r.rand(Int32) } }\nbenchmark_each \"Array 10^1 * 10^5\"\
    , Array.new(10**1) { Array.new(10**5) { r.rand(Int32) } }\n\n# Int32 10^2 sparse:\n\
    # each_clone 166.16k (  6.02\xB5s) (\xB1 2.98%)  528B/op   6.22\xD7 slower\n#\
    \  each_sort   1.03M (967.15ns) (\xB1 4.73%)  832B/op        fastest\n\n# Int32\
    \ 10^2 dence:\n# each_clone 148.79k (  6.72\xB5s) (\xB110.08%)  528B/op   5.01\xD7\
    \ slower\n#  each_sort 745.52k (  1.34\xB5s) (\xB1 8.87%)  832B/op        fastest\n\
    \n# Int32 10^6 sparse:\n# each_clone   3.91  (255.97ms) (\xB1 6.17%)  3.81MB/op\
    \  23.58\xD7 slower\n#  each_sort  92.14  ( 10.85ms) (\xB1 6.50%)   6.0MB/op \
    \       fastest\n\n# Int32 10^6 dence:\n# each_clone   3.89  (257.24ms) (\xB1\
    \ 5.56%)  3.81MB/op   7.01\xD7 slower\n#  each_sort  27.24  ( 36.71ms) (\xB1 5.54%)\
    \   6.0MB/op        fastest\n\n# Array 10^5 * 10^1:\n# each_clone  13.36  ( 74.83ms)\
    \ (\xB1 5.50%)  8.39MB/op   3.09\xD7 slower\n#  each_sort  41.34  ( 24.19ms) (\xB1\
    \ 7.81%)   1.5MB/op        fastest\n\n# Array 10^4 * 10^2:\n# each_clone  95.59\
    \  ( 10.46ms) (\xB1 4.96%)  4.65MB/op   6.44\xD7 slower\n#  each_sort 615.37 \
    \ (  1.63ms) (\xB1 5.48%)  96.1kB/op        fastest\n\n# Array 10^2 * 10^4:\n\
    # each_clone 885.26  (  1.13ms) (\xB1 5.04%)  3.82MB/op   7.80\xD7 slower\n# \
    \ each_sort   6.90k (144.85\xB5s) (\xB1 7.93%)  2.03kB/op        fastest\n\n#\
    \ Array 10^1 * 10^5:\n# each_clone 325.20  (  3.08ms) (\xB1 8.73%)  3.81MB/op\
    \  13893.74\xD7 slower\n#  each_sort   4.52M (221.33ns) (\xB1 8.63%)    144B/op\
    \           fastest\n"
  code: "require \"benchmark\"\nrequire \"../../src/datastructure/binary_heap\"\n\n\
    class BinaryHeap(T)\n  def each_clone\n    heap = clone\n    while v = heap.pop?\n\
    \      yield v\n    end\n  end\n\n  def each_sort\n    @heap.sort.each do |x|\n\
    \      yield x\n    end\n  end\nend\n\ndef benchmark_each(label, a : Array)\n\
    \  n = a.size\n  heap = BinaryHeap.new a\n\n  puts \"#{label}: \"\n  Benchmark.ips\
    \ do |x|\n    x.report(\"each_clone\") do\n      heap.each_clone { |x| }\n   \
    \ end\n    x.report(\"each_sort\") do\n      heap.each_sort { |x| }\n    end\n\
    \  end\n  puts\n\n  raise \"\" unless a.size == n\nend\n\nbenchmark_each \"Int32\
    \ 10^2 sparse\", Array.new(10**2) { |i| i }\nbenchmark_each \"Int32 10^2 dence\"\
    , Array.new(10**2) { |i| i % 10 }\nbenchmark_each \"Int32 10^6 sparse\", Array.new(10**6)\
    \ { |i| i }\nbenchmark_each \"Int32 10^6 dence\", Array.new(10**6) { |i| i % 100\
    \ }\n\nr = Random.new(12345)\nbenchmark_each \"Array 10^5 * 10^1\", Array.new(10**5)\
    \ { Array.new(10**1) { r.rand(Int32) } }\nbenchmark_each \"Array 10^4 * 10^2\"\
    , Array.new(10**4) { Array.new(10**2) { r.rand(Int32) } }\nbenchmark_each \"Array\
    \ 10^2 * 10^4\", Array.new(10**2) { Array.new(10**4) { r.rand(Int32) } }\nbenchmark_each\
    \ \"Array 10^1 * 10^5\", Array.new(10**1) { Array.new(10**5) { r.rand(Int32) }\
    \ }\n\n# Int32 10^2 sparse:\n# each_clone 166.16k (  6.02\xB5s) (\xB1 2.98%) \
    \ 528B/op   6.22\xD7 slower\n#  each_sort   1.03M (967.15ns) (\xB1 4.73%)  832B/op\
    \        fastest\n\n# Int32 10^2 dence:\n# each_clone 148.79k (  6.72\xB5s) (\xB1\
    10.08%)  528B/op   5.01\xD7 slower\n#  each_sort 745.52k (  1.34\xB5s) (\xB1 8.87%)\
    \  832B/op        fastest\n\n# Int32 10^6 sparse:\n# each_clone   3.91  (255.97ms)\
    \ (\xB1 6.17%)  3.81MB/op  23.58\xD7 slower\n#  each_sort  92.14  ( 10.85ms) (\xB1\
    \ 6.50%)   6.0MB/op        fastest\n\n# Int32 10^6 dence:\n# each_clone   3.89\
    \  (257.24ms) (\xB1 5.56%)  3.81MB/op   7.01\xD7 slower\n#  each_sort  27.24 \
    \ ( 36.71ms) (\xB1 5.54%)   6.0MB/op        fastest\n\n# Array 10^5 * 10^1:\n\
    # each_clone  13.36  ( 74.83ms) (\xB1 5.50%)  8.39MB/op   3.09\xD7 slower\n# \
    \ each_sort  41.34  ( 24.19ms) (\xB1 7.81%)   1.5MB/op        fastest\n\n# Array\
    \ 10^4 * 10^2:\n# each_clone  95.59  ( 10.46ms) (\xB1 4.96%)  4.65MB/op   6.44\xD7\
    \ slower\n#  each_sort 615.37  (  1.63ms) (\xB1 5.48%)  96.1kB/op        fastest\n\
    \n# Array 10^2 * 10^4:\n# each_clone 885.26  (  1.13ms) (\xB1 5.04%)  3.82MB/op\
    \   7.80\xD7 slower\n#  each_sort   6.90k (144.85\xB5s) (\xB1 7.93%)  2.03kB/op\
    \        fastest\n\n# Array 10^1 * 10^5:\n# each_clone 325.20  (  3.08ms) (\xB1\
    \ 8.73%)  3.81MB/op  13893.74\xD7 slower\n#  each_sort   4.52M (221.33ns) (\xB1\
    \ 8.63%)    144B/op           fastest\n"
  dependsOn:
  - src/datastructure/binary_heap.cr
  isVerificationFile: false
  path: benchmarks/datastructure/binary_heap_each.cr
  requiredBy: []
  timestamp: '2021-09-06 17:57:55+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: benchmarks/datastructure/binary_heap_each.cr
layout: document
redirect_from:
- /library/benchmarks/datastructure/binary_heap_each.cr
- /library/benchmarks/datastructure/binary_heap_each.cr.html
title: benchmarks/datastructure/binary_heap_each.cr
---
