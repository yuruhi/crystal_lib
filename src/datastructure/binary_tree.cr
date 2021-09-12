module TreeNode(T)
  abstract def key : T
  abstract def left
  abstract def right
  abstract def parent

  def node?
    true
  end

  def nil_node?
    false
  end

  def key? : T?
    key
  end

  def key! : T
    key
  end

  def min_node : self
    x = self
    while x.left.node?
      x = x.left
    end
    x
  end

  def max_node : self
    x = self
    while x.right.node?
      x = x.right
    end
    x
  end

  def succ : self
    if right.node?
      return right.min_node
    end
    x, y = self, parent
    while y.node? && x != y.left
      x = y
      y = y.parent
    end
    y
  end

  def pred : self
    if left.node?
      return left.max_node
    end
    x, y = self, parent
    while y.node? && x != y.right
      x = y
      y = y.parent
    end
    y
  end

  def to_s(io : IO)
    io << '[' << key << ']'
  end

  def inspect(io : IO)
    to_s(io)
  end
end

module TreeNilNode(T)
  def node?
    false
  end

  def nil_node?
    true
  end

  def key? : T?
    nil
  end

  def key!
    raise NilAssertionError.new
  end

  def to_s(io : IO)
    io << "NilNode"
  end

  def inspect(io : IO)
    to_s(io)
  end
end

module BinaryTree(T, Node, NilNode)
  class EmptyError < Exception
    def initialize(message = "Empty RedBlackTree")
      super(message)
    end
  end

  include Enumerable(T)

  abstract def root
  abstract def size : Int32
  abstract def add?(key : T) : Bool
  abstract def delete(key : T) : Bool

  def empty? : Bool
    root.nil_node?
  end

  def clear : self
    @root = NilNode.new
    @size = 0
    self
  end

  def add(key : T) : self
    add?(key)
    self
  end

  def <<(key : T) : self
    add(key)
  end

  def rotate_left(x : Node) : Nil
    raise "x.right is nil!" if x.right.nil_node?
    y = x.right
    x.right = y.left
    y.left.parent = x if y.left.node?
    y.parent = x.parent
    if x.parent.nil_node?
      @root = y
    else
      if x == x.parent.left
        x.parent.left = y
      else
        x.parent.right = y
      end
    end
    y.left = x
    x.parent = y
  end

  def rotate_right(x : Node) : Nil
    raise "x.left is nil!" if x.left.nil_node?
    y = x.left
    x.left = y.right
    y.right.parent = x if y.right.node?
    y.parent = x.parent
    if x.parent.nil_node?
      @root = y
    else
      if x == x.parent.left
        x.parent.left = y
      else
        x.parent.right = y
      end
    end
    y.right = x
    x.parent = y
  end

  def min_node : Node
    root.min_node
  end

  def max_node : Node
    root.max_node
  end

  def min? : T?
    min_node.key?
  end

  def min : T
    min? || raise EmptyError.new
  end

  def max? : T?
    max_node.key?
  end

  def max : T
    max? || raise EmptyError.new
  end

  def inorder_walk(x : Node) : Nil
    until x.nil_node?
      yield x.key
      x = x.succ
    end
  end

  def each : Nil
    inorder_walk(min_node) { |k| yield k }
  end

  def reverse_inorder_walk(x : Node) : Nil
    until x.nil_node?
      yield x.key
      x = x.pred
    end
  end

  def reverse_each : Nil
    reverse_inorder_walk(max_node) { |k| yield k }
  end

  def includes?(key : T) : Bool
    x = root
    loop do
      return false if x.nil_node?
      cmp = key <=> x.key
      return true if cmp == 0
      x = cmp < 0 ? x.left : x.right
    end
  end

  def search(key : T, x : Node = root) : Node
    while x.node?
      cmp = key <=> x.key
      break if cmp == 0
      x = cmp < 0 ? x.left : x.right
    end
    x
  end

  def le_node(key : T, x : Node = root) : Node
    loop do
      cmp = key <=> x.key
      y = cmp < 0 ? x.left : x.right
      if y.nil_node?
        return cmp < 0 ? x.pred : x
      end
      x = y
    end
  end

  def lt_node(key : T, x : Node = root) : Node
    loop do
      cmp = key <=> x.key
      y = cmp <= 0 ? x.left : x.right
      if y.nil_node?
        return cmp <= 0 ? x.pred : x
      end
      x = y
    end
  end

  def ge_node(key : T, x : Node = root) : Node
    loop do
      cmp = key <=> x.key
      y = cmp <= 0 ? x.left : x.right
      if y.nil_node?
        return cmp <= 0 ? x : x.succ
      end
      x = y
    end
  end

  def gt_node(key : T, x : Node = root) : Node
    loop do
      cmp = key <=> x.key
      y = cmp < 0 ? x.left : x.right
      if y.nil_node?
        return cmp < 0 ? x : x.succ
      end
      x = y
    end
  end

  {% for method in [:le, :lt, :ge, :gt] %}
    def {{method.id}}(key : T) : T?
			{{method.id}}_node(key).key?
    end

    def {{method.id}}!(key : T) : T
			{{method.id}}_node(key).key!
    end
  {% end %}
end
