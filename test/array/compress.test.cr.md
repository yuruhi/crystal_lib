---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/array/compress.cr
    title: src/array/compress.cr
  - icon: ':heavy_check_mark:'
    path: src/datastructure/imos_2d.cr
    title: src/datastructure/imos_2d.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://onlinejudge.u-aizu.ac.jp/problems/DSL_4_A
  bundledCode: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/DSL_4_A\n\
    # require \"../../src/array/compress\"\nclass Array(T)\n  def compress(values\
    \ : Array(T), *, index : Int = 0)\n    map do |x|\n      index + values.bsearch_index\
    \ { |y| y >= x }.not_nil!\n    end\n  end\n\n  def compress(*, index : Int = 0)\
    \ : Array(Int32)\n    compress(uniq.sort!, index: index)\n  end\nend\n\n# require\
    \ \"../../src/datastructure/imos_2d\"\nclass Imos2D(T)\n  getter height : Int32,\
    \ width : Int32\n  @builded = false\n\n  def initialize(@height, @width, init_val\
    \ : T = T.zero)\n    @table = Array(Array(T)).new(@height + 1) do\n      Array(T).new(@width\
    \ + 1, init_val)\n    end\n  end\n\n  def add(ys : Int, yc : Int, xs : Int, xc\
    \ : Int, val : T) : Nil\n    raise \"self had been called `build`\" if @builded\n\
    \    raise ArgumentError.new \"Negative count: #{yc}\" if yc < 0\n    raise ArgumentError.new\
    \ \"Negative count: #{xc}\" if xc < 0\n    @table[ys + yc][xs + xc] += val\n \
    \   @table[ys + yc][xs] -= val\n    @table[ys][xs + xc] -= val\n    @table[ys][xs]\
    \ += val\n  end\n\n  def add(y : Range, x : Range, val : T) : Nil\n    ys, yc\
    \ = Indexable.range_to_index_and_count(y, height) || raise IndexError.new\n  \
    \  xs, xc = Indexable.range_to_index_and_count(x, width) || raise IndexError.new\n\
    \    add(ys, yc, xs, xc, val)\n  end\n\n  def build : Array(Array(T))\n    raise\
    \ \"self had been called `#build`\" if @builded\n    @builded = true\n    (0..height).each\
    \ do |y|\n      (1..width).each do |x|\n        @table[y][x] += @table[y][x -\
    \ 1]\n      end\n    end\n    (1..height).each do |y|\n      (0..width).each do\
    \ |x|\n        @table[y][x] += @table[y - 1][x]\n      end\n    end\n    (0...height).map\
    \ { |i| @table[i][0...width] }\n  end\n\n  def [](y : Int32, x : Int32) : T\n\
    \    raise \"self had not been called `#build`\" unless @builded\n    @table[y][x]\n\
    \  end\nend\n\nn = read_line.to_i\nx1, y1, x2, y2 = Array.new(n) {\n  read_line.split.map(&.to_i64)\n\
    }.transpose\n\nx_values = (x1 + x2).uniq.sort!\nxx = x_values.size - 1\ncx1 =\
    \ x1.compress(x_values)\ncx2 = x2.compress(x_values)\n\ny_values = (y1 + y2).uniq.sort!\n\
    yy = y_values.size - 1\ncy1 = y1.compress(y_values)\ncy2 = y2.compress(y_values)\n\
    \nimos = Imos2D(Int32).new(xx, yy)\ncx1.zip(cy1, cx2, cy2) do |x1, y1, x2, y2|\n\
    \  imos.add(x1...x2, y1...y2, 1)\nend\nimos.build\n\nputs (0...xx).sum { |i|\n\
    \  (0...yy).sum { |j|\n    (x_values[i + 1] - x_values[i]) * (y_values[j + 1]\
    \ - y_values[j]) * imos[i, j].sign\n  }\n}\n"
  code: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/DSL_4_A\n\
    require \"../../src/array/compress\"\nrequire \"../../src/datastructure/imos_2d\"\
    \nn = read_line.to_i\nx1, y1, x2, y2 = Array.new(n) {\n  read_line.split.map(&.to_i64)\n\
    }.transpose\n\nx_values = (x1 + x2).uniq.sort!\nxx = x_values.size - 1\ncx1 =\
    \ x1.compress(x_values)\ncx2 = x2.compress(x_values)\n\ny_values = (y1 + y2).uniq.sort!\n\
    yy = y_values.size - 1\ncy1 = y1.compress(y_values)\ncy2 = y2.compress(y_values)\n\
    \nimos = Imos2D(Int32).new(xx, yy)\ncx1.zip(cy1, cx2, cy2) do |x1, y1, x2, y2|\n\
    \  imos.add(x1...x2, y1...y2, 1)\nend\nimos.build\n\nputs (0...xx).sum { |i|\n\
    \  (0...yy).sum { |j|\n    (x_values[i + 1] - x_values[i]) * (y_values[j + 1]\
    \ - y_values[j]) * imos[i, j].sign\n  }\n}\n"
  dependsOn:
  - src/array/compress.cr
  - src/datastructure/imos_2d.cr
  isVerificationFile: true
  path: test/array/compress.test.cr
  requiredBy: []
  timestamp: '2021-07-21 16:11:26+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/array/compress.test.cr
layout: document
redirect_from:
- /verify/test/array/compress.test.cr
- /verify/test/array/compress.test.cr.html
title: test/array/compress.test.cr
---
