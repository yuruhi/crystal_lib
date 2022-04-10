---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/collection/accumulate.cr
    title: src/collection/accumulate.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../src/collection/accumulate\"\n\
    module Enumerable(T)\n  def accumulate(init : U) : Array(U) forall U\n    accumulate(init)\
    \ { |a, b| a + b }\n  end\n\n  def accumulate : Array(T)\n    accumulate { |x,\
    \ y| x + y }\n  end\n\n  def accumulate(init : U, &block : U, T -> U) : Array(U)\
    \ forall U\n    result = [init]\n    each { |v| result << yield(result.last, v)\
    \ }\n    result\n  end\n\n  def accumulate(&block : T, T -> T) : Array(T)\n  \
    \  result = [] of T\n    memo = uninitialized T\n    each do |v|\n      memo =\
    \ result.empty? ? v : yield(memo, v)\n      result << memo\n    end\n    result\n\
    \  end\nend\n\ndescribe Enumerable do\n  it \"#accumulate(init)\" do\n    [0,\
    \ 1, 2, 3].accumulate(3).should eq [3, 3, 4, 6, 9]\n    (0..3).accumulate(3).should\
    \ eq [3, 3, 4, 6, 9]\n  end\n\n  it \"#accumulate(init, &block)\" do\n    [1,\
    \ 2, 3, 4].accumulate(1) { |x, y| x * y }.should eq [1, 1, 2, 6, 24]\n    (1..4).accumulate(1)\
    \ { |x, y| x * y }.should eq [1, 1, 2, 6, 24]\n    [3, 1, 4, 1, 5].accumulate(0)\
    \ { |x, y| Math.max(x, y) }.should eq [0, 3, 3, 4, 4, 5]\n  end\n\n  it \"#accumulate\"\
    \ do\n    [0, 1, 2, 3].accumulate.should eq [0, 1, 3, 6]\n    (0..3).accumulate.should\
    \ eq [0, 1, 3, 6]\n  end\nend\n"
  code: "require \"spec\"\nrequire \"../../src/collection/accumulate\"\n\ndescribe\
    \ Enumerable do\n  it \"#accumulate(init)\" do\n    [0, 1, 2, 3].accumulate(3).should\
    \ eq [3, 3, 4, 6, 9]\n    (0..3).accumulate(3).should eq [3, 3, 4, 6, 9]\n  end\n\
    \n  it \"#accumulate(init, &block)\" do\n    [1, 2, 3, 4].accumulate(1) { |x,\
    \ y| x * y }.should eq [1, 1, 2, 6, 24]\n    (1..4).accumulate(1) { |x, y| x *\
    \ y }.should eq [1, 1, 2, 6, 24]\n    [3, 1, 4, 1, 5].accumulate(0) { |x, y| Math.max(x,\
    \ y) }.should eq [0, 3, 3, 4, 4, 5]\n  end\n\n  it \"#accumulate\" do\n    [0,\
    \ 1, 2, 3].accumulate.should eq [0, 1, 3, 6]\n    (0..3).accumulate.should eq\
    \ [0, 1, 3, 6]\n  end\nend\n"
  dependsOn:
  - src/collection/accumulate.cr
  isVerificationFile: false
  path: spec/collection/accumulate_spec.cr
  requiredBy: []
  timestamp: '2022-03-25 20:11:13+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/collection/accumulate_spec.cr
layout: document
redirect_from:
- /library/spec/collection/accumulate_spec.cr
- /library/spec/collection/accumulate_spec.cr.html
title: spec/collection/accumulate_spec.cr
---
