# description : いもす法
class Imos(T)
  @builded = false

  def initialize(@size : Int32)
    @a = Array(T).new(@size + 1, T.zero)
  end

  def initialize(@size : Int32, init_val : T)
    @a = Array(T).new(@size + 1, init_val)
  end

  getter size : Int32

  def add(start : Int, count : Int, val : T)
    raise "self had been called `build`" if @builded
    raise ArgumentError.new "Negative count: #{count}" if count < 0
    start += size if start < 0
    if 0 <= start <= size
      count = Math.min(count, size - start)
      @a[start] += val
      @a[start + count] -= val
    end
    nil
  end

  def add(range : Range, val : T)
    start, count = Indexable.range_to_index_and_count(range, size) || raise IndexError.new
    add(start, count, val)
  end

  def build
    raise "self had been called `build`" if @builded
    @builded = true
    (1..size).each do |i|
      @a[i] += @a[i - 1]
    end
    @a[0, size]
  end
end
