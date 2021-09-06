class BinaryHeap(T)
  def initialize
    initialize { |a, b| a < b }
  end

  def initialize(&block : T, T -> Bool)
    @heap = Array(T).new
    @compare = block
  end

  include Enumerable(T)

  delegate size, to: @heap
  delegate empty?, to: @heap
  def_clone

  def ==(other : BinaryHeap(T))
    @heap.sort == other.@heap.sort
  end

  private def compare(index1 : Int32, index2 : Int32)
    @compare.call(@heap[index1], @heap[index2])
  end

  # Removes all elements from the heap and returns `self`.
  def clear : self
    @heap.clear
    self
  end

	# Returns the greatest value in the `self`.
	# If the `self` is empty, calls the block and returns its value.
  def top(&block)
    @heap.first { yield }
  end

	# Returns the greatest value in the `self`.
	# If the `self` is empty, returns `nil`.
  def top? : T?
    top { nil }
  end

	# Returns the greatest value in the `self`.
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

  # Removes the greatest value from `self` and returns the removed value.
  # If the array is empty, the given block is called.
  def pop(&block)
    case size
    when 0
      yield
    when 1
      @heap.pop
    else
      result = @heap.unsafe_fetch(0)
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
      result
    end
  end

  # Like `#pop`, but returns `nil` if `self` is empty.
  def pop? : T?
    pop { nil }
  end

  # Removes the greatest value from `self` and returns the removed value.
  # Raises `IndexError` if heap is of 0 size.
  def pop : T
    pop { raise IndexError.new }
  end

  def pop(n : Int) : Array(T)
    raise ArgumentError.new unless n >= 0
    n = Math.min(n, size)
    Array.new(n) { |i| pop }
  end

  def each(&block)
    heap = clone
    while v = heap.pop?
      yield v
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
