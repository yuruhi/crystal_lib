---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/int/each_subset_test.cr
    title: test/int/each_subset_test.cr
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
  path: src/int/each_subset.cr
  requiredBy: []
  timestamp: '2021-10-03 17:15:29+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/int/each_subset_test.cr
documentation_of: src/int/each_subset.cr
layout: document
redirect_from:
- /library/src/int/each_subset.cr
- /library/src/int/each_subset.cr.html
title: src/int/each_subset.cr
---
