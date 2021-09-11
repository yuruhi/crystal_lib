---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: src/datastructure/set/treap.cr
    title: src/datastructure/set/treap.cr
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
    )\n      super(message)\n    end\n  end\n\n  include Enumerable(T)\n\n  abstract\
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
    )\n      super(message)\n    end\n  end\n\n  include Enumerable(T)\n\n  abstract\
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
    \    end\n  {% end %}\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/datastructure/binary_tree.cr
  requiredBy:
  - src/datastructure/set/treap.cr
  timestamp: '2021-09-11 19:10:38+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/datastructure/binary_tree.cr
layout: document
redirect_from:
- /library/src/datastructure/binary_tree.cr
- /library/src/datastructure/binary_tree.cr.html
title: src/datastructure/binary_tree.cr
---
