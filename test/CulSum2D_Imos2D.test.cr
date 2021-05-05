# verification-helper: PROBLEM https://yukicoder.me/problems/no/1490
require "../utility/Imos2D"
require "../utility/CulSum2D"
h, w, n, m = read_line.split.map(&.to_i)
tulra = (1..n).map { read_line.split.map(&.to_i) }
imos = Imos2D(Int64).new(h, w)
m.times do
  x, y, b, c = read_line.split.map(&.to_i)
  x_range = {x - 1 - b, 0}.max...{x + b, h}.min
  y_range = {y - 1 - b, 0}.max...{y + b, w}.min
  imos.add(x_range, y_range, c.to_i64)
end
sum = CulSum2D.new(imos.build)

puts tulra.count { |(t, u, l, r, a)|
  sum[t - 1...u, l - 1...r] < a
}
