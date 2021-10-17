class BinaryHeap(T)
  # Creates a new empty heap.
  def initialize
    @heap = Array(T).new
    @compare_proc = nil
  end

  # Creates a new empty heap backed by a buffer that is initially *initial_capacity* big (default: `0`).
  #
  # ```
  # a = BinaryHeap.new(3)
  # a << 3 << 1 << 2
  # a.pop # => 1
  # a.pop # => 2
  # a.pop # => 3
  # ```
  def initialize(initial_capacity : Int = 0)
    @heap = Array(T).new(initial_capacity)
    @compare_proc = nil
  end

  # Creates a new heap from the elements in *enumerable*.
  #
  # ```
  # a = BinaryHeap.new [3, 1, 2]
  # a.pop # => 1
  # a.pop # => 2
  # a.pop # => 3
  # ```
  def initialize(enumerable : Enumerable(T))
    initialize
    enumerable.each { |x| add(x) }
  end

  # Creates a new empty heap with the custom comperator.
  #
  # The block must implement a comparison between two elements *a* and *b*, where `a < b` returns `-1`,
  # `a == b` returns `0`, and `a > b` returns `1`. The comparison operator `#<=>` can be used for this.
  #
  # ```
  # a = BinaryHeap.new [3, 1, 2]
  # a.pop # => 1
  # b = BinaryHeap.new [3, 1, 2] { |a, b| b <=> a }
  # b.pop # => 3
  # ```
  def initialize(initial_capacity : Int = 0, &block : T, T -> Int32?)
    @heap = Array(T).new(initial_capacity)
    @compare_proc = block
  end

  # :ditto:
  def initialize(enumerable : Enumerable(T), &block : T, T -> Int32?)
    initialize &block
    enumerable.each { |x| add(x) }
  end

  include Enumerable(T)
  include Iterable(T)

  def_clone

  # Returns true if both heap have the same elements.
  def ==(other : BinaryHeap(T)) : Bool
    return false if size != other.size
    @heap.sort == other.@heap.sort
  end

  # Returns the number of elements in the heap.
  def size : Int32
    @heap.size
  end

  # Returns `true` if `self` is empty, `false` otherwise.
  def empty? : Bool
    @heap.empty?
  end

  # Removes all elements from the heap and returns `self`.
  def clear : self
    @heap.clear
    self
  end

  # Returns the lowest value in the `self`.
  # If the `self` is empty, calls the block and returns its value.
  def top(&block)
    @heap.first { yield }
  end

  # Returns the lowest value in the `self`.
  # If the `self` is empty, returns `nil`.
  def top? : T?
    top { nil }
  end

  # Returns the lowest value in the `self`.
  # If the `self` is empty, raises `IndexError`.
  def top : T
    top { raise IndexError.new }
  end

  # Requires `0 <= i < size`, `0 <= j < size`.
  private def compare(i : Int32, j : Int32)
    x, y = @heap.unsafe_fetch(i), @heap.unsafe_fetch(j)
    if @compare_proc
      v = @compare_proc.not_nil!.call(x, y)
      raise ArgumentError.new("Comparison of #{x} and #{y} failed") if v.nil?
      v > 0
    else
      x > y
    end
  end

  # Adds *object* to the heap and returns `self`.
  def add(object : T) : self
    @heap << object
    i = size - 1
    parent = i.pred // 2
    while i > 0 && compare(parent, i)
      @heap.swap(parent, i)
      i, parent = parent, parent.pred // 2
    end
    self
  end

  # :ditto:
  def <<(object : T) : self
    add(object)
  end

  # Removes the lowest value from `self` and returns the removed value.
  # If the array is empty, the given block is called.
  def pop(&block)
    case size
    when 0
      yield
    when 1
      @heap.pop
    else
      value = @heap.unsafe_fetch(0)
      @heap[0] = @heap.pop
      i = 0
      loop do
        left, right = i * 2 + 1, i * 2 + 2
        j = if right < size && compare(i, right)
              compare(left, right) ? right : left
            elsif left < size && compare(i, left)
              left
            else
              break
            end
        @heap.swap(i, j)
        i = j
      end
      value
    end
  end

  # Like `#pop`, but returns `nil` if `self` is empty.
  def pop? : T?
    pop { nil }
  end

  # Removes the lowest value from `self` and returns the removed value.
  # Raises `IndexError` if heap is of 0 size.
  def pop : T
    pop { raise IndexError.new }
  end

  # Removes the last *n* values from `self` ahd returns the removed values.
  def pop(n : Int) : Array(T)
    raise ArgumentError.new unless n >= 0
    n = Math.min(n, size)
    Array.new(n) { pop }
  end

  # Yields each element of the heap, and returns `nil`.
  def each(&) : Nil
    @heap.each { |elem| yield elem }
  end

  # Returns an iterator for each element of the heap.
  def each
    @heap.each
  end

  # Returns a new array with all elements sorted.
  #
  # ```
  # a = BinaryHeap.new [3, 1, 2]
  # a.sort # => [1, 2, 3]
  # b = BinaryHeap.new [3, 1, 2] { |a, b| b <=> a }
  # b.sort # => [3, 2, 1]
  # ```
  def sort : Array(T)
    if @compare_proc
      @heap.sort { |a, b| @compare_proc.not_nil!.call(a, b) }
    else
      @heap.sort
    end
  end

  # Returns the elements as an Array.
  #
  # ```
  # BinaryHeap{3, 1, 2}.to_a # => [1, 3, 2]
  # ```
  def to_a : Array(T)
    @heap.dup
  end

  # Writes a string representation of the heap to `io`.
  #
  # ```
  # BinaryHeap{1, 2}.to_s # => "BinaryHeap{1, 2}"
  # ```
  def to_s(io : IO) : Nil
    io << "BinaryHeap{"
    # TODO: use join
    each_with_index do |x, i|
      io << ", " if i > 0
      io << x
    end
    io << '}'
  end

  # Writes a string representation of the heap to `io`.
  #
  # ```
  # BinaryHeap{1, 2}.inspect # => "BinaryHeap{1, 2}"
  # ```
  def inspect(io : IO) : Nil
    to_s(io)
  end
end
