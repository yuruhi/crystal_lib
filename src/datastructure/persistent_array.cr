class PersistentArray(T)
  CHILD_SIZE = 32

  private struct Node(T)
    property value : T
    property child : Node(T)*[CHILD_SIZE]

    def initialize
      @value = T.zero
      @child = StaticArray(Node(T)*, CHILD_SIZE).new(Pointer(Node(T)).null)
    end
  end

  protected def self.set(i : Int, value : T, ptr : Node(T)*) : Node(T)*
    result = Pointer(Node(T)).malloc
    result.copy_from(ptr, 1) if ptr
    if i == 0
      result.value.value = value
    else
      index = i % CHILD_SIZE
      result.value.child[index] = set(i // CHILD_SIZE, value, result.value.child[index])
    end
    result
  end

  @root : Node(T)*

  protected def initialize(@root)
  end

  def initialize
    @root = Pointer(Node(T)).null
  end

  def initialize(array : Array(T))
    @root = Pointer(Node(T)).null
    array.each_with_index do |x, i|
      destractive_set(i, x)
    end
  end

  def [](i : Int) : T
    get(i)
  end

  def get(i : Int) : T
    ptr = @root
    loop do
      if ptr.null?
        return T.zero
      elsif i == 0
        return ptr.value.value
      else
        ptr = ptr.value.child[i % CHILD_SIZE]
        i //= CHILD_SIZE
      end
    end
  end

  def set(i : Int, val : T) : self
    PersistentArray(T).new self.class.set(i, val, @root)
  end

  def destractive_set(i : Int, val : T) : T
    ptr = pointerof(@root)
    loop do
      if ptr.value.null?
        ptr.value = Pointer(Node(T)).malloc
      end
      if i == 0
        ptr.value.value.value = val
        break
      else
        ptr = ptr.value.value.child.to_unsafe + (i % CHILD_SIZE)
        i //= CHILD_SIZE
      end
    end
    val
  end

  def to_a(size : Int) : Array(T)
    (0...size).map { |i| get(i) }
  end
end
