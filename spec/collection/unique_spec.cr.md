---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/collection/unique.cr
    title: src/collection/unique.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../src/collection/unique\"\nmodule\
    \ Enumerable(T)\n  def unique : self\n    unique(&.itself)\n  end\n\n  def unique(&)\
    \ : self\n    last = uninitialized T\n    each_with_object([] of T) do |v, ary|\n\
    \      now = yield v\n      if ary.empty? || last != now\n        last = now\n\
    \        ary << v\n      end\n    end\n  end\nend\n\nmodule Iterator(T)\n  def\
    \ unique\n    unique &.itself\n  end\n\n  def unique(&func : T -> U) forall U\n\
    \    Unique(typeof(self), T, U).new(self, func)\n  end\n\n  private struct Unique(I,\
    \ T, U)\n    include Iterator(T)\n    include IteratorWrapper\n\n    def initialize(@iterator\
    \ : I, @func : T -> U)\n      @first = true\n      @prev_func_value = uninitialized\
    \ U\n    end\n\n    def next\n      loop do\n        value = wrapped_next\n  \
    \      func_value = @func.call value\n        if @first || func_value != @prev_func_value\n\
    \          @first = false\n          @prev_func_value = func_value\n         \
    \ return value\n        end\n      end\n    end\n  end\nend\n\ndescribe Enumerable\
    \ do\n  it \"#unique\" do\n    [0, 0, 1, 1, 0, 0].unique.should eq [0, 1, 0]\n\
    \    [0].unique.should eq [0]\n    [0, 0, nil, nil, 0, 0, nil, nil].unique.should\
    \ eq [0, nil, 0, nil]\n    Array(Int32).new.unique.should be_empty\n  end\n\n\
    \  it \"#unique(&)\" do\n    [0, 2, 1, 3, 0, 0, 2].unique(&.% 2).should eq [0,\
    \ 1, 0]\n    [0, 1, 2, 3, 4].unique { 42 }.should eq [0]\n    [0].unique(&.itself).should\
    \ eq [0]\n    Array(Int32).new.unique { raise \"\" }.should be_empty\n  end\n\
    end\n\ndescribe Iterator do\n  it \"#unique\" do\n    [0, 0, 1, 1, 0, 0].each.unique.to_a.should\
    \ eq [0, 1, 0]\n    [0].each.unique.to_a.should eq [0]\n    [0, 0, nil, nil, 0,\
    \ 0, nil, nil].each.unique.to_a.should eq [0, nil, 0, nil]\n    Array(Int32).new.each.unique.to_a.should\
    \ be_empty\n  end\n\n  it \"#unique(&)\" do\n    [0, 2, 1, 3, 0, 0, 2].each.unique(&.%\
    \ 2).to_a.should eq [0, 1, 0]\n    [0, 1, 2, 3, 4].each.unique { 42 }.to_a.should\
    \ eq [0]\n    [0].each.unique(&.itself).to_a.should eq [0]\n    Array(Int32).new.each.unique\
    \ { raise \"\" }.to_a.should be_empty\n  end\nend\n"
  code: "require \"spec\"\nrequire \"../../src/collection/unique\"\n\ndescribe Enumerable\
    \ do\n  it \"#unique\" do\n    [0, 0, 1, 1, 0, 0].unique.should eq [0, 1, 0]\n\
    \    [0].unique.should eq [0]\n    [0, 0, nil, nil, 0, 0, nil, nil].unique.should\
    \ eq [0, nil, 0, nil]\n    Array(Int32).new.unique.should be_empty\n  end\n\n\
    \  it \"#unique(&)\" do\n    [0, 2, 1, 3, 0, 0, 2].unique(&.% 2).should eq [0,\
    \ 1, 0]\n    [0, 1, 2, 3, 4].unique { 42 }.should eq [0]\n    [0].unique(&.itself).should\
    \ eq [0]\n    Array(Int32).new.unique { raise \"\" }.should be_empty\n  end\n\
    end\n\ndescribe Iterator do\n  it \"#unique\" do\n    [0, 0, 1, 1, 0, 0].each.unique.to_a.should\
    \ eq [0, 1, 0]\n    [0].each.unique.to_a.should eq [0]\n    [0, 0, nil, nil, 0,\
    \ 0, nil, nil].each.unique.to_a.should eq [0, nil, 0, nil]\n    Array(Int32).new.each.unique.to_a.should\
    \ be_empty\n  end\n\n  it \"#unique(&)\" do\n    [0, 2, 1, 3, 0, 0, 2].each.unique(&.%\
    \ 2).to_a.should eq [0, 1, 0]\n    [0, 1, 2, 3, 4].each.unique { 42 }.to_a.should\
    \ eq [0]\n    [0].each.unique(&.itself).to_a.should eq [0]\n    Array(Int32).new.each.unique\
    \ { raise \"\" }.to_a.should be_empty\n  end\nend\n"
  dependsOn:
  - src/collection/unique.cr
  isVerificationFile: false
  path: spec/collection/unique_spec.cr
  requiredBy: []
  timestamp: '2022-04-14 22:36:43+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/collection/unique_spec.cr
layout: document
redirect_from:
- /library/spec/collection/unique_spec.cr
- /library/spec/collection/unique_spec.cr.html
title: spec/collection/unique_spec.cr
---
