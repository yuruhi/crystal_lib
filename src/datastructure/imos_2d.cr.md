---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/array/compress_test.cr
    title: test/array/compress_test.cr
  - icon: ':heavy_check_mark:'
    path: test/datastructure/cul_sum_2d_2_test.cr
    title: test/datastructure/cul_sum_2d_2_test.cr
  - icon: ':heavy_check_mark:'
    path: test/datastructure/cul_sum_2d_imos_2d_test.cr
    title: test/datastructure/cul_sum_2d_imos_2d_test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "class Imos2D(T)\n  getter height : Int32, width : Int32\n  @built\
    \ = false\n\n  def initialize(@height, @width, init_val : T = T.zero)\n    @table\
    \ = Array(Array(T)).new(@height + 1) do\n      Array(T).new(@width + 1, init_val)\n\
    \    end\n  end\n\n  def add(ys : Int, yc : Int, xs : Int, xc : Int, val : T)\
    \ : Nil\n    raise \"self had been called `#build`\" if @built\n    raise ArgumentError.new\
    \ \"Negative count: #{yc}\" if yc < 0\n    raise ArgumentError.new \"Negative\
    \ count: #{xc}\" if xc < 0\n    @table[ys + yc][xs + xc] += val\n    @table[ys\
    \ + yc][xs] -= val\n    @table[ys][xs + xc] -= val\n    @table[ys][xs] += val\n\
    \  end\n\n  def add(y : Range, x : Range, val : T) : Nil\n    ys, yc = Indexable.range_to_index_and_count(y,\
    \ height) || raise IndexError.new\n    xs, xc = Indexable.range_to_index_and_count(x,\
    \ width) || raise IndexError.new\n    add(ys, yc, xs, xc, val)\n  end\n\n  def\
    \ build : Array(Array(T))\n    raise \"self had been called `#build`\" if @built\n\
    \    @built = true\n    (0..height).each do |y|\n      (1..width).each do |x|\n\
    \        @table[y][x] += @table[y][x - 1]\n      end\n    end\n    (1..height).each\
    \ do |y|\n      (0..width).each do |x|\n        @table[y][x] += @table[y - 1][x]\n\
    \      end\n    end\n    (0...height).map { |i| @table[i][0...width] }\n  end\n\
    \n  def [](y : Int32, x : Int32) : T\n    raise \"self had not been called `#build`\"\
    \ unless @built\n    @table[y][x]\n  end\nend\n"
  code: "class Imos2D(T)\n  getter height : Int32, width : Int32\n  @built = false\n\
    \n  def initialize(@height, @width, init_val : T = T.zero)\n    @table = Array(Array(T)).new(@height\
    \ + 1) do\n      Array(T).new(@width + 1, init_val)\n    end\n  end\n\n  def add(ys\
    \ : Int, yc : Int, xs : Int, xc : Int, val : T) : Nil\n    raise \"self had been\
    \ called `#build`\" if @built\n    raise ArgumentError.new \"Negative count: #{yc}\"\
    \ if yc < 0\n    raise ArgumentError.new \"Negative count: #{xc}\" if xc < 0\n\
    \    @table[ys + yc][xs + xc] += val\n    @table[ys + yc][xs] -= val\n    @table[ys][xs\
    \ + xc] -= val\n    @table[ys][xs] += val\n  end\n\n  def add(y : Range, x : Range,\
    \ val : T) : Nil\n    ys, yc = Indexable.range_to_index_and_count(y, height) ||\
    \ raise IndexError.new\n    xs, xc = Indexable.range_to_index_and_count(x, width)\
    \ || raise IndexError.new\n    add(ys, yc, xs, xc, val)\n  end\n\n  def build\
    \ : Array(Array(T))\n    raise \"self had been called `#build`\" if @built\n \
    \   @built = true\n    (0..height).each do |y|\n      (1..width).each do |x|\n\
    \        @table[y][x] += @table[y][x - 1]\n      end\n    end\n    (1..height).each\
    \ do |y|\n      (0..width).each do |x|\n        @table[y][x] += @table[y - 1][x]\n\
    \      end\n    end\n    (0...height).map { |i| @table[i][0...width] }\n  end\n\
    \n  def [](y : Int32, x : Int32) : T\n    raise \"self had not been called `#build`\"\
    \ unless @built\n    @table[y][x]\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/datastructure/imos_2d.cr
  requiredBy: []
  timestamp: '2022-01-08 12:01:15+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/datastructure/cul_sum_2d_imos_2d_test.cr
  - test/datastructure/cul_sum_2d_2_test.cr
  - test/array/compress_test.cr
documentation_of: src/datastructure/imos_2d.cr
layout: document
redirect_from:
- /library/src/datastructure/imos_2d.cr
- /library/src/datastructure/imos_2d.cr.html
title: src/datastructure/imos_2d.cr
---
