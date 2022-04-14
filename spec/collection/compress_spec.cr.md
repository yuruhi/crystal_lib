---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/collection/compress.cr
    title: src/collection/compress.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../src/collection/compress\"\n\
    class Array(T)\n  def compress(values : Array(T), *, index : Int = 0)\n    map\
    \ do |x|\n      index + values.bsearch_index { |y| y >= x }.not_nil!\n    end\n\
    \  end\n\n  def compress(*, index : Int = 0) : Array(Int32)\n    compress(uniq.sort!,\
    \ index: index)\n  end\nend\n\ndescribe Array do\n  it \"#compress\" do\n    a\
    \ = [0, 3, 7, 0, 5]\n    a.compress.should eq [0, 1, 3, 0, 2]\n    a.compress(index:\
    \ 1).should eq [1, 2, 4, 1, 3]\n    a.compress([0, 1, 3, 5, 7]).should eq [0,\
    \ 2, 4, 0, 3]\n    a.compress([0, 1, 3, 5, 7], index: 1).should eq [1, 3, 5, 1,\
    \ 4]\n  end\nend\n"
  code: "require \"spec\"\nrequire \"../../src/collection/compress\"\n\ndescribe Array\
    \ do\n  it \"#compress\" do\n    a = [0, 3, 7, 0, 5]\n    a.compress.should eq\
    \ [0, 1, 3, 0, 2]\n    a.compress(index: 1).should eq [1, 2, 4, 1, 3]\n    a.compress([0,\
    \ 1, 3, 5, 7]).should eq [0, 2, 4, 0, 3]\n    a.compress([0, 1, 3, 5, 7], index:\
    \ 1).should eq [1, 3, 5, 1, 4]\n  end\nend\n"
  dependsOn:
  - src/collection/compress.cr
  isVerificationFile: false
  path: spec/collection/compress_spec.cr
  requiredBy: []
  timestamp: '2022-04-10 08:38:15+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/collection/compress_spec.cr
layout: document
redirect_from:
- /library/spec/collection/compress_spec.cr
- /library/spec/collection/compress_spec.cr.html
title: spec/collection/compress_spec.cr
---
