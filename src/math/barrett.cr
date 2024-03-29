struct Barrett
  getter mod : UInt32, inv : UInt64

  # Requires `1 <= mod < 2^31`
  def initialize(@mod)
    @inv = UInt64::MAX // @mod &+ 1
  end

  # Caluclates `a * b % mod`.
  #
  # Requires `0 <= a < mod` and `0 <= b < mod`
  def mul(a : UInt32, b : UInt32) : UInt32
    z = a.to_u64! &* b
    x = ((z.to_u128! &* @inv) >> 64).to_u64!
    v = (z &- x &* @mod).to_u32!
    v &+= @mod if @mod <= v
    v
  end
end
