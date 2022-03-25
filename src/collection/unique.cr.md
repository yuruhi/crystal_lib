---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/collection/unique_spec.cr
    title: spec/collection/unique_spec.cr
  - icon: ':warning:'
    path: src/template.cr
    title: src/template.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "module Enumerable(T)\n  def unique : self\n    unique(&.itself)\n\
    \  end\n\n  def unique(&) : self\n    last = uninitialized T\n    each_with_object([]\
    \ of T) do |v, ary|\n      now = yield v\n      if ary.empty? || last != now\n\
    \        last = now\n        ary << v\n      end\n    end\n  end\nend\n\nmodule\
    \ Iterator(T)\n  def unique\n    unique &.itself\n  end\n\n  def unique(&func\
    \ : T -> U) forall U\n    Unique(typeof(self), T, U).new(self, func)\n  end\n\n\
    \  private struct Unique(I, T, U)\n    include Iterator(T)\n    include IteratorWrapper\n\
    \n    def initialize(@iterator : I, @func : T -> U)\n      @first = true\n   \
    \   @prev_func_value = uninitialized U\n    end\n\n    def next\n      loop do\n\
    \        value = wrapped_next\n        func_value = @func.call value\n       \
    \ if @first || func_value != @prev_func_value\n          @first = false\n    \
    \      @prev_func_value = func_value\n          return value\n        end\n  \
    \    end\n    end\n  end\nend\n"
  code: "module Enumerable(T)\n  def unique : self\n    unique(&.itself)\n  end\n\n\
    \  def unique(&) : self\n    last = uninitialized T\n    each_with_object([] of\
    \ T) do |v, ary|\n      now = yield v\n      if ary.empty? || last != now\n  \
    \      last = now\n        ary << v\n      end\n    end\n  end\nend\n\nmodule\
    \ Iterator(T)\n  def unique\n    unique &.itself\n  end\n\n  def unique(&func\
    \ : T -> U) forall U\n    Unique(typeof(self), T, U).new(self, func)\n  end\n\n\
    \  private struct Unique(I, T, U)\n    include Iterator(T)\n    include IteratorWrapper\n\
    \n    def initialize(@iterator : I, @func : T -> U)\n      @first = true\n   \
    \   @prev_func_value = uninitialized U\n    end\n\n    def next\n      loop do\n\
    \        value = wrapped_next\n        func_value = @func.call value\n       \
    \ if @first || func_value != @prev_func_value\n          @first = false\n    \
    \      @prev_func_value = func_value\n          return value\n        end\n  \
    \    end\n    end\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/collection/unique.cr
  requiredBy:
  - src/template.cr
  - spec/collection/unique_spec.cr
  timestamp: '2022-03-25 11:37:47+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/collection/unique.cr
layout: document
redirect_from:
- /library/src/collection/unique.cr
- /library/src/collection/unique.cr.html
title: src/collection/unique.cr
---
