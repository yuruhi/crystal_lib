---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/datastructure/binary_tree.cr
    title: src/datastructure/binary_tree.cr
  - icon: ':warning:'
    path: src/datastructure/sset/bucket.cr
    title: src/datastructure/sset/bucket.cr
  - icon: ':warning:'
    path: src/datastructure/sset/red_black_tree.cr
    title: src/datastructure/sset/red_black_tree.cr
  - icon: ':warning:'
    path: src/datastructure/sset/treap.cr
    title: src/datastructure/sset/treap.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"benchmark\"\n\n# require \"../../src/datastructure/sset/red_black_tree\"\
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
    \    end\n  {% end %}\nend\n\n# Copied with modifications from: https://github.com/crystal-lang/crystal/blob/1.1.1/samples/red_black_tree.cr\n\
    class SSet::RedBlackTree(T)\n  class Node(T)\n    enum Color\n      Red\n    \
    \  Black\n    end\n\n    include TreeNode(T)\n\n    property key : T, color :\
    \ Color\n    property! left : Node(T), right : Node(T), parent : Node(T)\n\n \
    \   def initialize(@key : T, @color : Color = :red)\n      @left = @right = @parent\
    \ = NilNode(T).new\n    end\n\n    def black?\n      color.black?\n    end\n\n\
    \    def red?\n      color.red?\n    end\n\n    def split(split_key : T) : {Node(T),\
    \ Node(T)}\n      if nil_node?\n        {NilNode(T).new, NilNode(T).new}\n   \
    \   elsif split_key < key\n        l, r = left.split(split_key)\n        self.left\
    \ = r\n        r.parent = self\n        {l, self}\n      else\n        l, r =\
    \ right.split(split_key)\n        self.right = l\n        l.parent = self\n  \
    \      {self, r}\n      end\n    end\n  end\n\n  class NilNode(T) < Node(T)\n\
    \    include TreeNilNode(T)\n\n    def initialize\n      @key = uninitialized\
    \ T\n      @left = @right = @parent = self\n    end\n  end\n\n  include BinaryTree(T,\
    \ Node(T), NilNode(T))\n  getter root : Node(T), size : Int32 = 0\n\n  def initialize\n\
    \    @root = NilNode(T).new\n  end\n\n  def initialize(enumerable : Enumerable(T))\n\
    \    initialize\n    enumerable.each { |x| self << x }\n  end\n\n  protected def\
    \ initialize(@root : Node(T))\n  end\n\n  private def insert_node(x : Node(T))\
    \ : Nil\n    insert_helper(x)\n\n    x.color = :red\n    while x != root && x.parent.red?\n\
    \      if x.parent == x.parent.parent.left\n        y = x.parent.parent.right\n\
    \        if !y.nil_node? && y.red?\n          x.parent.color = :black\n      \
    \    y.color = :black\n          x.parent.parent.color = :red\n          x = x.parent.parent\n\
    \        else\n          if x == x.parent.right\n            x = x.parent\n  \
    \          left_rotate(x)\n          end\n          x.parent.color = :black\n\
    \          x.parent.parent.color = :red\n          right_rotate(x.parent.parent)\n\
    \        end\n      else\n        y = x.parent.parent.left\n        if !y.nil_node?\
    \ && y.red?\n          x.parent.color = :black\n          y.color = :black\n \
    \         x.parent.parent.color = :red\n          x = x.parent.parent\n      \
    \  else\n          if x == x.parent.left\n            x = x.parent\n         \
    \   right_rotate(x)\n          end\n          x.parent.color = :black\n      \
    \    x.parent.parent.color = :red\n          left_rotate(x.parent.parent)\n  \
    \      end\n      end\n    end\n    root.color = :black\n  end\n\n  private def\
    \ delete_node(z : Node(T)) : Nil\n    y = (z.left.nil_node? || z.right.nil_node?)\
    \ ? z : z.succ\n    x = y.left.nil_node? ? y.right : y.left\n    x.parent = y.parent\n\
    \n    if y.parent.nil_node?\n      @root = x\n    else\n      if y == y.parent.left\n\
    \        y.parent.left = x\n      else\n        y.parent.right = x\n      end\n\
    \    end\n\n    z.key = y.key if y != z\n\n    if y.black?\n      delete_fixup(x)\n\
    \    end\n\n    @size -= 1\n    y\n  end\n\n  def add?(key : T) : Bool\n    return\
    \ false if includes?(key)\n    insert_node(Node.new(key))\n    true\n  end\n\n\
    \  def delete(key : T) : Bool\n    node = search(key)\n    return false if node.nil_node?\n\
    \    delete_node(node)\n    true\n  end\n\n  def split(key : T) : {self, self}\n\
    \    l, r = root.split(key)\n    l.parent = NilNode(T).new\n    r.parent = NilNode(T).new\n\
    \    {RedBlackTree(T).new(l), RedBlackTree(T).new(r)}\n  end\n\n  def black_height(x\
    \ : Node = root)\n    height = 0\n    until x.nil_node?\n      x = x.left\n  \
    \    height += 1 if x.nil_node? || x.black?\n    end\n    height\n  end\n\n  def\
    \ to_s(io : IO) : Nil\n    io << \"SSet::RedBlackTree{\"\n    each_with_index\
    \ do |x, i|\n      io << \", \" if i > 0\n      io << x\n    end\n    io << '}'\n\
    \  end\n\n  def inspect(io : IO) : Nil\n    to_s(io)\n  end\n\n  private def left_rotate(x\
    \ : Node)\n    raise \"x.right is nil!\" if x.right.nil_node?\n    y = x.right\n\
    \    x.right = y.left\n    y.left.parent = x if !y.left.nil_node?\n    y.parent\
    \ = x.parent\n    if x.parent.nil_node?\n      @root = y\n    else\n      if x\
    \ == x.parent.left\n        x.parent.left = y\n      else\n        x.parent.right\
    \ = y\n      end\n    end\n    y.left = x\n    x.parent = y\n  end\n\n  private\
    \ def right_rotate(x : Node)\n    raise \"x.left is nil!\" if x.left.nil_node?\n\
    \    y = x.left\n    x.left = y.right\n    y.right.parent = x if !y.right.nil_node?\n\
    \    y.parent = x.parent\n    if x.parent.nil_node?\n      @root = y\n    else\n\
    \      if x == x.parent.left\n        x.parent.left = y\n      else\n        x.parent.right\
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
    \        end\n      end\n    end\n    x.color = :black\n  end\nend\n\n# require\
    \ \"../../src/datastructure/sset/treap\"\n# require \"../binary_tree\"\n\nclass\
    \ SSet::Treap(T)\n  class Node(T)\n    include TreeNode(T)\n\n    getter key :\
    \ T, priority : Int32\n    property! left : Node(T), right : Node(T), parent :\
    \ Node(T)\n\n    def initialize(@key : T, @priority : Int32)\n      @left = @right\
    \ = @parent = NilNode(T).new\n    end\n\n    def split(split_key : T) : {Node(T),\
    \ Node(T)}\n      if nil_node?\n        {NilNode(T).new, NilNode(T).new}\n   \
    \   elsif split_key < key\n        l, r = left.split(split_key)\n        self.left\
    \ = r\n        r.parent = self\n        {l, self}\n      else\n        l, r =\
    \ right.split(split_key)\n        self.right = l\n        l.parent = self\n  \
    \      {self, r}\n      end\n    end\n\n    def to_s(io : IO)\n      io << '['\
    \ << key << ']'\n    end\n  end\n\n  class NilNode(T) < Node(T)\n    include TreeNilNode(T)\n\
    \n    def initialize\n      @key = uninitialized T\n      @left = @right = @parent\
    \ = self\n    end\n  end\n\n  include BinaryTree(T, Node(T), NilNode(T))\n  getter\
    \ root : Node(T), size : Int32 = 0\n\n  def initialize\n    @root = NilNode(T).new\n\
    \  end\n\n  def initialize(enumerable : Enumerable(T))\n    initialize\n    enumerable.each\
    \ { |x| self << x }\n  end\n\n  protected def initialize(@root : Node(T))\n  end\n\
    \n  private def add_node(node : Node) : Bool\n    if empty?\n      @root = node\n\
    \      @size += 1\n      return true\n    end\n    u, prev = root, NilNode(T).new\n\
    \    while u.node?\n      cmp = node.key <=> u.key\n      return false if cmp\
    \ == 0\n      u, prev = cmp < 0 ? u.left : u.right, u\n    end\n    if node.key\
    \ < prev.key\n      prev.left = node\n    else\n      prev.right = node\n    end\n\
    \    node.parent = prev\n    @size += 1\n    true\n  end\n\n  private def bubble_up(u\
    \ : Node) : Nil\n    raise \"u is nil node\" unless u.node?\n    while u.parent.node?\
    \ && u.parent.priority > u.priority\n      if u.parent.right == u\n        rotate_left(u.parent)\n\
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
    \  end\n\n  def inspect(io : IO) : Nil\n    to_s(io)\n  end\nend\n\n# require\
    \ \"../../src/datastructure/sset/bucket\"\n# reference: https://github.com/tatyam-prime/SortedSet/blob/main/SortedSet.py\n\
    class SSet::Bucket(T, BUCKET_RATIO, REBUILD_RATIO, BSEARCH)\n  include Enumerable(T)\n\
    \  include Iterable(T)\n  include Indexable(T)\n\n  getter size = 0\n  @buckets\
    \ = [] of Array(T)\n\n  def initialize\n  end\n\n  def initialize(a : Enumerable(T))\n\
    \    build a.to_a.sort!.uniq!\n  end\n\n  private def build(a : Array(T)) : Nil\n\
    \    @size = a.size\n    bucket_size = Math.sqrt(size / BUCKET_RATIO).ceil.to_i\n\
    \    @buckets = Array.new(bucket_size) { |i| a[size * i // bucket_size...size\
    \ * (i + 1) // bucket_size] }\n  end\n\n  private def build\n    build to_a\n\
    \  end\n\n  def empty? : Bool\n    @size == 0\n  end\n\n  def clear\n    @size\
    \ = 0\n    @buckets.clear\n  end\n\n  def min? : T?\n    empty? ? nil : @buckets.first.first\n\
    \  end\n\n  def min : T\n    min? || raise EmptyError.new\n  end\n\n  def max?\
    \ : T?\n    empty? ? nil : @buckets.last.last\n  end\n\n  def max : T\n    max?\
    \ || raise EmptyError.new\n  end\n\n  def each(&) : Nil\n    @buckets.each do\
    \ |bucket|\n      bucket.each do |object|\n        yield object\n      end\n \
    \   end\n  end\n\n  private class ItemIterator(T)\n    include Iterator(T)\n\n\
    \    def initialize(@buckets : Array(Array(T)))\n      @i, @j = 0, 0\n    end\n\
    \n    def next\n      if @buckets.size == @i\n        stop\n      else\n     \
    \   @buckets[@i][@j].tap do\n          @j += 1\n          @i, @j = @i + 1, 0 if\
    \ @buckets[@i].size == @j\n        end\n      end\n    end\n  end\n\n  def each\n\
    \    ItemIterator(T).new(@buckets)\n  end\n\n  def reverse_each(&) : Nil\n   \
    \ @buckets.reverse_each do |bucket|\n      bucket.reverse_each do |object|\n \
    \       yield object\n      end\n    end\n  end\n\n  private def find_bucket(object\
    \ : T)\n    {% if BSEARCH > 0 %}\n      @buckets.bsearch { |bucket| object <=\
    \ bucket.last } || @buckets.last\n    {% else %}\n      @buckets.find(@buckets.last)\
    \ { |bucket| object <= bucket.last }\n    {% end %}\n  end\n\n  def includes?(object\
    \ : T) : Bool\n    false if empty?\n    find_bucket(object).bsearch { |x| x >=\
    \ object } == object\n  end\n\n  def unsafe_fetch(index : Int) : T\n    @buckets.each\
    \ do |bucket|\n      return bucket.unsafe_fetch(index) if index < bucket.size\n\
    \      index -= bucket.size\n    end\n    raise \"Bug\"\n  end\n\n  def add?(object\
    \ : T) : Bool\n    if size == 0\n      @buckets = [[object]]\n      @size = 1\n\
    \      return true\n    end\n\n    a = find_bucket(object)\n    i = a.bsearch_index\
    \ { |x| x >= object }\n    return false if i && a[i] == object\n    i ? a.insert(i,\
    \ object) : a.push(object)\n    @size += 1\n    build if a.size > @buckets.size\
    \ * REBUILD_RATIO\n    true\n  end\n\n  def add(object : T) : self\n    add?(object)\n\
    \    self\n  end\n\n  def <<(object : T) : self\n    add(object)\n  end\n\n  def\
    \ concat(elems) : self\n    elems.each { |object| add(object) }\n    self\n  end\n\
    \n  def delete(object : T) : Bool\n    return false if empty?\n    a = find_bucket(object)\n\
    \    i = a.bsearch_index { |x| x >= object }\n    return false if i.nil? || a[i]\
    \ != object\n    a.delete_at(i)\n    @size -= 1\n    build if a.empty?\n    true\n\
    \  end\n\n  def count(object : T) : Int32\n    includes?(object) ? 1 : 0\n  end\n\
    \n  def index(object : T) : Int32?\n    offset = 0\n    @buckets.each do |bucket|\n\
    \      if bucket.last >= object\n        i = bucket.bsearch_index { |x| x >= object\
    \ }.not_nil!\n        return offset + i if bucket[i] == object\n      end\n  \
    \  end\n  end\n\n  def index_left(object : T) : Int32\n    @buckets.reduce(0)\
    \ do |offset, bucket|\n      if bucket.last >= object\n        return offset +\
    \ bucket.bsearch_index { |x| x >= object }.not_nil!\n      end\n      offset +\
    \ bucket.size\n    end\n  end\n\n  def index_right(object : T) : Int32?\n    @buckets.reduce(0)\
    \ do |offset, bucket|\n      if bucket.last > object\n        return offset +\
    \ bucket.bsearch_index { |x| x > object }.not_nil!\n      end\n      offset +\
    \ bucket.size\n    end\n  end\n\n  def le(object : T) : T?\n    @buckets.reverse_each\
    \ do |bucket|\n      if bucket.first <= object\n        i = bucket.bsearch_index\
    \ { |x| x > object } || bucket.size\n        return bucket[i - 1]\n      end\n\
    \    end\n  end\n\n  def lt(object : T) : T?\n    @buckets.reverse_each do |bucket|\n\
    \      if bucket.first < object\n        i = bucket.bsearch_index { |x| x >= object\
    \ } || bucket.size\n        return bucket[i - 1]\n      end\n    end\n  end\n\n\
    \  def ge(object : T) : T?\n    {% if BSEARCH > 0 %}\n      @buckets.bsearch {\
    \ |bucket| bucket.last >= object }.try do |bucket|\n        bucket.bsearch { |x|\
    \ x >= object }.not_nil!\n      end\n    {% else %}\n      @buckets.each do |bucket|\n\
    \        if bucket.last >= object\n          return bucket.bsearch { |x| x >=\
    \ object }.not_nil!\n        end\n      end\n    {% end %}\n  end\n\n  def gt(object\
    \ : T) : T?\n    @buckets.each do |bucket|\n      if bucket.last > object\n  \
    \      return bucket.bsearch { |x| x > object }.not_nil!\n      end\n    end\n\
    \  end\n\n  {% for method in [:le, :lt, :ge, :gt] %}\n    def {{method.id}}!(object\
    \ : T) : T\n      {{method.id}}(object).not_nil!\n    end\n  {% end %}\n\n  {%\
    \ for op in [:&, :|, :^, :+, :-] %}\n    def {{op.id}}(other : Enumerable(T))\
    \ : self\n      SSet::Bucket(T, BUCKET_RATIO, REBUILD_RATIO, BSEARCH).new (self.to_set\
    \ {{op.id}} other.to_set)\n    end\n  {% end %}\n\n  def to_a : Array(T)\n   \
    \ @buckets.each_with_object(Array(T).new size) do |bucket, a|\n      a.concat\
    \ bucket\n    end\n  end\n\n  def to_s(io : IO) : Nil\n    io << \"SSet::Bucket{\"\
    \n    join(\", \", io)\n    io << \"}\"\n  end\n\n  def inspect(io : IO) : Nil\n\
    \    @buckets.inspect(io)\n  end\nend\n\nprivate def add(type : T.class, x, label,\
    \ values) forall T\n  x.report(label) do\n    set = T.new\n    values.each { |x|\
    \ set.add x }\n  end\nend\n\nprivate def add_delete(type : T.class, x, label,\
    \ values) forall T\n  x.report(label) do\n    set = T.new\n    values.each { |x|\
    \ set.add x }\n    values.each { |x| set.delete x }\n  end\nend\n\nprivate def\
    \ each(type : T.class, x, label, n) forall T\n  set = T.new 0...n\n  x.report(label)\
    \ do\n    s = 0i64\n    set.each { |x| s += x }\n  end\nend\n\nprivate def includes?(type\
    \ : T.class, x, label, n) forall T\n  set = T.new (0...n).step(by: 2)\n  x.report(label)\
    \ do\n    (0...n).each { |x| set.includes?(x) }\n  end\nend\n\nprivate def add_includes?(type\
    \ : T.class, x, label, values, n) forall T\n  x.report(label) do\n    set = T.new\n\
    \    values.each { |x| set << x }\n    (0...n).each { |x| set.includes?(x) }\n\
    \  end\nend\n\nprivate def ge(type : T.class, x, label, n) forall T\n  set = T.new\
    \ (0...n).step(by: 2)\n  x.report(label) do\n    (0...n).each { |x| set.ge(x)\
    \ }\n  end\nend\n\nR = Random.new(42)\nvalues5 = (0...10**5).to_a.shuffle(R)\n\
    values6 = (0...10**6).to_a.shuffle(R)\n{% begin %}\n  {% hash = {\n       \"SSet::RedBlackTree\"\
    \              => \"RBT\",\n       \"SSet::Treap\"                     => \"Treap\"\
    ,\n       \"SSet::Bucket(Int32, 1, 170, 0)\"  => \"Bucket( 1, false)\",\n    \
    \   \"SSet::Bucket(Int32, 30, 170, 0)\" => \"Bucket(30, false)\",\n       \"SSet::Bucket(Int32,\
    \ 60, 170, 0)\" => \"Bucket(60, false)\",\n       \"SSet::Bucket(Int32, 90, 170,\
    \ 0)\" => \"Bucket(90, false)\",\n       \"SSet::Bucket(Int32, 1, 170, 1)\"  =>\
    \ \"Bucket( 1,  true)\",\n       \"SSet::Bucket(Int32, 30, 170, 1)\" => \"Bucket(30,\
    \  true)\",\n       \"SSet::Bucket(Int32, 60, 170, 1)\" => \"Bucket(60,  true)\"\
    ,\n       \"SSet::Bucket(Int32, 90, 170, 1)\" => \"Bucket(90,  true)\",\n    \
    \ } %}\n\n  puts \"#add (1e5 times)\"\n  Benchmark.ips do |x|\n    {% for type,\
    \ label in hash %} add({{type.id}}, x, {{label}}, values5); {% end %}\n  end\n\
    \n  puts \"\\n#add and #delete (1e5 times)\"\n  Benchmark.ips do |x|\n    {% for\
    \ type, label in hash %} add_delete({{type.id}}, x, {{label}}, values5); {% end\
    \ %}\n  end\n\n  puts \"\\n#add (1e6 times)\"\n  Benchmark.ips do |x|\n    {%\
    \ for type, label in hash %} add({{type.id}}, x, {{label}}, values6); {% end %}\n\
    \  end\n\n  puts \"\\n#add (1e6 times) and #delete (1e6 times)\"\n  Benchmark.ips\
    \ do |x|\n    {% for type, label in hash %} add_delete({{type.id}}, x, {{label}},\
    \ values6); {% end %}\n  end\n\n  puts \"\\n#add (1e6 times) and #includes? (1e6\
    \ times)\"\n  Benchmark.ips do |x|\n    {% for type, label in hash %} add_includes?({{type.id}},\
    \ x, {{label}}, values6, 10**6); {% end %}\n  end\n\n  puts \"\\n#each (1e6 elements)\"\
    \n  Benchmark.ips do |x|\n    {% for type, label in hash %} each({{type.id}},\
    \ x, {{label}}, 10**6); {% end %}\n  end\n\n  puts \"\\n#includes? (1e6 times\
    \ with 5e5 elements)\"\n  Benchmark.ips do |x|\n    {% for type, label in hash\
    \ %} includes?({{type.id}}, x, {{label}}, 10**6); {% end %}\n  end\n\n  puts \"\
    \\n#ge (1e6 times with 5e5 elements)\"\n  Benchmark.ips do |x|\n    {% for type,\
    \ label in hash %} ge({{type.id}}, x, {{label}}, 10**6); {% end %}\n  end\n{%\
    \ end %}\n"
  code: "require \"benchmark\"\nrequire \"../../src/datastructure/sset/red_black_tree\"\
    \nrequire \"../../src/datastructure/sset/treap\"\nrequire \"../../src/datastructure/sset/bucket\"\
    \n\nprivate def add(type : T.class, x, label, values) forall T\n  x.report(label)\
    \ do\n    set = T.new\n    values.each { |x| set.add x }\n  end\nend\n\nprivate\
    \ def add_delete(type : T.class, x, label, values) forall T\n  x.report(label)\
    \ do\n    set = T.new\n    values.each { |x| set.add x }\n    values.each { |x|\
    \ set.delete x }\n  end\nend\n\nprivate def each(type : T.class, x, label, n)\
    \ forall T\n  set = T.new 0...n\n  x.report(label) do\n    s = 0i64\n    set.each\
    \ { |x| s += x }\n  end\nend\n\nprivate def includes?(type : T.class, x, label,\
    \ n) forall T\n  set = T.new (0...n).step(by: 2)\n  x.report(label) do\n    (0...n).each\
    \ { |x| set.includes?(x) }\n  end\nend\n\nprivate def add_includes?(type : T.class,\
    \ x, label, values, n) forall T\n  x.report(label) do\n    set = T.new\n    values.each\
    \ { |x| set << x }\n    (0...n).each { |x| set.includes?(x) }\n  end\nend\n\n\
    private def ge(type : T.class, x, label, n) forall T\n  set = T.new (0...n).step(by:\
    \ 2)\n  x.report(label) do\n    (0...n).each { |x| set.ge(x) }\n  end\nend\n\n\
    R = Random.new(42)\nvalues5 = (0...10**5).to_a.shuffle(R)\nvalues6 = (0...10**6).to_a.shuffle(R)\n\
    {% begin %}\n  {% hash = {\n       \"SSet::RedBlackTree\"              => \"RBT\"\
    ,\n       \"SSet::Treap\"                     => \"Treap\",\n       \"SSet::Bucket(Int32,\
    \ 1, 170, 0)\"  => \"Bucket( 1, false)\",\n       \"SSet::Bucket(Int32, 30, 170,\
    \ 0)\" => \"Bucket(30, false)\",\n       \"SSet::Bucket(Int32, 60, 170, 0)\" =>\
    \ \"Bucket(60, false)\",\n       \"SSet::Bucket(Int32, 90, 170, 0)\" => \"Bucket(90,\
    \ false)\",\n       \"SSet::Bucket(Int32, 1, 170, 1)\"  => \"Bucket( 1,  true)\"\
    ,\n       \"SSet::Bucket(Int32, 30, 170, 1)\" => \"Bucket(30,  true)\",\n    \
    \   \"SSet::Bucket(Int32, 60, 170, 1)\" => \"Bucket(60,  true)\",\n       \"SSet::Bucket(Int32,\
    \ 90, 170, 1)\" => \"Bucket(90,  true)\",\n     } %}\n\n  puts \"#add (1e5 times)\"\
    \n  Benchmark.ips do |x|\n    {% for type, label in hash %} add({{type.id}}, x,\
    \ {{label}}, values5); {% end %}\n  end\n\n  puts \"\\n#add and #delete (1e5 times)\"\
    \n  Benchmark.ips do |x|\n    {% for type, label in hash %} add_delete({{type.id}},\
    \ x, {{label}}, values5); {% end %}\n  end\n\n  puts \"\\n#add (1e6 times)\"\n\
    \  Benchmark.ips do |x|\n    {% for type, label in hash %} add({{type.id}}, x,\
    \ {{label}}, values6); {% end %}\n  end\n\n  puts \"\\n#add (1e6 times) and #delete\
    \ (1e6 times)\"\n  Benchmark.ips do |x|\n    {% for type, label in hash %} add_delete({{type.id}},\
    \ x, {{label}}, values6); {% end %}\n  end\n\n  puts \"\\n#add (1e6 times) and\
    \ #includes? (1e6 times)\"\n  Benchmark.ips do |x|\n    {% for type, label in\
    \ hash %} add_includes?({{type.id}}, x, {{label}}, values6, 10**6); {% end %}\n\
    \  end\n\n  puts \"\\n#each (1e6 elements)\"\n  Benchmark.ips do |x|\n    {% for\
    \ type, label in hash %} each({{type.id}}, x, {{label}}, 10**6); {% end %}\n \
    \ end\n\n  puts \"\\n#includes? (1e6 times with 5e5 elements)\"\n  Benchmark.ips\
    \ do |x|\n    {% for type, label in hash %} includes?({{type.id}}, x, {{label}},\
    \ 10**6); {% end %}\n  end\n\n  puts \"\\n#ge (1e6 times with 5e5 elements)\"\n\
    \  Benchmark.ips do |x|\n    {% for type, label in hash %} ge({{type.id}}, x,\
    \ {{label}}, 10**6); {% end %}\n  end\n{% end %}\n"
  dependsOn:
  - src/datastructure/sset/red_black_tree.cr
  - src/datastructure/binary_tree.cr
  - src/datastructure/sset/treap.cr
  - src/datastructure/sset/bucket.cr
  isVerificationFile: false
  path: benchmarks/datastructure/sset.cr
  requiredBy: []
  timestamp: '2022-01-22 15:32:00+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: benchmarks/datastructure/sset.cr
layout: document
redirect_from:
- /library/benchmarks/datastructure/sset.cr
- /library/benchmarks/datastructure/sset.cr.html
title: benchmarks/datastructure/sset.cr
---
