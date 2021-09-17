---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: benchmarks/datastructure/sset_benchmark_helper.cr
    title: benchmarks/datastructure/sset_benchmark_helper.cr
  - icon: ':warning:'
    path: src/datastructure/smultiset/red_black_tree.cr
    title: src/datastructure/smultiset/red_black_tree.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"benchmark\"\n# require \"../sset_benchmark_helper\"\nrequire\
    \ \"benchmark\"\n\nclass Foo\n  getter x\n  include Comparable(Foo)\n\n  def initialize(@x\
    \ = 0)\n  end\n\n  def <=>(other : Foo)\n    x <=> other.x\n  end\nend\n\nclass\
    \ SlowCmp\n  include Comparable(SlowCmp)\n\n  def initialize(size)\n    @array\
    \ = Array(Int32).new(size) { yield }\n  end\n\n  def initialize\n    @array =\
    \ [] of Int32\n  end\n\n  def <=>(other : SlowCmp)\n    @array.sum <=> other.@array.sum\n\
    \  end\nend\n\ndef benchmark_add_delete(label, type : T.class, values) forall\
    \ T\n  index = (0...values.size).to_a.shuffle Random.new(123)\n  Benchmark.ips\
    \ do |x|\n    x.report(label) do\n      s = T.new\n      values.each { |x| s.add\
    \ x }\n      index.each { |i| s.delete values[i] }\n    end\n  end\nend\n\ndef\
    \ benchmark_split(label, type : T.class, values, split_key) forall T\n  Benchmark.ips\
    \ do |x|\n    x.report(label) do\n      s = T.new values\n      _, _ = s.split(split_key)\n\
    \    end\n  end\nend\n\ndef benchmark_sset(type : S.class) forall S\n  r = Random.new(12345)\n\
    \  values3 = Array.new(10**3, &.itself)\n  values6 = Array.new(10**6, &.itself)\n\
    \n  puts \"-------- add, delete --------\"\n  benchmark_add_delete \"Int32 1e3\
    \ sorted\", S(Int32), values3\n  benchmark_add_delete \"Int32 1e3       \", S(Int32),\
    \ values3.shuffle(r)\n  benchmark_add_delete \"Int32 1e6 sorted\", S(Int32), values6\n\
    \  benchmark_add_delete \"Int32 1e6       \", S(Int32), values6.shuffle(r)\n \
    \ benchmark_add_delete \"Int32 1e3 * 1e3 \", S(Int32), values6.map { |x| x % 1000\
    \ }.shuffle!(r)\n  benchmark_add_delete \"Array 1e6 * 1e2 \", S(Array(Int32)),\
    \ Array.new(10**6) { Array.new(10**2) { r.rand(100) } }\n  benchmark_add_delete\
    \ \"class 1e6       \", S(Foo), Array.new(10**6) { Foo.new r.rand(100) }\n  benchmark_add_delete\
    \ \"SlowC 1e6 * 1e2 \", S(SlowCmp), Array.new(10**6) { SlowCmp.new(100) { r.rand(100)\
    \ } }\n  puts\n\n  puts \"-------- split --------\"\n  benchmark_split \"Int32\
    \ 5e5+5e5\", S(Int32), values6, 5_000_000\n  benchmark_split \"Int32 1e5+9e5\"\
    , S(Int32), values6, 1_000_000\nend\n\n# require \"../../../src/datastructure/smultiset/red_black_tree\"\
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
    \ :lt, :ge, :gt] %}\n    def {{method.id}}(key : T) : T?\n\t\t\t{{method.id}}_node(key).key?\n\
    \    end\n\n    def {{method.id}}!(key : T) : T\n\t\t\t{{method.id}}_node(key).key!\n\
    \    end\n  {% end %}\nend\n\n# Copied with modifications from: https://github.com/crystal-lang/crystal/blob/1.1.1/samples/red_black_tree.cr\n\
    class SMultiSet::RedBlackTree(T)\n  class Node(T)\n    enum Color\n      Red\n\
    \      Black\n    end\n\n    include TreeNode(T)\n\n    property key : T, color\
    \ : Color\n    property! left : Node(T), right : Node(T), parent : Node(T)\n\n\
    \    def initialize(@key : T, @color : Color = :red)\n      @left = @right = @parent\
    \ = NilNode(T).new\n    end\n\n    def black?\n      color.black?\n    end\n\n\
    \    def red?\n      color.red?\n    end\n\n    def split(split_key : T) : {Node(T),\
    \ Node(T)}\n      if nil_node?\n        {NilNode(T).new, NilNode(T).new}\n   \
    \   elsif split_key < key\n        l, r = left.split(split_key)\n        self.left\
    \ = r\n        r.parent = self\n        {l, self}\n      else\n        l, r =\
    \ right.split(split_key)\n        self.right = l\n        l.parent = self\n  \
    \      {self, r}\n      end\n    end\n  end\n\n  class NilNode(T) < Node(T)\n\
    \    include TreeNilNode(T)\n\n    def initialize\n      @key = {% if T.class.has_method?(:zero)\
    \ %}\n               T.zero\n             {% else %}\n               T.new\n \
    \            {% end %}\n      @left = @right = @parent = self\n    end\n  end\n\
    \n  include BinaryTree(T, Node(T), NilNode(T))\n  getter root : Node(T), size\
    \ : Int32 = 0\n\n  def initialize\n    @root = NilNode(T).new\n  end\n\n  def\
    \ initialize(enumerable : Enumerable(T))\n    initialize\n    enumerable.each\
    \ { |x| self << x }\n  end\n\n  protected def initialize(@root : Node(T))\n  end\n\
    \n  private def insert_node(x : Node(T)) : Nil\n    insert_helper(x)\n\n    x.color\
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
    \        end\n      end\n    end\n    root.color = :black\n  end\n\n  private\
    \ def delete_node(z : Node(T)) : Nil\n    y = (z.left.nil_node? || z.right.nil_node?)\
    \ ? z : z.succ\n    x = y.left.nil_node? ? y.right : y.left\n    x.parent = y.parent\n\
    \n    if y.parent.nil_node?\n      @root = x\n    else\n      if y == y.parent.left\n\
    \        y.parent.left = x\n      else\n        y.parent.right = x\n      end\n\
    \    end\n\n    z.key = y.key if y != z\n\n    if y.black?\n      delete_fixup(x)\n\
    \    end\n\n    @size -= 1\n    y\n  end\n\n  def add?(key : T) : Bool\n    insert_node(Node.new(key))\n\
    \    true\n  end\n\n  def delete(key : T) : Bool\n    node = search(key)\n   \
    \ return false if node.nil_node?\n    delete_node(node)\n    true\n  end\n\n \
    \ def split(key : T) : {self, self}\n    l, r = root.split(key)\n    l.parent\
    \ = NilNode(T).new\n    r.parent = NilNode(T).new\n    {RedBlackTree(T).new(l),\
    \ RedBlackTree(T).new(r)}\n  end\n\n  def black_height(x : Node = root)\n    height\
    \ = 0\n    until x.nil_node?\n      x = x.left\n      height += 1 if x.nil_node?\
    \ || x.black?\n    end\n    height\n  end\n\n  def to_s(io : IO) : Nil\n    io\
    \ << \"SMultiSet::RedBlackTree{\"\n    each_with_index do |x, i|\n      io <<\
    \ \", \" if i > 0\n      io << x\n    end\n    io << '}'\n  end\n\n  def inspect(io\
    \ : IO) : Nil\n    to_s(io)\n  end\n\n  private def left_rotate(x : Node)\n  \
    \  raise \"x.right is nil!\" if x.right.nil_node?\n    y = x.right\n    x.right\
    \ = y.left\n    y.left.parent = x if !y.left.nil_node?\n    y.parent = x.parent\n\
    \    if x.parent.nil_node?\n      @root = y\n    else\n      if x == x.parent.left\n\
    \        x.parent.left = y\n      else\n        x.parent.right = y\n      end\n\
    \    end\n    y.left = x\n    x.parent = y\n  end\n\n  private def right_rotate(x\
    \ : Node)\n    raise \"x.left is nil!\" if x.left.nil_node?\n    y = x.left\n\
    \    x.left = y.right\n    y.right.parent = x if !y.right.nil_node?\n    y.parent\
    \ = x.parent\n    if x.parent.nil_node?\n      @root = y\n    else\n      if x\
    \ == x.parent.left\n        x.parent.left = y\n      else\n        x.parent.right\
    \ = y\n      end\n    end\n    y.right = x\n    x.parent = y\n  end\n\n  private\
    \ def insert_helper(z : Node)\n    y = NilNode(T).new\n    x = root\n    while\
    \ !x.nil_node?\n      y = x\n      x = (z.key < x.key) ? x.left : x.right\n  \
    \  end\n    z.parent = y\n    if y.nil_node?\n      @root = z\n    else\n    \
    \  z.key < y.key ? y.left = z : y.right = z\n    end\n    @size += 1\n  end\n\n\
    \  private def delete_fixup(x : Node)\n    while x != root && x.black?\n     \
    \ if x == x.parent.left\n        w = x.parent.right\n        if w.red?\n     \
    \     w.color = :black\n          x.parent.color = :red\n          left_rotate(x.parent)\n\
    \          w = x.parent.right\n        end\n        if w.left.black? && w.right.black?\n\
    \          w.color = :red\n          x = x.parent\n        else\n          if\
    \ w.right.black?\n            w.left.color = :black\n            w.color = :red\n\
    \            right_rotate(w)\n            w = x.parent.right\n          end\n\
    \          w.color = x.parent.color\n          x.parent.color = :black\n     \
    \     w.right.color = :black\n          left_rotate(x.parent)\n          x = root\n\
    \        end\n      else\n        w = x.parent.left\n        if w.red?\n     \
    \     w.color = :black\n          x.parent.color = :red\n          right_rotate(x.parent)\n\
    \          w = x.parent.left\n        end\n        if w.right.black? && w.left.black?\n\
    \          w.color = :red\n          x = x.parent\n        else\n          if\
    \ w.left.black?\n            w.right.color = :black\n            w.color = :red\n\
    \            left_rotate(w)\n            w = x.parent.left\n          end\n  \
    \        w.color = x.parent.color\n          x.parent.color = :black\n       \
    \   w.left.color = :black\n          right_rotate(x.parent)\n          x = root\n\
    \        end\n      end\n    end\n    x.color = :black\n  end\nend\n\nbenchmark_sset(SMultiSet::RedBlackTree)\n"
  code: 'require "benchmark"

    require "../sset_benchmark_helper"

    require "../../../src/datastructure/smultiset/red_black_tree"

    benchmark_sset(SMultiSet::RedBlackTree)

    '
  dependsOn:
  - benchmarks/datastructure/sset_benchmark_helper.cr
  - src/datastructure/smultiset/red_black_tree.cr
  isVerificationFile: false
  path: benchmarks/datastructure/smultiset/red_black_tree.cr
  requiredBy: []
  timestamp: '2021-09-12 11:51:59+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: benchmarks/datastructure/smultiset/red_black_tree.cr
layout: document
redirect_from:
- /library/benchmarks/datastructure/smultiset/red_black_tree.cr
- /library/benchmarks/datastructure/smultiset/red_black_tree.cr.html
title: benchmarks/datastructure/smultiset/red_black_tree.cr
---
