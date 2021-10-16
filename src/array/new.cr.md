---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/array/new_spec.cr
    title: spec/array/new_spec.cr
  - icon: ':warning:'
    path: spec/point/magic_square_spec.cr
    title: spec/point/magic_square_spec.cr
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
    \    {% begin %}\n      {% for i in 0...T.size %} Array.new(sizes[{{i}}]) { |index{{i}}|\
    \ {% end %}\n      yield({% for i in 0...T.size %} index{{i}}, {% end %})\n  \
    \    {% for i in 0...T.size %} } {% end %}\n    {% end %}\n  end\nend\n"
  code: "class Array\n  def self.new(sizes : Tuple(*T), initial_value) forall T\n\
    \    {% begin %}\n      {% for i in 0...T.size %} Array.new(sizes[{{i}}]) { {%\
    \ end %}\n      initial_value\n      {% for i in 0...T.size %} } {% end %}\n \
    \   {% end %}\n  end\n\n  def self.new(sizes : Tuple(*T), &block) forall T\n \
    \   {% begin %}\n      {% for i in 0...T.size %} Array.new(sizes[{{i}}]) { |index{{i}}|\
    \ {% end %}\n      yield({% for i in 0...T.size %} index{{i}}, {% end %})\n  \
    \    {% for i in 0...T.size %} } {% end %}\n    {% end %}\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/array/new.cr
  requiredBy:
  - src/template.cr
  - spec/array/new_spec.cr
  - spec/point/magic_square_spec.cr
  timestamp: '2021-10-16 13:32:38+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/array/new.cr
layout: document
redirect_from:
- /library/src/array/new.cr
- /library/src/array/new.cr.html
title: src/array/new.cr
---