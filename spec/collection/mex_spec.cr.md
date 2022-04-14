---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/collection/mex.cr
    title: src/collection/mex.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../src/collection/mex\"\nmodule\
    \ Enumerable(T)\n  # Returns the minimum value of the complement set.\n  def mex_sorted\
    \ : T\n    reduce(T.zero) do |now, x|\n      next now if x < T.zero\n      return\
    \ now if now < x\n      x.succ\n    end\n  end\n\n  # :ditto:\n  def mex : T\n\
    \    to_a.sort!.mex_sorted\n  end\nend\n\ndescribe Enumerable do\n  it \"#mex_sorted\"\
    \ do\n    (0...100).mex_sorted.should eq 100\n    (1..).mex_sorted.should eq 0\n\
    \    Array(Int32).new.mex_sorted.should eq 0\n    [0, 1, 2, 4].mex_sorted.should\
    \ eq 3\n    [0, 0, 1, 2, 2, 4].mex_sorted.should eq 3\n    [-3, -2, 0, 2].mex_sorted.should\
    \ eq 1\n  end\n\n  it \"#mex\" do\n    a = (0...100).to_a\n    a.mex.should eq\
    \ 100\n    a.shuffle.mex.should eq 100\n    (a * 2).shuffle.mex.should eq 100\n\
    \    Set{3, 4, 0, 7, 1, 2, 6, 3}.mex.should eq 5\n  end\nend\n"
  code: "require \"spec\"\nrequire \"../../src/collection/mex\"\n\ndescribe Enumerable\
    \ do\n  it \"#mex_sorted\" do\n    (0...100).mex_sorted.should eq 100\n    (1..).mex_sorted.should\
    \ eq 0\n    Array(Int32).new.mex_sorted.should eq 0\n    [0, 1, 2, 4].mex_sorted.should\
    \ eq 3\n    [0, 0, 1, 2, 2, 4].mex_sorted.should eq 3\n    [-3, -2, 0, 2].mex_sorted.should\
    \ eq 1\n  end\n\n  it \"#mex\" do\n    a = (0...100).to_a\n    a.mex.should eq\
    \ 100\n    a.shuffle.mex.should eq 100\n    (a * 2).shuffle.mex.should eq 100\n\
    \    Set{3, 4, 0, 7, 1, 2, 6, 3}.mex.should eq 5\n  end\nend\n"
  dependsOn:
  - src/collection/mex.cr
  isVerificationFile: false
  path: spec/collection/mex_spec.cr
  requiredBy: []
  timestamp: '2022-03-25 20:11:13+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/collection/mex_spec.cr
layout: document
redirect_from:
- /library/spec/collection/mex_spec.cr
- /library/spec/collection/mex_spec.cr.html
title: spec/collection/mex_spec.cr
---
