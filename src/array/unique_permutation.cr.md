---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/array/unique_permutation_test.cr
    title: test/array/unique_permutation_test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "class Array(T)\n  def next_permutation! : Bool\n    i = (1...size).reverse_each.find\
    \ { |i| self[i - 1] < self[i] } || return false\n    j = (0...size).reverse_each.find\
    \ { |j| self[i - 1] < self[j] }.not_nil!\n    swap(i - 1, j)\n    Slice.new(to_unsafe\
    \ + i, size - i).reverse!\n    true\n  end\n\n  private class UniquePermutationIterator(T)\n\
    \    include Iterator(T)\n\n    def initialize(@array : T)\n      @first = true\n\
    \    end\n\n    def next\n      if @first\n        @first = false\n        @array\n\
    \      elsif @array.next_permutation!\n        @array\n      else\n        stop\n\
    \      end\n    end\n  end\n\n  def each_unique_permutation\n    UniquePermutationIterator.new(clone)\n\
    \  end\n\n  def each_unique_permutation(&block)\n    perm = clone\n    loop do\n\
    \      yield perm\n      break unless perm.next_permutation!\n    end\n  end\n\
    \n  def unique_permutations\n    permutations = [] of Array(T)\n    each_unique_permutation\
    \ { |perm| permutations << perm }\n    permutations\n  end\nend\n"
  code: "class Array(T)\n  def next_permutation! : Bool\n    i = (1...size).reverse_each.find\
    \ { |i| self[i - 1] < self[i] } || return false\n    j = (0...size).reverse_each.find\
    \ { |j| self[i - 1] < self[j] }.not_nil!\n    swap(i - 1, j)\n    Slice.new(to_unsafe\
    \ + i, size - i).reverse!\n    true\n  end\n\n  private class UniquePermutationIterator(T)\n\
    \    include Iterator(T)\n\n    def initialize(@array : T)\n      @first = true\n\
    \    end\n\n    def next\n      if @first\n        @first = false\n        @array\n\
    \      elsif @array.next_permutation!\n        @array\n      else\n        stop\n\
    \      end\n    end\n  end\n\n  def each_unique_permutation\n    UniquePermutationIterator.new(clone)\n\
    \  end\n\n  def each_unique_permutation(&block)\n    perm = clone\n    loop do\n\
    \      yield perm\n      break unless perm.next_permutation!\n    end\n  end\n\
    \n  def unique_permutations\n    permutations = [] of Array(T)\n    each_unique_permutation\
    \ { |perm| permutations << perm }\n    permutations\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/array/unique_permutation.cr
  requiredBy: []
  timestamp: '2022-01-16 04:07:26+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/array/unique_permutation_test.cr
documentation_of: src/array/unique_permutation.cr
layout: document
redirect_from:
- /library/src/array/unique_permutation.cr
- /library/src/array/unique_permutation.cr.html
title: src/array/unique_permutation.cr
---
