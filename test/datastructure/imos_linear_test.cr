# verification-helper: PROBLEM https://yukicoder.me/problems/no/1008
require "../../src/datastructure/imos_linear"
require "../../src/scanner"
n, m = input(i, i)
a = input(i64[n])
xw = input({i - 1, i64}[m])

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
