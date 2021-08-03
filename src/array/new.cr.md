---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/array/new_spec.cr
    title: spec/array/new_spec.cr
  - icon: ':warning:'
    path: src/template.cr
    title: src/template.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "class Array\n  def self.new(sizes : Tuple(*T), initial_value) forall\
    \ T\n    {% begin %}\n      {% for i in 0...T.size %} Array.new(sizes[{{i}}])\
    \ { {% end %}\n      initial_value\n      {% for i in 0...T.size %} } {% end %}\n\
    \    {% end %}\n  end\n\n  def self.new(sizes : Tuple(*T), &block) forall T\n\
    \    {% begin %}\n      {% for i in 0...T.size %} Array.new(sizes[{{i}}]) { |%i{i}|\
    \ {% end %}\n      yield({% for i in 0...T.size %} %i{i}, {% end %})\n      {%\
    \ for i in 0...T.size %} } {% end %}\n    {% end %}\n  end\nend\n"
  code: "class Array\n  def self.new(sizes : Tuple(*T), initial_value) forall T\n\
    \    {% begin %}\n      {% for i in 0...T.size %} Array.new(sizes[{{i}}]) { {%\
    \ end %}\n      initial_value\n      {% for i in 0...T.size %} } {% end %}\n \
    \   {% end %}\n  end\n\n  def self.new(sizes : Tuple(*T), &block) forall T\n \
    \   {% begin %}\n      {% for i in 0...T.size %} Array.new(sizes[{{i}}]) { |%i{i}|\
    \ {% end %}\n      yield({% for i in 0...T.size %} %i{i}, {% end %})\n      {%\
    \ for i in 0...T.size %} } {% end %}\n    {% end %}\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/array/new.cr
  requiredBy:
  - src/template.cr
  - spec/array/new_spec.cr
  timestamp: '2021-08-03 17:34:10+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/array/new.cr
layout: document
redirect_from:
- /library/src/array/new.cr
- /library/src/array/new.cr.html
title: src/array/new.cr
---
