# verification-helper: PROBLEM https://yukicoder.me/problems/no/170
require "../..//src/array/unique_permutation"
s = read_line.chars.sort!

ans1 = -1
s.each_unique_permutation { ans1 += 1 }

ans2 = s.each_unique_permutation.count { true } - 1

ans3 = s.unique_permutations.size - 1

raise "" unless ans1 == ans2 == ans3

puts ans1
