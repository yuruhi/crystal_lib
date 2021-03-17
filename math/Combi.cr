# description : calculate combination
class Comb(T)
  def initialize(@Max = 400009)
    @factorial = Array(T).new(@Max, T.zero)
    @finv = Array(T).new(@Max, T.zero)
    @inv = Array(T).new(@Max, T.zero)
    @factorial[0] = @factorial[1] = T.new(1)
    @finv[0] = @finv[1] = T.new(1)
    @inv[1] = T.new(1)
    (2...@Max).each do |i|
      @factorial[i] = @factorial[i - 1] * i
      @inv[i] = -@inv[T.mod % i] * (T.mod // i)
      @finv[i] = @finv[i - 1] * @inv[i]
    end
  end

  def permutation(n, r)
    (n < r || n < 0 || r < 0) ? T.zero : @factorial[n] * @finv[n - r]
  end

  def combination(n, r)
    (n < r || n < 0 || r < 0) ? T.zero : @factorial[n] * @finv[r] * @finv[n - r]
  end

  def homogeneous_product(n, r)
    (n < 0 || r < 0) ? T.zero : r == T.zero ? T.new(1) : combination(n + r - 1, r)
  end

  def factorial(n)
    @factorial[n]
  end
end
