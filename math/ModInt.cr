# description : ModInt

struct Mint
  @@MOD = 1_000_000_007i64

  def self.mod
    @@MOD
  end

  def self.zero
    Mint.new
  end

  @value : Int64

  def initialize
    @value = 0i64
  end

  def initialize(value)
    @value = value.to_i64 % @@MOD
  end

  def initialize(m : Mint)
    @value = m.value
  end

  protected def value=(value : Int64)
    @value = value
  end

  getter value : Int64

  def + : self
    self
  end

  def - : self
    Mint.new(value != 0 ? @@MOD - @value : 0)
  end

  def +(m)
    Mint.new(@value + m.to_i64 % @@MOD)
  end

  def +(m : Mint)
    result = Mint.new
    result.value = @value + m.value
    result.value -= @@MOD if result.value > @@MOD
    result
  end

  def -(m)
    Mint.new(@value - m.to_i64 % @@MOD)
  end

  def -(m : Mint)
    result = Mint.new
    result.value = @value - m.value
    result.value += @@MOD if result.value < 0
    result
  end

  def *(m)
    Mint.new(@value * m.to_i64)
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
    Mint.new(@value * u)
  end

  def //(m)
    self / m
  end

  def **(m : Int)
    t, res = self, Mint.new(1)
    while m > 0
      res *= t if m.odd?
      t *= t
      m >>= 1
    end
    res
  end

  def ==(m)
    @value == m.to_i64
  end

  def !=(m)
    @value != m.to_i64
  end

  def succ
    self + 1
  end

  def pred
    self - 1
  end

  def to_i64 : Int64
    @value
  end

  delegate to_s, to: @value
  delegate inspect, to: @value
end

struct Int
  def to_mint : Mint
    Mint.new(self)
  end
end

class String
  def to_mint : Mint
    Mint.new(self)
  end
end
