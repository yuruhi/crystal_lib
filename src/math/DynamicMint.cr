require "./Barrett"
require "../atcoder/src/Math"

struct DynamicMint
  @@bt : Barrett = Barrett.new(998244353u32)
  alias Mint = DynamicMint

  def self.mod : Int32
    @@bt.mod.to_i
  end

  def self.mod=(m : Int32)
    raise ArgumentError.new unless 1 <= m
    @@bt = Barrett.new(m.to_u32)
  end

  def self.raw(v : Int32)
    result = Mint.new
    result.value = v
    result
  end

  def self.raw(v)
    result = Mint.new
    result.value = v.to_i!
    result
  end

  def self.zero
    Mint.new
  end

  getter value : Int32

  protected def value=(v : Int32)
    @value = v
  end

  def initialize
    @value = 0
  end

  def initialize(x : self)
    @value = x.value
  end

  def initialize(x : Int)
    @value = x.to_i % Mint.mod
  end

  def ==(v : self)
    value == v.value
  end

  def ==(v)
    value == v
  end

  def +
    self
  end

  def -
    Mint.raw value == 0 ? 0 : Mint.mod &- value
  end

  def +(v)
    x = value &+ Mint.new(v).value
    x &-= Mint.mod if x >= Mint.mod
    Mint.raw x
  end

  def -(v)
    x = value &- Mint.new(v).value
    x &+= Mint.mod if x < 0
    Mint.raw x
  end

  def *(v)
    Mint.raw @@bt.mul(value.to_u!, Mint.new(v).value.to_u!)
  end

  def /(v)
    self * Mint.new(v).inv
  end

  def //(v)
    self / v
  end

  def **(exponent : Int)
    t, res = self, Mint.raw(1)
    while exponent > 0
      res *= t if exponent & 1 == 1
      t *= t
      exponent >>= 1
    end
    res
  end

  def inv
    Mint.raw AtCoder::Math.inv_mod(value, Mint.mod)
  end

  def succ
    Mint.raw value == Mint.mod &- 1 ? 0 : value &+ 1
  end

  def pred
    Mint.raw value == 0 ? Mint.mod &- 1 : value &- 1
  end

  def abs
    self
  end

  def abs2
    self * self
  end

  def to_i64 : Int64
    value.to_i64
  end

  delegate to_s, to: @value
  delegate inspect, to: @value

  {% for op in %w[< <= > >=] %}
    def {{op.id}}(other)
      raise NotImplementedError.new({{op}})
    end
  {% end %}
end
