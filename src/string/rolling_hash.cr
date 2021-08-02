class RollingHash
  MOD = (1u64 << 61) - 1

  private def mul(a : UInt64, b : UInt64)
    t = a.to_u128 * b
    t = (t >> 61) + (t & MOD)
    (t < MOD ? t : t - MOD).to_u64
  end

  getter size : Int32

  def initialize(s : String, base : UInt64 = 10007u64)
    initialize(s.size, s.each_char, base, &.ord)
  end

  def initialize(a : Array(Int), base : UInt64 = 10007u64)
    initialize(a.size, a, base, &.itself)
  end

  def initialize(@size, a : Enumerable, base : UInt64 = 10007u64, &)
    @pow = Array(UInt64).new(size + 1, 1)
    @hash = Array(UInt64).new(size + 1, 0)
    a.each_with_index do |x, i|
      @pow[i + 1] = mul(@pow[i], base)
      @hash[i + 1] = mul(@hash[i], base) + yield(x)
      @hash[i + 1] -= MOD if @hash[i + 1] >= MOD
    end
  end

  def [](start : Int, count : Int) : UInt64
    res = @hash[start + count] + MOD - mul(@hash[start], @pow[count])
    res < MOD ? res : res - MOD
  end

  def [](range : Range) : UInt64
    self[*Indexable.range_to_index_and_count(range, size) || raise IndexError.new]
  end
end
