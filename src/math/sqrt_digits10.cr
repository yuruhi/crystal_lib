require "big"

module Math
  def sqrt_digits10(x : Int, scale : Int) : {Array(Int32), Array(Int32)}
    raise ArgumentError.new unless x >= 0
    raise ArgumentError.new unless scale >= 0

    a, b = BigInt.zero, BigInt.zero

    # TODO: use Int.digits
    digits100 = [] of typeof(x)
    while x > 0
      digits100 << x % 100
      x //= 100
    end

    integer_digits = [] of Int32
    digits100.reverse_each do |d|
      a = a * 100 + d
      k = (0..9).reverse_each.find { |k| (b * 10 + k) * k <= a }.not_nil!
      integer_digits << k
      a -= (b * 10 + k) * k
      b = b * 10 + k * 2
    end

    decimal_digits = [] of Int32
    scale.times do
      a *= 100
      k = (0..9).reverse_each.find { |k| (b * 10 + k) * k <= a }.not_nil!
      decimal_digits << k
      a -= (b * 10 + k) * k
      b = b * 10 + k * 2
    end

    {integer_digits, decimal_digits}
  end
end
