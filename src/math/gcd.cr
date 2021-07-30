require "../../src/math/prime"

class Array(T)
  # `result[i] = Sum_{n | i} a[i]` (inplace)
  def gcd_zeta!
    Prime.each(size - 1) do |p|
      i, k = size.pred // p, size.pred // p * p
      while k > 0
        self[i] += self[i * p]
        i -= 1; k -= p
      end
    end
    self
  end

  # `result[i] = Sum_{n | i} a[i]`
  def gcd_zeta
    dup.gcd_zeta!
  end

  # `a[i] = Sum_{n | i} result[i]` (inplace)
  def gcd_mobius!
    Prime.each(size - 1) do |p|
      i, k = 1, p
      while k < size
        self[i] -= self[k]
        i += 1; k += p
      end
    end
    self
  end

  # `a[i] = Sum_{n | i} result[i]`
  def gcd_mobius
    dup.gcd_mobius!
  end
end

module GCD
  extend self

  # `result[n] = Sum_{gcd(i, j) = n} f[i] * g[j]`
  def convolution(f : Array(T), g : Array(T)) forall T
    f.gcd_zeta.zip?(g.gcd_zeta).map { |x, y| (x || T.zero) * (y || T.zero) }.gcd_mobius!
  end
end
