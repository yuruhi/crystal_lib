# verification-helper: PROBLEM https://yukicoder.me/problems/no/275
# verification-helper: ERROR 0
require "../Scanner"
n = input(Int32)
a = input(Int32[n])
a.sort!
puts (a[n.pred // 2] + a[n // 2]) / 2
