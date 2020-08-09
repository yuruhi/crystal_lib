# description : エラトステネスの篩
def eratosthenes(n : Int32)
  raise ArgumentError.new if n <= 0
  res = [true] * (n + 1)
  res[0] = res[1] = false
  2.upto(n) do |i|
    next if !res[i] || i.to_i64 ** 2 > n
    (i**2).step(to: n, by: i) do |j|
      res[j] = false
    end
  end
  res
end

def primes(n : Int32)
  flag = eratosthenes(n)
  (2..n).select { |i| flag[i] }
end
