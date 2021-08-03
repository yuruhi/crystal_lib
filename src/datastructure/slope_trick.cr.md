---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: atcoder/src/PriorityQueue.cr
    title: atcoder/src/PriorityQueue.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "# require \"../../atcoder/src/PriorityQueue\"\n# ac-library.cr by\
    \ hakatashi https://github.com/google/ac-library.cr\n#\n# Copyright 2021 Google\
    \ LLC\n#\n# Licensed under the Apache License, Version 2.0 (the \"License\");\n\
    # you may not use this file except in compliance with the License.\n# You may\
    \ obtain a copy of the License at\n#\n#      https://www.apache.org/licenses/LICENSE-2.0\n\
    #\n# Unless required by applicable law or agreed to in writing, software\n# distributed\
    \ under the License is distributed on an \"AS IS\" BASIS,\n# WITHOUT WARRANTIES\
    \ OR CONDITIONS OF ANY KIND, either express or implied.\n# See the License for\
    \ the specific language governing permissions and\n# limitations under the License.\n\
    \nmodule AtCoder\n  # Implements standard priority queue like [std::priority_queue](https://en.cppreference.com/w/cpp/container/priority_queue).\n\
    \  #\n  # ```\n  # q = AtCoder::PriorityQueue(Int64).new\n  # q << 1_i64\n  #\
    \ q << 3_i64\n  # q << 2_i64\n  # q.pop # => 3\n  # q.pop # => 2\n  # q.pop #\
    \ => 1\n  # ```\n  class PriorityQueue(T)\n    getter heap : Array(T)\n\n    def\
    \ initialize\n      initialize { |a, b| a <= b }\n    end\n\n    # Initializes\
    \ queue with the custom comperator.\n    #\n    # If the second argument `b` should\
    \ be popped earlier than\n    # the first argument `a`, return `true`. Else, return\
    \ `false`.\n    #\n    # ```\n    # q = AtCoder::PriorityQueue(Int64).new { |a,\
    \ b| a >= b }\n    # q << 1_i64\n    # q << 3_i64\n    # q << 2_i64\n    # q.pop\
    \ # => 1\n    # q.pop # => 2\n    # q.pop # => 3\n    # ```\n    def initialize(&block\
    \ : T, T -> Bool)\n      @heap = Array(T).new\n      @compare_proc = block\n \
    \   end\n\n    # Pushes value into the queue.\n    def push(v : T)\n      @heap\
    \ << v\n      index = @heap.size - 1\n      while index != 0\n        parent =\
    \ (index - 1) // 2\n        if @compare_proc.call(@heap[index], @heap[parent])\n\
    \          break\n        end\n        @heap[parent], @heap[index] = @heap[index],\
    \ @heap[parent]\n        index = parent\n      end\n    end\n\n    # Alias of\
    \ `push`\n    def <<(v : T)\n      push(v)\n    end\n\n    # Pops value from the\
    \ queue.\n    def pop\n      if @heap.size == 0\n        return nil\n      end\n\
    \      if @heap.size == 1\n        return @heap.pop\n      end\n      ret = @heap.first\n\
    \      @heap[0] = @heap.pop\n      index = 0\n      while index * 2 + 1 < @heap.size\n\
    \        child = if index * 2 + 2 < @heap.size && !@compare_proc.call(@heap[index\
    \ * 2 + 2], @heap[index * 2 + 1])\n                  index * 2 + 2\n         \
    \       else\n                  index * 2 + 1\n                end\n        if\
    \ @compare_proc.call(@heap[child], @heap[index])\n          break\n        end\n\
    \        @heap[child], @heap[index] = @heap[index], @heap[child]\n        index\
    \ = child\n      end\n      ret\n    end\n\n    # Returns `true` if the queue\
    \ is empty.\n    delegate :empty?, to: @heap\n\n    # Returns size of the queue.\n\
    \    delegate :size, to: @heap\n  end\nend\n\n# reference: https://maspypy.com/slope-trick-1-%e8%a7%a3%e8%aa%ac%e7%b7%a8\n\
    class SlopeTrick(T)\n  getter min : T, shift : T\n  getter left, right\n\n  #\
    \ Lets `f(x) = 0`\n  def initialize\n    @min = T.zero\n    @shift = T.zero\n\
    \    @left = AtCoder::PriorityQueue(T).new { |a, b| a <= b }\n    @right = AtCoder::PriorityQueue(T).new\
    \ { |a, b| a >= b }\n  end\n\n  # Calculates `f(x)`\n  def f(x : T) : T\n    left.heap.sum\
    \ { |l| Math.max(l - x, T.zero) } +\n      right.heap.sum { |r| Math.max(x - r,\
    \ T.zero) } +\n      min\n  end\n\n  def l0\n    @left.empty? ? nil : @left.heap.first\
    \ + shift\n  end\n\n  def r0\n    @right.empty? ? nil : @right.heap.first + shift\n\
    \  end\n\n  # Adds constant function `a`\n  def add(a : T) : self\n    @min +=\
    \ a\n    self\n  end\n\n  # Adds `max(x - a, 0)`\n  def add_r(a : T) : self\n\
    \    if @left.empty?\n      @right << a - shift\n    else\n      @min += Math.max(l0.not_nil!\
    \ - a, T.zero)\n      @left << a - shift\n      @right << @left.pop.not_nil!\n\
    \    end\n    self\n  end\n\n  # Adds `max(a - x, 0)`\n  def add_l(a : T) : self\n\
    \    if @right.empty?\n      @left << a - shift\n    else\n      @min += Math.max(a\
    \ - r0.not_nil!, T.zero)\n      @right << a - shift\n      @left << @right.pop.not_nil!\n\
    \    end\n    self\n  end\n\n  # Adds `|x - a|`\n  def add_abs(a : T) : self\n\
    \    add_r(a)\n    add_l(a)\n  end\n\n  # `g(x) := min_{y <= x} f(y)`\n  def accumulate_min\
    \ : self\n    @right.heap.clear\n    self\n  end\n\n  # `g(x) := min_{y >= x}\
    \ f(y)`\n  def accumulate_min_right : self\n    @left.heap.clear\n    self\n \
    \ end\n\n  # `g(x) := f(x - a)`\n  def slide(a : T) : self\n    @shift += a\n\
    \    self\n  end\nend\n"
  code: "require \"../../atcoder/src/PriorityQueue\"\n\n# reference: https://maspypy.com/slope-trick-1-%e8%a7%a3%e8%aa%ac%e7%b7%a8\n\
    class SlopeTrick(T)\n  getter min : T, shift : T\n  getter left, right\n\n  #\
    \ Lets `f(x) = 0`\n  def initialize\n    @min = T.zero\n    @shift = T.zero\n\
    \    @left = AtCoder::PriorityQueue(T).new { |a, b| a <= b }\n    @right = AtCoder::PriorityQueue(T).new\
    \ { |a, b| a >= b }\n  end\n\n  # Calculates `f(x)`\n  def f(x : T) : T\n    left.heap.sum\
    \ { |l| Math.max(l - x, T.zero) } +\n      right.heap.sum { |r| Math.max(x - r,\
    \ T.zero) } +\n      min\n  end\n\n  def l0\n    @left.empty? ? nil : @left.heap.first\
    \ + shift\n  end\n\n  def r0\n    @right.empty? ? nil : @right.heap.first + shift\n\
    \  end\n\n  # Adds constant function `a`\n  def add(a : T) : self\n    @min +=\
    \ a\n    self\n  end\n\n  # Adds `max(x - a, 0)`\n  def add_r(a : T) : self\n\
    \    if @left.empty?\n      @right << a - shift\n    else\n      @min += Math.max(l0.not_nil!\
    \ - a, T.zero)\n      @left << a - shift\n      @right << @left.pop.not_nil!\n\
    \    end\n    self\n  end\n\n  # Adds `max(a - x, 0)`\n  def add_l(a : T) : self\n\
    \    if @right.empty?\n      @left << a - shift\n    else\n      @min += Math.max(a\
    \ - r0.not_nil!, T.zero)\n      @right << a - shift\n      @left << @right.pop.not_nil!\n\
    \    end\n    self\n  end\n\n  # Adds `|x - a|`\n  def add_abs(a : T) : self\n\
    \    add_r(a)\n    add_l(a)\n  end\n\n  # `g(x) := min_{y <= x} f(y)`\n  def accumulate_min\
    \ : self\n    @right.heap.clear\n    self\n  end\n\n  # `g(x) := min_{y >= x}\
    \ f(y)`\n  def accumulate_min_right : self\n    @left.heap.clear\n    self\n \
    \ end\n\n  # `g(x) := f(x - a)`\n  def slide(a : T) : self\n    @shift += a\n\
    \    self\n  end\nend\n"
  dependsOn:
  - atcoder/src/PriorityQueue.cr
  isVerificationFile: false
  path: src/datastructure/slope_trick.cr
  requiredBy: []
  timestamp: '2021-07-19 14:20:52+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/datastructure/slope_trick.cr
layout: document
redirect_from:
- /library/src/datastructure/slope_trick.cr
- /library/src/datastructure/slope_trick.cr.html
title: src/datastructure/slope_trick.cr
---
