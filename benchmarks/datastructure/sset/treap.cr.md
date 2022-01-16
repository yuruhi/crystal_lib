---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: benchmarks/datastructure/sset_benchmark_helper.cr
    title: benchmarks/datastructure/sset_benchmark_helper.cr
  - icon: ':warning:'
    path: src/datastructure/binary_tree.cr
    title: src/datastructure/binary_tree.cr
  - icon: ':warning:'
    path: src/datastructure/sset/treap.cr
    title: src/datastructure/sset/treap.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "# require \"../sset_benchmark_helper\"\nrequire \"benchmark\"\n\n\
    private class Foo\n  getter x\n  include Comparable(Foo)\n\n  def initialize(@x\
    \ = 0)\n  end\n\n  def <=>(other : Foo)\n    x <=> other.x\n  end\nend\n\nprivate\
    \ class SlowCmp\n  include Comparable(SlowCmp)\n\n  def initialize(size)\n   \
    \ @array = Array(Int32).new(size) { yield }\n  end\n\n  def initialize\n    @array\
    \ = [] of Int32\n  end\n\n  def <=>(other : SlowCmp)\n    @array.sum <=> other.@array.sum\n\
    \  end\nend\n\nprivate def add_delete(x, type : S.class, label, values) forall\
    \ S\n  index = (0...values.size).to_a.shuffle Random.new(123)\n  x.report(label)\
    \ do\n    s = S(typeof(values.first)).new\n    values.each { |x| s.add x }\n \
    \   index.each { |i| s.delete values[i] }\n  end\nend\n\nprivate def split(x,\
    \ type : T.class, label, values, split_key) forall T\n  x.report(label) do\n \
    \   s = T.new values\n    _, _ = s.split(split_key)\n  end\nend\n\ndef benchmark_sset_add_delete(type\
    \ : S.class) forall S\n  r = Random.new(12345)\n  values3 = Array.new(10**3, &.itself)\n\
    \  values6 = Array.new(10**6, &.itself)\n\n  puts \"-------- add, delete --------\"\
    \n  Benchmark.ips do |x|\n    add_delete x, S, \"Int32 1e3 sorted\", values3\n\
    \    add_delete x, S, \"Int32 1e3       \", values3.shuffle(r)\n    add_delete\
    \ x, S, \"Int32 1e6 sorted\", values6\n    add_delete x, S, \"Int32 1e6      \
    \ \", values6.shuffle(r)\n    add_delete x, S, \"Int32 1e3 * 1e3 \", values6.map\
    \ { |x| x % 1000 }.shuffle!(r)\n    add_delete x, S, \"Array 1e6 * 1e2 \", Array.new(10**6)\
    \ { Array.new(10**2) { r.rand(100) } }\n    add_delete x, S, \"class 1e6     \
    \  \", Array.new(10**6) { Foo.new r.rand(100) }\n    add_delete x, S, \"SlowC\
    \ 1e6 * 1e2 \", Array.new(10**6) { SlowCmp.new(100) { r.rand(100) } }\n  end\n\
    end\n\ndef benchmark_sset_split(type : S.class) forall S\n  values6 = Array.new(10**6,\
    \ &.itself)\n\n  puts \"-------- split --------\"\n  Benchmark.ips do |x|\n  \
    \  split x, S, \"Int32 5e5+5e5\", values6, 5_000_000\n    split x, S, \"Int32\
    \ 1e5+9e5\", values6, 1_000_000\n  end\nend\n\n# require \"../../../src/datastructure/sset/treap\"\
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
    \    end\n  end\n\n  include Enumerable(T)\n  include Iterable(T)\n\n  abstract\
    \ def root\n  abstract def size : Int32\n  abstract def add?(key : T) : Bool\n\
    \  abstract def delete(key : T) : Bool\n\n  def empty? : Bool\n    root.nil_node?\n\
    \  end\n\n  def clear : self\n    @root = NilNode.new\n    @size = 0\n    self\n\
    \  end\n\n  def add(key : T) : self\n    add?(key)\n    self\n  end\n\n  def <<(key\
    \ : T) : self\n    add(key)\n  end\n\n  def rotate_left(x : Node) : Nil\n    raise\
    \ \"x.right is nil!\" if x.right.nil_node?\n    y = x.right\n    x.right = y.left\n\
    \    y.left.parent = x if y.left.node?\n    y.parent = x.parent\n    if x.parent.nil_node?\n\
    \      @root = y\n    else\n      if x == x.parent.left\n        x.parent.left\
    \ = y\n      else\n        x.parent.right = y\n      end\n    end\n    y.left\
    \ = x\n    x.parent = y\n  end\n\n  def rotate_right(x : Node) : Nil\n    raise\
    \ \"x.left is nil!\" if x.left.nil_node?\n    y = x.left\n    x.left = y.right\n\
    \    y.right.parent = x if y.right.node?\n    y.parent = x.parent\n    if x.parent.nil_node?\n\
    \      @root = y\n    else\n      if x == x.parent.left\n        x.parent.left\
    \ = y\n      else\n        x.parent.right = y\n      end\n    end\n    y.right\
    \ = x\n    x.parent = y\n  end\n\n  def min_node : Node\n    root.min_node\n \
    \ end\n\n  def max_node : Node\n    root.max_node\n  end\n\n  def min? : T?\n\
    \    min_node.key?\n  end\n\n  def min : T\n    min? || raise EmptyError.new\n\
    \  end\n\n  def max? : T?\n    max_node.key?\n  end\n\n  def max : T\n    max?\
    \ || raise EmptyError.new\n  end\n\n  private class InorderWalkIterator(T, Node)\n\
    \    include Iterator(T)\n\n    def initialize(@node : Node)\n    end\n\n    def\
    \ next\n      if @node.nil_node?\n        stop\n      else\n        @node.key.tap\
    \ { @node = @node.succ }\n      end\n    end\n  end\n\n  def each(node : Node\
    \ = min_node, &block) : Nil\n    while node.node?\n      yield node.key\n    \
    \  node = node.succ\n    end\n  end\n\n  def each(node : Node = min_node)\n  \
    \  InorderWalkIterator(T, Node).new(node)\n  end\n\n  private class ReverseInorderWalkIterator(T,\
    \ Node)\n    include Iterator(T)\n\n    def initialize(@node : Node)\n    end\n\
    \n    def next\n      if @node.nil_node?\n        stop\n      else\n        @node.key.tap\
    \ { @node = @node.pred }\n      end\n    end\n  end\n\n  def reverse_each(node\
    \ : Node = max_node, &block) : Nil\n    while node.node?\n      yield node.key\n\
    \      node = node.pred\n    end\n  end\n\n  def reverse_each(node : Node = max_node)\n\
    \    ReverseInorderWalkIterator(T, Node).new(node)\n  end\n\n  def includes?(key\
    \ : T) : Bool\n    x = root\n    loop do\n      return false if x.nil_node?\n\
    \      cmp = key <=> x.key\n      return true if cmp == 0\n      x = cmp < 0 ?\
    \ x.left : x.right\n    end\n  end\n\n  def search(key : T, x : Node = root) :\
    \ Node\n    while x.node?\n      cmp = key <=> x.key\n      break if cmp == 0\n\
    \      x = cmp < 0 ? x.left : x.right\n    end\n    x\n  end\n\n  def le_node(key\
    \ : T, x : Node = root) : Node\n    loop do\n      cmp = key <=> x.key\n     \
    \ y = cmp < 0 ? x.left : x.right\n      if y.nil_node?\n        return cmp < 0\
    \ ? x.pred : x\n      end\n      x = y\n    end\n  end\n\n  def lt_node(key :\
    \ T, x : Node = root) : Node\n    loop do\n      cmp = key <=> x.key\n      y\
    \ = cmp <= 0 ? x.left : x.right\n      if y.nil_node?\n        return cmp <= 0\
    \ ? x.pred : x\n      end\n      x = y\n    end\n  end\n\n  def ge_node(key :\
    \ T, x : Node = root) : Node\n    loop do\n      cmp = key <=> x.key\n      y\
    \ = cmp <= 0 ? x.left : x.right\n      if y.nil_node?\n        return cmp <= 0\
    \ ? x : x.succ\n      end\n      x = y\n    end\n  end\n\n  def gt_node(key :\
    \ T, x : Node = root) : Node\n    loop do\n      cmp = key <=> x.key\n      y\
    \ = cmp < 0 ? x.left : x.right\n      if y.nil_node?\n        return cmp < 0 ?\
    \ x : x.succ\n      end\n      x = y\n    end\n  end\n\n  {% for method in [:le,\
    \ :lt, :ge, :gt] %}\n    def {{method.id}}(key : T) : T?\n      {{method.id}}_node(key).key?\n\
    \    end\n\n    def {{method.id}}!(key : T) : T\n      {{method.id}}_node(key).key!\n\
    \    end\n  {% end %}\nend\n\nclass SSet::Treap(T)\n  class Node(T)\n    include\
    \ TreeNode(T)\n\n    getter key : T, priority : Int32\n    property! left : Node(T),\
    \ right : Node(T), parent : Node(T)\n\n    def initialize(@key : T, @priority\
    \ : Int32)\n      @left = @right = @parent = NilNode(T).new\n    end\n\n    def\
    \ split(split_key : T) : {Node(T), Node(T)}\n      if nil_node?\n        {NilNode(T).new,\
    \ NilNode(T).new}\n      elsif split_key < key\n        l, r = left.split(split_key)\n\
    \        self.left = r\n        r.parent = self\n        {l, self}\n      else\n\
    \        l, r = right.split(split_key)\n        self.right = l\n        l.parent\
    \ = self\n        {self, r}\n      end\n    end\n\n    def to_s(io : IO)\n   \
    \   io << '[' << key << ']'\n    end\n  end\n\n  class NilNode(T) < Node(T)\n\
    \    include TreeNilNode(T)\n\n    def initialize\n      @key = uninitialized\
    \ T\n      @left = @right = @parent = self\n    end\n  end\n\n  include BinaryTree(T,\
    \ Node(T), NilNode(T))\n  getter root : Node(T), size : Int32 = 0\n\n  def initialize\n\
    \    @root = NilNode(T).new\n  end\n\n  def initialize(enumerable : Enumerable(T))\n\
    \    initialize\n    enumerable.each { |x| self << x }\n  end\n\n  protected def\
    \ initialize(@root : Node(T))\n  end\n\n  private def add_node(node : Node) :\
    \ Bool\n    if empty?\n      @root = node\n      @size += 1\n      return true\n\
    \    end\n    u, prev = root, NilNode(T).new\n    while u.node?\n      cmp = node.key\
    \ <=> u.key\n      return false if cmp == 0\n      u, prev = cmp < 0 ? u.left\
    \ : u.right, u\n    end\n    if node.key < prev.key\n      prev.left = node\n\
    \    else\n      prev.right = node\n    end\n    node.parent = prev\n    @size\
    \ += 1\n    true\n  end\n\n  private def bubble_up(u : Node) : Nil\n    raise\
    \ \"u is nil node\" unless u.node?\n    while u.parent.node? && u.parent.priority\
    \ > u.priority\n      if u.parent.right == u\n        rotate_left(u.parent)\n\
    \      else\n        rotate_right(u.parent)\n      end\n    end\n    @root = u\
    \ if u.parent.nil_node?\n  end\n\n  def add?(key : T) : Bool\n    u = Node.new(key,\
    \ rand(Int32))\n    add_node(u).tap do |f|\n      bubble_up(u) if f\n    end\n\
    \  end\n\n  private def trickle_down(u : Node(T))\n    loop do\n      l, r = u.left.node?,\
    \ u.right.node?\n      break unless l || r\n      if !l\n        rotate_left(u)\n\
    \      elsif !r\n        rotate_right(u)\n      elsif u.left.priority < u.right.priority\n\
    \        rotate_right(u)\n      else\n        rotate_left(u)\n      end\n    \
    \  @root = u.parent if root == u\n    end\n  end\n\n  def delete(key : T) : Bool\n\
    \    u = search(key)\n    return false if u.nil_node?\n    trickle_down(u)\n \
    \   if u.parent.left == u\n      u.parent.left = NilNode(T).new\n    else\n  \
    \    u.parent.right = NilNode(T).new\n    end\n    @size -= 1\n    if size ==\
    \ 0\n      @root = NilNode(T).new\n    end\n    true\n  end\n\n  def split(key\
    \ : T) : {self, self}\n    l, r = root.split(key)\n    l.parent = NilNode(T).new\n\
    \    r.parent = NilNode(T).new\n    {Treap(T).new(l), Treap(T).new(r)}\n  end\n\
    \n  def to_s(io : IO) : Nil\n    io << \"SSet::Treap{\"\n    each_with_index do\
    \ |x, i|\n      io << \", \" if i > 0\n      io << x\n    end\n    io << '}'\n\
    \  end\n\n  def inspect(io : IO) : Nil\n    to_s(io)\n  end\nend\n\nbenchmark_sset_add_delete(SSet::Treap)\n\
    puts\nbenchmark_sset_split(SSet::Treap)\n"
  code: 'require "../sset_benchmark_helper"

    require "../../../src/datastructure/sset/treap"

    benchmark_sset_add_delete(SSet::Treap)

    puts

    benchmark_sset_split(SSet::Treap)

    '
  dependsOn:
  - benchmarks/datastructure/sset_benchmark_helper.cr
  - src/datastructure/sset/treap.cr
  - src/datastructure/binary_tree.cr
  isVerificationFile: false
  path: benchmarks/datastructure/sset/treap.cr
  requiredBy: []
  timestamp: '2022-01-16 09:14:56+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: benchmarks/datastructure/sset/treap.cr
layout: document
redirect_from:
- /library/benchmarks/datastructure/sset/treap.cr
- /library/benchmarks/datastructure/sset/treap.cr.html
title: benchmarks/datastructure/sset/treap.cr
---
