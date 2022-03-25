---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/math/pythagorean_triples_spec.cr
    title: spec/math/pythagorean_triples_spec.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "class PythagoreanTriples\n  include Enumerable({Int32, Int32, Int32})\n\
    \  include Iterable({Int32, Int32, Int32})\n\n  getter limit : Int32\n\n  def\
    \ initialize(@limit : Int32)\n  end\n\n  # Enumerates all primitive Pythagorean\
    \ triples not more than `#limit`.\n  def each(&)\n    (1...).each do |m|\n   \
    \   mm = m * m\n      break if mm > limit\n      (m % 2 + 1...m).step(2) do |n|\n\
    \        nn = n * n\n        break if mm + nn > limit\n        next if m.gcd(n)\
    \ != 1\n        a, b, c = mm - nn, m * n * 2, mm + nn\n        a, b = b, a if\
    \ a > b\n        yield({a, b, c})\n      end\n    end\n  end\n\n  # Returns an\
    \ `Iterator` for all primitive Pythagorean triples not more than `#limit`.\n \
    \ def each\n    TriplesIterator.new(@limit)\n  end\n\n  private class TriplesIterator\n\
    \    include Iterator({Int32, Int32, Int32})\n\n    def initialize(@limit : Int32)\n\
    \      @m, @n = 1, 2\n    end\n\n    def next\n      loop do\n        mm, nn =\
    \ @m * @m, @n * @n\n        if mm > @limit\n          return stop\n        elsif\
    \ @n >= @m || mm + nn > @limit\n          @m += 1\n          @n = @m % 2 + 1\n\
    \        elsif @m.gcd(@n) != 1\n          @n += 2\n        else\n          a,\
    \ b, c = mm - nn, @m * @n * 2, mm + nn\n          a, b = b, a if a > b\n     \
    \     @n += 2\n          return {a, b, c}\n        end\n      end\n    end\n \
    \ end\nend\n"
  code: "class PythagoreanTriples\n  include Enumerable({Int32, Int32, Int32})\n \
    \ include Iterable({Int32, Int32, Int32})\n\n  getter limit : Int32\n\n  def initialize(@limit\
    \ : Int32)\n  end\n\n  # Enumerates all primitive Pythagorean triples not more\
    \ than `#limit`.\n  def each(&)\n    (1...).each do |m|\n      mm = m * m\n  \
    \    break if mm > limit\n      (m % 2 + 1...m).step(2) do |n|\n        nn = n\
    \ * n\n        break if mm + nn > limit\n        next if m.gcd(n) != 1\n     \
    \   a, b, c = mm - nn, m * n * 2, mm + nn\n        a, b = b, a if a > b\n    \
    \    yield({a, b, c})\n      end\n    end\n  end\n\n  # Returns an `Iterator`\
    \ for all primitive Pythagorean triples not more than `#limit`.\n  def each\n\
    \    TriplesIterator.new(@limit)\n  end\n\n  private class TriplesIterator\n \
    \   include Iterator({Int32, Int32, Int32})\n\n    def initialize(@limit : Int32)\n\
    \      @m, @n = 1, 2\n    end\n\n    def next\n      loop do\n        mm, nn =\
    \ @m * @m, @n * @n\n        if mm > @limit\n          return stop\n        elsif\
    \ @n >= @m || mm + nn > @limit\n          @m += 1\n          @n = @m % 2 + 1\n\
    \        elsif @m.gcd(@n) != 1\n          @n += 2\n        else\n          a,\
    \ b, c = mm - nn, @m * @n * 2, mm + nn\n          a, b = b, a if a > b\n     \
    \     @n += 2\n          return {a, b, c}\n        end\n      end\n    end\n \
    \ end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/math/pythagorean_triples.cr
  requiredBy:
  - spec/math/pythagorean_triples_spec.cr
  timestamp: '2022-03-25 11:37:47+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/math/pythagorean_triples.cr
layout: document
redirect_from:
- /library/src/math/pythagorean_triples.cr
- /library/src/math/pythagorean_triples.cr.html
title: src/math/pythagorean_triples.cr
---
