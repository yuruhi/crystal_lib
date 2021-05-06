class Matrix(T)
  include Indexable(Array(T))

  getter height : Int32
  getter width : Int32
  getter data : Array(Array(T))

  def Matrix.identity(size : Int32)
    result = Matrix(T).new(size, size)
    (0...size).each do |i|
      result[i][i] = T.new(1)
    end
    result
  end

  def initialize(@height, @width, init_value = T.zero)
    @data = Array(Array(T)).new(height) { Array(T).new(width, init_value) }
  end

  def initialize(init_matrix : Array(Array(T)))
    @height = init_matrix.size
    @width = init_matrix[0].size
    raise ArgumentError.new unless init_matrix.all? { |a| a.size == width }
    @data = init_matrix
  end

  def size
    data.size
  end

  def unsafe_fetch(index : Int)
    data.unsafe_fetch(index)
  end

  def +(other : self)
    IndexError.new unless height == other.height && width == other.width
    result = Matrix(T).new(height, width)
    (0...height).each do |i|
      (0...width).each do |j|
        result[i][j] = data[i][j] + other[i][j]
      end
    end
    result
  end

  def -(other : self)
    IndexError.new unless height == other.height && width == other.width
    result = Matrix(T).new(height, width)
    (0...height).each do |i|
      (0...width).each do |j|
        result[i][j] = data[i][j] - other[i][j]
      end
    end
    result
  end

  def *(other : self)
    IndexError.new unless width == other.height
    result = Matrix(T).new(height, other.width)
    (0...height).each do |i|
      (0...other.width).each do |j|
        (0...width).each do |k|
          result[i][j] += data[i][k] * other[k][j]
        end
      end
    end
    result
  end

  def **(k : Int)
    result = Matrix(T).identity(height)
    memo = Matrix.new(data)
    while k > 0
      result *= memo if k.odd?
      memo *= memo
      k >>= 1
    end
    result
  end

  def to_s(io)
    io << data
  end
end
