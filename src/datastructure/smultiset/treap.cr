require "../binary_tree"

class SMultiSet::Treap(T)
  class Node(T)
    include TreeNode(T)

    getter key : T, priority : Int32
    property! left : Node(T), right : Node(T), parent : Node(T)

    def initialize(@key : T, @priority : Int32)
      @left = @right = @parent = NilNode(T).new
    end

    def split(split_key : T) : {Node(T), Node(T)}
      if nil_node?
        {NilNode(T).new, NilNode(T).new}
      elsif split_key < key
        l, r = left.split(split_key)
        self.left = r
        r.parent = self
        {l, self}
      else
        l, r = right.split(split_key)
        self.right = l
        l.parent = self
        {self, r}
      end
    end

    def to_s(io : IO)
      io << '[' << key << ']'
    end
  end

  class NilNode(T) < Node(T)
    include TreeNilNode(T)

    def initialize
      @key = uninitialized T
      @left = @right = @parent = self
    end
  end

  include BinaryTree(T, Node(T), NilNode(T))
  getter root : Node(T), size : Int32 = 0

  def initialize
    @root = NilNode(T).new
  end

  def initialize(enumerable : Enumerable(T))
    initialize
    enumerable.each { |x| self << x }
  end

  protected def initialize(@root : Node(T))
  end

  private def add_node(node : Node) : Bool
    if empty?
      @root = node
      @size += 1
      return true
    end
    u, prev = root, NilNode(T).new
    while u.node?
      u, prev = node.key < u.key ? u.left : u.right, u
    end
    if node.key < prev.key
      prev.left = node
    else
      prev.right = node
    end
    node.parent = prev
    @size += 1
    true
  end

  private def bubble_up(u : Node) : Nil
    raise "u is nil node" unless u.node?
    while u.parent.node? && u.parent.priority > u.priority
      if u.parent.right == u
        rotate_left(u.parent)
      else
        rotate_right(u.parent)
      end
    end
    @root = u if u.parent.nil_node?
  end

  def add?(key : T) : Bool
    u = Node.new(key, rand(Int32))
    add_node(u).tap do |f|
      bubble_up(u) if f
    end
  end

  private def trickle_down(u : Node(T))
    loop do
      l, r = u.left.node?, u.right.node?
      break unless l || r
      if !l
        rotate_left(u)
      elsif !r
        rotate_right(u)
      elsif u.left.priority < u.right.priority
        rotate_right(u)
      else
        rotate_left(u)
      end
      @root = u.parent if root == u
    end
  end

  def delete(key : T) : Bool
    u = search(key)
    return false if u.nil_node?
    trickle_down(u)
    if u.parent.left == u
      u.parent.left = NilNode(T).new
    else
      u.parent.right = NilNode(T).new
    end
    @size -= 1
    if size == 0
      @root = NilNode(T).new
    end
    true
  end

  def split(key : T) : {self, self}
    l, r = root.split(key)
    l.parent = NilNode(T).new
    r.parent = NilNode(T).new
    {Treap(T).new(l), Treap(T).new(r)}
  end

  def to_s(io : IO) : Nil
    io << "SMultiSet::Treap{"
    each_with_index do |x, i|
      io << ", " if i > 0
      io << x
    end
    io << '}'
  end

  def inspect(io : IO) : Nil
    to_s(io)
  end
end
