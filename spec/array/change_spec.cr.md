---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/array/change.cr
    title: src/array/change.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../src/array/change\"\nclass Array(T)\n\
    \  def chmin(i : Int, value : T)\n    (self[i] > value).tap do |f|\n      self[i]\
    \ = value if f\n    end\n  end\n\n  protected def chmin(i : Int, *indexes, value)\n\
    \    self[i].chmin(*indexes, value: value)\n  end\n\n  def chmin(indexes : Tuple,\
    \ value)\n    chmin(*indexes, value: value)\n  end\n\n  def chmax(i : Int, value\
    \ : T)\n    (self[i] < value).tap do |f|\n      self[i] = value if f\n    end\n\
    \  end\n\n  protected def chmax(i : Int, *indexes, value)\n    self[i].chmax(*indexes,\
    \ value: value)\n  end\n\n  def chmax(indexes : Tuple, value)\n    chmax(*indexes,\
    \ value: value)\n  end\nend\n\ndescribe Array do\n  it \"#chmin(i, value)\" do\n\
    \    a = [0, 1, 2, 3]\n    a.chmin(3, 0).should be_true\n    a.should eq [0, 1,\
    \ 2, 0]\n    a.chmin(0, 0).should be_false\n    a.should eq [0, 1, 2, 0]\n   \
    \ a.chmin(-2, 0).should be_true\n    a.should eq [0, 1, 0, 0]\n    a.chmin(1,\
    \ 10).should be_false\n    a.should eq [0, 1, 0, 0]\n  end\n\n  it \"#chmin(indexes,\
    \ value)\" do\n    a = [[0, 1], [2, 3], [4, 5]]\n    a.chmin({1, 1}, 0).should\
    \ be_true\n    a.should eq [[0, 1], [2, 0], [4, 5]]\n    a.chmin({0, 0}, 0).should\
    \ be_false\n    a.should eq [[0, 1], [2, 0], [4, 5]]\n    a.chmin({2, 1}, 3).should\
    \ be_true\n    a.should eq [[0, 1], [2, 0], [4, 3]]\n    a[1].chmin({0}, 42).should\
    \ be_false\n    a.should eq [[0, 1], [2, 0], [4, 3]]\n  end\n\n  it \"#chmax(i,\
    \ value)\" do\n    a = [0, 1, 2, 3]\n    a.chmax(3, 4).should be_true\n    a.should\
    \ eq [0, 1, 2, 4]\n    a.chmax(0, 0).should be_false\n    a.should eq [0, 1, 2,\
    \ 4]\n    a.chmax(-2, 4).should be_true\n    a.should eq [0, 1, 4, 4]\n    a.chmax(1,\
    \ -10).should be_false\n    a.should eq [0, 1, 4, 4]\n  end\n\n  it \"#chmax(indexes,\
    \ value)\" do\n    a = [[0, 1], [2, 3], [4, 5]]\n    a.chmax({1, 1}, 10).should\
    \ be_true\n    a.should eq [[0, 1], [2, 10], [4, 5]]\n    a.chmax({0, 0}, 0).should\
    \ be_false\n    a.should eq [[0, 1], [2, 10], [4, 5]]\n    a.chmax({2, 1}, 11).should\
    \ be_true\n    a.should eq [[0, 1], [2, 10], [4, 11]]\n    a[1].chmax({0}, -42).should\
    \ be_false\n    a.should eq [[0, 1], [2, 10], [4, 11]]\n  end\nend\n"
  code: "require \"spec\"\nrequire \"../../src/array/change\"\n\ndescribe Array do\n\
    \  it \"#chmin(i, value)\" do\n    a = [0, 1, 2, 3]\n    a.chmin(3, 0).should\
    \ be_true\n    a.should eq [0, 1, 2, 0]\n    a.chmin(0, 0).should be_false\n \
    \   a.should eq [0, 1, 2, 0]\n    a.chmin(-2, 0).should be_true\n    a.should\
    \ eq [0, 1, 0, 0]\n    a.chmin(1, 10).should be_false\n    a.should eq [0, 1,\
    \ 0, 0]\n  end\n\n  it \"#chmin(indexes, value)\" do\n    a = [[0, 1], [2, 3],\
    \ [4, 5]]\n    a.chmin({1, 1}, 0).should be_true\n    a.should eq [[0, 1], [2,\
    \ 0], [4, 5]]\n    a.chmin({0, 0}, 0).should be_false\n    a.should eq [[0, 1],\
    \ [2, 0], [4, 5]]\n    a.chmin({2, 1}, 3).should be_true\n    a.should eq [[0,\
    \ 1], [2, 0], [4, 3]]\n    a[1].chmin({0}, 42).should be_false\n    a.should eq\
    \ [[0, 1], [2, 0], [4, 3]]\n  end\n\n  it \"#chmax(i, value)\" do\n    a = [0,\
    \ 1, 2, 3]\n    a.chmax(3, 4).should be_true\n    a.should eq [0, 1, 2, 4]\n \
    \   a.chmax(0, 0).should be_false\n    a.should eq [0, 1, 2, 4]\n    a.chmax(-2,\
    \ 4).should be_true\n    a.should eq [0, 1, 4, 4]\n    a.chmax(1, -10).should\
    \ be_false\n    a.should eq [0, 1, 4, 4]\n  end\n\n  it \"#chmax(indexes, value)\"\
    \ do\n    a = [[0, 1], [2, 3], [4, 5]]\n    a.chmax({1, 1}, 10).should be_true\n\
    \    a.should eq [[0, 1], [2, 10], [4, 5]]\n    a.chmax({0, 0}, 0).should be_false\n\
    \    a.should eq [[0, 1], [2, 10], [4, 5]]\n    a.chmax({2, 1}, 11).should be_true\n\
    \    a.should eq [[0, 1], [2, 10], [4, 11]]\n    a[1].chmax({0}, -42).should be_false\n\
    \    a.should eq [[0, 1], [2, 10], [4, 11]]\n  end\nend\n"
  dependsOn:
  - src/array/change.cr
  isVerificationFile: false
  path: spec/array/change_spec.cr
  requiredBy: []
  timestamp: '2021-07-18 19:56:57+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/array/change_spec.cr
layout: document
redirect_from:
- /library/spec/array/change_spec.cr
- /library/spec/array/change_spec.cr.html
title: spec/array/change_spec.cr
---
