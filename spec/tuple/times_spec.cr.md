---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/tuple/times.cr
    title: src/tuple/times.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../src/tuple/times\"\nstruct Tuple\n\
    \  def times(&block) : Nil\n    {% begin %}\n      {% for i in 0...@type.size\
    \ %}\n        {% if @type[i].has_method?(:each) %}\n          self[{{i}}].each\
    \ do |i{{i}}|\n        {% else %}\n          self[{{i}}].times do |i{{i}}|\n \
    \       {% end %}\n      {% end %}\n      yield({% for i in 0...@type.size %}\
    \ i{{i}}, {% end %})\n      {% for i in 0...@type.size %} end {% end %}\n    {%\
    \ end %}\n  end\n\n  private class TimesIterator(T)\n    include Iterator(T)\n\
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
    \  end\n  end\n\n  def times\n    TimesIterator(self).new(self)\n  end\nend\n\n\
    describe Tuple do\n  describe \"#times(&block)\" do\n    it \"all types of tuple\
    \ are Int32\" do\n      result = [] of {Int32, Int32, Int32}\n      {1, 2, 3}.times\
    \ do |i, j, k|\n        result << {i, j, k}\n      end\n      result.should eq\
    \ [\n        {0, 0, 0}, {0, 0, 1}, {0, 0, 2},\n        {0, 1, 0}, {0, 1, 1}, {0,\
    \ 1, 2},\n      ]\n    end\n\n    it \"types of tuple are Int\" do\n      result\
    \ = [] of {Int32, Int32, Int64}\n      {1, 2, 3i64}.times do |i, j, k|\n     \
    \   typeof(i).should eq Int32\n        typeof(j).should eq Int32\n        typeof(k).should\
    \ eq Int64\n        result << {i, j, k}\n      end\n      result.should eq [\n\
    \        {0, 0, 0}, {0, 0, 1}, {0, 0, 2},\n        {0, 1, 0}, {0, 1, 1}, {0, 1,\
    \ 2},\n      ]\n    end\n\n    it \"types of tuple are class that has #each\"\
    \ do\n      result = [] of {Int32, Int32, Int64}\n      {1..2, [3, 4], {5i64,\
    \ 6i64}}.times do |i, j, k|\n        typeof(i).should eq Int32\n        typeof(j).should\
    \ eq Int32\n        typeof(k).should eq Int64\n        result << {i, j, k}\n \
    \     end\n      result.should eq [\n        {1, 3, 5}, {1, 3, 6}, {1, 4, 5},\
    \ {1, 4, 6},\n        {2, 3, 5}, {2, 3, 6}, {2, 4, 5}, {2, 4, 6},\n      ]\n \
    \   end\n  end\n\n  describe \"#each\" do\n    it \"all types of tuple are Int32\"\
    \ do\n      {1, 2, 3}.times.to_a.should eq [\n        {0, 0, 0}, {0, 0, 1}, {0,\
    \ 0, 2},\n        {0, 1, 0}, {0, 1, 1}, {0, 1, 2},\n      ]\n    end\n\n    it\
    \ \"types of tuple are mixed\" do\n      {1, 2u8, 3i64}.times.to_a.should eq [\n\
    \        {0, 0, 0}, {0, 0, 1}, {0, 0, 2},\n        {0, 1, 0}, {0, 1, 1}, {0, 1,\
    \ 2},\n      ]\n      {1, 2u8, 3i64}.times.each do |i, j, k|\n        typeof(i).should\
    \ eq Int32\n        typeof(j).should eq UInt8\n        typeof(k).should eq Int64\n\
    \      end\n    end\n  end\nend\n"
  code: "require \"spec\"\nrequire \"../../src/tuple/times\"\n\ndescribe Tuple do\n\
    \  describe \"#times(&block)\" do\n    it \"all types of tuple are Int32\" do\n\
    \      result = [] of {Int32, Int32, Int32}\n      {1, 2, 3}.times do |i, j, k|\n\
    \        result << {i, j, k}\n      end\n      result.should eq [\n        {0,\
    \ 0, 0}, {0, 0, 1}, {0, 0, 2},\n        {0, 1, 0}, {0, 1, 1}, {0, 1, 2},\n   \
    \   ]\n    end\n\n    it \"types of tuple are Int\" do\n      result = [] of {Int32,\
    \ Int32, Int64}\n      {1, 2, 3i64}.times do |i, j, k|\n        typeof(i).should\
    \ eq Int32\n        typeof(j).should eq Int32\n        typeof(k).should eq Int64\n\
    \        result << {i, j, k}\n      end\n      result.should eq [\n        {0,\
    \ 0, 0}, {0, 0, 1}, {0, 0, 2},\n        {0, 1, 0}, {0, 1, 1}, {0, 1, 2},\n   \
    \   ]\n    end\n\n    it \"types of tuple are class that has #each\" do\n    \
    \  result = [] of {Int32, Int32, Int64}\n      {1..2, [3, 4], {5i64, 6i64}}.times\
    \ do |i, j, k|\n        typeof(i).should eq Int32\n        typeof(j).should eq\
    \ Int32\n        typeof(k).should eq Int64\n        result << {i, j, k}\n    \
    \  end\n      result.should eq [\n        {1, 3, 5}, {1, 3, 6}, {1, 4, 5}, {1,\
    \ 4, 6},\n        {2, 3, 5}, {2, 3, 6}, {2, 4, 5}, {2, 4, 6},\n      ]\n    end\n\
    \  end\n\n  describe \"#each\" do\n    it \"all types of tuple are Int32\" do\n\
    \      {1, 2, 3}.times.to_a.should eq [\n        {0, 0, 0}, {0, 0, 1}, {0, 0,\
    \ 2},\n        {0, 1, 0}, {0, 1, 1}, {0, 1, 2},\n      ]\n    end\n\n    it \"\
    types of tuple are mixed\" do\n      {1, 2u8, 3i64}.times.to_a.should eq [\n \
    \       {0, 0, 0}, {0, 0, 1}, {0, 0, 2},\n        {0, 1, 0}, {0, 1, 1}, {0, 1,\
    \ 2},\n      ]\n      {1, 2u8, 3i64}.times.each do |i, j, k|\n        typeof(i).should\
    \ eq Int32\n        typeof(j).should eq UInt8\n        typeof(k).should eq Int64\n\
    \      end\n    end\n  end\nend\n"
  dependsOn:
  - src/tuple/times.cr
  isVerificationFile: false
  path: spec/tuple/times_spec.cr
  requiredBy: []
  timestamp: '2021-07-24 16:21:01+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/tuple/times_spec.cr
layout: document
redirect_from:
- /library/spec/tuple/times_spec.cr
- /library/spec/tuple/times_spec.cr.html
title: spec/tuple/times_spec.cr
---
