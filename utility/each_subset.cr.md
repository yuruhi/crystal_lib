---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/each_subset.test.cr
    title: test/each_subset.test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "struct Int\n  private class SubsetIterator(T)\n    include Iterator(T)\n\
    \n    def initialize(@set : T)\n      @subset = T.zero.as(T)\n      @first = true\n\
    \    end\n\n    def next\n      if @subset == 0 && !@first\n        stop\n   \
    \   else\n        @first = false\n        @subset = ~-@subset & @set\n      end\n\
    \    end\n  end\n\n  def each_subset\n    SubsetIterator.new(self)\n  end\n\n\
    \  def each_subset(&)\n    yield self\n    sub = ~-self & self\n    loop do\n\
    \      yield sub\n      break if sub == 0\n      sub = ~-sub & self\n    end\n\
    \  end\nend\n"
  code: "struct Int\n  private class SubsetIterator(T)\n    include Iterator(T)\n\n\
    \    def initialize(@set : T)\n      @subset = T.zero.as(T)\n      @first = true\n\
    \    end\n\n    def next\n      if @subset == 0 && !@first\n        stop\n   \
    \   else\n        @first = false\n        @subset = ~-@subset & @set\n      end\n\
    \    end\n  end\n\n  def each_subset\n    SubsetIterator.new(self)\n  end\n\n\
    \  def each_subset(&)\n    yield self\n    sub = ~-self & self\n    loop do\n\
    \      yield sub\n      break if sub == 0\n      sub = ~-sub & self\n    end\n\
    \  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: utility/each_subset.cr
  requiredBy: []
  timestamp: '2021-06-24 10:22:55+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/each_subset.test.cr
documentation_of: utility/each_subset.cr
layout: document
redirect_from:
- /library/utility/each_subset.cr
- /library/utility/each_subset.cr.html
title: utility/each_subset.cr
---
