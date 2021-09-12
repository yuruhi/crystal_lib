require "../binary_tree"

# Copied with modifications from: https://github.com/crystal-lang/crystal/blob/1.1.1/samples/red_black_tree.cr
class SMultiSet::RedBlackTree(T)
  class Node(T)
    enum Color
      Red
      Black
    end

    include TreeNode(T)

    property key : T, color : Color
    property! left : Node(T), right : Node(T), parent : Node(T)

    def initialize(@key : T, @color : Color = :red)
      @left = @right = @parent = NilNode(T).new
    end

    def black?
      color.black?
    end

    def red?
      color.red?
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
  end

  class NilNode(T) < Node(T)
    include TreeNilNode(T)

    def initialize
      @key = {% if T.class.has_method?(:zero) %}
               T.zero
             {% else %}
               T.new
             {% end %}
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

  private def insert_node(x : Node(T)) : Nil
    insert_helper(x)

    x.color = :red
    while x != root && x.parent.red?
      if x.parent == x.parent.parent.left
        y = x.parent.parent.right
        if !y.nil_node? && y.red?
          x.parent.color = :black
          y.color = :black
          x.parent.parent.color = :red
          x = x.parent.parent
        else
          if x == x.parent.right
            x = x.parent
            left_rotate(x)
          end
          x.parent.color = :black
          x.parent.parent.color = :red
          right_rotate(x.parent.parent)
        end
      else
        y = x.parent.parent.left
        if !y.nil_node? && y.red?
          x.parent.color = :black
          y.color = :black
          x.parent.parent.color = :red
          x = x.parent.parent
        else
          if x == x.parent.left
            x = x.parent
            right_rotate(x)
          end
          x.parent.color = :black
          x.parent.parent.color = :red
          left_rotate(x.parent.parent)
        end
      end
    end
    root.color = :black
  end

  private def delete_node(z : Node(T)) : Nil
    y = (z.left.nil_node? || z.right.nil_node?) ? z : z.succ
    x = y.left.nil_node? ? y.right : y.left
    x.parent = y.parent

    if y.parent.nil_node?
      @root = x
    else
      if y == y.parent.left
        y.parent.left = x
      else
        y.parent.right = x
      end
    end

    z.key = y.key if y != z

    if y.black?
      delete_fixup(x)
    end

    @size -= 1
    y
  end

  def add?(key : T) : Bool
    insert_node(Node.new(key))
    true
  end

  def delete(key : T) : Bool
    node = search(key)
    return false if node.nil_node?
    delete_node(node)
    true
  end

  def split(key : T) : {self, self}
    l, r = root.split(key)
    l.parent = NilNode(T).new
    r.parent = NilNode(T).new
    {RedBlackTree(T).new(l), RedBlackTree(T).new(r)}
  end

  def black_height(x : Node = root)
    height = 0
    until x.nil_node?
      x = x.left
      height += 1 if x.nil_node? || x.black?
    end
    height
  end

  def to_s(io : IO) : Nil
    io << "SMultiSet::RedBlackTree{"
    each_with_index do |x, i|
      io << ", " if i > 0
      io << x
    end
    io << '}'
  end

  def inspect(io : IO) : Nil
    to_s(io)
  end

  private def left_rotate(x : Node)
    raise "x.right is nil!" if x.right.nil_node?
    y = x.right
    x.right = y.left
    y.left.parent = x if !y.left.nil_node?
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

  private def right_rotate(x : Node)
    raise "x.left is nil!" if x.left.nil_node?
    y = x.left
    x.left = y.right
    y.right.parent = x if !y.right.nil_node?
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

  private def insert_helper(z : Node)
    y = NilNode(T).new
    x = root
    while !x.nil_node?
      y = x
      x = (z.key < x.key) ? x.left : x.right
    end
    z.parent = y
    if y.nil_node?
      @root = z
    else
      z.key < y.key ? y.left = z : y.right = z
    end
    @size += 1
  end

  private def delete_fixup(x : Node)
    while x != root && x.black?
      if x == x.parent.left
        w = x.parent.right
        if w.red?
          w.color = :black
          x.parent.color = :red
          left_rotate(x.parent)
          w = x.parent.right
        end
        if w.left.black? && w.right.black?
          w.color = :red
          x = x.parent
        else
          if w.right.black?
            w.left.color = :black
            w.color = :red
            right_rotate(w)
            w = x.parent.right
          end
          w.color = x.parent.color
          x.parent.color = :black
          w.right.color = :black
          left_rotate(x.parent)
          x = root
        end
      else
        w = x.parent.left
        if w.red?
          w.color = :black
          x.parent.color = :red
          right_rotate(x.parent)
          w = x.parent.left
        end
        if w.right.black? && w.left.black?
          w.color = :red
          x = x.parent
        else
          if w.left.black?
            w.right.color = :black
            w.color = :red
            left_rotate(w)
            w = x.parent.left
          end
          w.color = x.parent.color
          x.parent.color = :black
          w.left.color = :black
          right_rotate(x.parent)
          x = root
        end
      end
    end
    x.color = :black
  end
end
