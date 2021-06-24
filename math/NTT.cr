# reference : https://kopricky.github.io/code/FFTs/ntt.html
class NTT
  ROOT = 3

  private def self.ntt(a : Array(T), rev = false) forall T
    return a if a.size == 1
    b = Array.new(a.size, T.zero)
    r = T::MOD.pred // a.size
    r = T::MOD.pred - r if rev
    s = T.new(ROOT) ** r
    kp = Array.new(a.size // 2 + 1, T.new(1))
    (1...kp.size).each { |i| kp[i] = kp[i - 1] * s }

    i, l = 1, a.size // 2
    while i < a.size
      r = 0
      (0...l).each do |j|
        s = kp[i * j]
        (0...i).each do |k|
          p, q = a[k + r], a[k + r + a.size // 2]
          b[k + 2 * r] = p + q
          b[k + 2 * r + i] = (p - q) * s
        end
        r += i
      end
      a, b = b, a
      i <<= 1; l >>= 1
    end
    if rev
      s = T.new(a.size).inv
      a.map! { |x| x * s }
    end
    a
  end

  def self.multiple(a : Array(T), b : Array(T)) forall T
    size = a.size + b.size - 1
    t = Math.pw2ceil(size)
    aa = a + Array.new(t - a.size, T.zero)
    bb = b + Array.new(t - b.size, T.zero)
    c = ntt(aa).zip(ntt(bb)).map { |x, y| x * y }
    ntt(c, true).first(size)
  end
end
