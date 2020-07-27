# description : いもす法
class Imos(T)
  @flag = false

  def initialize(@size : Int32)
    @a = Array(T).new(@size + 1, T.zero)
  end

  def initialize(@size : Int32, init_val : T)
    @a = Array(T).new(@size + 1, init_val)
  end

  getter size : Int32

  def add(start : Int, count : Int, val : T)
    raise "self had been called `build`" if @flag
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
    add(*Indexable.range_to_index_and_count(range, size), val)
  end

  def build
    raise "self had been called `build`" if @flag
    @flag = true
    (1..size).each do |i|
      @a[i] += @a[i - 1]
    end
    @a[0, size]
  end
end
