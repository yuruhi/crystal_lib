# verification-helper: PROBLEM https://yukicoder.me/problems/no/5
require "../../src/scanner"
l, range = input(i, 1..i)
puts range.map { input(i) }.sort.count { |x| (l -= x) >= 0 }
