# https://yukicoder.me/problems/no/217
# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/ITP1_1_A
require "../../src/point"
require "../../src/array/new"

def generate_odd(n)
  a = Array.new({n, n}, nil.as(Int32?))
  k = 0
  p = Point[0, n // 2]
  loop do
    a[p %= n] = (k += 1)
    if a[p.ur % n].nil?
      p.ur!
    elsif a[p.down % n].nil?
      p.down!
    else
      break
    end
  end
  a.map &.map &.not_nil!
end

def generate_4x(n)
  a = Array.new({n, n}, nil.as(Int32?))
  Point.each do |p|
    p2 = p % 4
    if p2.x == p2.y || (p2.x + p2.y) == 3
      a[p] = p.to_i + 1
    end
  end
  Point.reverse_each do |p|
    if a[p].nil?
      a[p] = n * n - p.to_i
    end
  end
  a.map &.map &.not_nil!
end

LUX = [
  [[4, 1], [2, 3]],
  [[1, 4], [2, 3]],
  [[1, 4], [3, 2]],
]

def generate_4x2(n)
  k = n // 4
  m = k * 2 + 1
  b = generate_odd(m).map &.map { |x| x.pred * 4 }
  a = Array.new({n, n}, 0)
  Point.each(m, m) do |p|
    index = if (p.y <= k && p != Point[k, k]) || p == Point[k + 1, k]
              0
            elsif p.y <= k + 1
              1
            else
              2
            end
    {Point.zero, Point.right, Point.down, Point.dr}.each do |d|
      a[p * 2 + d] = LUX[index][d] + b[p]
    end
  end
  a
end

def generate(n)
  Point.set_range(n, n)
  if n.odd?
    generate_odd(n)
  elsif n % 4 == 0
    generate_4x(n)
  else
    generate_4x2(n)
  end
end

def check(n, a)
  sum = n * (n * n + 1) // 2
  a.size == n &&
    a.all? { |b| b.size == n } &&
    a.flatten.sort! == (1..n * n).to_a &&
    a.all? { |b| b.sum == sum } &&
    a.transpose.all? { |b| b.sum == sum }
end

(3..500).each do |n|
  ans = generate(n)
  raise "" unless check(n, ans)
end

puts "Hello World"
