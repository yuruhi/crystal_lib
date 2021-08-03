---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/datastructure/imos_linear.cr
    title: src/datastructure/imos_linear.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://yukicoder.me/problems/no/1008
  bundledCode: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/1008\n\
    # require \"../../src/datastructure/imos_linear\"\nclass ImosLinear(T)\n  getter\
    \ size : Int32\n  @builded = false\n\n  def initialize(@size : Int32)\n    @a\
    \ = Array(T).new(@size + 1, T.zero)\n    @b = Array(T).new(@size + 1, T.zero)\n\
    \  end\n\n  # Add `a + (i - l) * b` to `[l, r)`.\n  def add(start : Int, count\
    \ : Int, val_a : T, val_b : T) : Nil\n    raise \"self had been called `#build`\"\
    \ if @builded\n    raise ArgumentError.new \"Negative count: #{count}\" if count\
    \ < 0\n    @a[start] += val_a - val_b * start\n    @b[start] += val_b\n    @a[start\
    \ + count] -= val_a - val_b * start\n    @b[start + count] -= val_b\n  end\n\n\
    \  def add(range : Range, val_a : T, val_b : T) : Nil\n    start, count = Indexable.range_to_index_and_count(range,\
    \ size) || raise IndexError.new\n    add(start, count, val_a, val_b)\n  end\n\n\
    \  def build : Array(T)\n    raise \"self had been called `#build`\" if @builded\n\
    \    @builded = true\n    (0...size).map do |i|\n      @a[i + 1] += @a[i]\n  \
    \    @b[i + 1] += @b[i]\n      @a[i] + @b[i] * i\n    end\n  end\nend\n\nn, m\
    \ = read_line.split.map(&.to_i)\na = read_line.split.map(&.to_i64)\nxw = (1..m).map\
    \ {\n  x, w = read_line.split\n  {x.to_i - 1, w.to_i64}\n}\n\nif xw.sum(&.[1])\
    \ < a.min\n  puts 0\n  exit\nend\n\nputs (1i64..10i64**9).bsearch { |c|\n  imos\
    \ = ImosLinear(Int64).new(n)\n  xw.each do |x, w|\n    imos.add(x..x, w, 0)\n\
    \    left = {x, w // c}.min\n    imos.add(x - left, left, w - c * left, c)\n \
    \   right = {n - 1 - x, w // c}.min\n    imos.add(x + 1, right, w - c, -c)\n \
    \ end\n  imos.build.zip(a).all? { |imos, a| imos < a }\n} || -1\n"
  code: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/1008\nrequire\
    \ \"../../src/datastructure/imos_linear\"\nn, m = read_line.split.map(&.to_i)\n\
    a = read_line.split.map(&.to_i64)\nxw = (1..m).map {\n  x, w = read_line.split\n\
    \  {x.to_i - 1, w.to_i64}\n}\n\nif xw.sum(&.[1]) < a.min\n  puts 0\n  exit\nend\n\
    \nputs (1i64..10i64**9).bsearch { |c|\n  imos = ImosLinear(Int64).new(n)\n  xw.each\
    \ do |x, w|\n    imos.add(x..x, w, 0)\n    left = {x, w // c}.min\n    imos.add(x\
    \ - left, left, w - c * left, c)\n    right = {n - 1 - x, w // c}.min\n    imos.add(x\
    \ + 1, right, w - c, -c)\n  end\n  imos.build.zip(a).all? { |imos, a| imos < a\
    \ }\n} || -1\n"
  dependsOn:
  - src/datastructure/imos_linear.cr
  isVerificationFile: true
  path: test/datastructure/imos_linear.test.cr
  requiredBy: []
  timestamp: '2021-07-18 13:52:56+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/datastructure/imos_linear.test.cr
layout: document
redirect_from:
- /verify/test/datastructure/imos_linear.test.cr
- /verify/test/datastructure/imos_linear.test.cr.html
title: test/datastructure/imos_linear.test.cr
---
