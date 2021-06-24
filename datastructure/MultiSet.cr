class MultiSet(T)
  include Iterable(T)
  include Enumerable(T)

  @count = Hash(T, Int32).new(0)
  getter size = 0

  def initialize
  end

  def initialize(enumerable : Enumerable(T))
    concat enumerable
  end

  def kind_count
    @count.size
  end

  def add(object : T)
    @count[object] += 1
    @size += 1
    self
  end

  def add(object : T, count : Int32)
    raise ArgumentError.new unless count >= 0
    return self if count == 0
    @count[object] += count
    @size += count
    self
  end

  def <<(object : T)
    add object
  end

  def delete(object : T)
    if flag = @count[object] > 0
      @count[object] -= 1
      @count.delete(object) if @count[object] == 0
    end
    flag
  end

  def delete(object : T, count : Int32)
    raise ArgumentError.new unless count >= 0
    if flag = @count[object] > 0
      @count[object] = {0, @count[object] - count}.max
      @count.delete(object) if @count[object] == 0
    end
  end

  def concat(elems)
    elems.each { |elem| self << elem }
    self
  end

  def clear
    @count.clear
    @size = 0
  end

  def count(object : T)
    @count[object]
  end

  def empty?
    size == 0
  end

  def includes?(object : T)
    @count[object] > 0
  end

  def intersects?(other : MultiSet(T))
    if kind_count < other.kind_count
      any? { |o| other.includes?(o) }
    else
      other.any? { |o| includes?(o) }
    end
  end

  def subset_of?(other : MultiSet(T))
    return false if other.size < size
    all? { |o| other.includes?(o) }
  end

  def superset_of?(other : MultiSet(T))
    other.subset_of?(self)
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

  def each
    MultiSetIterator(T).new(@count)
  end

  def each(&) : Nil
    @count.each do |(elem, cnt)|
      cnt.times { yield elem }
    end
  end

  def each_count
    @count.each
  end

  def each_count(&) : Nil
    @count.each do |(elem, cnt)|
      yield({elem, cnt})
    end
  end

  def &(other : MultiSet(T))
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

  def |(other : MultiSet(U)) forall U
    result = MultiSet(T | U).new
    each_count { |(elem, cnt)| result.add elem, cnt }
    other.each_count { |(elem, cnt)| result.add elem, cnt }
    result
  end

  def +(other : MultiSet(U)) forall U
    self | other
  end

  def to_s(io : IO)
    io << @count
  end

  def inspect(io : IO)
    io << '['
    each.join(", ", io)
    io << ']'
  end
end
