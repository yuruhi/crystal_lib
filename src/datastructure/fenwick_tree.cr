class FenwickTree(T)
  getter size : Int32

  def initialize(size : Int)
    @size = size.to_i
    @data = Array(T).new(@size + 1, T.zero)
  end

  def initialize(array : Array(T))
    @data = [T.zero] + array
    @size = array.size
    (1...size).each do |i|
      j = i + (i & -i)
      next if j > size
      @data[j] += @data[i]
    end
  end

  # Adds *x* to *index* th element.
  def add(index : Int, x) : Nil
    raise IndexError.new unless 0 <= index < size
    index += 1
    while index <= size
      @data[index] += x
      index += index & -index
    end
  end

  # Set *x* to *index* th element.
  def set(index : Int, x) : Nil
    add(index, x - self[index])
  end

  # :ditto:
  def []=(index : Int, x) : Nil
    set(index, x)
  end

  # Culculates sum of `a[0...i]`.
  def left_sum(i : Int) : T
    raise IndexError.new unless 0 <= i <= size
    sum = T.zero
    while i > 0
      sum += @data[i]
      i -= i & -i
    end
    sum
  end

  # Returns *index* th element.
  def [](index : Int)
    left_sum(index + 1) - left_sum(index)
  end

  # Returns sum of `a[start, count]`
  def [](start : Int, count : Int) : T
    left_sum(start + count) - left_sum(start)
  end

  # Returns sum of `a[range]`
  def [](range : Range) : T
    self[*Indexable.range_to_index_and_count(range, size) || raise IndexError.new]
  end

  # Returns the elements as an Array.
  def to_a : Array(T)
    Array.new(size) { |i| self[i] }
  end
end
