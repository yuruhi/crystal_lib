struct Int
  # Caluclates `self ** exp % mod`.
  def powmod(exp : Int, mod : self)
    n = self % mod
    res = typeof(self).new(1)
    while exp > 0
      res = res * n % mod if exp.odd?
      n = n * n % mod
      exp >>= 1
    end
    res
  end
end
