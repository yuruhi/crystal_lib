# verification-helper: PROBLEM https://yukicoder.me/problems/no/712
require "../src/scanner"
h, w = input(i, i)
s = input(Char[h, w])
puts s.sum(&.count('W'))
