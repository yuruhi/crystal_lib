# verification-helper: PROBLEM https://judge.yosupo.jp/problem/many_aplusb
require "../../src/scanner"
n = input(i)
a, b = input_column({Int64, Int64}, n)
a.zip(b) do |a, b|
  puts a + b
end
