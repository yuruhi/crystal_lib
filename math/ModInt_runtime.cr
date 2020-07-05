# description : 実行時に法が決まるModInt
struct ModInt
  @@mod : Int64 = 1_000_000_007i64

  def initialize(n)
    @n = n.to_i64 % @@mod
  end

  def self.zero
    ModInt.new(0)
  end

  def self.mod=(m)
    @@mod = m.to_i64
  end

  getter n : Int64

  def + : self
    self
  end

  def - : self
    ModInt.new(n != 0 ? @@mod - @n : 0)
  end

  def +(m)
    ModInt.new(@n + m.to_i64 % @@mod)
  end

  def -(m)
    ModInt.new(@n - m.to_i64 % @@mod)
  end

  def *(m)
    ModInt.new(@n * m.to_i64 % @@mod)
  end

  def /(m)
    raise DivisionByZeroError.new if m == 0
    a, b, u, v = m.to_i64, @@mod, 1i64, 0i64
    while b != 0
      t = a // b
      a -= t * b
      a, b = b, a
      u -= t * v
      u, v = v, u
    end
    ModInt.new(@n * u)
  end

  def //(m)
    self / m
  end

  def **(m)
    t, res = self, ModInt.new(1)
    while m > 0
      res *= t if m.odd?
      t *= t
      m >>= 1
    end
    res
  end

  def ==(m)
    @n == m.to_i64
  end

  def !=(m)
    @n != m.to_i64
  end

  def succ
    self + 1
  end

  def pred
    self - 1
  end

  def to_i64 : Int64
    @n
  end

  delegate to_s, to: @n
  delegate inspect, to: @n
end
