---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/datastructure/red_black_tree.cr
    title: src/datastructure/red_black_tree.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"benchmark\"\n\n# require \"../../src/datastructure/red_black_tree\"\
    \n# Copied with modifications from: https://github.com/crystal-lang/crystal/blob/1.1.1/samples/red_black_tree.cr\n\
    macro define_red_black_tree(name, type, nil_key)\nclass {{name}}\n  class Node\n\
    \    enum Color\n      Red\n      Black\n    end\n\n    property color : Color,\
    \ key : {{type}}\n    property! left : self, right : self, parent : self\n\n \
    \   def initialize(@key, @color : Color = :red)\n      @left = @right = @parent\
    \ = NilNode.instance\n    end\n\n    delegate black?, to: @color\n    delegate\
    \ red?, to: @color\n\n    def nil_node?\n      false\n    end\n\n    def min_node\
    \ : Node\n      x = self\n      until x.left.nil_node?\n        x = x.left\n \
    \     end\n      x\n    end\n\n    def max_node : Node\n      x = self\n     \
    \ until x.right.nil_node?\n        x = x.right\n      end\n      x\n    end\n\n\
    \    def succ : Node\n      unless right.nil_node?\n        return right.min_node\n\
    \      end\n      x, y = self, parent\n      until y.nil_node? || x == y.left\n\
    \        x = y\n        y = y.parent\n      end\n      y\n    end\n\n    def pred\
    \ : Node\n      unless left.nil_node?\n        return left.max_node\n      end\n\
    \      x, y = self, parent\n      until y.nil_node? || x == y.right\n        x\
    \ = y\n        y = y.parent\n      end\n      y\n    end\n\n    def to_s(io :\
    \ IO)\n      io << '[' << key << ']'\n    end\n\n    def inspect(io)\n      to_s(io)\n\
    \    end\n  end\n\n  class NilNode < Node\n    def self.instance\n      @@instance\
    \ ||= NilNode.new\n    end\n\n    def initialize\n      @key = {{nil_key}}\n \
    \     @color = :black\n      @left = @right = @parent = self\n    end\n\n    def\
    \ nil_node?\n      true\n    end\n\n    def to_s(io : IO)\n      io << \"NilNode\"\
    \n    end\n\n    def inspect(io)\n      to_s(io)\n    end\n  end\n\n  class EmptyError\
    \ < Exception\n    def initialize(message = \"Empty RedBlackTree\")\n      super(message)\n\
    \    end\n  end\n\n\talias T = {{type}}\n  include Enumerable(T)\n\n  def initialize\n\
    \    @root = NilNode.instance\n    @size = 0\n  end\n\n  def initialize(enumerable\
    \ : Enumerable(T))\n    initialize\n    enumerable.each { |x| add(x) }\n  end\n\
    \n  getter root : Node, size : Int32\n\n  def empty? : Bool\n    root.nil_node?\n\
    \  end\n\n  def insert_node(x : Node) : Nil\n    insert_helper(x)\n\n    x.color\
    \ = :red\n    while x != root && x.parent.red?\n      if x.parent == x.parent.parent.left\n\
    \        y = x.parent.parent.right\n        if !y.nil_node? && y.red?\n      \
    \    x.parent.color = :black\n          y.color = :black\n          x.parent.parent.color\
    \ = :red\n          x = x.parent.parent\n        else\n          if x == x.parent.right\n\
    \            x = x.parent\n            left_rotate(x)\n          end\n       \
    \   x.parent.color = :black\n          x.parent.parent.color = :red\n        \
    \  right_rotate(x.parent.parent)\n        end\n      else\n        y = x.parent.parent.left\n\
    \        if !y.nil_node? && y.red?\n          x.parent.color = :black\n      \
    \    y.color = :black\n          x.parent.parent.color = :red\n          x = x.parent.parent\n\
    \        else\n          if x == x.parent.left\n            x = x.parent\n   \
    \         right_rotate(x)\n          end\n          x.parent.color = :black\n\
    \          x.parent.parent.color = :red\n          left_rotate(x.parent.parent)\n\
    \        end\n      end\n    end\n    root.color = :black\n  end\n\n  def delete_node(z\
    \ : Node) : Nil\n    y = (z.left.nil_node? || z.right.nil_node?) ? z : z.succ\n\
    \    x = y.left.nil_node? ? y.right : y.left\n    x.parent = y.parent\n\n    if\
    \ y.parent.nil_node?\n      @root = x\n    else\n      if y == y.parent.left\n\
    \        y.parent.left = x\n      else\n        y.parent.right = x\n      end\n\
    \    end\n\n    z.key = y.key if y != z\n\n    if y.black?\n      delete_fixup(x)\n\
    \    end\n\n    @size -= 1\n    y\n  end\n\n  def add(key : T) : self\n    insert_node(Node.new(key))\n\
    \    self\n  end\n\n  def <<(key : T) : self\n    add(key)\n  end\n\n  def delete(key\
    \ : T) : Bool\n    node = search(key)\n    unless node.nil_node?\n      delete_node(node)\n\
    \      true\n    else\n      false\n    end\n  end\n\n  def min_node : Node\n\
    \    root.min_node\n  end\n\n  def max_node : Node\n    root.max_node\n  end\n\
    \n  def min? : T?\n    node = self.min_node\n    node.nil_node? ? nil : node.key\n\
    \  end\n\n  def min : T\n    min? || raise EmptyError.new\n  end\n\n  def max?\
    \ : T?\n    node = self.max_node\n    node.nil_node? ? nil : node.key\n  end\n\
    \n  def max : T\n    max? || raise EmptyError.new\n  end\n\n  def inorder_walk(x\
    \ : Node) : Nil\n    until x.nil_node?\n      yield x.key\n      x = x.succ\n\
    \    end\n  end\n\n  def each : Nil\n    inorder_walk(self.min_node) { |k| yield\
    \ k }\n  end\n\n  def reverse_inorder_walk(x : Node) : Nil\n    until x.nil_node?\n\
    \      yield x.key\n      x = x.pred\n    end\n  end\n\n  def reverse_each : Nil\n\
    \    reverse_inorder_walk(self.max_node) { |k| yield k }\n  end\n\n  def includes?(key\
    \ : T) : Bool\n    x = root\n    loop do\n      return false if x.nil_node?\n\
    \      return true if x.key == key\n      x = key < x.key ? x.left : x.right\n\
    \    end\n  end\n\n  def search(key : T, x : Node = root) : Node\n    until x.nil_node?\
    \ || x.key == key\n      x = key < x.key ? x.left : x.right\n    end\n    x\n\
    \  end\n\n  def le_node(key : T, x : Node = root) : Node\n    loop do\n      y\
    \ = key < x.key ? x.left : x.right\n      if y.nil_node?\n        return key <\
    \ x.key ? x.pred : x\n      end\n      x = y\n    end\n  end\n\n  def lt_node(key\
    \ : T, x : Node = root) : Node\n    loop do\n      y = key <= x.key ? x.left :\
    \ x.right\n      if y.nil_node?\n        return key <= x.key ? x.pred : x\n  \
    \    end\n      x = y\n    end\n  end\n\n  def ge_node(key : T, x : Node = root)\
    \ : Node\n    loop do\n      y = key <= x.key ? x.left : x.right\n      if y.nil_node?\n\
    \        return key <= x.key ? x : x.succ\n      end\n      x = y\n    end\n \
    \ end\n\n  def gt_node(key : T, x : Node = root) : Node\n    loop do\n      y\
    \ = key < x.key ? x.left : x.right\n      if y.nil_node?\n        return key <\
    \ x.key ? x : x.succ\n      end\n      x = y\n    end\n  end\n\n  {% for method\
    \ in [:le, :lt, :ge, :gt] %}\n    def {{method.id}}(key : T ) : T?\n      node\
    \ = {{method.id}}_node(key)\n      node.nil_node? ? nil : node.key\n    end\n\n\
    \    def {{method.id}}!(key : T) : T\n      {{method.id}}(key).not_nil!\n    end\n\
    \  {% end %}\n\n  def black_height(x : Node = root)\n    height = 0\n    until\
    \ x.nil_node?\n      x = x.left\n      height += 1 if x.nil_node? || x.black?\n\
    \    end\n    height\n  end\n\n  def to_s(io : IO) : Nil\n    io << \"RedBlackTree{\"\
    \n    each_with_index do |x, i|\n      io << \", \" if i > 0\n      io << x\n\
    \    end\n    io << '}'\n  end\n\n  def inspect(io : IO) : Nil\n    to_s(io)\n\
    \  end\n\n  private def left_rotate(x : Node)\n    raise \"x.right is nil!\" if\
    \ x.right.nil_node?\n    y = x.right\n    x.right = y.left\n    y.left.parent\
    \ = x if !y.left.nil_node?\n    y.parent = x.parent\n    if x.parent.nil_node?\n\
    \      @root = y\n    else\n      if x == x.parent.left\n        x.parent.left\
    \ = y\n      else\n        x.parent.right = y\n      end\n    end\n    y.left\
    \ = x\n    x.parent = y\n  end\n\n  private def right_rotate(x : Node)\n    raise\
    \ \"x.left is nil!\" if x.left.nil_node?\n    y = x.left\n    x.left = y.right\n\
    \    y.right.parent = x if !y.right.nil_node?\n    y.parent = x.parent\n    if\
    \ x.parent.nil_node?\n      @root = y\n    else\n      if x == x.parent.left\n\
    \        x.parent.left = y\n      else\n        x.parent.right = y\n      end\n\
    \    end\n    y.right = x\n    x.parent = y\n  end\n\n  private def insert_helper(z\
    \ : Node)\n    y = NilNode.instance\n    x = root\n    while !x.nil_node?\n  \
    \    y = x\n      x = (z.key < x.key) ? x.left : x.right\n    end\n    z.parent\
    \ = y\n    if y.nil_node?\n      @root = z\n    else\n      z.key < y.key ? y.left\
    \ = z : y.right = z\n    end\n    @size += 1\n  end\n\n  private def delete_fixup(x\
    \ : Node)\n    while x != root && x.black?\n      if x == x.parent.left\n    \
    \    w = x.parent.right\n        if w.red?\n          w.color = :black\n     \
    \     x.parent.color = :red\n          left_rotate(x.parent)\n          w = x.parent.right\n\
    \        end\n        if w.left.black? && w.right.black?\n          w.color =\
    \ :red\n          x = x.parent\n        else\n          if w.right.black?\n  \
    \          w.left.color = :black\n            w.color = :red\n            right_rotate(w)\n\
    \            w = x.parent.right\n          end\n          w.color = x.parent.color\n\
    \          x.parent.color = :black\n          w.right.color = :black\n       \
    \   left_rotate(x.parent)\n          x = root\n        end\n      else\n     \
    \   w = x.parent.left\n        if w.red?\n          w.color = :black\n       \
    \   x.parent.color = :red\n          right_rotate(x.parent)\n          w = x.parent.left\n\
    \        end\n        if w.right.black? && w.left.black?\n          w.color =\
    \ :red\n          x = x.parent\n        else\n          if w.left.black?\n   \
    \         w.right.color = :black\n            w.color = :red\n            left_rotate(w)\n\
    \            w = x.parent.left\n          end\n          w.color = x.parent.color\n\
    \          x.parent.color = :black\n          w.left.color = :black\n        \
    \  right_rotate(x.parent)\n          x = root\n        end\n      end\n    end\n\
    \    x.color = :black\n  end\nend\nend\n\nclass Foo\n  getter x\n  include Comparable(Foo)\n\
    \n  def initialize(@x = 0)\n  end\n\n  def <=>(other : Foo)\n    x <=> other.x\n\
    \  end\nend\n\nR = Random.new(12345)\ndefine_red_black_tree(RBT_Int32, Int32,\
    \ 0)\ndefine_red_black_tree(RBT_Array, Array(Int32), [] of Int32)\ndefine_red_black_tree(RBT_Class,\
    \ Foo, Foo.new)\n\ndef benchmark(label, type : T.class, values) forall T\n  index\
    \ = (0...values.size).to_a.shuffle Random.new(123)\n  Benchmark.ips do |x|\n \
    \   x.report(label) do\n      a = T.new\n      values.each { |x| a.add x }\n \
    \     index.each { |i| a.delete values[i] }\n    end\n  end\nend\n\nbenchmark\
    \ \"Int32 10^2 sparse\", RBT_Int32, Array.new(10**2) { |i| i }.shuffle(R)\nbenchmark\
    \ \"Int32 10^2 dence \", RBT_Int32, Array.new(10**2) { |i| i % 10 }.shuffle(R)\n\
    benchmark \"Int32 10^6 sparse\", RBT_Int32, Array.new(10**6) { |i| i }.shuffle(R)\n\
    benchmark \"Int32 10^6 dence \", RBT_Int32, Array.new(10**6) { |i| i % 100 }.shuffle(R)\n\
    benchmark \"Array 10^6 * 10^2\", RBT_Array, Array.new(10**6) { Array.new(10**2)\
    \ { R.rand(100) } }\nbenchmark \"class 10^6       \", RBT_Class, Array.new(10**6)\
    \ { Foo.new R.rand(100) }\n"
  code: "require \"benchmark\"\nrequire \"../../src/datastructure/red_black_tree\"\
    \n\nclass Foo\n  getter x\n  include Comparable(Foo)\n\n  def initialize(@x =\
    \ 0)\n  end\n\n  def <=>(other : Foo)\n    x <=> other.x\n  end\nend\n\nR = Random.new(12345)\n\
    define_red_black_tree(RBT_Int32, Int32, 0)\ndefine_red_black_tree(RBT_Array, Array(Int32),\
    \ [] of Int32)\ndefine_red_black_tree(RBT_Class, Foo, Foo.new)\n\ndef benchmark(label,\
    \ type : T.class, values) forall T\n  index = (0...values.size).to_a.shuffle Random.new(123)\n\
    \  Benchmark.ips do |x|\n    x.report(label) do\n      a = T.new\n      values.each\
    \ { |x| a.add x }\n      index.each { |i| a.delete values[i] }\n    end\n  end\n\
    end\n\nbenchmark \"Int32 10^2 sparse\", RBT_Int32, Array.new(10**2) { |i| i }.shuffle(R)\n\
    benchmark \"Int32 10^2 dence \", RBT_Int32, Array.new(10**2) { |i| i % 10 }.shuffle(R)\n\
    benchmark \"Int32 10^6 sparse\", RBT_Int32, Array.new(10**6) { |i| i }.shuffle(R)\n\
    benchmark \"Int32 10^6 dence \", RBT_Int32, Array.new(10**6) { |i| i % 100 }.shuffle(R)\n\
    benchmark \"Array 10^6 * 10^2\", RBT_Array, Array.new(10**6) { Array.new(10**2)\
    \ { R.rand(100) } }\nbenchmark \"class 10^6       \", RBT_Class, Array.new(10**6)\
    \ { Foo.new R.rand(100) }\n"
  dependsOn:
  - src/datastructure/red_black_tree.cr
  isVerificationFile: false
  path: benchmarks/datastructure/red_black_tree.cr
  requiredBy: []
  timestamp: '2021-09-07 18:59:37+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: benchmarks/datastructure/red_black_tree.cr
layout: document
redirect_from:
- /library/benchmarks/datastructure/red_black_tree.cr
- /library/benchmarks/datastructure/red_black_tree.cr.html
title: benchmarks/datastructure/red_black_tree.cr
---
