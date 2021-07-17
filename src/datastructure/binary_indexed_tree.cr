class BinaryIndexedTree(T)
  getter size : Int32

  def initialize(@size)
    @a = Array(T).new(@size + 1, T.zero)
  end

  def initialize(a : Array(T))
    @a = [T.zero]
    @a.concat a
    @size = a.size
    (1...size).each do |i|
      j = i + (i & -i)
      next if j > size
      @a[j] += @a[i]
    end
  end

  # Add *x* to `a[i]`.
  def add(i : Int32, x) : Nil
    raise IndexError.new unless 0 <= i < size
    i += 1
    while i <= size
      @a[i] += x
      i += i & -i
    end
  end

  # Culculates sum of `a[0...i]`.
  def left_sum(i : Int32) : T
    raise IndexError.new unless 0 <= i <= size
    sum = T.zero
    while i > 0
      sum += @a[i]
      i -= i & -i
    end
    sum
  end

  def [](start : Int32, count : Int32) : T
    left_sum(start + count) - left_sum(start)
  end

  def [](range : Range) : T
    self[*Indexable.range_to_index_and_count(range, size) || raise IndexError.new]
  end

  def to_a : Array(T)
    (0...size).map { |i| self[i..i] }
  end
end
