struct ModInt(MOD)
  def self.mod
    MOD
  end

  def self.zero
    new
  end

  def self.raw(value : Int64)
    result = new
    result.value = value
    result
  end

  macro [](*nums)
    Array({{@type}}).build({{nums.size}}) do |buffer|
      {% for num, i in nums %}
        buffer[{{i}}] = {{@type}}.new({{num}})
      {% end %}
      {{nums.size}}
    end
  end

  getter value : Int64

  private macro check_mod
    {% if MOD.is_a?(NumberLiteral) %}
      {% raise "can't instantiate ModInt(MOD) with MOD = #{MOD} (MOD must be positive)" unless MOD >= 1 %}
      {% raise "can't instantiate ModInt(MOD) with MOD = #{MOD.kind} (MOD must be Int64)" unless MOD.kind == :i64 %}
    {% else %}
      {% raise "can't instantiate ModInt(MOD) with MOD = #{MOD.class_name.id} (MOD must be an integer)" %}
    {% end %}
  end

  def initialize
    check_mod
    @value = 0i64
  end

  def initialize(value)
    check_mod
    @value = value.to_i64 % MOD
  end

  def initialize(m : ModInt(MOD2)) forall MOD2
    {% raise "Can't create ModInt(#{MOD}) from ModInt(#{MOD2})" if MOD != MOD2 %}
    check_mod
    @value = m.value
  end

  protected def value=(value : Int64)
    @value = value
  end

  def self.scan(scanner, io : IO) : self
    new scanner.i64(io)
  end

  def ==(m : ModInt(MOD2)) forall MOD2
    {% raise "Can't compare ModInt(#{MOD}) and ModInt(#{MOD2})" if MOD != MOD2 %}
    value == m.value
  end

  def ==(m : Int)
    value == m
  end

  def + : self
    self
  end

  def - : self
    self.class.raw(value != 0 ? MOD &- value : 0i64)
  end

  def +(v)
    self + self.class.new(v)
  end

  def +(m : self)
    x = value &+ m.value
    x &-= MOD if x >= MOD
    self.class.raw(x)
  end

  def -(v)
    self - self.class.new(v)
  end

  def -(m : self)
    x = value &- m.value
    x &+= MOD if x < 0
    self.class.raw(x)
  end

  def *(v)
    self * self.class.new(v)
  end

  def *(m : self)
    self.class.new(value &* m.value)
  end

  def /(v)
    self / self.class.new(v)
  end

  def /(m : self)
    raise DivisionByZeroError.new if m.value == 0
    a, b, u, v = m.value, MOD, 1i64, 0i64
    while b != 0
      t = a // b
      a &-= t &* b
      a, b = b, a
      u &-= t &* v
      u, v = v, u
    end
    self.class.new(value &* u)
  end

  def //(v)
    self / v
  end

  def **(exponent : Int)
    t, res = self, self.class.raw(1i64)
    while exponent > 0
      res *= t if exponent & 1 == 1
      t *= t
      exponent >>= 1
    end
    res
  end

  {% for op in %w[< <= > >=] %}
    def {{op.id}}(other)
      raise NotImplementedError.new({{op}})
    end
  {% end %}

  def inv
    self.class.raw(1) // self
  end

  def succ
    self.class.raw(value != MOD &- 1 ? value &+ 1 : 0i64)
  end

  def pred
    self.class.raw(value != 0 ? value &- 1 : MOD &- 1)
  end

  def abs
    self
  end

  def abs2
    self * self
  end

  def to_i64 : Int64
    value
  end

  def to_s(io : IO) : Nil
    value.to_s(io)
  end

  def inspect(io : IO) : Nil
    value.inspect(io)
  end
end

struct Int
  def to_m(type : M.class) forall M
    M.new(self)
  end
end

class String
  def to_m(type : M.class) forall M
    M.new(self)
  end
end

alias Mint = ModInt(1000000007i64)
alias Mint2 = ModInt(998244353i64)
