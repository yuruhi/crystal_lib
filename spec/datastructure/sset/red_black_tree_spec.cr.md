---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: spec/datastructure/sset/spec_helper.cr
    title: spec/datastructure/sset/spec_helper.cr
  - icon: ':warning:'
    path: src/datastructure/sset/red_black_tree.cr
    title: src/datastructure/sset/red_black_tree.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "# require \"./spec_helper\"\nrequire \"spec\"\n\ndef run_sset_spec(type\
    \ : SSet.class, class_name : String) forall SSet\n  describe class_name + \"(Int32)\"\
    \ do\n    it \"{}\" do\n      SSet{3, 1, 4, 1, 5}.to_a.should eq [1, 3, 4, 5]\n\
    \    end\n\n    it \"#root\" do\n      s = SSet(Int32).new\n      s.root.nil_node?.should\
    \ be_true\n    end\n\n    it \"#size\" do\n      s = SSet(Int32).new\n      s.size.should\
    \ eq 0\n      s.add 1\n      s.size.should eq 1\n      s.add 1\n      s.size.should\
    \ eq 1\n      s.delete 1\n      s.size.should eq 0\n    end\n\n    it \"#empty?\"\
    \ do\n      s = SSet(Int32).new\n      s.empty?.should be_true\n      s.add 1\n\
    \      s.empty?.should be_false\n    end\n\n    it \"#clear\" do\n      s = SSet(Int32).new\n\
    \      s.add 1\n      s.clear.size.should eq 0\n    end\n\n    it \"#add?\" do\n\
    \      s = SSet(Int32).new\n      s.add?(1).should be_true\n      s.add?(1).should\
    \ be_false\n      s.verify\n    end\n\n    it \"#add, #<<\" do\n      s = SSet(Int32).new\n\
    \      s.add(1).add(2).add(1)\n      s.size.should eq 2\n      s << 3 << 4 <<\
    \ 3\n      s.size.should eq 4\n      s.verify\n    end\n\n    it \"#min_node,\
    \ #max_node\" do\n      s = SSet(Int32).new\n      s.min_node.nil_node?.should\
    \ be_true\n      s.max_node.nil_node?.should be_true\n      s << 1 << 2\n    \
    \  s.min_node.key?.should eq 1\n      s.max_node.key?.should eq 2\n    end\n\n\
    \    it \"#min?, #min, #max?, #max\" do\n      s = SSet(Int32).new\n      s.min?.should\
    \ be_nil\n      s.max?.should be_nil\n      expect_raises(SSet::EmptyError) {\
    \ s.min }\n      expect_raises(SSet::EmptyError) { s.max }\n      s << 1 << 2\n\
    \      s.min?.should eq 1\n      s.max?.should eq 2\n      s.min.should eq 1\n\
    \      s.max.should eq 2\n    end\n\n    it \"#split\" do\n      1000.times do\n\
    \        s = SSet.new(1..10)\n        l, r = s.split(5)\n        l.to_a.should\
    \ eq [1, 2, 3, 4, 5]\n        r.to_a.should eq [6, 7, 8, 9, 10]\n        s.verify\n\
    \      end\n      10.times do\n        s = SSet.new(1..1000)\n        l, r = s.split(500)\n\
    \        l.to_a.should eq (1..500).to_a\n        r.to_a.should eq (501..1000).to_a\n\
    \        s.verify\n      end\n    end\n\n    it \"#each\" do\n      s = SSet{3,\
    \ 1, 4, 1, 5}\n\n      a = [] of Int32\n      s.each { |x| a << x }\n      a.should\
    \ eq [1, 3, 4, 5]\n\n      b = [] of Int32\n      s.each(s.search(3)) { |x| b\
    \ << x }\n      b.should eq [3, 4, 5]\n\n      s.each.to_a.should eq [1, 3, 4,\
    \ 5]\n      s.each(s.search(3)).to_a.should eq [3, 4, 5]\n    end\n\n    it \"\
    #reverse_each\" do\n      s = SSet{3, 1, 4, 1, 5}\n\n      a = [] of Int32\n \
    \     s.reverse_each { |x| a << x }\n      a.should eq [5, 4, 3, 1]\n\n      a\
    \ = [] of Int32\n      s.reverse_each(s.search(4)) { |x| a << x }\n      a.should\
    \ eq [4, 3, 1]\n\n      s.reverse_each.to_a.should eq [5, 4, 3, 1]\n      s.reverse_each(s.search(4)).to_a.should\
    \ eq [4, 3, 1]\n    end\n\n    it \"#includes?\" do\n      s = SSet{1, 3, 5}\n\
    \      {1, 3, 5}.each { |x| s.includes?(x).should be_true }\n      {0, 2, 4}.each\
    \ { |x| s.includes?(x).should be_false }\n    end\n\n    it \"#search\" do\n \
    \     s = SSet{1, 3, 5}\n      {1, 3, 5}.each { |x| s.search(x).key?.should eq\
    \ x }\n      {0, 2, 4}.each { |x| s.search(x).nil_node?.should be_true }\n   \
    \ end\n\n    it \"#le, #le!\" do\n      s = SSet{1, 3}\n      [nil, 1, 1, 3, 3].each_with_index\
    \ { |e, x| s.le(x).should eq e }\n      expect_raises(NilAssertionError) { s.le!(0)\
    \ }\n      [1, 1, 3, 3].each_with_index(1) { |e, x| s.le!(x).should eq e }\n \
    \   end\n\n    it \"#lt, #lt!\" do\n      s = SSet{1, 3}\n      [nil, nil, 1,\
    \ 1, 3, 3].each_with_index { |e, x| s.lt(x).should eq e }\n      expect_raises(NilAssertionError)\
    \ { s.lt!(0) }\n      expect_raises(NilAssertionError) { s.lt!(1) }\n      [1,\
    \ 1, 3, 3].each_with_index(2) { |e, x| s.lt!(x).should eq e }\n    end\n\n   \
    \ it \"#ge, #ge!\" do\n      s = SSet{1, 3}\n      [1, 1, 3, 3, nil].each_with_index\
    \ { |e, x| s.ge(x).should eq e }\n      expect_raises(NilAssertionError) { s.ge!(4)\
    \ }\n      [1, 1, 3, 3].each_with_index { |e, x| s.ge!(x).should eq e }\n    end\n\
    \n    it \"#gt, #gt!\" do\n      s = SSet{1, 3}\n      [1, 3, 3, nil, nil].each_with_index\
    \ { |e, x| s.gt(x).should eq e }\n      expect_raises(NilAssertionError) { s.gt!(3)\
    \ }\n      expect_raises(NilAssertionError) { s.gt!(4) }\n      [1, 3, 3].each_with_index\
    \ { |e, x| s.gt!(x).should eq e }\n    end\n\n    it \"include Enumerable\" do\n\
    \      s = SSet{1, 2, 3, 4}\n      s.all? { |x| x > 0 }.should be_true\n    end\n\
    \n    it \"include Iterable\" do\n      s = SSet{1, 2, 3, 4}\n      s.cycle(2).to_a.should\
    \ eq [1, 2, 3, 4, 1, 2, 3, 4]\n    end\n\n    it \"#to_s, #inspect\" do\n    \
    \  s = SSet{1, 2, 3, 4}\n      s.to_s.should eq \"#{class_name}{1, 2, 3, 4}\"\n\
    \      s.inspect.should eq \"#{class_name}{1, 2, 3, 4}\"\n    end\n\n    it \"\
    big\" do\n      n = 10**4\n      s = SSet(Int32).new\n      (1..n).each do |x|\n\
    \        s << x\n        s.size.should eq x\n        s.min.should eq 1\n     \
    \   s.max.should eq x\n        s.verify\n      end\n      s.to_a.should eq (1..n).to_a\n\
    \      (-n..n*2).each do |x|\n        s.includes?(x).should (1 <= x <= n ? be_true\
    \ : be_false)\n      end\n      (1..n).each do |x|\n        s.delete(x).should\
    \ be_true\n        s.delete(x).should be_false\n      end\n    end\n  end\n\n\
    \  it class_name + \"(String)\" do\n    SSet{\"a\", \"c\", \"b\"}.to_a.should\
    \ eq %w[a b c]\n    SSet{\"a\", \"ab\", \"abc\", \"abc\"}.to_a.should eq %w[a\
    \ ab abc]\n  end\nend\n\n# require \"../../../src/datastructure/sset/red_black_tree\"\
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
    \        end\n      end\n    end\n    x.color = :black\n  end\nend\n\nclass SSet::RedBlackTree::Node\n\
    \  def verify\n    if nil_node?\n      left.nil_node?.should be_true\n      right.nil_node?.should\
    \ be_true\n    end\n\n    if left.node?\n      key.should be > left.key\n    \
    \  (red? && left.red?).should be_false\n      left.parent.should eq self\n   \
    \   left.verify\n    end\n\n    if right.node?\n      key.should be < right.key\n\
    \      (red? && right.red?).should be_false\n      right.parent.should eq self\n\
    \      right.verify\n    end\n  end\nend\n\nclass SSet::RedBlackTree\n  def verify\n\
    \    if root.node?\n      root.parent.nil_node?.should be_true\n    end\n    root.verify\n\
    \  end\nend\n\nrun_sset_spec(SSet::RedBlackTree, \"SSet::RedBlackTree\")\n"
  code: "require \"./spec_helper\"\nrequire \"../../../src/datastructure/sset/red_black_tree\"\
    \n\nclass SSet::RedBlackTree::Node\n  def verify\n    if nil_node?\n      left.nil_node?.should\
    \ be_true\n      right.nil_node?.should be_true\n    end\n\n    if left.node?\n\
    \      key.should be > left.key\n      (red? && left.red?).should be_false\n \
    \     left.parent.should eq self\n      left.verify\n    end\n\n    if right.node?\n\
    \      key.should be < right.key\n      (red? && right.red?).should be_false\n\
    \      right.parent.should eq self\n      right.verify\n    end\n  end\nend\n\n\
    class SSet::RedBlackTree\n  def verify\n    if root.node?\n      root.parent.nil_node?.should\
    \ be_true\n    end\n    root.verify\n  end\nend\n\nrun_sset_spec(SSet::RedBlackTree,\
    \ \"SSet::RedBlackTree\")\n"
  dependsOn:
  - spec/datastructure/sset/spec_helper.cr
  - src/datastructure/sset/red_black_tree.cr
  isVerificationFile: false
  path: spec/datastructure/sset/red_black_tree_spec.cr
  requiredBy: []
  timestamp: '2021-09-21 18:47:08+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/datastructure/sset/red_black_tree_spec.cr
layout: document
redirect_from:
- /library/spec/datastructure/sset/red_black_tree_spec.cr
- /library/spec/datastructure/sset/red_black_tree_spec.cr.html
title: spec/datastructure/sset/red_black_tree_spec.cr
---
