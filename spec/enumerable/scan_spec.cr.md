---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/enumerable/scan.cr
    title: src/enumerable/scan.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../src/enumerable/scan\"\nmodule\
    \ Enumerable(T)\n  def scan(init : U) forall U\n    scan(init) { |a, b| a + b\
    \ }\n  end\n\n  def scan\n    scan(T.zero)\n  end\n\n  def scan(init : U, &) forall\
    \ U\n    result = [init]\n    each { |v| result << yield(result.last, v) }\n \
    \   result\n  end\n\n  def inclusive_scan(&)\n    first = true\n    result = []\
    \ of T\n    each do |v|\n      if first\n        result << v\n        first =\
    \ false\n      else\n        result << yield(result[-1], v)\n      end\n    end\n\
    \    result\n  end\n\n  def inclusive_scan\n    inclusive_scan { |x, y| x + y\
    \ }\n  end\nend\n\ndescribe Enumerable do\n  it \"#scan(init)\" do\n    [0, 1,\
    \ 2, 3].scan(3).should eq [3, 3, 4, 6, 9]\n    (0..3).scan(3).should eq [3, 3,\
    \ 4, 6, 9]\n  end\n\n  it \"#scan(init, &block)\" do\n    [1, 2, 3, 4].scan(1)\
    \ { |x, y| x * y }.should eq [1, 1, 2, 6, 24]\n    (1..4).scan(1) { |x, y| x *\
    \ y }.should eq [1, 1, 2, 6, 24]\n    [3, 1, 4, 1, 5].scan(0) { |x, y| Math.max(x,\
    \ y) }.should eq [0, 3, 3, 4, 4, 5]\n  end\n\n  it \"#scan\" do\n    [0, 1, 2,\
    \ 3].scan.should eq [0, 0, 1, 3, 6]\n    (0..3).scan.should eq [0, 0, 1, 3, 6]\n\
    \  end\n\n  it \"#inclusive_scan(&block)\" do\n    [3, 1, 4, 1, 5].inclusive_scan\
    \ { |x, y| Math.max(x, y) }.should eq [3, 3, 4, 4, 5]\n    [3, 1, 4, 1, 5].inclusive_scan\
    \ { |x, y| x - y }.should eq [3, 2, -2, -3, -8]\n  end\n\n  it \"#inclusive_scan\"\
    \ do\n    [3, 1, 4, 1, 5].inclusive_scan.should eq [3, 4, 8, 9, 14]\n  end\nend\n"
  code: "require \"spec\"\nrequire \"../../src/enumerable/scan\"\n\ndescribe Enumerable\
    \ do\n  it \"#scan(init)\" do\n    [0, 1, 2, 3].scan(3).should eq [3, 3, 4, 6,\
    \ 9]\n    (0..3).scan(3).should eq [3, 3, 4, 6, 9]\n  end\n\n  it \"#scan(init,\
    \ &block)\" do\n    [1, 2, 3, 4].scan(1) { |x, y| x * y }.should eq [1, 1, 2,\
    \ 6, 24]\n    (1..4).scan(1) { |x, y| x * y }.should eq [1, 1, 2, 6, 24]\n   \
    \ [3, 1, 4, 1, 5].scan(0) { |x, y| Math.max(x, y) }.should eq [0, 3, 3, 4, 4,\
    \ 5]\n  end\n\n  it \"#scan\" do\n    [0, 1, 2, 3].scan.should eq [0, 0, 1, 3,\
    \ 6]\n    (0..3).scan.should eq [0, 0, 1, 3, 6]\n  end\n\n  it \"#inclusive_scan(&block)\"\
    \ do\n    [3, 1, 4, 1, 5].inclusive_scan { |x, y| Math.max(x, y) }.should eq [3,\
    \ 3, 4, 4, 5]\n    [3, 1, 4, 1, 5].inclusive_scan { |x, y| x - y }.should eq [3,\
    \ 2, -2, -3, -8]\n  end\n\n  it \"#inclusive_scan\" do\n    [3, 1, 4, 1, 5].inclusive_scan.should\
    \ eq [3, 4, 8, 9, 14]\n  end\nend\n"
  dependsOn:
  - src/enumerable/scan.cr
  isVerificationFile: false
  path: spec/enumerable/scan_spec.cr
  requiredBy: []
  timestamp: '2021-07-18 10:59:06+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/enumerable/scan_spec.cr
layout: document
redirect_from:
- /library/spec/enumerable/scan_spec.cr
- /library/spec/enumerable/scan_spec.cr.html
title: spec/enumerable/scan_spec.cr
---
