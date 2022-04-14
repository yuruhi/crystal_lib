---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/collection/unique_permutation.cr
    title: src/collection/unique_permutation.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://yukicoder.me/problems/no/170
  bundledCode: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/170\n\
    # require \"../../src/collection/unique_permutation\"\nclass Array(T)\n  def next_permutation!\
    \ : Bool\n    i = (1...size).reverse_each.find { |i| self[i - 1] < self[i] } ||\
    \ return false\n    j = (0...size).reverse_each.find { |j| self[i - 1] < self[j]\
    \ }.not_nil!\n    swap(i - 1, j)\n    Slice.new(to_unsafe + i, size - i).reverse!\n\
    \    true\n  end\n\n  def next_permutation? : Array(T)?\n    arr = dup\n    arr.next_permutation!\
    \ ? arr : nil\n  end\n\n  def each_unique_permutation(reuse : Bool = false, &block)\
    \ : Nil\n    pool = dup\n    loop do\n      yield reuse ? pool : pool.dup\n  \
    \    break unless pool.next_permutation!\n    end\n  end\n\n  def each_unique_permutation(reuse\
    \ : Bool = false)\n    UniquePermutationIterator.new(clone, reuse)\n  end\n\n\
    \  def unique_permutations : Array(Array(T))\n    permutations = [] of Array(T)\n\
    \    each_unique_permutation { |perm| permutations << perm.dup }\n    permutations\n\
    \  end\n\n  private class UniquePermutationIterator(T)\n    include Iterator(T)\n\
    \n    @pool : T\n\n    def initialize(a : T, @reuse : Bool)\n      @pool = a.dup\n\
    \      @first = true\n    end\n\n    def next\n      if @first\n        @first\
    \ = false\n        @reuse ? @pool : @pool.dup\n      elsif @pool.next_permutation!\n\
    \        @reuse ? @pool : @pool.dup\n      else\n        stop\n      end\n   \
    \ end\n  end\nend\n\ns = read_line.chars.sort!\n\nans1 = -1\ns.each_unique_permutation\
    \ { ans1 += 1 }\n\nans2 = s.each_unique_permutation.count { true } - 1\n\nans3\
    \ = s.unique_permutations.size - 1\n\nraise \"\" unless ans1 == ans2 == ans3\n\
    \nputs ans1\n"
  code: '# verification-helper: PROBLEM https://yukicoder.me/problems/no/170

    require "../../src/collection/unique_permutation"

    s = read_line.chars.sort!


    ans1 = -1

    s.each_unique_permutation { ans1 += 1 }


    ans2 = s.each_unique_permutation.count { true } - 1


    ans3 = s.unique_permutations.size - 1


    raise "" unless ans1 == ans2 == ans3


    puts ans1

    '
  dependsOn:
  - src/collection/unique_permutation.cr
  isVerificationFile: true
  path: test/collection/unique_permutation_test.cr
  requiredBy: []
  timestamp: '2022-04-10 10:27:41+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/collection/unique_permutation_test.cr
layout: document
redirect_from:
- /verify/test/collection/unique_permutation_test.cr
- /verify/test/collection/unique_permutation_test.cr.html
title: test/collection/unique_permutation_test.cr
---
