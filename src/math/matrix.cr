class Matrix(T)
  include Indexable(Array(T))

  def Matrix.identity(size : Int32) : self
    result = Matrix(T).new(size, size, T.zero)
    (0...size).each do |i|
      result[i][i] = T.new(1)
    end
    result
  end

  macro [](*args)
    Matrix.new [{{args.splat}}]
  end

  getter height : Int32, width : Int32, data : Array(Array(T))

  def initialize
    @height = 0
    @width = 0
    @data = Array(Array(T)).new
  end

  def initialize(@height, @width, value : T)
    raise ArgumentError.new("Negative matrix height: #{@height}") unless @height >= 0
    raise ArgumentError.new("Negative matrix width: #{@width}") unless @width >= 0
    @data = Array.new(height) { Array(T).new(width, value) }
  end

  def initialize(@height, @width, &block : Int32, Int32 -> T)
    raise ArgumentError.new("Negative matrix height: #{@height}") unless @height >= 0
    raise ArgumentError.new("Negative matrix width: #{@width}") unless @width >= 0
    @data = Array.new(height) { |i| Array.new(width) { |j| yield i, j } }
  end

  def initialize(@data : Array(Array(T)))
    @height = @data.size
    @width = @data[0].size
    raise ArgumentError.new unless @data.all? { |a| a.size == width }
  end

  def size : Int32
    @data.size
  end

  def unsafe_fetch(index : Int) : Array(Int32)
    @data.unsafe_fetch(index)
  end

  private def check_index_out_of_bounds(i, j)
    check_index_out_of_bounds(i, j) { raise IndexError.new }
  end

  private def check_index_out_of_bounds(i, j)
    i += height if i < 0
    j += width if j < 0
    if 0 <= i < height && 0 <= j < width
      {i, j}
    else
      yield
    end
  end

  def fetch(i : Int, j : Int, &)
    i, j = check_index_out_of_bounds(i, j) { return yield i, j }
    unsafe_fetch(i, j)
  end

  def fetch(i : Int, j : Int, default)
    fetch(i, j) { default }
  end

  def [](i : Int, j : Int) : T
    fetch(i, j) { raise IndexError.new }
  end

  def []?(i : Int, j : Int) : T?
    fetch(i, j, nil)
  end

  def unsafe_fetch(i : Int, j : Int) : T
    @data.unsafe_fetch(i).unsafe_fetch(j)
  end

  def +(other : self) : self
    raise IndexError.new unless height == other.height && width == other.width
    Matrix(T).new(height, width) { |i, j|
      unsafe_fetch(i, j) + other.unsafe_fetch(i, j)
    }
  end

  def -(other : self) : self
    raise IndexError.new unless height == other.height && width == other.width
    Matrix(T).new(height, width) { |i, j|
      unsafe_fetch(i, j) - other.unsafe_fetch(i, j)
    }
  end

  def *(other : self) : self
    raise IndexError.new unless width == other.height
    Matrix(T).new(height, other.width) { |i, j|
      (0...width).sum { |k| unsafe_fetch(i, k) * other.unsafe_fetch(k, j) }
    }
  end

  def **(k : Int) : self
    result = Matrix(T).identity(height)
    memo = Matrix.new(data)
    while k > 0
      result *= memo if k.odd?
      memo *= memo
      k >>= 1
    end
    result
  end

  def ==(other : Matrix) : Bool
    return false unless height == other.height && width == other.width
    data == other.data
  end

  def to_s(io) : Nil
    io << data
  end

  def inspect(io) : Nil
    io << "Matrix" << data
  end
end
