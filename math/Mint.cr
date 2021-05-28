struct Mint
  MOD = 1_000_000_007i64

  def self.zero
    Mint.new
  end

  def self.raw(value : Int64)
    result = Mint.new
    result.value = value
    result
  end

  @value : Int64

  def initialize
    @value = 0i64
  end

  def initialize(value)
    @value = value.to_i64 % MOD
  end

  def initialize(m : Mint)
    @value = m.value
  end

  protected def value=(value : Int64)
    @value = value
  end

  getter value : Int64

  def + : Mint
    self
  end

  def - : Mint
    Mint.raw(value != 0 ? MOD - value : 0i64)
  end

  def +(v)
    self + v.to_m
  end

  def +(m : Mint)
    x = value + m.value
    x -= MOD if x >= MOD
    Mint.raw(x)
  end

  def -(v)
    self - v.to_m
  end

  def -(m : Mint)
    x = value - m.value
    x += MOD if x < 0
    Mint.raw(x)
  end

  def *(v)
    self * v.to_m
  end

  def *(m : Mint)
    Mint.new(value * m.value)
  end

  def /(v)
    self / v.to_m
  end

  def /(m : Mint)
    raise DivisionByZeroError.new if m.value == 0
    a, b, u, v = m.to_i64, MOD, 1i64, 0i64
    while b != 0
      t = a // b
      a -= t * b
      a, b = b, a
      u -= t * v
      u, v = v, u
    end
    Mint.new(value * u)
  end

  def //(v)
    self / v
  end

  def **(exponent : Int)
    t, res = self, Mint.raw(1i64)
    while exponent > 0
      res *= t if exponent.odd?
      t *= t
      exponent >>= 1
    end
    res
  end

  def ==(v)
    value == v
  end

  def ==(m : Mint)
    value == m.value
  end

  def succ
    Mint.raw(value != MOD - 1 ? value + 1 : 0i64)
  end

  def pred
    Mint.raw(value != 0 ? value - 1 : MOD - 1)
  end

  def abs
    self
  end

  def to_i64 : Int64
    value
  end

  delegate to_s, to: @value
  delegate inspect, to: @value
end

struct Int
  def to_m : Mint
    Mint.new(self)
  end
end

class String
  def to_m : Mint
    Mint.new(self)
  end
end
