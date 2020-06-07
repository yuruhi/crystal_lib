struct Int
  def powmod(exp : self, mod : self)
    n = self % mod
    res = 1
    while exp > 0
      res = res * n % mod if exp.odd?
      n = n * n % mod
      exp >>= 1
    end
    res
  end
end