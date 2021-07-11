class Imos(T)
  getter size : Int32
  @builded = false

  def initialize(@size : Int32)
    @a = Array(T).new(@size + 1, T.zero)
  end

  def add(start : Int, count : Int, val : T) : Nil
    raise "self had been called `#build`" if @builded
    raise ArgumentError.new "Negative count: #{count}" if count < 0
    start += size if start < 0
    if 0 <= start <= size
      count = Math.min(count, size - start)
      @a[start] += val
      @a[start + count] -= val
    end
  end

  def add(range : Range, val : T)
    start, count = Indexable.range_to_index_and_count(range, size) || raise IndexError.new
    add(start, count, val)
  end

  def build : Array(T)
    raise "self had been called `#build`" if @builded
    @builded = true
    (0...size).map do |i|
      @a[i].tap { |x| @a[i + 1] += x }
    end
  end
end
