class CulSum2D(T)
  getter height : Int32
  getter width : Int32

  def initialize(a : Array(Array(T)))
    @height = a.size
    raise ArgumentError.new unless height > 0
    @width = a[0].size
    raise ArgumentError.new unless a.all? { |b| b.size == width }

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

  def []?(y_start : Int, y_count : Int, x_start : Int, x_count : Int)
    raise ArgumentError.new "Negative y_count: #{y_count}" unless y_count >= 0
    raise ArgumentError.new "Negative x_count: #{x_count}" unless x_count >= 0
    y_start += height if y_start < 0
    x_start += width if x_start < 0

    if 0 <= y_start <= height && 0 <= x_start <= width
      y_count = Math.min(y_count, height - y_start)
      x_count = Math.min(x_count, width - x_start)

      @s[y_start + y_count][x_start + x_count] - @s[y_start + y_count][x_start] -
        @s[y_start][x_start + x_count] + @s[y_start][x_start]
    end
  end

  def []?(y_range : Range, x_range : Range)
    ys, yc = Indexable.range_to_index_and_count(y_range, height) || raise IndexError.new
    xs, xc = Indexable.range_to_index_and_count(x_range, width) || raise IndexError.new
    self[ys, yc, xs, xc]?
  end

  def [](ys : Int, yc : Int, xs : Int, xc : Int)
    self[ys, yc, xs, xc]? || raise IndexError.new
  end

  def [](y_range : Range, x_range : Range)
    self[y_range, x_range]? || raise IndexError.new
  end

  def to_a
    Array.new(height) do |i|
      Array.new(width) do |j|
        self[i, 1, j, 1]
      end
    end
  end
end
