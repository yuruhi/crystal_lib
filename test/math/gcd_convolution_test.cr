# verification-helper: PROBLEM https://yukicoder.me/problems/no/886
require "../../src/math/gcd"
require "../../src/math/mint"
h, w = read_line.split.map(&.to_i)
hh = (0...h).map { |i| (h - i).to_m }
ww = (0...w).map { |i| (w - i).to_m }
one = h.to_m * w.pred + w.to_m * h.pred
puts GCD.convolution(hh, ww).fetch(1, Mint.zero) * 2 + one
