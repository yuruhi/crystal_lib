---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/math/pythagorean_triples.cr
    title: src/math/pythagorean_triples.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../src/math/pythagorean_triples\"\
    \nclass PythagoreanTriples\n  include Enumerable({Int32, Int32, Int32})\n  include\
    \ Iterable({Int32, Int32, Int32})\n\n  getter limit : Int32\n\n  def initialize(@limit\
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
    \ end\nend\n\ntriples = [{3, 4, 5}, {5, 12, 13}, {8, 15, 17}, {7, 24, 25}, {20,\
    \ 21, 29}]\n\ndescribe PythagoreanTriples do\n  it \"#each(&)\" do\n    a = []\
    \ of {Int32, Int32, Int32}\n    PythagoreanTriples.new(29).each { |tuple| a <<\
    \ tuple }\n    a.should eq triples\n  end\n\n  it \"#each\" do\n    PythagoreanTriples.new(29).each.to_a.should\
    \ eq triples\n  end\n\n  it \"includes Enumerable({Int32, Int32, Int32})\" do\n\
    \    PythagoreanTriples.new(29).to_a.should eq triples\n    PythagoreanTriples.new(30).to_a.should\
    \ eq triples\n  end\n\n  it \"includes Iterable({Int32, Int32, Int32})\" do\n\
    \    PythagoreanTriples.new(29).cycle(2).to_a.should eq triples * 2\n  end\nend\n"
  code: "require \"spec\"\nrequire \"../../src/math/pythagorean_triples\"\n\ntriples\
    \ = [{3, 4, 5}, {5, 12, 13}, {8, 15, 17}, {7, 24, 25}, {20, 21, 29}]\n\ndescribe\
    \ PythagoreanTriples do\n  it \"#each(&)\" do\n    a = [] of {Int32, Int32, Int32}\n\
    \    PythagoreanTriples.new(29).each { |tuple| a << tuple }\n    a.should eq triples\n\
    \  end\n\n  it \"#each\" do\n    PythagoreanTriples.new(29).each.to_a.should eq\
    \ triples\n  end\n\n  it \"includes Enumerable({Int32, Int32, Int32})\" do\n \
    \   PythagoreanTriples.new(29).to_a.should eq triples\n    PythagoreanTriples.new(30).to_a.should\
    \ eq triples\n  end\n\n  it \"includes Iterable({Int32, Int32, Int32})\" do\n\
    \    PythagoreanTriples.new(29).cycle(2).to_a.should eq triples * 2\n  end\nend\n"
  dependsOn:
  - src/math/pythagorean_triples.cr
  isVerificationFile: false
  path: spec/math/pythagorean_triples_spec.cr
  requiredBy: []
  timestamp: '2021-11-14 10:50:51+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/math/pythagorean_triples_spec.cr
layout: document
redirect_from:
- /library/spec/math/pythagorean_triples_spec.cr
- /library/spec/math/pythagorean_triples_spec.cr.html
title: spec/math/pythagorean_triples_spec.cr
---
