# verification-helper: PROBLEM https://yukicoder.me/problems/no/275
# verification-helper: ERROR 0
require "../src/scanner"
n = input(i)
a = input(i(n))
a.sort!
puts (a[n.pred // 2] + a[n // 2]) / 2
