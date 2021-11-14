---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/math/prime.cr
    title: src/math/prime.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../src/math/prime\"\nmodule Prime\n\
    \  extend self\n  include Indexable(Int32)\n\n  @@primes = [\n    2, 3, 5, 7,\
    \ 11, 13, 17, 19, 23, 29,\n    31, 37, 41, 43, 47, 53, 59, 61, 67, 71,\n    73,\
    \ 79, 83, 89, 97, 101, 103, 107, 109, 113,\n    127, 131, 137, 139, 149, 151,\
    \ 157, 163, 167, 173,\n    179, 181, 191, 193, 197, 199, 211, 223, 227, 229,\n\
    \    233, 239, 241, 251, 257, 263, 269, 271, 277, 281,\n    283, 293, 307, 311,\
    \ 313, 317, 331, 337, 347, 349,\n    353, 359, 367, 373, 379, 383, 389, 397, 401,\
    \ 409,\n    419, 421, 431, 433, 439, 443, 449, 457, 461, 463,\n    467, 479, 487,\
    \ 491, 499, 503, 509, 521, 523, 541,\n    547, 557, 563, 569, 571, 577, 587, 593,\
    \ 599, 601,\n    607, 613, 617, 619, 631, 641, 643, 647, 653, 659,\n    661, 673,\
    \ 677, 683, 691, 701, 709, 719, 727, 733,\n    739, 743, 751, 757, 761, 769, 773,\
    \ 787, 797, 809,\n    811, 821, 823, 827, 829, 839, 853, 857, 859, 863,\n    877,\
    \ 881, 883, 887, 907, 911, 919, 929, 937, 941,\n    947, 953, 967, 971, 977, 983,\
    \ 991, 997,\n  ]\n\n  private def generate_primes : Nil\n    size = @@primes.size\n\
    \    primes = Array.new(size) { |i| @@primes.last + (i + 1) * 2 }\n    last =\
    \ primes.last\n\n    @@primes.each do |prime|\n      next if prime == 2\n    \
    \  break if prime * prime > last\n      from = prime * ((@@primes.last // prime\
    \ + 1) // 2 * 2 + 1)\n      from.step(to: last, by: prime * 2) do |x|\n      \
    \  primes[~((last - x) // 2)] = 0\n      end\n    end\n\n    @@primes.concat primes.reject(0)\n\
    \  end\n\n  private def generate_until(*, index : Int)\n    while @@primes.size\
    \ <= index\n      generate_primes\n    end\n  end\n\n  private def generate_until(*,\
    \ value : Int)\n    while @@primes.last < value\n      generate_primes\n    end\n\
    \  end\n\n  private def check_index_out_of_bounds(index)\n    if 0 <= index <\
    \ size\n      index\n    else\n      yield\n    end\n  end\n\n  # Returns the\
    \ *index* th prime, without doing any bounds check.\n  def unsafe_fetch(index\
    \ : Int) : Int32\n    generate_until(index: index)\n    @@primes.unsafe_fetch(index)\n\
    \  end\n\n  # Returns the limit of size.\n  def size : Int32\n    10**9\n  end\n\
    \n  def []?(start : Int, count : Int) : Array(Int32)?\n    raise ArgumentError.new\
    \ \"Negative count: #{count}\" if count < 0\n    return [] of Int32 if start ==\
    \ size\n\n    if 0 <= start <= size\n      return [] of Int32 if count == 0\n\n\
    \      count = Math.min(count, size - start)\n      generate_until(index: start\
    \ + count)\n\n      Array(Int32).build(count) do |buffer|\n        buffer.copy_from(@@primes.to_unsafe\
    \ + start, count)\n        count\n      end\n    end\n  end\n\n  def [](start\
    \ : Int, count : Int) : Array(Int32)\n    self[start, count]? || raise IndexError.new\n\
    \  end\n\n  private def self.range_to_index_and_count(range : Range, size : Int)\n\
    \    end_index = range.end || raise ArgumentError.new\n    end_index -= 1 if range.excludes_end?\n\
    \    start_index = range.begin || 0\n    raise IndexError.new unless start_index\
    \ >= 0\n    count = Math.max(end_index - start_index + 1, 0)\n    {start_index,\
    \ count}\n  end\n\n  def []?(range : Range) : Array(Int32)?\n    self[*range_to_index_and_count(range,\
    \ size)]?\n  end\n\n  def [](range : Range) : Array(Int32)\n    self[*range_to_index_and_count(range,\
    \ size)]\n  end\n\n  def includes?(x : Int) : Bool\n    generate_until(value:\
    \ x)\n    @@primes.bsearch { |y| y >= x } == x\n  end\n\n  def index(x : Int)\
    \ : Int32?\n    generate_until(value: x)\n    i = @@primes.bsearch_index { |y|\
    \ y >= x }.not_nil!\n    @@primes[i] == x ? i : nil\n  end\n\n  def each(x : Int,\
    \ &) : Nil\n    i = 0\n    loop do\n      generate_primes if @@primes.size ==\
    \ i\n      prime = @@primes.unsafe_fetch(i)\n      break if prime > x\n      yield\
    \ prime\n      i += 1\n    end\n  end\n\n  def each(x : Int)\n    each.take_while\
    \ { |prime| prime <= x }\n  end\nend\n\ndescribe Prime do\n  it \"#unsafe_fetch(i)\"\
    \ do\n    Prime.unsafe_fetch(0).should eq 2\n    Prime.unsafe_fetch(1).should\
    \ eq 3\n    Prime.unsafe_fetch(2).should eq 5\n    Prime.unsafe_fetch(999999).should\
    \ eq 15485863\n  end\n\n  it \"#size\" do\n    Prime.size.should eq 10**9\n  end\n\
    \n  it \"#each(x, &)\" do\n    primes = [] of Int32\n    Prime.each(20) { |x|\
    \ primes << x }\n    primes.should eq [2, 3, 5, 7, 11, 13, 17, 19]\n  end\n\n\
    \  it \"#each(x)\" do\n    Prime.each(20).to_a.should eq [2, 3, 5, 7, 11, 13,\
    \ 17, 19]\n    Prime.each(20).index(19).should eq 7\n    Prime.each(20).index(23).should\
    \ be_nil\n    Prime.each(10**8).size.should eq 5761455\n  end\n\n  describe \"\
    includes Indexable\" do\n    it \"#[](i)\" do\n      Prime[0].should eq 2\n  \
    \    Prime[1].should eq 3\n      Prime[2].should eq 5\n      expect_raises(IndexError)\
    \ { Prime[-1] }\n      expect_raises(IndexError) { Prime[10**9] }\n    end\n\n\
    \    it \"#first\" do\n      Prime.first.should eq 2\n    end\n  end\n\n  it \"\
    #[]?(start, count)\" do\n    Prime[0, 3]?.should eq [2, 3, 5]\n    Prime[1, 3]?.should\
    \ eq [3, 5, 7]\n    Prime[2, 3]?.should eq [5, 7, 11]\n    Prime[-2, 3]?.should\
    \ be_nil\n    expect_raises(ArgumentError) { Prime[0, -3]? }\n  end\n\n  it \"\
    #[](start, count)\" do\n    Prime[0, 3].should eq [2, 3, 5]\n    Prime[1, 3].should\
    \ eq [3, 5, 7]\n    Prime[2, 3].should eq [5, 7, 11]\n    expect_raises(IndexError)\
    \ { Prime[-2, 3] }\n    expect_raises(ArgumentError) { Prime[0, -3] }\n  end\n\
    \n  it \"#[]?(range)\" do\n    Prime[0...3]?.should eq [2, 3, 5]\n    Prime[1...4]?.should\
    \ eq [3, 5, 7]\n    Prime[2...5]?.should eq [5, 7, 11]\n    Prime[0..-3]?.should\
    \ eq [] of Int32\n    Prime[5..2]?.should eq [] of Int32\n    Prime[...3]?.should\
    \ eq [2, 3, 5]\n    Prime[...-3]?.should eq [] of Int32\n    expect_raises(IndexError)\
    \ { Prime[-2..3]? }\n    expect_raises(ArgumentError) { Prime[3..]? }\n  end\n\
    \n  it \"#[](range)\" do\n    Prime[0...3].should eq [2, 3, 5]\n    Prime[1...4].should\
    \ eq [3, 5, 7]\n    Prime[2...5].should eq [5, 7, 11]\n    Prime[0..-3].should\
    \ eq [] of Int32\n    Prime[5..2].should eq [] of Int32\n    Prime[...3].should\
    \ eq [2, 3, 5]\n    Prime[...-3].should eq [] of Int32\n    expect_raises(IndexError)\
    \ { Prime[-2..3] }\n    expect_raises(ArgumentError) { Prime[3..] }\n  end\n\n\
    \  it \"#includes?(x)\" do\n    Prime.includes?(-10**9).should be_false\n    Prime.includes?(-1).should\
    \ be_false\n    Prime.includes?(0).should be_false\n    Prime.includes?(57).should\
    \ be_false\n    Prime.includes?(91).should be_false\n    Prime.includes?(9943081).should\
    \ be_false\n\n    Prime.includes?(13).should be_true\n    Prime.includes?(10**6\
    \ + 3).should be_true\n    Prime.includes?(10**8 + 7).should be_true\n  end\n\n\
    \  it \"#index(x)\" do\n    Prime.index(2).should eq 0\n    Prime.index(3).should\
    \ eq 1\n    Prime.index(5).should eq 2\n    Prime.index(7).should eq 3\n    Prime.index(10**8\
    \ + 7).should eq 5761455\n\n    Prime.index(-10**9).should be_nil\n    Prime.index(-1).should\
    \ be_nil\n    Prime.index(0).should be_nil\n    Prime.index(1).should be_nil\n\
    \    Prime.index(57).should be_nil\n    Prime.index(91).should be_nil\n    Prime.index(9943081).should\
    \ be_nil\n  end\nend\n"
  code: "require \"spec\"\nrequire \"../../src/math/prime\"\n\ndescribe Prime do\n\
    \  it \"#unsafe_fetch(i)\" do\n    Prime.unsafe_fetch(0).should eq 2\n    Prime.unsafe_fetch(1).should\
    \ eq 3\n    Prime.unsafe_fetch(2).should eq 5\n    Prime.unsafe_fetch(999999).should\
    \ eq 15485863\n  end\n\n  it \"#size\" do\n    Prime.size.should eq 10**9\n  end\n\
    \n  it \"#each(x, &)\" do\n    primes = [] of Int32\n    Prime.each(20) { |x|\
    \ primes << x }\n    primes.should eq [2, 3, 5, 7, 11, 13, 17, 19]\n  end\n\n\
    \  it \"#each(x)\" do\n    Prime.each(20).to_a.should eq [2, 3, 5, 7, 11, 13,\
    \ 17, 19]\n    Prime.each(20).index(19).should eq 7\n    Prime.each(20).index(23).should\
    \ be_nil\n    Prime.each(10**8).size.should eq 5761455\n  end\n\n  describe \"\
    includes Indexable\" do\n    it \"#[](i)\" do\n      Prime[0].should eq 2\n  \
    \    Prime[1].should eq 3\n      Prime[2].should eq 5\n      expect_raises(IndexError)\
    \ { Prime[-1] }\n      expect_raises(IndexError) { Prime[10**9] }\n    end\n\n\
    \    it \"#first\" do\n      Prime.first.should eq 2\n    end\n  end\n\n  it \"\
    #[]?(start, count)\" do\n    Prime[0, 3]?.should eq [2, 3, 5]\n    Prime[1, 3]?.should\
    \ eq [3, 5, 7]\n    Prime[2, 3]?.should eq [5, 7, 11]\n    Prime[-2, 3]?.should\
    \ be_nil\n    expect_raises(ArgumentError) { Prime[0, -3]? }\n  end\n\n  it \"\
    #[](start, count)\" do\n    Prime[0, 3].should eq [2, 3, 5]\n    Prime[1, 3].should\
    \ eq [3, 5, 7]\n    Prime[2, 3].should eq [5, 7, 11]\n    expect_raises(IndexError)\
    \ { Prime[-2, 3] }\n    expect_raises(ArgumentError) { Prime[0, -3] }\n  end\n\
    \n  it \"#[]?(range)\" do\n    Prime[0...3]?.should eq [2, 3, 5]\n    Prime[1...4]?.should\
    \ eq [3, 5, 7]\n    Prime[2...5]?.should eq [5, 7, 11]\n    Prime[0..-3]?.should\
    \ eq [] of Int32\n    Prime[5..2]?.should eq [] of Int32\n    Prime[...3]?.should\
    \ eq [2, 3, 5]\n    Prime[...-3]?.should eq [] of Int32\n    expect_raises(IndexError)\
    \ { Prime[-2..3]? }\n    expect_raises(ArgumentError) { Prime[3..]? }\n  end\n\
    \n  it \"#[](range)\" do\n    Prime[0...3].should eq [2, 3, 5]\n    Prime[1...4].should\
    \ eq [3, 5, 7]\n    Prime[2...5].should eq [5, 7, 11]\n    Prime[0..-3].should\
    \ eq [] of Int32\n    Prime[5..2].should eq [] of Int32\n    Prime[...3].should\
    \ eq [2, 3, 5]\n    Prime[...-3].should eq [] of Int32\n    expect_raises(IndexError)\
    \ { Prime[-2..3] }\n    expect_raises(ArgumentError) { Prime[3..] }\n  end\n\n\
    \  it \"#includes?(x)\" do\n    Prime.includes?(-10**9).should be_false\n    Prime.includes?(-1).should\
    \ be_false\n    Prime.includes?(0).should be_false\n    Prime.includes?(57).should\
    \ be_false\n    Prime.includes?(91).should be_false\n    Prime.includes?(9943081).should\
    \ be_false\n\n    Prime.includes?(13).should be_true\n    Prime.includes?(10**6\
    \ + 3).should be_true\n    Prime.includes?(10**8 + 7).should be_true\n  end\n\n\
    \  it \"#index(x)\" do\n    Prime.index(2).should eq 0\n    Prime.index(3).should\
    \ eq 1\n    Prime.index(5).should eq 2\n    Prime.index(7).should eq 3\n    Prime.index(10**8\
    \ + 7).should eq 5761455\n\n    Prime.index(-10**9).should be_nil\n    Prime.index(-1).should\
    \ be_nil\n    Prime.index(0).should be_nil\n    Prime.index(1).should be_nil\n\
    \    Prime.index(57).should be_nil\n    Prime.index(91).should be_nil\n    Prime.index(9943081).should\
    \ be_nil\n  end\nend\n"
  dependsOn:
  - src/math/prime.cr
  isVerificationFile: false
  path: spec/math/prime_spec.cr
  requiredBy: []
  timestamp: '2021-10-17 22:03:11+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/math/prime_spec.cr
layout: document
redirect_from:
- /library/spec/math/prime_spec.cr
- /library/spec/math/prime_spec.cr.html
title: spec/math/prime_spec.cr
---
