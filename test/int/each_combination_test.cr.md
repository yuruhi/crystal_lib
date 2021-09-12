---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/int/each_combination.cr
    title: src/int/each_combination.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://onlinejudge.u-aizu.ac.jp/courses/lesson/8/ITP2/all/ITP2_11_D
  bundledCode: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/lesson/8/ITP2/all/ITP2_11_D\n\
    # require \"../../src/int/each_combination\"\nstruct Int\n  private class CombinationIterator(T,\
    \ U)\n    include Iterator(T)\n\n    @combination : T\n\n    def initialize(@n\
    \ : T, @k : U)\n      @combination = (T.new(1) << @k) - 1\n      @first = true\n\
    \    end\n\n    def next\n      if @first\n        @first = false\n        @combination\n\
    \      else\n        x = @combination & -@combination\n        y = @combination\
    \ + x\n        @combination = ((@combination & ~y) // x >> 1) | y\n        @combination\
    \ < (T.new(1) << @n) ? @combination : stop\n      end\n    end\n  end\n\n  def\
    \ each_combination(k : Int)\n    CombinationIterator.new(self, k)\n  end\n\n \
    \ def each_combination(k : Int, &) : Nil\n    combination = (self.class.new(1)\
    \ << k) - 1\n    while combination < (self.class.new(1) << self)\n      yield\
    \ combination\n      x = combination & (-combination)\n      y = combination +\
    \ x\n      combination = ((combination & ~y) // x >> 1) | y\n    end\n  end\n\
    end\n\nn, k = read_line.split.map(&.to_i)\n\nans = [] of Int32\nn.each_combination(k)\
    \ { |x| ans << x }\nans2 = n.each_combination(k).to_a\nraise \"\" unless ans ==\
    \ ans2\n\nans.each do |x|\n  print x, \": \", (0...n).select { |i| x.bit(i) ==\
    \ 1 }.join(' '), '\\n'\nend\n"
  code: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/lesson/8/ITP2/all/ITP2_11_D\n\
    require \"../../src/int/each_combination\"\nn, k = read_line.split.map(&.to_i)\n\
    \nans = [] of Int32\nn.each_combination(k) { |x| ans << x }\nans2 = n.each_combination(k).to_a\n\
    raise \"\" unless ans == ans2\n\nans.each do |x|\n  print x, \": \", (0...n).select\
    \ { |i| x.bit(i) == 1 }.join(' '), '\\n'\nend\n"
  dependsOn:
  - src/int/each_combination.cr
  isVerificationFile: true
  path: test/int/each_combination_test.cr
  requiredBy: []
  timestamp: '2021-08-04 18:11:49+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/int/each_combination_test.cr
layout: document
redirect_from:
- /verify/test/int/each_combination_test.cr
- /verify/test/int/each_combination_test.cr.html
title: test/int/each_combination_test.cr
---
