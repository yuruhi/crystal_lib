# description : ModInt

struct ModInt
  @@MOD = 1_000_000_007i64

  def self.mod
    @@MOD
  end

  def self.zero
    ModInt.new(0)
  end

  def initialize(n)
    @n = n.to_i64 % @@MOD
  end

  getter n : Int64

  def + : self
    self
  end

  def - : self
    ModInt.new(n != 0 ? @@MOD - @n : 0)
  end

  def +(m)
    ModInt.new(@n + m.to_i64 % @@MOD)
  end

  def -(m)
    ModInt.new(@n - m.to_i64 % @@MOD)
  end

  def *(m)
    ModInt.new(@n * m.to_i64 % @@MOD)
  end

  def /(m)
    raise DivisionByZeroError.new if m == 0
    a, b, u, v = m.to_i64, @@MOD, 1i64, 0i64
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

  def **(m : Int)
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

struct Int
  def to_mint : ModInt
    ModInt.new(self)
  end
end

class String
  def to_mint : ModInt
    ModInt.new(self)
  end
end
