# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/lesson/8/ITP2/all/ITP2_11_C
require "../../src/int/each_subset"
n = read_line.to_i
a = read_line.split.map(&.to_i).skip(1).reduce(0) { |acc, x| acc | (1 << x) }
puts a.each_subset.map { |x|
  "#{x}:" + (0...n).select { |i| x.bit(i) == 1 }.join { |i| " #{i}" }
}.to_a.reverse.join('\n')
