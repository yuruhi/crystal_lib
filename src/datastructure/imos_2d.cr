class Imos2D(T)
  getter height : Int32, width : Int32
  @builded = false

  def initialize(@height, @width, init_val : T = T.zero)
    @table = Array(Array(T)).new(@height + 1) do
      Array(T).new(@width + 1, init_val)
    end
  end

  def add(ys : Int, yc : Int, xs : Int, xc : Int, val : T) : Nil
    raise "self had been called `build`" if @builded
    raise ArgumentError.new "Negative count: #{yc}" if yc < 0
    raise ArgumentError.new "Negative count: #{xc}" if xc < 0
    @table[ys + yc][xs + xc] += val
    @table[ys + yc][xs] -= val
    @table[ys][xs + xc] -= val
    @table[ys][xs] += val
  end

  def add(y : Range, x : Range, val : T)
    ys, yc = Indexable.range_to_index_and_count(y, height) || raise IndexError.new
    xs, xc = Indexable.range_to_index_and_count(x, width) || raise IndexError.new
    add(ys, yc, xs, xc, val)
  end

  def build : Array(Array(T))
    raise "self had been called `#build`" if @builded
    @builded = true
    (0..height).each do |y|
      (1..width).each do |x|
        @table[y][x] += @table[y][x - 1]
      end
    end
    (1..height).each do |y|
      (0..width).each do |x|
        @table[y][x] += @table[y - 1][x]
      end
    end
    (0...height).map { |i| @table[i][0...width] }
  end

  def [](y : Int32, x : Int32) : T
    raise "self had not been called `#build`" unless @builded
    @table[y][x]
  end
end
