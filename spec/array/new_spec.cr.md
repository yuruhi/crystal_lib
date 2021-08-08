---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/array/new.cr
    title: src/array/new.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../src/array/new\"\nclass Array\n\
    \  def self.new(sizes : Tuple(*T), initial_value) forall T\n    {% begin %}\n\
    \      {% for i in 0...T.size %} Array.new(sizes[{{i}}]) { {% end %}\n      initial_value\n\
    \      {% for i in 0...T.size %} } {% end %}\n    {% end %}\n  end\n\n  def self.new(sizes\
    \ : Tuple(*T), &block) forall T\n    {% begin %}\n      {% for i in 0...T.size\
    \ %} Array.new(sizes[{{i}}]) { |index{{i}}| {% end %}\n      yield({% for i in\
    \ 0...T.size %} index{{i}}, {% end %})\n      {% for i in 0...T.size %} } {% end\
    \ %}\n    {% end %}\n  end\nend\n\ndescribe Array do\n  it \".new(sizes, initial_value)\"\
    \ do\n    Array.new({2, 2}, 42).should eq [[42, 42], [42, 42]]\n    Array.new({2,\
    \ 3}, 42).should eq [[42, 42, 42], [42, 42, 42]]\n  end\n\n  it \".new(sizes,\
    \ &block)\" do\n    Array.new({2, 2}) { |i, j| i + j }.should eq [[0, 1], [1,\
    \ 2]]\n    Array.new({3, 3, 3}) { |i, j, k| i*j*k }.should eq [\n      [[0, 0,\
    \ 0], [0, 0, 0], [0, 0, 0]],\n      [[0, 0, 0], [0, 1, 2], [0, 2, 4]],\n     \
    \ [[0, 0, 0], [0, 2, 4], [0, 4, 8]],\n    ]\n    Array.new({3, 3}) { |i, j| {i,\
    \ j} }.should eq [\n      [{0, 0}, {0, 1}, {0, 2}],\n      [{1, 0}, {1, 1}, {1,\
    \ 2}],\n      [{2, 0}, {2, 1}, {2, 2}],\n    ]\n  end\nend\n"
  code: "require \"spec\"\nrequire \"../../src/array/new\"\n\ndescribe Array do\n\
    \  it \".new(sizes, initial_value)\" do\n    Array.new({2, 2}, 42).should eq [[42,\
    \ 42], [42, 42]]\n    Array.new({2, 3}, 42).should eq [[42, 42, 42], [42, 42,\
    \ 42]]\n  end\n\n  it \".new(sizes, &block)\" do\n    Array.new({2, 2}) { |i,\
    \ j| i + j }.should eq [[0, 1], [1, 2]]\n    Array.new({3, 3, 3}) { |i, j, k|\
    \ i*j*k }.should eq [\n      [[0, 0, 0], [0, 0, 0], [0, 0, 0]],\n      [[0, 0,\
    \ 0], [0, 1, 2], [0, 2, 4]],\n      [[0, 0, 0], [0, 2, 4], [0, 4, 8]],\n    ]\n\
    \    Array.new({3, 3}) { |i, j| {i, j} }.should eq [\n      [{0, 0}, {0, 1}, {0,\
    \ 2}],\n      [{1, 0}, {1, 1}, {1, 2}],\n      [{2, 0}, {2, 1}, {2, 2}],\n   \
    \ ]\n  end\nend\n"
  dependsOn:
  - src/array/new.cr
  isVerificationFile: false
  path: spec/array/new_spec.cr
  requiredBy: []
  timestamp: '2021-08-08 12:21:06+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/array/new_spec.cr
layout: document
redirect_from:
- /library/spec/array/new_spec.cr
- /library/spec/array/new_spec.cr.html
title: spec/array/new_spec.cr
---
