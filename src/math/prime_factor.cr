struct Int
  def prime_factor : Array(Tuple(self, Int32))
    result = [] of Tuple(self, Int32)
    n = self
    typeof(self).new(2).upto(Math.sqrt(self).ceil) do |x|
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

  def each_divisor(&)
    tmp = [] of self
    typeof(self).new(1).upto(self) do |x|
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
