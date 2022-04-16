---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/tuple/each_product.cr
    title: src/tuple/each_product.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../src/tuple/each_product\"\nstruct\
    \ Tuple\n  def each_product(&block) : Nil\n    {% begin %}\n      {% for i in\
    \ 0...@type.size %}\n        self[{{i}}].each do |i{{i}}|\n      {% end %}\n \
    \     yield({% for i in 0...@type.size %} i{{i}}, {% end %})\n      {% for i in\
    \ 0...@type.size %}\n        end\n      {% end %}\n    {% end %}\n  end\n\n  private\
    \ class ProductIterator(T, Begin, End)\n    include Iterator(Begin)\n\n    def\
    \ initialize(@n : T)\n      @index = {% begin %}\n        { {% for i in 0...T.size\
    \ %} @n[{{i}}].begin, {% end %} }\n      {% end %}.as(Begin)\n      @end = {%\
    \ begin %}\n        { {% for i in 0...T.size %} @n[{{i}}].exclusive? ? @n[{{i}}].end.pred\
    \ : @n[{{i}}].end, {% end %} }\n      {% end %}.as(End)\n      @first = true\n\
    \    end\n\n    def next\n      if @first\n        @first = false\n        return\
    \ @index\n      end\n      {% begin %}\n        {%\n          type = @type.type_vars[0]\n\
    \          size = type.size\n        %}\n        {% for i in 1..size %}\n    \
    \      if @index[{{size - i}}] < @end[{{size - i}}]\n            @index = {\n\
    \              {% for j in 0...size %}\n                {% if j < size - i %}\n\
    \                  @index[{{j}}],\n                {% elsif j == size - i %}\n\
    \                  @index[{{j}}] + 1,\n                {% else %}\n          \
    \        @n[{{j}}].begin,\n                {% end %}\n              {% end %}\n\
    \            }\n            return @index\n          end\n        {% end %}\n\
    \        stop\n      {% end %}\n    end\n  end\n\n  def each_product\n    {% for\
    \ type in T %}\n      {% raise \"Can't product for not Range\" unless type < Range\
    \ %}\n      {% raise \"Can't product for open Range\" if type.type_vars[0].nilable?\
    \ %}\n      {% raise \"Can't product for open Range\" if type.type_vars[1].nilable?\
    \ %}\n    {% end %}\n    ProductIterator(self, typeof({% begin %}\n      { {%\
    \ for i in 0...@type.size %} self[{{i}}].begin,{% end %} }\n    {% end %}), typeof({%\
    \ begin %}\n      { {% for i in 0...@type.size %} self[{{i}}].end, {% end %} }\n\
    \    {% end %})).new(self)\n  end\nend\n\ndescribe Tuple do\n  it \"#product_each(&block)\"\
    \ do\n    result = [] of {Int32, Int32, Int64}\n    {1..2, [3, 4], {5i64, 6i64}}.each_product\
    \ do |i, j, k|\n      i.should be_a Int32\n      j.should be_a Int32\n      k.should\
    \ be_a Int64\n      result << {i, j, k}\n    end\n    result.should eq [\n   \
    \   {1, 3, 5}, {1, 3, 6}, {1, 4, 5}, {1, 4, 6},\n      {2, 3, 5}, {2, 3, 6}, {2,\
    \ 4, 5}, {2, 4, 6},\n    ]\n  end\n\n  it \"#product_each\" do\n    {1..2, 3...5}.each_product.to_a.should\
    \ eq [\n      {1, 3}, {1, 4}, {2, 3}, {2, 4},\n    ]\n    typeof({1i32..2u32,\
    \ 3i64...5u64}.each_product).should be < Iterator({Int32, Int64})\n  end\nend\n"
  code: "require \"spec\"\nrequire \"../../src/tuple/each_product\"\n\ndescribe Tuple\
    \ do\n  it \"#product_each(&block)\" do\n    result = [] of {Int32, Int32, Int64}\n\
    \    {1..2, [3, 4], {5i64, 6i64}}.each_product do |i, j, k|\n      i.should be_a\
    \ Int32\n      j.should be_a Int32\n      k.should be_a Int64\n      result <<\
    \ {i, j, k}\n    end\n    result.should eq [\n      {1, 3, 5}, {1, 3, 6}, {1,\
    \ 4, 5}, {1, 4, 6},\n      {2, 3, 5}, {2, 3, 6}, {2, 4, 5}, {2, 4, 6},\n    ]\n\
    \  end\n\n  it \"#product_each\" do\n    {1..2, 3...5}.each_product.to_a.should\
    \ eq [\n      {1, 3}, {1, 4}, {2, 3}, {2, 4},\n    ]\n    typeof({1i32..2u32,\
    \ 3i64...5u64}.each_product).should be < Iterator({Int32, Int64})\n  end\nend\n"
  dependsOn:
  - src/tuple/each_product.cr
  isVerificationFile: false
  path: spec/tuple/each_producr_spec.cr
  requiredBy: []
  timestamp: '2022-04-14 22:36:43+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/tuple/each_producr_spec.cr
layout: document
redirect_from:
- /library/spec/tuple/each_producr_spec.cr
- /library/spec/tuple/each_producr_spec.cr.html
title: spec/tuple/each_producr_spec.cr
---
