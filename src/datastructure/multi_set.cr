class MultiSet(T)
  include Iterable(T)
  include Enumerable(T)

  @count = Hash(T, Int32).new(0)
  @size = 0

  def initialize
  end

  def initialize(enumerable : Enumerable(T))
    concat enumerable
  end

  # Returns the number of elements in the set.
  def size : Int32
    @size
  end

  # Returns the number of kinds in the multiset.
  def kind_count : Int32
    @count.size
  end

  # Returns `true` if the multiset is empty.
  def empty? : Bool
    size == 0
  end

  # Returns `true` if *object* exists in the multiset.
  def includes?(object : T) : Bool
    @count[object] > 0
  end

  # Same as `includes?`
  def ===(object : T) : Bool
    includes?(object)
  end

  # Returns the number of times that the *object* is present in the multiset.
  def count(object : T)
    @count[object]
  end

  # Adds *object* to the multiset and returns self.
  def add(object : T) : self
    @count[object] += 1
    @size += 1
    self
  end

  # Adds *object* to the multiset *count* times and returns self.
  def add(object : T, count : Int32) : self
    raise ArgumentError.new unless count >= 0
    @count[object] += count
    @size += count
    self
  end

  # Alias for `add`.
  def <<(object : T) : self
    add object
  end

  # Removes the *object* from the multiset and returns `true` if it was present, otherwise returns `false`.
  def delete(object : T) : Bool
    if flag = @count[object] > 0
      @count[object] -= 1
      @count.delete(object) if @count[object] == 0
    end
    flag
  end

  # Removes the *object* from the multiset at most *count* times and returns `true` if it was present, otherwise returns `false`.
  def delete(object : T, count : Int32) : Bool
    raise ArgumentError.new unless count >= 0
    if flag = @count[object] > 0
      @count[object] = {0, @count[object] - count}.max
      @count.delete(object) if @count[object] == 0
    end
    flag
  end

  # Adds `each` element of *elems* to the multisetset and returns self.
  def concat(elems) : self
    elems.each { |elem| self << elem }
    self
  end

  # Removes all elements in the multiset and returns `self`.
  def clear
    @count.clear
    @size = 0
    self
  end

  private class MultiSetIterator(T)
    include Iterator(T)
    include IteratorWrapper

    @iterator : Iterator({T, Int32})
    @value : Tuple(T?, Int32)

    def initialize(count : Hash(T, Int32))
      @iterator = count.each
      @value = {nil, 0}
    end

    def next
      until @value[1] > 0
        @value = wrapped_next
      end
      @value = {@value[0], @value[1] - 1}
      @value[0].not_nil!
    end
  end

  # Returns an iterator for each element of the multiset.
  def each
    MultiSetIterator(T).new(@count)
  end

  # Yields each element of the multiset, and returns `nil`.
  def each(&) : Nil
    @count.each do |(elem, cnt)|
      cnt.times { yield elem }
    end
  end

  # Returns `true` if the multiset and the given multiset have at least one element in common.
  def intersects?(other : self)
    if kind_count < other.kind_count
      any? { |o| other.includes?(o) }
    else
      other.any? { |o| includes?(o) }
    end
  end

  # Returns `true` if the multiset is a subset of the given multiset.
  def subset_of?(other : self)
    return false if other.size < size
    all? { |o| other.includes?(o) }
  end

  # Returns true if the multiset is a superset of the given multiset.
  def superset_of?(other : self)
    other.subset_of?(self)
  end

  # Returns an iterator for each tuple of element and count of the multiset
  def each_count
    @count.each
  end

  # Yields each pair of element and count of the multiset, and returns `nil`.
  def each_count(&) : Nil
    @count.each do |(elem, cnt)|
      yield(elem, cnt)
    end
  end

  # Intersection
  def &(other : MultiSet(T)) : self
    small, large = self, other
    if large.kind_count < small.kind_count
      small, large = large, small
    end

    result = MultiSet(T).new
    small.each_count do |elem, cnt|
      result.add elem, Math.min(cnt, large.count(elem))
    end
    result
  end

  # Union
  def |(other : MultiSet(U)) forall U
    result = MultiSet(T | U).new
    each_count { |elem, cnt| result.add elem, cnt }
    other.each_count { |elem, cnt| result.add elem, cnt }
    result
  end

  # Addition
  def +(other : MultiSet(U)) forall U
    self | other
  end

  # Writes a string representation of the multiset to *io*.
  #
  # ```
  # set = MultiSet{3, 1, 4, 1, 5}
  # set.to_s # => "MultiSet{3, 1, 1, 4, 5}"
  # ```
  def to_s(io : IO)
    io << "MultiSet{"
    each.join(", ", io)
    io << '}'
  end

  # Writes a string representation of the multiset to *io*.
  #
  # ```
  # set = MultiSet{3, 1, 4, 1, 5}
  # set.to_s # => "{3(1), 1(2), 4(1), 5(1)}"
  # ```
  def inspect(io : IO)
    io << '{'
    each_count.join(", ", io) do |(elem, count), io|
      io << elem << '(' << count << ')'
    end
    io << '}'
  end
end
