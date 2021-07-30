---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/math/prime_spec.cr
    title: spec/math/prime_spec.cr
  - icon: ':heavy_check_mark:'
    path: src/math/gcd.cr
    title: src/math/gcd.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "module Prime\n  extend self\n  include Indexable(Int32)\n\n  @@primes\
    \ = [\n    2, 3, 5, 7, 11, 13, 17, 19, 23, 29,\n    31, 37, 41, 43, 47, 53, 59,\
    \ 61, 67, 71,\n    73, 79, 83, 89, 97, 101, 103, 107, 109, 113,\n    127, 131,\
    \ 137, 139, 149, 151, 157, 163, 167, 173,\n    179, 181, 191, 193, 197, 199, 211,\
    \ 223, 227, 229,\n    233, 239, 241, 251, 257, 263, 269, 271, 277, 281,\n    283,\
    \ 293, 307, 311, 313, 317, 331, 337, 347, 349,\n    353, 359, 367, 373, 379, 383,\
    \ 389, 397, 401, 409,\n    419, 421, 431, 433, 439, 443, 449, 457, 461, 463,\n\
    \    467, 479, 487, 491, 499, 503, 509, 521, 523, 541,\n    547, 557, 563, 569,\
    \ 571, 577, 587, 593, 599, 601,\n    607, 613, 617, 619, 631, 641, 643, 647, 653,\
    \ 659,\n    661, 673, 677, 683, 691, 701, 709, 719, 727, 733,\n    739, 743, 751,\
    \ 757, 761, 769, 773, 787, 797, 809,\n    811, 821, 823, 827, 829, 839, 853, 857,\
    \ 859, 863,\n    877, 881, 883, 887, 907, 911, 919, 929, 937, 941,\n    947, 953,\
    \ 967, 971, 977, 983, 991, 997,\n  ]\n\n  private def generate_primes\n    size\
    \ = @@primes.size\n    primes = Array.new(size) { |i| @@primes.last + (i + 1)\
    \ * 2 }\n    last = primes.last\n\n    @@primes.each do |prime|\n      next if\
    \ prime == 2\n      break if prime * prime > last\n      from = prime * ((@@primes.last\
    \ // prime + 1) // 2 * 2 + 1)\n      from.step(to: last, by: prime * 2) do |x|\n\
    \        primes[~((last - x) // 2)] = 0\n      end\n    end\n\n    @@primes.concat\
    \ primes.reject(0)\n  end\n\n  private def generate_until(*, index : Int)\n  \
    \  while @@primes.size <= index\n      generate_primes\n    end\n  end\n\n  private\
    \ def generate_until(*, value : Int)\n    while @@primes.last < value\n      generate_primes\n\
    \    end\n  end\n\n  private def check_index_out_of_bounds(index)\n    if 0 <=\
    \ index < size\n      index\n    else\n      yield\n    end\n  end\n\n  def unsafe_fetch(index\
    \ : Int)\n    generate_until(index: index)\n    @@primes.unsafe_fetch(index)\n\
    \  end\n\n  def size\n    10**9\n  end\n\n  def includes?(x : Int)\n    generate_until(value:\
    \ x)\n    @@primes.bsearch { |y| y >= x } == x\n  end\n\n  def index(x : Int)\n\
    \    generate_until(value: x)\n    i = @@primes.bsearch_index { |y| y >= x }.not_nil!\n\
    \    @@primes[i] == x ? i : nil\n  end\n\n  def each(x : Int, &)\n    i = 0\n\
    \    loop do\n      generate_primes if @@primes.size == i\n      prime = @@primes.unsafe_fetch(i)\n\
    \      break if prime > x\n      yield prime\n      i += 1\n    end\n  end\n\n\
    \  def each(x : Int)\n    each.take_while { |prime| prime <= x }\n  end\nend\n"
  code: "module Prime\n  extend self\n  include Indexable(Int32)\n\n  @@primes = [\n\
    \    2, 3, 5, 7, 11, 13, 17, 19, 23, 29,\n    31, 37, 41, 43, 47, 53, 59, 61,\
    \ 67, 71,\n    73, 79, 83, 89, 97, 101, 103, 107, 109, 113,\n    127, 131, 137,\
    \ 139, 149, 151, 157, 163, 167, 173,\n    179, 181, 191, 193, 197, 199, 211, 223,\
    \ 227, 229,\n    233, 239, 241, 251, 257, 263, 269, 271, 277, 281,\n    283, 293,\
    \ 307, 311, 313, 317, 331, 337, 347, 349,\n    353, 359, 367, 373, 379, 383, 389,\
    \ 397, 401, 409,\n    419, 421, 431, 433, 439, 443, 449, 457, 461, 463,\n    467,\
    \ 479, 487, 491, 499, 503, 509, 521, 523, 541,\n    547, 557, 563, 569, 571, 577,\
    \ 587, 593, 599, 601,\n    607, 613, 617, 619, 631, 641, 643, 647, 653, 659,\n\
    \    661, 673, 677, 683, 691, 701, 709, 719, 727, 733,\n    739, 743, 751, 757,\
    \ 761, 769, 773, 787, 797, 809,\n    811, 821, 823, 827, 829, 839, 853, 857, 859,\
    \ 863,\n    877, 881, 883, 887, 907, 911, 919, 929, 937, 941,\n    947, 953, 967,\
    \ 971, 977, 983, 991, 997,\n  ]\n\n  private def generate_primes\n    size = @@primes.size\n\
    \    primes = Array.new(size) { |i| @@primes.last + (i + 1) * 2 }\n    last =\
    \ primes.last\n\n    @@primes.each do |prime|\n      next if prime == 2\n    \
    \  break if prime * prime > last\n      from = prime * ((@@primes.last // prime\
    \ + 1) // 2 * 2 + 1)\n      from.step(to: last, by: prime * 2) do |x|\n      \
    \  primes[~((last - x) // 2)] = 0\n      end\n    end\n\n    @@primes.concat primes.reject(0)\n\
    \  end\n\n  private def generate_until(*, index : Int)\n    while @@primes.size\
    \ <= index\n      generate_primes\n    end\n  end\n\n  private def generate_until(*,\
    \ value : Int)\n    while @@primes.last < value\n      generate_primes\n    end\n\
    \  end\n\n  private def check_index_out_of_bounds(index)\n    if 0 <= index <\
    \ size\n      index\n    else\n      yield\n    end\n  end\n\n  def unsafe_fetch(index\
    \ : Int)\n    generate_until(index: index)\n    @@primes.unsafe_fetch(index)\n\
    \  end\n\n  def size\n    10**9\n  end\n\n  def includes?(x : Int)\n    generate_until(value:\
    \ x)\n    @@primes.bsearch { |y| y >= x } == x\n  end\n\n  def index(x : Int)\n\
    \    generate_until(value: x)\n    i = @@primes.bsearch_index { |y| y >= x }.not_nil!\n\
    \    @@primes[i] == x ? i : nil\n  end\n\n  def each(x : Int, &)\n    i = 0\n\
    \    loop do\n      generate_primes if @@primes.size == i\n      prime = @@primes.unsafe_fetch(i)\n\
    \      break if prime > x\n      yield prime\n      i += 1\n    end\n  end\n\n\
    \  def each(x : Int)\n    each.take_while { |prime| prime <= x }\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/math/prime.cr
  requiredBy:
  - src/math/gcd.cr
  - spec/math/prime_spec.cr
  timestamp: '2021-07-30 20:19:07+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/math/prime.cr
layout: document
redirect_from:
- /library/src/math/prime.cr
- /library/src/math/prime.cr.html
title: src/math/prime.cr
---
