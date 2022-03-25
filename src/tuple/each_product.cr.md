---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/tuple/each_producr_spec.cr
    title: spec/tuple/each_producr_spec.cr
  - icon: ':warning:'
    path: src/template.cr
    title: src/template.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "struct Tuple\n  def each_product(&block) : Nil\n    {% begin %}\n\
    \      {% for i in 0...@type.size %}\n        self[{{i}}].each do |i{{i}}|\n \
    \     {% end %}\n      yield({% for i in 0...@type.size %} i{{i}}, {% end %})\n\
    \      {% for i in 0...@type.size %}\n        end\n      {% end %}\n    {% end\
    \ %}\n  end\n\n  private class ProductIterator(T, Begin, End)\n    include Iterator(Begin)\n\
    \n    def initialize(@n : T)\n      @index = {% begin %}\n        { {% for i in\
    \ 0...T.size %} @n[{{i}}].begin, {% end %} }\n      {% end %}.as(Begin)\n    \
    \  @end = {% begin %}\n        { {% for i in 0...T.size %} @n[{{i}}].exclusive?\
    \ ? @n[{{i}}].end.pred : @n[{{i}}].end, {% end %} }\n      {% end %}.as(End)\n\
    \      @first = true\n    end\n\n    def next\n      if @first\n        @first\
    \ = false\n        return @index\n      end\n      {% begin %}\n        {%\n \
    \         type = @type.type_vars[0]\n          size = type.size\n        %}\n\
    \        {% for i in 1..size %}\n          if @index[{{size - i}}] < @end[{{size\
    \ - i}}]\n            @index = {\n              {% for j in 0...size %}\n    \
    \            {% if j < size - i %}\n                  @index[{{j}}],\n       \
    \         {% elsif j == size - i %}\n                  @index[{{j}}] + 1,\n  \
    \              {% else %}\n                  @n[{{j}}].begin,\n              \
    \  {% end %}\n              {% end %}\n            }\n            return @index\n\
    \          end\n        {% end %}\n        stop\n      {% end %}\n    end\n  end\n\
    \n  def each_product\n    {% for type in T %}\n      {% raise \"Can't product\
    \ for not Range\" unless type < Range %}\n      {% raise \"Can't product for open\
    \ Range\" if type.type_vars[0].nilable? %}\n      {% raise \"Can't product for\
    \ open Range\" if type.type_vars[1].nilable? %}\n    {% end %}\n    ProductIterator(self,\
    \ typeof({% begin %}\n      { {% for i in 0...@type.size %} self[{{i}}].begin,{%\
    \ end %} }\n    {% end %}), typeof({% begin %}\n      { {% for i in 0...@type.size\
    \ %} self[{{i}}].end, {% end %} }\n    {% end %})).new(self)\n  end\nend\n"
  code: "struct Tuple\n  def each_product(&block) : Nil\n    {% begin %}\n      {%\
    \ for i in 0...@type.size %}\n        self[{{i}}].each do |i{{i}}|\n      {% end\
    \ %}\n      yield({% for i in 0...@type.size %} i{{i}}, {% end %})\n      {% for\
    \ i in 0...@type.size %}\n        end\n      {% end %}\n    {% end %}\n  end\n\
    \n  private class ProductIterator(T, Begin, End)\n    include Iterator(Begin)\n\
    \n    def initialize(@n : T)\n      @index = {% begin %}\n        { {% for i in\
    \ 0...T.size %} @n[{{i}}].begin, {% end %} }\n      {% end %}.as(Begin)\n    \
    \  @end = {% begin %}\n        { {% for i in 0...T.size %} @n[{{i}}].exclusive?\
    \ ? @n[{{i}}].end.pred : @n[{{i}}].end, {% end %} }\n      {% end %}.as(End)\n\
    \      @first = true\n    end\n\n    def next\n      if @first\n        @first\
    \ = false\n        return @index\n      end\n      {% begin %}\n        {%\n \
    \         type = @type.type_vars[0]\n          size = type.size\n        %}\n\
    \        {% for i in 1..size %}\n          if @index[{{size - i}}] < @end[{{size\
    \ - i}}]\n            @index = {\n              {% for j in 0...size %}\n    \
    \            {% if j < size - i %}\n                  @index[{{j}}],\n       \
    \         {% elsif j == size - i %}\n                  @index[{{j}}] + 1,\n  \
    \              {% else %}\n                  @n[{{j}}].begin,\n              \
    \  {% end %}\n              {% end %}\n            }\n            return @index\n\
    \          end\n        {% end %}\n        stop\n      {% end %}\n    end\n  end\n\
    \n  def each_product\n    {% for type in T %}\n      {% raise \"Can't product\
    \ for not Range\" unless type < Range %}\n      {% raise \"Can't product for open\
    \ Range\" if type.type_vars[0].nilable? %}\n      {% raise \"Can't product for\
    \ open Range\" if type.type_vars[1].nilable? %}\n    {% end %}\n    ProductIterator(self,\
    \ typeof({% begin %}\n      { {% for i in 0...@type.size %} self[{{i}}].begin,{%\
    \ end %} }\n    {% end %}), typeof({% begin %}\n      { {% for i in 0...@type.size\
    \ %} self[{{i}}].end, {% end %} }\n    {% end %})).new(self)\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/tuple/each_product.cr
  requiredBy:
  - src/template.cr
  - spec/tuple/each_producr_spec.cr
  timestamp: '2022-03-25 11:37:47+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/tuple/each_product.cr
layout: document
redirect_from:
- /library/src/tuple/each_product.cr
- /library/src/tuple/each_product.cr.html
title: src/tuple/each_product.cr
---
