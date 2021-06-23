---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: datastructure/Imos.cr
    title: datastructure/Imos.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://onlinejudge.u-aizu.ac.jp/problems/2013
  bundledCode: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/2013\n\
    # require \"../datastructure/Imos\"\nclass Imos(T)\n  getter size : Int32\n  @builded\
    \ = false\n\n  def initialize(@size : Int32)\n    @a = Array(T).new(@size + 1,\
    \ T.zero)\n  end\n\n  def add(start : Int, count : Int, val : T) : Nil\n    raise\
    \ \"self had been called `#build`\" if @builded\n    raise ArgumentError.new \"\
    Negative count: #{count}\" if count < 0\n    start += size if start < 0\n    if\
    \ 0 <= start <= size\n      count = Math.min(count, size - start)\n      @a[start]\
    \ += val\n      @a[start + count] -= val\n    end\n  end\n\n  def add(range :\
    \ Range, val : T)\n    start, count = Indexable.range_to_index_and_count(range,\
    \ size) || raise IndexError.new\n    add(start, count, val)\n  end\n\n  def build\
    \ : Array(T)\n    raise \"self had been called `#build`\" if @builded\n    @builded\
    \ = true\n    (0...size).map do |i|\n      @a[i].tap { |x| @a[i + 1] += x }\n\
    \    end\n  end\nend\n\nloop do\n  n = read_line.to_i\n  break if n == 0\n  imos\
    \ = Imos(Int32).new(24 * 60 * 60)\n  n.times do\n    s, t = read_line.split.map\
    \ { |i|\n      h, m, s = i.split(':').map(&.to_i)\n      h * 3600 + m * 60 + s\n\
    \    }\n    imos.add(s...t, 1)\n  end\n  puts imos.build.max\nend\n"
  code: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/2013\n\
    require \"../datastructure/Imos\"\nloop do\n  n = read_line.to_i\n  break if n\
    \ == 0\n  imos = Imos(Int32).new(24 * 60 * 60)\n  n.times do\n    s, t = read_line.split.map\
    \ { |i|\n      h, m, s = i.split(':').map(&.to_i)\n      h * 3600 + m * 60 + s\n\
    \    }\n    imos.add(s...t, 1)\n  end\n  puts imos.build.max\nend\n"
  dependsOn:
  - datastructure/Imos.cr
  isVerificationFile: true
  path: test/Imos.test.cr
  requiredBy: []
  timestamp: '2021-06-20 21:15:01+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/Imos.test.cr
layout: document
redirect_from:
- /verify/test/Imos.test.cr
- /verify/test/Imos.test.cr.html
title: test/Imos.test.cr
---
