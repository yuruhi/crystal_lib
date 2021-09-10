require "../binary_tree"

class Set::Treap(T)
  class Node(T)
    include TreeNode(T)

    getter key : T, priority : Int32
    property! left : Node(T), right : Node(T), parent : Node(T)

    def initialize(@key : T, @priority)
      @left = @right = @parent = NilNode(T).new
    end
  end

  class NilNode(T) < Node(T)
    include TreeNilNode(T)

    def initialize
      @key = T.zero
      @left = @right = @parent = self
    end
  end

  include BinaryTree(T, Node(T), NilNode(T))
  getter root : Node(T), size : Int32 = 0

  def initialize
    @root = NilNode(T).new
  end

  private def add_node(node : Node) : Bool
    if empty?
      @root = node
      @size += 1
      return true
    end
    u, prev = root, NilNode(T).new
    while u.node?
      return false if u.key == node.key
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

  private def trickle_down(u : Node)
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
    true
  end
end
