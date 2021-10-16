---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/math/quadratic_equation.cr
    title: src/math/quadratic_equation.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    ERROR: 1e-11
    PROBLEM: https://yukicoder.me/problems/no/955
  bundledCode: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/955\n\
    # verification-helper: ERROR 1e-11\n# require \"../../src/math/quadratic_equation\"\
    \nmodule Math\n  # Solve `ax^2 + bx + c = 0`.\n  def quadratic_equation(a : Int64,\
    \ b : Int64, c : Int64) : Array(Float64)?\n    if a == 0 && b == 0 && c == 0\n\
    \      nil\n    elsif a == 0 && b == 0\n      [] of Float64\n    elsif a == 0\n\
    \      [-(c / b)]\n    elsif (d = b * b - a * c * 4) < 0\n      [] of Float64\n\
    \    elsif d == 0\n      [-b / (a * 2)]\n    else\n      x1 = (b > 0) ? (-b -\
    \ Math.sqrt(d)) / (a * 2) : (-b + Math.sqrt(d)) / (a * 2)\n      x2 = (c / a)\
    \ / x1\n      [{x1, x2}.min, {x1, x2}.max]\n    end\n  end\nend\n\na, b, c = read_line.split.map(&.to_i64)\n\
    ans = Math.quadratic_equation(a, b, c)\nif ans.nil?\n  puts -1\nelse\n  puts ans.size,\
    \ ans.join('\\n')\nend\n"
  code: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/955\n# verification-helper:\
    \ ERROR 1e-11\nrequire \"../../src/math/quadratic_equation\"\na, b, c = read_line.split.map(&.to_i64)\n\
    ans = Math.quadratic_equation(a, b, c)\nif ans.nil?\n  puts -1\nelse\n  puts ans.size,\
    \ ans.join('\\n')\nend\n"
  dependsOn:
  - src/math/quadratic_equation.cr
  isVerificationFile: true
  path: test/math/quadratic_equation_test.cr
  requiredBy: []
  timestamp: '2021-09-21 20:11:21+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/math/quadratic_equation_test.cr
layout: document
redirect_from:
- /verify/test/math/quadratic_equation_test.cr
- /verify/test/math/quadratic_equation_test.cr.html
title: test/math/quadratic_equation_test.cr
---
