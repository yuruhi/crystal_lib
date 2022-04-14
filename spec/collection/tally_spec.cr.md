---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/collection/tally.cr
    title: src/collection/tally.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../src/collection/tally\"\nmodule\
    \ Enumerable(T)\n  def tally(*, default : Int32) : Hash(T, Int32)\n    each_with_object(Hash(T,\
    \ Int32).new default) do |value, hash|\n      hash[value] += 1\n    end\n  end\n\
    end\n\ndescribe Enumerable do\n  it \"#tally(*, default)\" do\n    c = [1, 2,\
    \ 2, 3, 3, 3].tally(default: 0)\n    c.should eq({1 => 1, 2 => 2, 3 => 3})\n \
    \   c[0].should eq 0\n\n    c = [1, 2, 2, 3, 3, 3].tally(default: 100)\n    c.should\
    \ eq({1 => 101, 2 => 102, 3 => 103})\n    c[0].should eq 100\n  end\nend\n"
  code: "require \"spec\"\nrequire \"../../src/collection/tally\"\n\ndescribe Enumerable\
    \ do\n  it \"#tally(*, default)\" do\n    c = [1, 2, 2, 3, 3, 3].tally(default:\
    \ 0)\n    c.should eq({1 => 1, 2 => 2, 3 => 3})\n    c[0].should eq 0\n\n    c\
    \ = [1, 2, 2, 3, 3, 3].tally(default: 100)\n    c.should eq({1 => 101, 2 => 102,\
    \ 3 => 103})\n    c[0].should eq 100\n  end\nend\n"
  dependsOn:
  - src/collection/tally.cr
  isVerificationFile: false
  path: spec/collection/tally_spec.cr
  requiredBy: []
  timestamp: '2022-03-25 20:11:13+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/collection/tally_spec.cr
layout: document
redirect_from:
- /library/spec/collection/tally_spec.cr
- /library/spec/collection/tally_spec.cr.html
title: spec/collection/tally_spec.cr
---
