---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/datastructure/sset/treap.cr
    title: src/datastructure/sset/treap.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../../src/datastructure/sset/treap\"\
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
    \    include TreeNilNode(T)\n\n    def initialize\n      @key = {% if T.class.has_method?(:zero)\
    \ %}\n               T.zero\n             {% else %}\n               T.new\n \
    \            {% end %}\n      @left = @right = @parent = self\n    end\n  end\n\
    \n  include BinaryTree(T, Node(T), NilNode(T))\n  getter root : Node(T), size\
    \ : Int32 = 0\n\n  def initialize\n    @root = NilNode(T).new\n  end\n\n  def\
    \ initialize(enumerable : Enumerable(T))\n    initialize\n    enumerable.each\
    \ { |x| self << x }\n  end\n\n  protected def initialize(@root : Node(T))\n  end\n\
    \n  private def add_node(node : Node) : Bool\n    if empty?\n      @root = node\n\
    \      @size += 1\n      return true\n    end\n    u, prev = root, NilNode(T).new\n\
    \    while u.node?\n      return false if u.key == node.key\n      u, prev = node.key\
    \ < u.key ? u.left : u.right, u\n    end\n    if node.key < prev.key\n      prev.left\
    \ = node\n    else\n      prev.right = node\n    end\n    node.parent = prev\n\
    \    @size += 1\n    true\n  end\n\n  private def bubble_up(u : Node) : Nil\n\
    \    raise \"u is nil node\" unless u.node?\n    while u.parent.node? && u.parent.priority\
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
    \    u.parent.right = NilNode(T).new\n    end\n    @size -= 1\n    true\n  end\n\
    \n  def split(key : T) : {self, self}\n    l, r = root.split(key)\n    l.parent\
    \ = NilNode(T).new\n    r.parent = NilNode(T).new\n    {Treap(T).new(l), Treap(T).new(r)}\n\
    \  end\n\n  def to_s(io : IO) : Nil\n    io << \"SSet::Treap{\"\n    each_with_index\
    \ do |x, i|\n      io << \", \" if i > 0\n      io << x\n    end\n    io << '}'\n\
    \  end\n\n  def inspect(io : IO) : Nil\n    to_s(io)\n  end\nend\n\ndef verify_dfs(node\
    \ : SSet::Treap::Node)\n  if node.nil_node?\n    node.left.nil_node?.should be_true\n\
    \    node.right.nil_node?.should be_true\n  end\n\n  if node.left.node?\n    node.key.should\
    \ be > node.left.key\n    node.priority.should be <= node.left.priority\n    node.left.parent.should\
    \ eq node\n    verify_dfs(node.left)\n  end\n\n  if node.right.node?\n    node.key.should\
    \ be < node.right.key\n    node.priority.should be <= node.right.priority\n  \
    \  node.right.parent.should eq node\n    verify_dfs(node.right)\n  end\nend\n\n\
    def verify(set : SSet::Treap)\n  if set.root.node?\n    set.root.parent.nil_node?.should\
    \ be_true\n  end\n  verify_dfs(set.root)\nend\n\nalias Treap = SSet::Treap(Int32)\n\
    \ndescribe SSet::Treap(Int32) do\n  it \"{}\" do\n    Treap{3, 1, 4, 1, 5}.to_a.should\
    \ eq [1, 3, 4, 5]\n  end\n\n  it \"#root\" do\n    s = Treap.new\n    s.root.nil_node?.should\
    \ be_true\n  end\n\n  it \"#size\" do\n    s = Treap.new\n    s.size.should eq\
    \ 0\n    s.add 1\n    s.size.should eq 1\n    s.add 1\n    s.size.should eq 1\n\
    \    s.delete 1\n    s.size.should eq 0\n  end\n\n  it \"#empty?\" do\n    s =\
    \ Treap.new\n    s.empty?.should be_true\n    s.add 1\n    s.empty?.should be_false\n\
    \  end\n\n  it \"#clear\" do\n    s = Treap.new\n    s.add 1\n    s.clear.size.should\
    \ eq 0\n  end\n\n  it \"#add?\" do\n    s = Treap.new\n    s.add?(1).should be_true\n\
    \    s.add?(1).should be_false\n    verify(s)\n  end\n\n  it \"#add, #<<\" do\n\
    \    s = Treap.new\n    s.add(1).add(2).add(1)\n    s.size.should eq 2\n    s\
    \ << 3 << 4 << 3\n    s.size.should eq 4\n    verify(s)\n  end\n\n  it \"#min_node,\
    \ #max_node\" do\n    s = Treap.new\n    s.min_node.nil_node?.should be_true\n\
    \    s.max_node.nil_node?.should be_true\n    s << 1 << 2\n    s.min_node.key?.should\
    \ eq 1\n    s.max_node.key?.should eq 2\n  end\n\n  it \"#min?, #min, #max?, #max\"\
    \ do\n    s = Treap.new\n    s.min?.should be_nil\n    s.max?.should be_nil\n\
    \    expect_raises(SSet::Treap::EmptyError) { s.min }\n    expect_raises(SSet::Treap::EmptyError)\
    \ { s.max }\n    s << 1 << 2\n    s.min?.should eq 1\n    s.max?.should eq 2\n\
    \    s.min.should eq 1\n    s.max.should eq 2\n  end\n\n  it \"#split\" do\n \
    \   1000.times do\n      s = Treap.new(1..10)\n      l, r = s.split(5)\n     \
    \ l.to_a.should eq [1, 2, 3, 4, 5]\n      r.to_a.should eq [6, 7, 8, 9, 10]\n\
    \      verify(s)\n    end\n    10.times do\n      s = Treap.new(1..1000)\n   \
    \   l, r = s.split(500)\n      l.to_a.should eq (1..500).to_a\n      r.to_a.should\
    \ eq (501..1000).to_a\n      verify(s)\n    end\n  end\n\n  it \"#each\" do\n\
    \    s = Treap{3, 1, 4, 1, 5}\n    a = [] of Int32\n    s.each { |x| a << x }\n\
    \    a.should eq [1, 3, 4, 5]\n  end\n\n  it \"#reverse_each\" do\n    s = Treap{3,\
    \ 1, 4, 1, 5}\n    a = [] of Int32\n    s.reverse_each { |x| a << x }\n    a.should\
    \ eq [5, 4, 3, 1]\n  end\n\n  it \"#includes?\" do\n    s = Treap{1, 3, 5}\n \
    \   {1, 3, 5}.each { |x| s.includes?(x).should be_true }\n    {0, 2, 4}.each {\
    \ |x| s.includes?(x).should be_false }\n  end\n\n  it \"#search\" do\n    s =\
    \ Treap{1, 3, 5}\n    {1, 3, 5}.each { |x| s.search(x).key?.should eq x }\n  \
    \  {0, 2, 4}.each { |x| s.search(x).nil_node?.should be_true }\n  end\n\n  it\
    \ \"#le, #le!\" do\n    s = Treap{1, 3}\n    [nil, 1, 1, 3, 3].each_with_index\
    \ { |e, x| s.le(x).should eq e }\n    expect_raises(NilAssertionError) { s.le!(0)\
    \ }\n    [1, 1, 3, 3].each_with_index(1) { |e, x| s.le!(x).should eq e }\n  end\n\
    \n  it \"#lt, #lt!\" do\n    s = Treap{1, 3}\n    [nil, nil, 1, 1, 3, 3].each_with_index\
    \ { |e, x| s.lt(x).should eq e }\n    expect_raises(NilAssertionError) { s.lt!(0)\
    \ }\n    expect_raises(NilAssertionError) { s.lt!(1) }\n    [1, 1, 3, 3].each_with_index(2)\
    \ { |e, x| s.lt!(x).should eq e }\n  end\n\n  it \"#ge, #ge!\" do\n    s = Treap{1,\
    \ 3}\n    [1, 1, 3, 3, nil].each_with_index { |e, x| s.ge(x).should eq e }\n \
    \   expect_raises(NilAssertionError) { s.ge!(4) }\n    [1, 1, 3, 3].each_with_index\
    \ { |e, x| s.ge!(x).should eq e }\n  end\n\n  it \"#gt, #gt!\" do\n    s = Treap{1,\
    \ 3}\n    [1, 3, 3, nil, nil].each_with_index { |e, x| s.gt(x).should eq e }\n\
    \    expect_raises(NilAssertionError) { s.gt!(3) }\n    expect_raises(NilAssertionError)\
    \ { s.gt!(4) }\n    [1, 3, 3].each_with_index { |e, x| s.gt!(x).should eq e }\n\
    \  end\n\n  it \"#to_s, #inspect\" do\n    s = Treap{1, 2, 3, 4}\n    s.to_s.should\
    \ eq \"SSet::Treap{1, 2, 3, 4}\"\n    s.inspect.should eq \"SSet::Treap{1, 2,\
    \ 3, 4}\"\n  end\nend\n\nit SSet::Treap(String) do\n  SSet::Treap{\"a\", \"c\"\
    , \"b\"}.to_a.should eq %w[a b c]\n  SSet::Treap{\"a\", \"ab\", \"abc\", \"abc\"\
    }.to_a.should eq %w[a ab abc]\nend\n"
  code: "require \"spec\"\nrequire \"../../../src/datastructure/sset/treap\"\n\ndef\
    \ verify_dfs(node : SSet::Treap::Node)\n  if node.nil_node?\n    node.left.nil_node?.should\
    \ be_true\n    node.right.nil_node?.should be_true\n  end\n\n  if node.left.node?\n\
    \    node.key.should be > node.left.key\n    node.priority.should be <= node.left.priority\n\
    \    node.left.parent.should eq node\n    verify_dfs(node.left)\n  end\n\n  if\
    \ node.right.node?\n    node.key.should be < node.right.key\n    node.priority.should\
    \ be <= node.right.priority\n    node.right.parent.should eq node\n    verify_dfs(node.right)\n\
    \  end\nend\n\ndef verify(set : SSet::Treap)\n  if set.root.node?\n    set.root.parent.nil_node?.should\
    \ be_true\n  end\n  verify_dfs(set.root)\nend\n\nalias Treap = SSet::Treap(Int32)\n\
    \ndescribe SSet::Treap(Int32) do\n  it \"{}\" do\n    Treap{3, 1, 4, 1, 5}.to_a.should\
    \ eq [1, 3, 4, 5]\n  end\n\n  it \"#root\" do\n    s = Treap.new\n    s.root.nil_node?.should\
    \ be_true\n  end\n\n  it \"#size\" do\n    s = Treap.new\n    s.size.should eq\
    \ 0\n    s.add 1\n    s.size.should eq 1\n    s.add 1\n    s.size.should eq 1\n\
    \    s.delete 1\n    s.size.should eq 0\n  end\n\n  it \"#empty?\" do\n    s =\
    \ Treap.new\n    s.empty?.should be_true\n    s.add 1\n    s.empty?.should be_false\n\
    \  end\n\n  it \"#clear\" do\n    s = Treap.new\n    s.add 1\n    s.clear.size.should\
    \ eq 0\n  end\n\n  it \"#add?\" do\n    s = Treap.new\n    s.add?(1).should be_true\n\
    \    s.add?(1).should be_false\n    verify(s)\n  end\n\n  it \"#add, #<<\" do\n\
    \    s = Treap.new\n    s.add(1).add(2).add(1)\n    s.size.should eq 2\n    s\
    \ << 3 << 4 << 3\n    s.size.should eq 4\n    verify(s)\n  end\n\n  it \"#min_node,\
    \ #max_node\" do\n    s = Treap.new\n    s.min_node.nil_node?.should be_true\n\
    \    s.max_node.nil_node?.should be_true\n    s << 1 << 2\n    s.min_node.key?.should\
    \ eq 1\n    s.max_node.key?.should eq 2\n  end\n\n  it \"#min?, #min, #max?, #max\"\
    \ do\n    s = Treap.new\n    s.min?.should be_nil\n    s.max?.should be_nil\n\
    \    expect_raises(SSet::Treap::EmptyError) { s.min }\n    expect_raises(SSet::Treap::EmptyError)\
    \ { s.max }\n    s << 1 << 2\n    s.min?.should eq 1\n    s.max?.should eq 2\n\
    \    s.min.should eq 1\n    s.max.should eq 2\n  end\n\n  it \"#split\" do\n \
    \   1000.times do\n      s = Treap.new(1..10)\n      l, r = s.split(5)\n     \
    \ l.to_a.should eq [1, 2, 3, 4, 5]\n      r.to_a.should eq [6, 7, 8, 9, 10]\n\
    \      verify(s)\n    end\n    10.times do\n      s = Treap.new(1..1000)\n   \
    \   l, r = s.split(500)\n      l.to_a.should eq (1..500).to_a\n      r.to_a.should\
    \ eq (501..1000).to_a\n      verify(s)\n    end\n  end\n\n  it \"#each\" do\n\
    \    s = Treap{3, 1, 4, 1, 5}\n    a = [] of Int32\n    s.each { |x| a << x }\n\
    \    a.should eq [1, 3, 4, 5]\n  end\n\n  it \"#reverse_each\" do\n    s = Treap{3,\
    \ 1, 4, 1, 5}\n    a = [] of Int32\n    s.reverse_each { |x| a << x }\n    a.should\
    \ eq [5, 4, 3, 1]\n  end\n\n  it \"#includes?\" do\n    s = Treap{1, 3, 5}\n \
    \   {1, 3, 5}.each { |x| s.includes?(x).should be_true }\n    {0, 2, 4}.each {\
    \ |x| s.includes?(x).should be_false }\n  end\n\n  it \"#search\" do\n    s =\
    \ Treap{1, 3, 5}\n    {1, 3, 5}.each { |x| s.search(x).key?.should eq x }\n  \
    \  {0, 2, 4}.each { |x| s.search(x).nil_node?.should be_true }\n  end\n\n  it\
    \ \"#le, #le!\" do\n    s = Treap{1, 3}\n    [nil, 1, 1, 3, 3].each_with_index\
    \ { |e, x| s.le(x).should eq e }\n    expect_raises(NilAssertionError) { s.le!(0)\
    \ }\n    [1, 1, 3, 3].each_with_index(1) { |e, x| s.le!(x).should eq e }\n  end\n\
    \n  it \"#lt, #lt!\" do\n    s = Treap{1, 3}\n    [nil, nil, 1, 1, 3, 3].each_with_index\
    \ { |e, x| s.lt(x).should eq e }\n    expect_raises(NilAssertionError) { s.lt!(0)\
    \ }\n    expect_raises(NilAssertionError) { s.lt!(1) }\n    [1, 1, 3, 3].each_with_index(2)\
    \ { |e, x| s.lt!(x).should eq e }\n  end\n\n  it \"#ge, #ge!\" do\n    s = Treap{1,\
    \ 3}\n    [1, 1, 3, 3, nil].each_with_index { |e, x| s.ge(x).should eq e }\n \
    \   expect_raises(NilAssertionError) { s.ge!(4) }\n    [1, 1, 3, 3].each_with_index\
    \ { |e, x| s.ge!(x).should eq e }\n  end\n\n  it \"#gt, #gt!\" do\n    s = Treap{1,\
    \ 3}\n    [1, 3, 3, nil, nil].each_with_index { |e, x| s.gt(x).should eq e }\n\
    \    expect_raises(NilAssertionError) { s.gt!(3) }\n    expect_raises(NilAssertionError)\
    \ { s.gt!(4) }\n    [1, 3, 3].each_with_index { |e, x| s.gt!(x).should eq e }\n\
    \  end\n\n  it \"#to_s, #inspect\" do\n    s = Treap{1, 2, 3, 4}\n    s.to_s.should\
    \ eq \"SSet::Treap{1, 2, 3, 4}\"\n    s.inspect.should eq \"SSet::Treap{1, 2,\
    \ 3, 4}\"\n  end\nend\n\nit SSet::Treap(String) do\n  SSet::Treap{\"a\", \"c\"\
    , \"b\"}.to_a.should eq %w[a b c]\n  SSet::Treap{\"a\", \"ab\", \"abc\", \"abc\"\
    }.to_a.should eq %w[a ab abc]\nend\n"
  dependsOn:
  - src/datastructure/sset/treap.cr
  isVerificationFile: false
  path: spec/datastructure/sset/treap_spec.cr
  requiredBy: []
  timestamp: '2021-09-12 10:49:16+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/datastructure/sset/treap_spec.cr
layout: document
redirect_from:
- /library/spec/datastructure/sset/treap_spec.cr
- /library/spec/datastructure/sset/treap_spec.cr.html
title: spec/datastructure/sset/treap_spec.cr
---
