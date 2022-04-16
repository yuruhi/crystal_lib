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
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../src/collection/unique_permutation\"\
    \nclass Array(T)\n  def next_permutation! : Bool\n    i = (1...size).reverse_each.find\
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
    \   else\n        stop\n      end\n    end\n  end\nend\n\ndescribe Array do\n\
    \  rng = Random.new(42)\n  arrays = [\n    [] of Int32,\n    [0],\n    [0, 0],\n\
    \    (0...8).to_a,\n  ] + Array.new(100) {\n    Array.new(8) { rng.rand(3) }\n\
    \  }\n\n  it \"#next_unique_permutation, #each_unique_permutation\" do\n    arrays.each\
    \ do |a|\n      perms = a.sort.permutations.uniq!.skip_while(&.!= a)\n\n     \
    \ b, i = a.dup, 0\n      while i + 1 < perms.size\n        b.next_permutation!.should\
    \ be_true\n        b.should eq perms[i += 1]\n      end\n      b.next_permutation!.should\
    \ be_false\n      b.should eq perms.last\n\n      b, i = a.dup, 0\n      while\
    \ i + 1 < perms.size\n        (b = b.next_permutation?.not_nil!).should eq perms[i\
    \ += 1]\n      end\n      b.next_permutation?.should be_nil\n\n      a.unique_permutations.should\
    \ eq perms\n\n      a.each_unique_permutation.to_a.should eq perms\n      i =\
    \ 0\n      a.each_unique_permutation(true).each do |b|\n        b.should eq perms[i]\n\
    \        i += 1\n      end\n\n      i = 0\n      a.each_unique_permutation do\
    \ |b|\n        b.should eq perms[i]\n        i += 1\n      end\n      i = 0\n\
    \      a.each_unique_permutation(reuse: true) do |b|\n        b.should eq perms[i]\n\
    \        i += 1\n      end\n    end\n  end\nend\n"
  code: "require \"spec\"\nrequire \"../../src/collection/unique_permutation\"\n\n\
    describe Array do\n  rng = Random.new(42)\n  arrays = [\n    [] of Int32,\n  \
    \  [0],\n    [0, 0],\n    (0...8).to_a,\n  ] + Array.new(100) {\n    Array.new(8)\
    \ { rng.rand(3) }\n  }\n\n  it \"#next_unique_permutation, #each_unique_permutation\"\
    \ do\n    arrays.each do |a|\n      perms = a.sort.permutations.uniq!.skip_while(&.!=\
    \ a)\n\n      b, i = a.dup, 0\n      while i + 1 < perms.size\n        b.next_permutation!.should\
    \ be_true\n        b.should eq perms[i += 1]\n      end\n      b.next_permutation!.should\
    \ be_false\n      b.should eq perms.last\n\n      b, i = a.dup, 0\n      while\
    \ i + 1 < perms.size\n        (b = b.next_permutation?.not_nil!).should eq perms[i\
    \ += 1]\n      end\n      b.next_permutation?.should be_nil\n\n      a.unique_permutations.should\
    \ eq perms\n\n      a.each_unique_permutation.to_a.should eq perms\n      i =\
    \ 0\n      a.each_unique_permutation(true).each do |b|\n        b.should eq perms[i]\n\
    \        i += 1\n      end\n\n      i = 0\n      a.each_unique_permutation do\
    \ |b|\n        b.should eq perms[i]\n        i += 1\n      end\n      i = 0\n\
    \      a.each_unique_permutation(reuse: true) do |b|\n        b.should eq perms[i]\n\
    \        i += 1\n      end\n    end\n  end\nend\n"
  dependsOn:
  - src/collection/unique_permutation.cr
  isVerificationFile: false
  path: spec/collection/unique_permutation_spec.cr
  requiredBy: []
  timestamp: '2022-04-10 10:27:41+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/collection/unique_permutation_spec.cr
layout: document
redirect_from:
- /library/spec/collection/unique_permutation_spec.cr
- /library/spec/collection/unique_permutation_spec.cr.html
title: spec/collection/unique_permutation_spec.cr
---
