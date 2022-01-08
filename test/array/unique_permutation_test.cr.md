---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/array/unique_permutation.cr
    title: src/array/unique_permutation.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://yukicoder.me/problems/no/170
  bundledCode: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/170\n\
    # require \"../..//src/array/unique_permutation\"\nclass Array(T)\n  def next_permutation!\
    \ : Bool\n    i = (1...size).reverse_each.find { |i| self[i - 1] < self[i] } ||\
    \ return false\n    j = (0...size).reverse_each.find { |j| self[i - 1] < self[j]\
    \ }.not_nil!\n    swap(i - 1, j)\n    Slice.new(to_unsafe + i, size - i).reverse!\n\
    \    true\n  end\n\n  private class UniquePermutationIterator(T)\n    include\
    \ Iterator(T)\n\n    def initialize(@array : T)\n      @first = true\n    end\n\
    \n    def next\n      if @first\n        @first = false\n        @array\n    \
    \  elsif @array.next_permutation!\n        @array\n      else\n        stop\n\
    \      end\n    end\n  end\n\n  def each_unique_permutation\n    UniquePermutationIterator.new(clone)\n\
    \  end\n\n  def each_unique_permutation(&block)\n    perm = clone\n    loop do\n\
    \      yield perm\n      break unless perm.next_permutation!\n    end\n  end\n\
    \n  def unique_permutations\n    permutations = [] of Array(T)\n    each_unique_permutation\
    \ { |perm| permutations << perm }\n    permutations\n  end\nend\n\ns = read_line.chars.sort!\n\
    \nans1 = -1\ns.each_unique_permutation { ans1 += 1 }\n\nans2 = s.each_unique_permutation.count\
    \ { true } - 1\n\nans3 = s.unique_permutations.size - 1\n\nraise \"\" unless ans1\
    \ == ans2 == ans3\n\nputs ans1\n"
  code: '# verification-helper: PROBLEM https://yukicoder.me/problems/no/170

    require "../..//src/array/unique_permutation"

    s = read_line.chars.sort!


    ans1 = -1

    s.each_unique_permutation { ans1 += 1 }


    ans2 = s.each_unique_permutation.count { true } - 1


    ans3 = s.unique_permutations.size - 1


    raise "" unless ans1 == ans2 == ans3


    puts ans1

    '
  dependsOn:
  - src/array/unique_permutation.cr
  isVerificationFile: true
  path: test/array/unique_permutation_test.cr
  requiredBy: []
  timestamp: '2021-10-05 18:21:29+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/array/unique_permutation_test.cr
layout: document
redirect_from:
- /verify/test/array/unique_permutation_test.cr
- /verify/test/array/unique_permutation_test.cr.html
title: test/array/unique_permutation_test.cr
---
