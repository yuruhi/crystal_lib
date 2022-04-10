---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/collection/each_pair.cr
    title: src/collection/each_pair.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../src/collection/each_pair\"\n\
    module Indexable(T)\n  def each_pair(&)\n    each_with_index do |x, i|\n     \
    \ (i + 1...size).each do |j|\n        yield x, unsafe_fetch(j)\n      end\n  \
    \  end\n  end\n\n  def each_pair\n    PairIterator(self, T).new(self)\n  end\n\
    \n  private class PairIterator(A, T)\n    include Iterator({T, T})\n\n    def\
    \ initialize(@array : A)\n      @i, @j = 0, 1\n    end\n\n    def next : {T, T}\
    \ | Iterator::Stop\n      if @j >= @array.size\n        @i += 1\n        @j =\
    \ @i + 1\n      end\n      if @j >= @array.size\n        stop\n      else\n  \
    \      {@array[@i], @array[@j]}.tap { @j += 1 }\n      end\n    end\n  end\nend\n\
    \ndescribe Indexable do\n  it \"#each_pair(&)\" do\n    result = [] of {Int32,\
    \ Int32}\n    [0, 1, 2, 3].each_pair { |i, j| result << {i, j} }\n    result.should\
    \ eq [{0, 1}, {0, 2}, {0, 3}, {1, 2}, {1, 3}, {2, 3}]\n  end\n\n  it \"#each_pair\"\
    \ do\n    [0, 1, 2, 3].each_pair.to_a.should eq [\n      {0, 1}, {0, 2}, {0, 3},\n\
    \      {1, 2}, {1, 3},\n      {2, 3},\n    ]\n    (0...1000).to_a.each_pair.max_of(&.sum).should\
    \ eq 998 + 999\n  end\nend\n"
  code: "require \"spec\"\nrequire \"../../src/collection/each_pair\"\n\ndescribe\
    \ Indexable do\n  it \"#each_pair(&)\" do\n    result = [] of {Int32, Int32}\n\
    \    [0, 1, 2, 3].each_pair { |i, j| result << {i, j} }\n    result.should eq\
    \ [{0, 1}, {0, 2}, {0, 3}, {1, 2}, {1, 3}, {2, 3}]\n  end\n\n  it \"#each_pair\"\
    \ do\n    [0, 1, 2, 3].each_pair.to_a.should eq [\n      {0, 1}, {0, 2}, {0, 3},\n\
    \      {1, 2}, {1, 3},\n      {2, 3},\n    ]\n    (0...1000).to_a.each_pair.max_of(&.sum).should\
    \ eq 998 + 999\n  end\nend\n"
  dependsOn:
  - src/collection/each_pair.cr
  isVerificationFile: false
  path: spec/collection/each_pair_spec.cr
  requiredBy: []
  timestamp: '2022-03-25 20:11:13+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/collection/each_pair_spec.cr
layout: document
redirect_from:
- /library/spec/collection/each_pair_spec.cr
- /library/spec/collection/each_pair_spec.cr.html
title: spec/collection/each_pair_spec.cr
---
