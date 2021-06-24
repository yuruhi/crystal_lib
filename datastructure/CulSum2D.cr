class CulSum2D(T)
  getter height : Int32
  getter width : Int32

  def initialize(a : Array(Array(T)))
    @height = a.size
    raise ArgumentError.new unless height > 0
    @width = a[0].size
    raise ArgumentError.new unless a.map(&.size).all?(width)

    @s = Array(Array(T)).new(height + 1) { Array.new(width + 1, T.zero) }
    (0...height).each do |i|
      (0...width).each do |j|
        @s[i + 1][j + 1] = @s[i][j + 1] + @s[i + 1][j] - @s[i][j] + a[i][j]
      end
    end
  end

  def initialize(@height : Int32, @width : Int32, &f : Int32, Int32 -> T)
    raise ArgumentError.new unless height > 0
    raise ArgumentError.new unless width > 0
    @s = Array(Array(T)).new(height + 1) { Array.new(width + 1, T.zero) }
    (0...height).each do |i|
      (0...width).each do |j|
        @s[i + 1][j + 1] = @s[i][j + 1] + @s[i + 1][j] - @s[i][j] + yield(i, j)
      end
    end
  end

  def [](y_start, y_count, x_start, x_count)
    @s[y_start + y_count][x_start + x_count] - @s[y_start + y_count][x_start] -
      @s[y_start][x_start + x_count] + @s[y_start][x_start]
  end

  def [](y_range : Range, x_range : Range)
    ys, yc = Indexable.range_to_index_and_count(y_range, height) || raise IndexError.new
    xs, xc = Indexable.range_to_index_and_count(x_range, width) || raise IndexError.new
    self[ys, yc, xs, xc]
  end

  def to_a
    (0...@n).map { |i| self[i..i] }
  end
end