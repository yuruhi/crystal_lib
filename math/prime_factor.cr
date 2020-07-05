# description : 素因数分解
struct Int
  def prime_factor : Array(Tuple(self, Int32))
    res = Array(Tuple(self, Int32)).new
    n = self
    typeof(self).new(2).upto(Math.sqrt(self).ceil) do |i|
      c = 0
      while n % i == 0
        n //= i
        c += 1
      end
      res << {i, c} if c != 0
    end
    res << {n, 1} if n != 1
    res
  end
end
