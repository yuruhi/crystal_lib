# Copied with modifications from: https://github.com/crystal-lang/crystal/blob/1.1.1/samples/red_black_tree.cr
class RedBlackTree(T)
  class Node
    enum Color
      Red
      Black
    end

    property color : Color, key : Int32
    property! left, right, parent : self

    def initialize(@key, @color : Color = :red)
      @left = @right = @parent = NilNode.instance
    end

    delegate black?, to: @color
    delegate red?, to: @color

    def nil_node?
      false
    end
  end

  class NilNode < Node
    def self.instance
      @@instance ||= RedBlackTree::NilNode.new
    end

    def initialize
      @key = 0
      @color = :black
      @left = @right = @parent = self
    end

    def nil_node?
      true
    end
  end

  class EmptyError < Exception
    def initialize(message = "Empty RedBlackTree")
      super(message)
    end
  end

  include Enumerable(T)

  def initialize
    @root = NilNode.instance
    @size = 0
  end

  def initialize(enumerable : Enumerable(T))
    initialize
    enumerable.each { |x| add(x) }
  end

  getter root : Node, size : Int32

  private def root=(@root)
  end

  private def size=(@size)
  end

  def empty? : Bool
    self.root.nil_node?
  end

  def insert_node(x : Node) : Nil
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

  def delete_node(z : Node) : Nil
    y = (z.left.nil_node? || z.right.nil_node?) ? z : succ(z)
    x = y.left.nil_node? ? y.right : y.left
    x.parent = y.parent

    if y.parent.nil_node?
      self.root = x
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

    self.size -= 1
    y
  end

  def add(key : T) : self
    insert_node(Node.new(key))
    self
  end

  def <<(key : T) : self
    add(key)
  end

  def delete(key : T) : Bool
    node = search(key)
    if node.nil_node?
      false
    else
      delete_node(node)
      true
    end
  end

  def min_node(x : Node = root) : Node
    while !x.left.nil_node?
      x = x.left
    end
    x
  end

  def max_node(x : Node = root) : Node
    while !x.right.nil_node?
      x = x.right
    end
    x
  end

  def min? : T?
    node = min_node
    node.nil_node? ? nil : node.key
  end

  def min : T
    min? || raise EmptyError.new
  end

  def max? : T?
    node = max_node
    node.nil_node? ? nil : node.key
  end

  def max : T
    max? || raise EmptyError.new
  end

  def succ(x : Node) : Node
    if !x.right.nil_node?
      return min_node(x.right)
    end
    y = x.parent
    while !y.nil_node? && x == y.right
      x = y
      y = y.parent
    end
    y
  end

  def pred(x : Node) : Node
    if !x.left.nil_node?
      return max_node(x.left)
    end
    y = x.parent
    while !y.nil_node? && x == y.left
      x = y
      y = y.parent
    end
    y
  end

  def inorder_walk : Nil
    x = self.min_node
    while !x.nil_node?
      yield x.key
      x = succ(x)
    end
  end

  def each : Nil
    inorder_walk(x) { |k| yield k }
  end

  def reverse_inorder_walk : Nil
    x = self.max_node
    while !x.nil_node?
      yield x.key
      x = pred(x)
    end
  end

  def reverse_each : Nil
    reverse_inorder_walk(x) { |k| yield k }
  end

  def includes?(key : T) : Bool
    x = root
    loop do
      return false if x.nil_node?
      return true if x.key == key
      x = key < x.key ? x.left : x.right
    end
  end

  def search(key : T, x : Node = root) : Node
    while !x.nil_node? && x.key != key
      x = key < x.key ? x.left : x.right
    end
    x
  end

  def le_node(key : T, x : Node = root) : Node
    loop do
      y = key < x.key ? x.left : x.right
      if y.nil_node?
        return key < x.key ? pred(x) : x
      end
      x = y
    end
  end

  def lt_node(key : T, x : Node = root) : Node
    loop do
      y = key <= x.key ? x.left : x.right
      if y.nil_node?
        return key <= x.key ? pred(x) : x
      end
      x = y
    end
  end

  def ge_node(key : T, x : Node = root) : Node
    loop do
      y = key <= x.key ? x.left : x.right
      if y.nil_node?
        return key <= x.key ? x : succ(x)
      end
      x = y
    end
  end

  def gt_node(key : T, x : Node = root) : Node
    loop do
      y = key < x.key ? x.left : x.right
      if y.nil_node?
        return key < x.key ? x : succ(x)
      end
      x = y
    end
  end

  {% for method in [:le, :lt, :ge, :gt] %}
    def {{method.id}}(key : T ) : T?
      node = {{method.id}}_node(key)
      node.nil_node? ? nil : node.key
    end

    def {{method.id}}!(key : T) : T
      {{method.id}}(key).not_nil!
    end
  {% end %}

  def black_height(x : Node = root)
    height = 0
    while !x.nil_node?
      x = x.left
      height += 1 if x.nil_node? || x.black?
    end
    height
  end

  def to_s(io : IO) : Nil
    io << "RedBlackTree{"
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
      self.root = y
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
      self.root = y
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
    y = NilNode.instance
    x = root
    while !x.nil_node?
      y = x
      x = (z.key < x.key) ? x.left : x.right
    end
    z.parent = y
    if y.nil_node?
      self.root = z
    else
      z.key < y.key ? y.left = z : y.right = z
    end
    self.size += 1
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
