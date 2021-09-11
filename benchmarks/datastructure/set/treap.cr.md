---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/datastructure/set/treap.cr
    title: src/datastructure/set/treap.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"benchmark\"\n\n# require \"../../../src/datastructure/set/treap\"\
    \n# require \"../binary_tree\"\nmodule TreeNode(T)\n  abstract def key : T\n \
    \ abstract def left\n  abstract def right\n  abstract def parent\n\n  def node?\n\
    \    true\n  end\n\n  def nil_node?\n    false\n  end\n\n  def key? : T?\n   \
    \ key\n  end\n\n  def key! : T\n    key\n  end\n\n  def min_node : self\n    x\
    \ = self\n    while x.left.node?\n      x = x.left\n    end\n    x\n  end\n\n\
    \  def max_node : self\n    x = self\n    while x.right.node?\n      x = x.right\n\
    \    end\n    x\n  end\n\n  def succ : self\n    if right.node?\n      return\
    \ right.min_node\n    end\n    x, y = self, parent\n    while y.node? && x !=\
    \ y.left\n      x = y\n      y = y.parent\n    end\n    y\n  end\n\n  def pred\
    \ : self\n    if left.node?\n      return left.max_node\n    end\n    x, y = self,\
    \ parent\n    while y.node? && x != y.right\n      x = y\n      y = y.parent\n\
    \    end\n    y\n  end\n\n  def to_s(io : IO)\n    io << '[' << key << ']'\n \
    \ end\n\n  def inspect(io : IO)\n    to_s(io)\n  end\nend\n\nmodule TreeNilNode(T)\n\
    \  def node?\n    false\n  end\n\n  def nil_node?\n    true\n  end\n\n  def key?\
    \ : T?\n    nil\n  end\n\n  def key!\n    raise NilAssertionError.new\n  end\n\
    \n  def to_s(io : IO)\n    io << \"NilNode\"\n  end\n\n  def inspect(io : IO)\n\
    \    to_s(io)\n  end\nend\n\nmodule BinaryTree(T, Node, NilNode)\n  class EmptyError\
    \ < Exception\n    def initialize(message = \"Empty RedBlackTree\")\n      super(message)\n\
    \    end\n  end\n\n  include Enumerable(T)\n\n  abstract def root\n  abstract\
    \ def size : Int32\n  abstract def add?(key : T) : Bool\n  abstract def delete(key\
    \ : T) : Bool\n\n  def empty? : Bool\n    root.nil_node?\n  end\n\n  def clear\
    \ : self\n    @root = NilNode.new\n    @size = 0\n    self\n  end\n\n  def add(key\
    \ : T) : self\n    add?(key)\n    self\n  end\n\n  def <<(key : T) : self\n  \
    \  add(key)\n  end\n\n  def rotate_left(x : Node) : Nil\n    raise \"x.right is\
    \ nil!\" if x.right.nil_node?\n    y = x.right\n    x.right = y.left\n    y.left.parent\
    \ = x if y.left.node?\n    y.parent = x.parent\n    if x.parent.nil_node?\n  \
    \    @root = y\n    else\n      if x == x.parent.left\n        x.parent.left =\
    \ y\n      else\n        x.parent.right = y\n      end\n    end\n    y.left =\
    \ x\n    x.parent = y\n  end\n\n  def rotate_right(x : Node) : Nil\n    raise\
    \ \"x.left is nil!\" if x.left.nil_node?\n    y = x.left\n    x.left = y.right\n\
    \    y.right.parent = x if y.right.node?\n    y.parent = x.parent\n    if x.parent.nil_node?\n\
    \      @root = y\n    else\n      if x == x.parent.left\n        x.parent.left\
    \ = y\n      else\n        x.parent.right = y\n      end\n    end\n    y.right\
    \ = x\n    x.parent = y\n  end\n\n  def min_node : Node\n    root.min_node\n \
    \ end\n\n  def max_node : Node\n    root.max_node\n  end\n\n  def min? : T?\n\
    \    min_node.key?\n  end\n\n  def min : T\n    min? || raise EmptyError.new\n\
    \  end\n\n  def max? : T?\n    max_node.key?\n  end\n\n  def max : T\n    max?\
    \ || raise EmptyError.new\n  end\n\n  def inorder_walk(x : Node) : Nil\n    until\
    \ x.nil_node?\n      yield x.key\n      x = x.succ\n    end\n  end\n\n  def each\
    \ : Nil\n    inorder_walk(min_node) { |k| yield k }\n  end\n\n  def reverse_inorder_walk(x\
    \ : Node) : Nil\n    until x.nil_node?\n      yield x.key\n      x = x.pred\n\
    \    end\n  end\n\n  def reverse_each : Nil\n    reverse_inorder_walk(max_node)\
    \ { |k| yield k }\n  end\n\n  def includes?(key : T) : Bool\n    x = root\n  \
    \  loop do\n      return false if x.nil_node?\n      return true if x.key == key\n\
    \      x = key < x.key ? x.left : x.right\n    end\n  end\n\n  def search(key\
    \ : T, x : Node = root) : Node\n    while x.node? && x.key != key\n      x = key\
    \ < x.key ? x.left : x.right\n    end\n    x\n  end\n\n  def le_node(key : T,\
    \ x : Node = root) : Node\n    loop do\n      y = key < x.key ? x.left : x.right\n\
    \      if y.nil_node?\n        return key < x.key ? x.pred : x\n      end\n  \
    \    x = y\n    end\n  end\n\n  def lt_node(key : T, x : Node = root) : Node\n\
    \    loop do\n      y = key <= x.key ? x.left : x.right\n      if y.nil_node?\n\
    \        return key <= x.key ? x.pred : x\n      end\n      x = y\n    end\n \
    \ end\n\n  def ge_node(key : T, x : Node = root) : Node\n    loop do\n      y\
    \ = key <= x.key ? x.left : x.right\n      if y.nil_node?\n        return key\
    \ <= x.key ? x : x.succ\n      end\n      x = y\n    end\n  end\n\n  def gt_node(key\
    \ : T, x : Node = root) : Node\n    loop do\n      y = key < x.key ? x.left :\
    \ x.right\n      if y.nil_node?\n        return key < x.key ? x : x.succ\n   \
    \   end\n      x = y\n    end\n  end\n\n  {% for method in [:le, :lt, :ge, :gt]\
    \ %}\n    def {{method.id}}(key : T) : T?\n\t\t\t{{method.id}}_node(key).key?\n\
    \    end\n\n    def {{method.id}}!(key : T) : T\n\t\t\t{{method.id}}_node(key).key!\n\
    \    end\n  {% end %}\nend\n\nclass Set::Treap(T)\n  class Node(T)\n    include\
    \ TreeNode(T)\n\n    getter key : T, priority : Int32\n    property! left : Node(T),\
    \ right : Node(T), parent : Node(T)\n\n    def initialize(@key : T, @priority)\n\
    \      @left = @right = @parent = NilNode(T).new\n    end\n  end\n\n  class NilNode(T)\
    \ < Node(T)\n    include TreeNilNode(T)\n\n    def initialize\n      @key = {%\
    \ if T.class.has_method?(:zero) %}\n               T.zero\n             {% else\
    \ %}\n               T.new\n             {% end %}\n      @left = @right = @parent\
    \ = self\n    end\n  end\n\n  include BinaryTree(T, Node(T), NilNode(T))\n  getter\
    \ root : Node(T), size : Int32 = 0\n\n  def initialize\n    @root = NilNode(T).new\n\
    \  end\n\n  def initialize(enumerable : Enumerable(T))\n    initialize\n    enumerable.each\
    \ { |x| self << x }\n  end\n\n  private def add_node(node : Node) : Bool\n   \
    \ if empty?\n      @root = node\n      @size += 1\n      return true\n    end\n\
    \    u, prev = root, NilNode(T).new\n    while u.node?\n      return false if\
    \ u.key == node.key\n      u, prev = node.key < u.key ? u.left : u.right, u\n\
    \    end\n    if node.key < prev.key\n      prev.left = node\n    else\n     \
    \ prev.right = node\n    end\n    node.parent = prev\n    @size += 1\n    true\n\
    \  end\n\n  private def bubble_up(u : Node) : Nil\n    raise \"u is nil node\"\
    \ unless u.node?\n    while u.parent.node? && u.parent.priority > u.priority\n\
    \      if u.parent.right == u\n        rotate_left(u.parent)\n      else\n   \
    \     rotate_right(u.parent)\n      end\n    end\n    @root = u if u.parent.nil_node?\n\
    \  end\n\n  def add?(key : T) : Bool\n    u = Node.new(key, rand(Int32))\n   \
    \ add_node(u).tap do |f|\n      bubble_up(u) if f\n    end\n  end\n\n  private\
    \ def trickle_down(u : Node)\n    loop do\n      l, r = u.left.node?, u.right.node?\n\
    \      break unless l || r\n      if !l\n        rotate_left(u)\n      elsif !r\n\
    \        rotate_right(u)\n      elsif u.left.priority < u.right.priority\n   \
    \     rotate_right(u)\n      else\n        rotate_left(u)\n      end\n      @root\
    \ = u.parent if root == u\n    end\n  end\n\n  def delete(key : T) : Bool\n  \
    \  u = search(key)\n    return false if u.nil_node?\n    trickle_down(u)\n   \
    \ if u.parent.left == u\n      u.parent.left = NilNode(T).new\n    else\n    \
    \  u.parent.right = NilNode(T).new\n    end\n    @size -= 1\n    true\n  end\n\
    end\n\nclass Foo\n  getter x\n  include Comparable(Foo)\n\n  def initialize(@x\
    \ = 0)\n  end\n\n  def <=>(other : Foo)\n    x <=> other.x\n  end\nend\n\nR =\
    \ Random.new(12345)\n\ndef benchmark(label, type : T.class, values) forall T\n\
    \  index = (0...values.size).to_a.shuffle Random.new(123)\n  Benchmark.ips do\
    \ |x|\n    x.report(label) do\n      a = T.new\n      values.each { |x| a.add\
    \ x }\n      index.each { |i| a.delete values[i] }\n    end\n  end\nend\n\nSInt32\
    \ = Set::Treap(Int32)\nSArray = Set::Treap(Array(Int32))\nSClass = Set::Treap(Foo)\n\
    \nbenchmark \"Int32 1..1e2 * 1e1\", SInt32, Array.new(10**3) { |i| i % 100 }.shuffle(R)\n\
    benchmark \"Int32 1..1e2 * 1e4\", SInt32, Array.new(10**6) { |i| i % 100 }.shuffle(R)\n\
    benchmark \"Int32 1..1e3      \", SInt32, Array.new(10**3) { |i| i }.shuffle(R)\n\
    benchmark \"Int32 1..1e6      \", SInt32, Array.new(10**6) { |i| i }.shuffle(R)\n\
    benchmark \"Array 1e6 * 1e2   \", SArray, Array.new(10**6) { Array.new(10**2)\
    \ { R.rand(100) } }\nbenchmark \"class 1..1e6      \", SClass, Array.new(10**6)\
    \ { |i| Foo.new i }.shuffle(R)\n"
  code: "require \"benchmark\"\nrequire \"../../../src/datastructure/set/treap\"\n\
    \nclass Foo\n  getter x\n  include Comparable(Foo)\n\n  def initialize(@x = 0)\n\
    \  end\n\n  def <=>(other : Foo)\n    x <=> other.x\n  end\nend\n\nR = Random.new(12345)\n\
    \ndef benchmark(label, type : T.class, values) forall T\n  index = (0...values.size).to_a.shuffle\
    \ Random.new(123)\n  Benchmark.ips do |x|\n    x.report(label) do\n      a = T.new\n\
    \      values.each { |x| a.add x }\n      index.each { |i| a.delete values[i]\
    \ }\n    end\n  end\nend\n\nSInt32 = Set::Treap(Int32)\nSArray = Set::Treap(Array(Int32))\n\
    SClass = Set::Treap(Foo)\n\nbenchmark \"Int32 1..1e2 * 1e1\", SInt32, Array.new(10**3)\
    \ { |i| i % 100 }.shuffle(R)\nbenchmark \"Int32 1..1e2 * 1e4\", SInt32, Array.new(10**6)\
    \ { |i| i % 100 }.shuffle(R)\nbenchmark \"Int32 1..1e3      \", SInt32, Array.new(10**3)\
    \ { |i| i }.shuffle(R)\nbenchmark \"Int32 1..1e6      \", SInt32, Array.new(10**6)\
    \ { |i| i }.shuffle(R)\nbenchmark \"Array 1e6 * 1e2   \", SArray, Array.new(10**6)\
    \ { Array.new(10**2) { R.rand(100) } }\nbenchmark \"class 1..1e6      \", SClass,\
    \ Array.new(10**6) { |i| Foo.new i }.shuffle(R)\n"
  dependsOn:
  - src/datastructure/set/treap.cr
  isVerificationFile: false
  path: benchmarks/datastructure/set/treap.cr
  requiredBy: []
  timestamp: '2021-09-11 16:53:58+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: benchmarks/datastructure/set/treap.cr
layout: document
redirect_from:
- /library/benchmarks/datastructure/set/treap.cr
- /library/benchmarks/datastructure/set/treap.cr.html
title: benchmarks/datastructure/set/treap.cr
---
