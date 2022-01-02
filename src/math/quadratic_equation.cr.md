---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/math/quadratic_equation_test.cr
    title: test/math/quadratic_equation_test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "module Math\n  # Solve `ax^2 + bx + c = 0`.\n  def quadratic_equation(a\
    \ : Int64, b : Int64, c : Int64) : Array(Float64)?\n    if a == 0 && b == 0 &&\
    \ c == 0\n      nil\n    elsif a == 0 && b == 0\n      [] of Float64\n    elsif\
    \ a == 0\n      [-(c / b)]\n    elsif (d = b * b - a * c * 4) < 0\n      [] of\
    \ Float64\n    elsif d == 0\n      [-b / (a * 2)]\n    else\n      x1 = (b > 0)\
    \ ? (-b - Math.sqrt(d)) / (a * 2) : (-b + Math.sqrt(d)) / (a * 2)\n      x2 =\
    \ (c / a) / x1\n      [{x1, x2}.min, {x1, x2}.max]\n    end\n  end\nend\n"
  code: "module Math\n  # Solve `ax^2 + bx + c = 0`.\n  def quadratic_equation(a :\
    \ Int64, b : Int64, c : Int64) : Array(Float64)?\n    if a == 0 && b == 0 && c\
    \ == 0\n      nil\n    elsif a == 0 && b == 0\n      [] of Float64\n    elsif\
    \ a == 0\n      [-(c / b)]\n    elsif (d = b * b - a * c * 4) < 0\n      [] of\
    \ Float64\n    elsif d == 0\n      [-b / (a * 2)]\n    else\n      x1 = (b > 0)\
    \ ? (-b - Math.sqrt(d)) / (a * 2) : (-b + Math.sqrt(d)) / (a * 2)\n      x2 =\
    \ (c / a) / x1\n      [{x1, x2}.min, {x1, x2}.max]\n    end\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/math/quadratic_equation.cr
  requiredBy: []
  timestamp: '2022-01-02 08:46:32+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/math/quadratic_equation_test.cr
documentation_of: src/math/quadratic_equation.cr
layout: document
redirect_from:
- /library/src/math/quadratic_equation.cr
- /library/src/math/quadratic_equation.cr.html
title: src/math/quadratic_equation.cr
---
