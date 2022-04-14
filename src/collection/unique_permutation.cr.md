---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/collection/unique_permutation_spec.cr
    title: spec/collection/unique_permutation_spec.cr
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/collection/unique_permutation_test.cr
    title: test/collection/unique_permutation_test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "class Array(T)\n  def next_permutation! : Bool\n    i = (1...size).reverse_each.find\
    \ { |i| self[i - 1] < self[i] } || return false\n    j = (0...size).reverse_each.find\
    \ { |j| self[i - 1] < self[j] }.not_nil!\n    swap(i - 1, j)\n    Slice.new(to_unsafe\
    \ + i, size - i).reverse!\n    true\n  end\n\n  def next_permutation? : Array(T)?\n\
    \    arr = dup\n    arr.next_permutation! ? arr : nil\n  end\n\n  def each_unique_permutation(reuse\
    \ : Bool = false, &block) : Nil\n    pool = dup\n    loop do\n      yield reuse\
    \ ? pool : pool.dup\n      break unless pool.next_permutation!\n    end\n  end\n\
    \n  def each_unique_permutation(reuse : Bool = false)\n    UniquePermutationIterator.new(clone,\
    \ reuse)\n  end\n\n  def unique_permutations : Array(Array(T))\n    permutations\
    \ = [] of Array(T)\n    each_unique_permutation { |perm| permutations << perm.dup\
    \ }\n    permutations\n  end\n\n  private class UniquePermutationIterator(T)\n\
    \    include Iterator(T)\n\n    @pool : T\n\n    def initialize(a : T, @reuse\
    \ : Bool)\n      @pool = a.dup\n      @first = true\n    end\n\n    def next\n\
    \      if @first\n        @first = false\n        @reuse ? @pool : @pool.dup\n\
    \      elsif @pool.next_permutation!\n        @reuse ? @pool : @pool.dup\n   \
    \   else\n        stop\n      end\n    end\n  end\nend\n"
  code: "class Array(T)\n  def next_permutation! : Bool\n    i = (1...size).reverse_each.find\
    \ { |i| self[i - 1] < self[i] } || return false\n    j = (0...size).reverse_each.find\
    \ { |j| self[i - 1] < self[j] }.not_nil!\n    swap(i - 1, j)\n    Slice.new(to_unsafe\
    \ + i, size - i).reverse!\n    true\n  end\n\n  def next_permutation? : Array(T)?\n\
    \    arr = dup\n    arr.next_permutation! ? arr : nil\n  end\n\n  def each_unique_permutation(reuse\
    \ : Bool = false, &block) : Nil\n    pool = dup\n    loop do\n      yield reuse\
    \ ? pool : pool.dup\n      break unless pool.next_permutation!\n    end\n  end\n\
    \n  def each_unique_permutation(reuse : Bool = false)\n    UniquePermutationIterator.new(clone,\
    \ reuse)\n  end\n\n  def unique_permutations : Array(Array(T))\n    permutations\
    \ = [] of Array(T)\n    each_unique_permutation { |perm| permutations << perm.dup\
    \ }\n    permutations\n  end\n\n  private class UniquePermutationIterator(T)\n\
    \    include Iterator(T)\n\n    @pool : T\n\n    def initialize(a : T, @reuse\
    \ : Bool)\n      @pool = a.dup\n      @first = true\n    end\n\n    def next\n\
    \      if @first\n        @first = false\n        @reuse ? @pool : @pool.dup\n\
    \      elsif @pool.next_permutation!\n        @reuse ? @pool : @pool.dup\n   \
    \   else\n        stop\n      end\n    end\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/collection/unique_permutation.cr
  requiredBy:
  - spec/collection/unique_permutation_spec.cr
  timestamp: '2022-04-14 18:17:07+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/collection/unique_permutation_test.cr
documentation_of: src/collection/unique_permutation.cr
layout: document
redirect_from:
- /library/src/collection/unique_permutation.cr
- /library/src/collection/unique_permutation.cr.html
title: src/collection/unique_permutation.cr
---
