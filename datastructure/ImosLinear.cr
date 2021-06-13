class ImosLinear(T)
  getter size : Int32
  @builded = false

  def initialize(@size : Int32)
    @a = Array(T).new(@size + 1, T.zero)
    @b = Array(T).new(@size + 1, T.zero)
  end

  # add `a + (i - l) * b` to [l, r)
  def add(start : Int, count : Int, val_a : T, val_b : T) : Nil
    raise "self had been called `#build`" if @builded
    raise ArgumentError.new "Negative count: #{count}" if count < 0
    @a[start] += val_a - val_b * start
    @b[start] += val_b
    @a[start + count] -= val_a - val_b * start
    @b[start] -= val_b
  end

  def add(range : Range, val_a : T, val_b : T)
    start, count = Indexable.range_to_index_and_count(range, size) || raise IndexError.new
    add(start, count, val_a, val_b)
  end

  def build : Array(T)
    raise "self had been called `#build`" if @builded
    @builded = true
    (0...size).map do |i|
      (@a[i] + @b[i] * i).tap { @a[i + 1] += @a[i]; @b[i + 1] += @b[i] }
    end
  end
end
