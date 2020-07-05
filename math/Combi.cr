# description : calculate combination
class Comb(T)
  def initialize(@Max = 300009)
    @fac = Array(T).new(@Max, T.zero)
    @finv = Array(T).new(@Max, T.zero)
    @inv = Array(T).new(@Max, T.zero)
    @fac[0] = @fac[1] = T.new(1)
    @finv[0] = @finv[1] = T.new(1)
    @inv[1] = T.new(1)
    (2...@Max).each do |i|
      @fac[i] = @fac[i - 1] * i
      @inv[i] = -@inv[T.mod % i] * (T.mod / i)
      @finv[i] = @finv[i - 1] * @inv[i]
    end
  end

  def p(n, r)
    (n < r || n < 0 || r < 0) ? 0 : @fac[n] * @finv[n - r]
  end

  def c(n, r)
    (n < r || n < 0 || r < 0) ? 0 : @fac[n] * @finv[r] * @finv[n - r]
  end

  def h(n, r)
    (n < 0 || r < 0) ? 0 : r == 0 ? 1 : c(n + r - 1, r)
  end

  def fact(n)
    @fac[n]
  end
end