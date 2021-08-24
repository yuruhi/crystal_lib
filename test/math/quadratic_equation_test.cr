# verification-helper: PROBLEM https://yukicoder.me/problems/no/955
# verification-helper: ERROR 1e-11
require "../../src/math/quadratic_equation"
a, b, c = read_line.split.map(&.to_i64)
ans = Math.quadratic_equation(a, b, c)
if ans.nil?
  puts -1
else
  puts ans.size, ans.join('\n')
end
