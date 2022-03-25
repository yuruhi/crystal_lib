---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: benchmarks/datastructure/smultiset/red_black_tree.cr
    title: benchmarks/datastructure/smultiset/red_black_tree.cr
  - icon: ':warning:'
    path: benchmarks/datastructure/smultiset/treap.cr
    title: benchmarks/datastructure/smultiset/treap.cr
  - icon: ':warning:'
    path: benchmarks/datastructure/sset.cr
    title: benchmarks/datastructure/sset.cr
  - icon: ':warning:'
    path: benchmarks/datastructure/sset/red_black_tree.cr
    title: benchmarks/datastructure/sset/red_black_tree.cr
  - icon: ':warning:'
    path: benchmarks/datastructure/sset/treap.cr
    title: benchmarks/datastructure/sset/treap.cr
  - icon: ':warning:'
    path: spec/datastructure/smultiset/red_black_tree_spec.cr
    title: spec/datastructure/smultiset/red_black_tree_spec.cr
  - icon: ':warning:'
    path: spec/datastructure/smultiset/treap_spec.cr
    title: spec/datastructure/smultiset/treap_spec.cr
  - icon: ':warning:'
    path: spec/datastructure/sset/red_black_tree_spec.cr
    title: spec/datastructure/sset/red_black_tree_spec.cr
  - icon: ':warning:'
    path: spec/datastructure/sset/treap_spec.cr
    title: spec/datastructure/sset/treap_spec.cr
  - icon: ':warning:'
    path: src/datastructure/smultiset/red_black_tree.cr
    title: src/datastructure/smultiset/red_black_tree.cr
  - icon: ':warning:'
    path: src/datastructure/smultiset/treap.cr
    title: src/datastructure/smultiset/treap.cr
  - icon: ':warning:'
    path: src/datastructure/sset/red_black_tree.cr
    title: src/datastructure/sset/red_black_tree.cr
  - icon: ':warning:'
    path: src/datastructure/sset/treap.cr
    title: src/datastructure/sset/treap.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "module TreeNode(T)\n  abstract def key : T\n  abstract def left\n\
    \  abstract def right\n  abstract def parent\n\n  def node?\n    true\n  end\n\
    \n  def nil_node?\n    false\n  end\n\n  def key? : T?\n    key\n  end\n\n  def\
    \ key! : T\n    key\n  end\n\n  def min_node : self\n    x = self\n    while x.left.node?\n\
    \      x = x.left\n    end\n    x\n  end\n\n  def max_node : self\n    x = self\n\
    \    while x.right.node?\n      x = x.right\n    end\n    x\n  end\n\n  def succ\
    \ : self\n    if right.node?\n      return right.min_node\n    end\n    x, y =\
    \ self, parent\n    while y.node? && x != y.left\n      x = y\n      y = y.parent\n\
    \    end\n    y\n  end\n\n  def pred : self\n    if left.node?\n      return left.max_node\n\
    \    end\n    x, y = self, parent\n    while y.node? && x != y.right\n      x\
    \ = y\n      y = y.parent\n    end\n    y\n  end\n\n  def to_s(io : IO)\n    io\
    \ << '[' << key << ']'\n  end\n\n  def inspect(io : IO)\n    to_s(io)\n  end\n\
    end\n\nmodule TreeNilNode(T)\n  def node?\n    false\n  end\n\n  def nil_node?\n\
    \    true\n  end\n\n  def key? : T?\n    nil\n  end\n\n  def key!\n    raise NilAssertionError.new\n\
    \  end\n\n  def to_s(io : IO)\n    io << \"NilNode\"\n  end\n\n  def inspect(io\
    \ : IO)\n    to_s(io)\n  end\nend\n\nmodule BinaryTree(T, Node, NilNode)\n  class\
    \ EmptyError < Exception\n    def initialize(message = \"Empty RedBlackTree\"\
    )\n      super(message)\n    end\n  end\n\n  include Enumerable(T)\n  include\
    \ Iterable(T)\n\n  abstract def root\n  abstract def size : Int32\n  abstract\
    \ def add?(key : T) : Bool\n  abstract def delete(key : T) : Bool\n\n  def empty?\
    \ : Bool\n    root.nil_node?\n  end\n\n  def clear : self\n    @root = NilNode.new\n\
    \    @size = 0\n    self\n  end\n\n  def add(key : T) : self\n    add?(key)\n\
    \    self\n  end\n\n  def <<(key : T) : self\n    add(key)\n  end\n\n  def rotate_left(x\
    \ : Node) : Nil\n    raise \"x.right is nil!\" if x.right.nil_node?\n    y = x.right\n\
    \    x.right = y.left\n    y.left.parent = x if y.left.node?\n    y.parent = x.parent\n\
    \    if x.parent.nil_node?\n      @root = y\n    else\n      if x == x.parent.left\n\
    \        x.parent.left = y\n      else\n        x.parent.right = y\n      end\n\
    \    end\n    y.left = x\n    x.parent = y\n  end\n\n  def rotate_right(x : Node)\
    \ : Nil\n    raise \"x.left is nil!\" if x.left.nil_node?\n    y = x.left\n  \
    \  x.left = y.right\n    y.right.parent = x if y.right.node?\n    y.parent = x.parent\n\
    \    if x.parent.nil_node?\n      @root = y\n    else\n      if x == x.parent.left\n\
    \        x.parent.left = y\n      else\n        x.parent.right = y\n      end\n\
    \    end\n    y.right = x\n    x.parent = y\n  end\n\n  def min_node : Node\n\
    \    root.min_node\n  end\n\n  def max_node : Node\n    root.max_node\n  end\n\
    \n  def min? : T?\n    min_node.key?\n  end\n\n  def min : T\n    min? || raise\
    \ EmptyError.new\n  end\n\n  def max? : T?\n    max_node.key?\n  end\n\n  def\
    \ max : T\n    max? || raise EmptyError.new\n  end\n\n  private class InorderWalkIterator(T,\
    \ Node)\n    include Iterator(T)\n\n    def initialize(@node : Node)\n    end\n\
    \n    def next\n      if @node.nil_node?\n        stop\n      else\n        @node.key.tap\
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
    \    end\n  {% end %}\nend\n"
  code: "module TreeNode(T)\n  abstract def key : T\n  abstract def left\n  abstract\
    \ def right\n  abstract def parent\n\n  def node?\n    true\n  end\n\n  def nil_node?\n\
    \    false\n  end\n\n  def key? : T?\n    key\n  end\n\n  def key! : T\n    key\n\
    \  end\n\n  def min_node : self\n    x = self\n    while x.left.node?\n      x\
    \ = x.left\n    end\n    x\n  end\n\n  def max_node : self\n    x = self\n   \
    \ while x.right.node?\n      x = x.right\n    end\n    x\n  end\n\n  def succ\
    \ : self\n    if right.node?\n      return right.min_node\n    end\n    x, y =\
    \ self, parent\n    while y.node? && x != y.left\n      x = y\n      y = y.parent\n\
    \    end\n    y\n  end\n\n  def pred : self\n    if left.node?\n      return left.max_node\n\
    \    end\n    x, y = self, parent\n    while y.node? && x != y.right\n      x\
    \ = y\n      y = y.parent\n    end\n    y\n  end\n\n  def to_s(io : IO)\n    io\
    \ << '[' << key << ']'\n  end\n\n  def inspect(io : IO)\n    to_s(io)\n  end\n\
    end\n\nmodule TreeNilNode(T)\n  def node?\n    false\n  end\n\n  def nil_node?\n\
    \    true\n  end\n\n  def key? : T?\n    nil\n  end\n\n  def key!\n    raise NilAssertionError.new\n\
    \  end\n\n  def to_s(io : IO)\n    io << \"NilNode\"\n  end\n\n  def inspect(io\
    \ : IO)\n    to_s(io)\n  end\nend\n\nmodule BinaryTree(T, Node, NilNode)\n  class\
    \ EmptyError < Exception\n    def initialize(message = \"Empty RedBlackTree\"\
    )\n      super(message)\n    end\n  end\n\n  include Enumerable(T)\n  include\
    \ Iterable(T)\n\n  abstract def root\n  abstract def size : Int32\n  abstract\
    \ def add?(key : T) : Bool\n  abstract def delete(key : T) : Bool\n\n  def empty?\
    \ : Bool\n    root.nil_node?\n  end\n\n  def clear : self\n    @root = NilNode.new\n\
    \    @size = 0\n    self\n  end\n\n  def add(key : T) : self\n    add?(key)\n\
    \    self\n  end\n\n  def <<(key : T) : self\n    add(key)\n  end\n\n  def rotate_left(x\
    \ : Node) : Nil\n    raise \"x.right is nil!\" if x.right.nil_node?\n    y = x.right\n\
    \    x.right = y.left\n    y.left.parent = x if y.left.node?\n    y.parent = x.parent\n\
    \    if x.parent.nil_node?\n      @root = y\n    else\n      if x == x.parent.left\n\
    \        x.parent.left = y\n      else\n        x.parent.right = y\n      end\n\
    \    end\n    y.left = x\n    x.parent = y\n  end\n\n  def rotate_right(x : Node)\
    \ : Nil\n    raise \"x.left is nil!\" if x.left.nil_node?\n    y = x.left\n  \
    \  x.left = y.right\n    y.right.parent = x if y.right.node?\n    y.parent = x.parent\n\
    \    if x.parent.nil_node?\n      @root = y\n    else\n      if x == x.parent.left\n\
    \        x.parent.left = y\n      else\n        x.parent.right = y\n      end\n\
    \    end\n    y.right = x\n    x.parent = y\n  end\n\n  def min_node : Node\n\
    \    root.min_node\n  end\n\n  def max_node : Node\n    root.max_node\n  end\n\
    \n  def min? : T?\n    min_node.key?\n  end\n\n  def min : T\n    min? || raise\
    \ EmptyError.new\n  end\n\n  def max? : T?\n    max_node.key?\n  end\n\n  def\
    \ max : T\n    max? || raise EmptyError.new\n  end\n\n  private class InorderWalkIterator(T,\
    \ Node)\n    include Iterator(T)\n\n    def initialize(@node : Node)\n    end\n\
    \n    def next\n      if @node.nil_node?\n        stop\n      else\n        @node.key.tap\
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
    \    end\n  {% end %}\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/datastructure/binary_tree.cr
  requiredBy:
  - src/datastructure/sset/treap.cr
  - src/datastructure/sset/red_black_tree.cr
  - src/datastructure/smultiset/treap.cr
  - src/datastructure/smultiset/red_black_tree.cr
  - benchmarks/datastructure/sset/treap.cr
  - benchmarks/datastructure/sset/red_black_tree.cr
  - benchmarks/datastructure/sset.cr
  - benchmarks/datastructure/smultiset/treap.cr
  - benchmarks/datastructure/smultiset/red_black_tree.cr
  - spec/datastructure/sset/treap_spec.cr
  - spec/datastructure/sset/red_black_tree_spec.cr
  - spec/datastructure/smultiset/treap_spec.cr
  - spec/datastructure/smultiset/red_black_tree_spec.cr
  timestamp: '2022-03-25 11:37:47+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/datastructure/binary_tree.cr
layout: document
redirect_from:
- /library/src/datastructure/binary_tree.cr
- /library/src/datastructure/binary_tree.cr.html
title: src/datastructure/binary_tree.cr
---
