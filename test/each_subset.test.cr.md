---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: utility/each_subset.cr
    title: utility/each_subset.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://onlinejudge.u-aizu.ac.jp/courses/lesson/8/ITP2/all/ITP2_11_C
  bundledCode: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/lesson/8/ITP2/all/ITP2_11_C\n\
    # require \"../utility/each_subset\"\nstruct Int\n  private class SubsetIterator(T)\n\
    \    include Iterator(T)\n\n    def initialize(@set : T)\n      @subset = T.zero.as(T)\n\
    \      @first = true\n    end\n\n    def next\n      if @subset == 0 && !@first\n\
    \        stop\n      else\n        @first = false\n        @subset = ~-@subset\
    \ & @set\n      end\n    end\n  end\n\n  def each_subset\n    SubsetIterator.new(self)\n\
    \  end\n\n  def each_subset(&)\n    yield self\n    sub = ~-self & self\n    loop\
    \ do\n      yield sub\n      break if sub == 0\n      sub = ~-sub & self\n   \
    \ end\n  end\nend\n\nn = read_line.to_i\na = read_line.split.map(&.to_i).skip(1).reduce(0)\
    \ { |acc, x| acc | (1 << x) }\nputs a.each_subset.map { |x|\n  \"#{x}:\" + (0...n).select\
    \ { |i| x.bit(i) == 1 }.join { |i| \" #{i}\" }\n}.to_a.reverse.join('\\n')\n"
  code: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/lesson/8/ITP2/all/ITP2_11_C\n\
    require \"../utility/each_subset\"\nn = read_line.to_i\na = read_line.split.map(&.to_i).skip(1).reduce(0)\
    \ { |acc, x| acc | (1 << x) }\nputs a.each_subset.map { |x|\n  \"#{x}:\" + (0...n).select\
    \ { |i| x.bit(i) == 1 }.join { |i| \" #{i}\" }\n}.to_a.reverse.join('\\n')\n"
  dependsOn:
  - utility/each_subset.cr
  isVerificationFile: true
  path: test/each_subset.test.cr
  requiredBy: []
  timestamp: '2021-05-27 22:21:55+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/each_subset.test.cr
layout: document
redirect_from:
- /verify/test/each_subset.test.cr
- /verify/test/each_subset.test.cr.html
title: test/each_subset.test.cr
---
