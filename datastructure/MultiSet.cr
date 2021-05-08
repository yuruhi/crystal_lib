class MultiSet(T)
  include Iterable(T)
  include Enumerable(T)

  @count = Hash(T, Int32).new(0)
  getter kind_count = 0
  getter size = 0

  def add(object : T) : self
    @kind_count += 1 if @count[object] == 0
    @count[object] += 1
    @size += 1
    self
  end

  def <<(object : T)
    add object
  end

  def delete(object : T)
    (@count[object] > 0).tap do |flag|
      if flag
        @count[object] -= 1
        @kind_count -= 1 if @count[object] == 0
      end
    end
  end

  def concat(elems)
    elems.each { |elem| self << elem }
    self
  end

  def clear
    @count.clear
    @size = 0
    @kind_count = 0
  end

  def count(object : T)
    @count[object]
  end

  def includes?(object : T)
    @count[object] > 0
  end

  def empty?
    size == 0
  end

  class MultiSetIterator(T)
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

  def each : Nil
    @count.each do |(elem, cnt)|
      cnt.times { yield elem }
    end
  end
end
