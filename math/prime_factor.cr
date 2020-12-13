# description : 素因数分解、約数列挙
struct Int
  def prime_factor : Array(Tuple(self, Int32))
    result = Array(Tuple(self, Int32)).new
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
    result = Array(self).new
    typeof(self).new(1).upto(self) do |x|
      break if x * x > self
      result << x if self % x == 0
    end
    (0...result.size).reverse_each do |i|
      result << self // result[i] if result[i] * result[i] < self
    end
    result
  end
end
