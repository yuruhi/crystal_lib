# verification-helper: PROBLEM https://yukicoder.me/problems/no/117
require "../src/math/Mint"
require "../src/math/Combination"

C = Combination(Mint).new

read_line.to_i.times do
  read_line =~ /(.).(\d+).(\d+)./
  c, n, r = $1[-1], $2.to_i, $3.to_i
  puts case c
  when 'C'
    C.combination(n, r)
  when 'P'
    C.permutation(n, r)
  when 'H'
    C.repeated_combination(n, r)
  end
end
