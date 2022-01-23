# verification-helper: PROBLEM https://yukicoder.me/problems/no/886
require "../../src/math/gcd"
require "../../src/math/mint"
h, w = read_line.split.map(&.to_i)
hh = (0...h).map { |i| Mint.new h - i }
ww = (0...w).map { |i| Mint.new w - i }
one = Mint.new(h) * w.pred + Mint.new(w) * h.pred
puts GCD.convolution(hh, ww).fetch(1, Mint.zero) * 2 + one
