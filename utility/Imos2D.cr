class Imos2D(T)
  @builded = false

  getter height : Int32
  getter width : Int32

  def initialize(@height, @width)
    @table = Array(Array(T)).new(@height + 1) {
      Array(T).new(@width + 1, T.zero)
    }
  end

  def initialize(@height, @width, init_val : T)
    @table = Array(Array(T)).new(@height + 1) {
      Array(T).new(@width + 1, T.zero)
    }
  end

  def add(ys : Int32, yc : Int32, xs : Int32, xc : Int32, val : T)
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
    raise "self had been called `build`" if @builded
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
    raise IndexError.new unless 0 <= y < height
    raise IndexError.new unless 0 <= x < width
    @table[y][x]
  end
end
