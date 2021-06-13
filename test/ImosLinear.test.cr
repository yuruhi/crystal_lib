# verification-helper: PROBLEM https://yukicoder.me/problems/no/1008
require "../datastructure/ImosLinear"
n, m = read_line.split.map(&.to_i)
a = read_line.split.map(&.to_i64)
xw = (1..m).map {
  x, w = read_line.split.map(&.to_i)
  {x - 1, w}
}

if xw.sum(&.[0]) < a.min
  puts 0
  exit
end

puts (0i64..10i64**9).bsearch { |x|
  imos = ImosLinear(Int64).new(n)
  xw.each do |x, w|
    imos.add(x..x, w, 0)
    left = {x, w // c}.min
    imos.add(x - left...x, w - c * left, c)
    right = {n - 1 - x, w // c}.min
    imos.add(x + 1...x + right, w - c, -c)
  end
  imos.build.zip(a).all? { |x, a| x < a }
} || -1
