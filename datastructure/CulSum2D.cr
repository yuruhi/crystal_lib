class CulSum2D(T)
  getter height : Int32
  getter width : Int32

  def initialize(a : Array(Array(T)))
    @height = a.size
    raise ArgumentError.new unless height > 0
    @width = a[0].size
    raise ArgumentError.new unless a.all? { |b| b.size == width }

    @sum = Array(Array(T)).new(height + 1) { |i|
      i == 0 ? Array.new(width + 1, T.zero) : [T.zero] + a[i - 1]
    }
    height.times do |i|
      width.succ.times do |j|
        @sum[i + 1][j] += @sum[i][j]
      end
    end
    height.succ.times do |i|
      width.times do |j|
        @sum[i][j + 1] += @sum[i][j]
      end
    end
  end

  def initialize(@height : Int32, @width : Int32, &block : Int32, Int32 -> T)
    raise ArgumentError.new unless height > 0
    raise ArgumentError.new unless width > 0
    @sum = Array(Array(T)).new(height + 1) { Array.new(width + 1, T.zero) }
    height.times do |i|
      width.times do |j|
        @sum[i + 1][j + 1] = yield(i, j)
      end
    end
    height.times do |i|
      width.succ.times do |j|
        @sum[i + 1][j] += @sum[i][j]
      end
    end
    height.succ.times do |i|
      width.times do |j|
        @sum[i][j + 1] += @sum[i][j]
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

      @sum[y_start + y_count][x_start + x_count] - @sum[y_start + y_count][x_start] -
        @sum[y_start][x_start + x_count] + @sum[y_start][x_start]
    end
  end

  def []?(y_range : Range, x_range : Range)
    ys, yc = Indexable.range_to_index_and_count(y_range, height) || return nil
    xs, xc = Indexable.range_to_index_and_count(x_range, width) || return nil
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
