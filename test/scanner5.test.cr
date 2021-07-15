# verification-helper: PROBLEM https://yukicoder.me/problems/no/712
require "../src/scanner"
h, _ = input(i, i)
s = input(String[h])
puts s.sum(&.count('W'))
