---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/indexable/each_pair_spec.cr
    title: spec/indexable/each_pair_spec.cr
  - icon: ':warning:'
    path: src/template.cr
    title: src/template.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "module Indexable(T)\n  def each_pair(&)\n    each_with_index do |x,\
    \ i|\n      (i + 1...size).each do |j|\n        yield x, unsafe_fetch(j)\n   \
    \   end\n    end\n  end\n\n  def each_pair\n    PairIterator(self, T).new(self)\n\
    \  end\n\n  private class PairIterator(A, T)\n    include Iterator({T, T})\n\n\
    \    def initialize(@array : A)\n      @i, @j = 0, 1\n    end\n\n    def next\
    \ : {T, T} | Iterator::Stop\n      if @j >= @array.size\n        @i += 1\n   \
    \     @j = @i + 1\n      end\n      if @j >= @array.size\n        stop\n     \
    \ else\n        {@array[@i], @array[@j]}.tap { @j += 1 }\n      end\n    end\n\
    \  end\nend\n"
  code: "module Indexable(T)\n  def each_pair(&)\n    each_with_index do |x, i|\n\
    \      (i + 1...size).each do |j|\n        yield x, unsafe_fetch(j)\n      end\n\
    \    end\n  end\n\n  def each_pair\n    PairIterator(self, T).new(self)\n  end\n\
    \n  private class PairIterator(A, T)\n    include Iterator({T, T})\n\n    def\
    \ initialize(@array : A)\n      @i, @j = 0, 1\n    end\n\n    def next : {T, T}\
    \ | Iterator::Stop\n      if @j >= @array.size\n        @i += 1\n        @j =\
    \ @i + 1\n      end\n      if @j >= @array.size\n        stop\n      else\n  \
    \      {@array[@i], @array[@j]}.tap { @j += 1 }\n      end\n    end\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/indexable/each_pair.cr
  requiredBy:
  - spec/indexable/each_pair_spec.cr
  - src/template.cr
  timestamp: '2022-01-23 03:37:04+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/indexable/each_pair.cr
layout: document
redirect_from:
- /library/src/indexable/each_pair.cr
- /library/src/indexable/each_pair.cr.html
title: src/indexable/each_pair.cr
---
