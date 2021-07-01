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
    expand_until(intiial_capacity)
  end

  private def expand_until(n : Int)
    while @size <= n
      @factorial << @factorial[-1] * @size
      @inv << -@inv[T::MOD % @size] * (T::MOD // @size)
      @finv << @finv[-1] * @inv[@size]
      @size += 1
    end
  end

  def factorial(n : Int)
    expand_until(n)
    @factorial[n]
  end

  def inv(n : Int)
    expand_until(n)
    @inv[n]
  end

  def finv(n : Int)
    expand_until(n)
    @finv[n]
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
end
