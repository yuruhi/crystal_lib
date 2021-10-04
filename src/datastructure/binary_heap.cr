class BinaryHeap(T)
  def initialize
    @heap = Array(T).new
    @compare_proc = nil
  end

  def initialize(initial_capacity : Int = 0)
    @heap = Array(T).new(initial_capacity)
    @compare_proc = nil
  end

  def initialize(enumerable : Enumerable(T))
    initialize
    enumerable.each { |x| add(x) }
  end

  def initialize(&block : T, T -> Int32?)
    @heap = Array(T).new
    @compare_proc = block
  end

  def initialize(initial_capacity : Int = 0, &block : T, T -> Int32?)
    @heap = Array(T).new(initial_capacity)
    @compare_proc = block
  end

  def initialize(enumerable : Enumerable(T), &block : T, T -> Int32?)
    initialize &block
    enumerable.each { |x| add(x) }
  end

  include Enumerable(T)

  delegate size, to: @heap
  delegate empty?, to: @heap
  def_clone

  def ==(other : BinaryHeap(T))
    @heap.sort == other.@heap.sort
  end

  private def compare(i : Int32, j : Int32)
    if @compare_proc
      v = @compare_proc.not_nil!.call(@heap[i], @heap[j])
      raise ArgumentError.new("Comparison of #{@heap[i]} and #{@heap[j]} failed") if v.nil?
      v > 0
    else
      @heap[i] > @heap[j]
    end
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

  # Alias for `#add`.
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

  def each(&block) : Nil
    if @compare_proc
      @heap.sort { |a, b| @compare_proc.not_nil!.call(a, b) }.each { |x| yield x }
    else
      @heap.sort.each { |x| yield x }
    end
  end

  def to_a : Array(T)
    if @compare_proc
      @heap.sort { |a, b| @compare_proc.not_nil!.call(a, b) }
    else
      @heap.sort
    end
  end

  def to_s(io : IO) : Nil
    io << "BinaryHeap{"
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
