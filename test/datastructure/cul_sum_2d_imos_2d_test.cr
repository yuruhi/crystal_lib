# verification-helper: PROBLEM https://yukicoder.me/problems/no/1490
require "../../src/datastructure/imos_2d"
require "../../src/datastructure/cul_sum_2d"
require "../../src/scanner"
h, w, n, m = input(i, i, i, i)
tulra = input({i, i, i, i, i}[n])

imos = Imos2D(Int64).new(h, w)
m.times do
  x, y, b, c = read_line.split.map(&.to_i)
  x_range = {x - 1 - b, 0}.max...{x + b, h}.min
  y_range = {y - 1 - b, 0}.max...{y + b, w}.min
  imos.add(x_range, y_range, c.to_i64)
end
sum = CulSum2D.new(imos.build)

puts tulra.count { |t, u, l, r, a|
  sum[t - 1...u, l - 1...r] < a
}
