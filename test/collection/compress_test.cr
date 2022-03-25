# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/DSL_4_A
require "../../src/collection/compress"
require "../../src/datastructure/imos_2d"
require "../../src/scanner"
n = read_line.to_i
x1, y1, x2, y2 = input_column({Int64, Int64, Int64, Int64}, n)

x_values = (x1 + x2).uniq.sort!
xx = x_values.size - 1
cx1 = x1.compress(x_values)
cx2 = x2.compress(x_values)

y_values = (y1 + y2).uniq.sort!
yy = y_values.size - 1
cy1 = y1.compress(y_values)
cy2 = y2.compress(y_values)

imos = Imos2D(Int32).new(xx, yy)
cx1.zip(cy1, cx2, cy2) do |x1, y1, x2, y2|
  imos.add(x1...x2, y1...y2, 1)
end
imos.build

puts (0...xx).sum { |i|
  (0...yy).sum { |j|
    (x_values[i + 1] - x_values[i]) * (y_values[j + 1] - y_values[j]) * imos[i, j].sign
  }
}
