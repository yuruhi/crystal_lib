---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/tuple/times_spec.cr
    title: spec/tuple/times_spec.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "struct Tuple\n  def times(&block) : Nil\n    {% begin %}\n      {%\
    \ for i in 0...@type.size %}\n        {% if @type[i].has_method?(:each) %}\n \
    \         self[{{i}}].each do |i{{i}}|\n        {% else %}\n          self[{{i}}].times\
    \ do |i{{i}}|\n        {% end %}\n      {% end %}\n      yield({% for i in 0...@type.size\
    \ %} i{{i}}, {% end %})\n      {% for i in 0...@type.size %} end {% end %}\n \
    \   {% end %}\n  end\n\n  private class TimesIterator(T)\n    include Iterator(T)\n\
    \n    def initialize(@n : T)\n      tuple = {% begin %}\n                { {%\
    \ for i in 0...T.size %} T[{{i}}].zero, {% end %} }\n              {% end %}\n\
    \      @index = tuple.as(T)\n      @first = true\n    end\n\n    def next\n  \
    \    if @first\n        @first = false\n        return @index\n      end\n   \
    \   {% begin %}\n        {%\n          type = @type.type_vars[0]\n          size\
    \ = type.size\n        %}\n        {% for i in 1..size %}\n          if @index[{{size\
    \ - i}}] < @n[{{size - i}}] - 1\n            @index = {\n              {% for\
    \ j in 0...size %}\n                {% if j < size - i %}\n                  @index[{{j}}],\n\
    \                {% elsif j == size - i %}\n                  @index[{{j}}] +\
    \ 1,\n                {% else %}\n                  {{type[j]}}.zero,\n      \
    \          {% end %}\n              {% end %}\n            }\n            return\
    \ @index\n          end\n        {% end %}\n        stop\n      {% end %}\n  \
    \  end\n  end\n\n  def times\n    TimesIterator(self).new(self)\n  end\nend\n"
  code: "struct Tuple\n  def times(&block) : Nil\n    {% begin %}\n      {% for i\
    \ in 0...@type.size %}\n        {% if @type[i].has_method?(:each) %}\n       \
    \   self[{{i}}].each do |i{{i}}|\n        {% else %}\n          self[{{i}}].times\
    \ do |i{{i}}|\n        {% end %}\n      {% end %}\n      yield({% for i in 0...@type.size\
    \ %} i{{i}}, {% end %})\n      {% for i in 0...@type.size %} end {% end %}\n \
    \   {% end %}\n  end\n\n  private class TimesIterator(T)\n    include Iterator(T)\n\
    \n    def initialize(@n : T)\n      tuple = {% begin %}\n                { {%\
    \ for i in 0...T.size %} T[{{i}}].zero, {% end %} }\n              {% end %}\n\
    \      @index = tuple.as(T)\n      @first = true\n    end\n\n    def next\n  \
    \    if @first\n        @first = false\n        return @index\n      end\n   \
    \   {% begin %}\n        {%\n          type = @type.type_vars[0]\n          size\
    \ = type.size\n        %}\n        {% for i in 1..size %}\n          if @index[{{size\
    \ - i}}] < @n[{{size - i}}] - 1\n            @index = {\n              {% for\
    \ j in 0...size %}\n                {% if j < size - i %}\n                  @index[{{j}}],\n\
    \                {% elsif j == size - i %}\n                  @index[{{j}}] +\
    \ 1,\n                {% else %}\n                  {{type[j]}}.zero,\n      \
    \          {% end %}\n              {% end %}\n            }\n            return\
    \ @index\n          end\n        {% end %}\n        stop\n      {% end %}\n  \
    \  end\n  end\n\n  def times\n    TimesIterator(self).new(self)\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/tuple/times.cr
  requiredBy:
  - spec/tuple/times_spec.cr
  timestamp: '2021-07-30 10:57:41+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/tuple/times.cr
layout: document
redirect_from:
- /library/src/tuple/times.cr
- /library/src/tuple/times.cr.html
title: src/tuple/times.cr
---
