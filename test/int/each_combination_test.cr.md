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
    \ < (T.new(1) << @n) ? @combination : stop\n      end\n    end\n  end\n\n  # Returns\
    \ an iterator that returns all integers whose bit_length is *n* and popcount is\
    \ *k*.\n  #\n  # ```\n  # Int.each_combination(3, 2).to_a # => [0b011, 0b101,\
    \ 0b110]\n  # ```\n  def self.each_combination(n : Int, k : Int)\n    CombinationIterator.new(n,\
    \ k)\n  end\n\n  # Calls the given block for each integer whose bit_length is\
    \ *n* and popcount is *k*.\n  #\n  # ```\n  # # x = 0b011, 0b101, 0b110\n  # Int.each_combination(3,\
    \ 2) { |x| }\n  # ```\n  def self.each_combination(n : Int, k : Int, &) : Nil\n\
    \    combination = (n.class.new(1) << k) - 1\n    while combination < (n.class.new(1)\
    \ << n)\n      yield combination\n      x = combination & (-combination)\n   \
    \   y = combination + x\n      combination = ((combination & ~y) // x >> 1) |\
    \ y\n    end\n  end\nend\n\nn, k = read_line.split.map(&.to_i)\n\nans = [] of\
    \ Int32\nInt.each_combination(n, k) { |x| ans << x }\nans2 = Int.each_combination(n,\
    \ k).to_a\nraise \"\" unless ans == ans2\n\nans.each do |x|\n  print x, \": \"\
    , (0...n).select { |i| x.bit(i) == 1 }.join(' '), '\\n'\nend\n"
  code: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/lesson/8/ITP2/all/ITP2_11_D\n\
    require \"../../src/int/each_combination\"\nn, k = read_line.split.map(&.to_i)\n\
    \nans = [] of Int32\nInt.each_combination(n, k) { |x| ans << x }\nans2 = Int.each_combination(n,\
    \ k).to_a\nraise \"\" unless ans == ans2\n\nans.each do |x|\n  print x, \": \"\
    , (0...n).select { |i| x.bit(i) == 1 }.join(' '), '\\n'\nend\n"
  dependsOn:
  - src/int/each_combination.cr
  isVerificationFile: true
  path: test/int/each_combination_test.cr
  requiredBy: []
  timestamp: '2021-10-17 21:56:08+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/int/each_combination_test.cr
layout: document
redirect_from:
- /verify/test/int/each_combination_test.cr
- /verify/test/int/each_combination_test.cr.html
title: test/int/each_combination_test.cr
---
