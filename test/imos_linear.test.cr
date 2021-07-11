# verification-helper: PROBLEM https://yukicoder.me/problems/no/1008
require "../src/datastructure/imos_linear"
n, m = read_line.split.map(&.to_i)
a = read_line.split.map(&.to_i64)
xw = (1..m).map {
  x, w = read_line.split
  {x.to_i - 1, w.to_i64}
}

if xw.sum(&.[1]) < a.min
  puts 0
  exit
end

puts (1i64..10i64**9).bsearch { |c|
  imos = ImosLinear(Int64).new(n)
  xw.each do |x, w|
    imos.add(x..x, w, 0)
    left = {x, w // c}.min
    imos.add(x - left, left, w - c * left, c)
    right = {n - 1 - x, w // c}.min
    imos.add(x + 1, right, w - c, -c)
  end
  imos.build.zip(a).all? { |imos, a| imos < a }
} || -1
