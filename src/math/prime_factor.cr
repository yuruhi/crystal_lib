struct Int
  def prime_factor : Array({self, Int32})
    raise DivisionByZeroError.new if self == 0
    result = [] of {self, Int32}
    result << {self.class.new(-1), 1} if self < 0
    n = abs
    self.class.new(2).upto(Math.sqrt(n).ceil) do |x|
      count = 0
      while n % x == 0
        n //= x
        count += 1
      end
      result << {x, count} if count > 0
    end
    result << {n, 1} if n != 1
    result
  end

  def divisors : Array(self)
    result = [] of self
    each_divisor do |d|
      result << d
    end
    result
  end

  def each_divisor(&) : Nil
    raise DivisionByZeroError.new if self == 0
    raise ArgumentError.new unless self > 0
    tmp = [] of self
    self.class.new(1).upto(self) do |x|
      break if x * x > self
      if self % x == 0
        yield x
        tmp << x
      end
    end
    (0...tmp.size).reverse_each do |i|
      yield self // tmp[i] if tmp[i] * tmp[i] < self
    end
  end
end
