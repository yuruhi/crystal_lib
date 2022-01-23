class Combination(T)
  def initialize(initial_capacity : Int = 2)
    initial_capacity += 1
    @size = 2
    @factorial = Array(T).new(initial_capacity)
    @factorial << T.new(1) << T.new(1)
    @inv = Array(T).new(initial_capacity)
    @inv << T.zero << T.new(1)
    @finv = Array(T).new(initial_capacity)
    @finv << T.new(1) << T.new(1)
    expand_until(initial_capacity)
  end

  private def expand_until(n : Int)
    while @size <= n
      @factorial << @factorial[-1] * @size
      @inv << -@inv[T.mod % @size] * (T.mod // @size)
      @finv << @finv[-1] * @inv[@size]
      @size += 1
    end
  end

  def factorial(n : Int)
    raise IndexError.new if n < 0
    expand_until(n)
    @factorial.unsafe_fetch(n)
  end

  def inv(n : Int)
    raise DivisionByZeroError.new if n == 0
    raise IndexError.new if n < 0
    expand_until(n)
    @inv.unsafe_fetch(n)
  end

  def finv(n : Int)
    raise IndexError.new if n < 0
    expand_until(n)
    @finv.unsafe_fetch(n)
  end

  def permutation(n : Int, r : Int)
    (n < r || n < 0 || r < 0) ? T.zero : factorial(n) * finv(n - r)
  end

  def combination(n : Int, r : Int)
    (n < r || n < 0 || r < 0) ? T.zero : factorial(n) * finv(r) * finv(n - r)
  end

  def repeated_combination(n : Int, r : Int)
    (n < 0 || r < 0) ? T.zero : r == 0 ? T.new(1) : combination(n + r - 1, r)
  end

  def self.table(n : Int)
    table = Array.new(n + 1) { Array.new(n + 1, T.zero) }
    (0..n).each do |i|
      table[i][0] = table[i][i] = 1
    end
    (1..n).each do |i|
      (1...i).each do |j|
        table[i][j] = table[i - 1][j - 1] + table[i - 1][j]
      end
    end
    table
  end
end
