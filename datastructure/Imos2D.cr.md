---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/CulSum2D_Imos2D.test.cr
    title: test/CulSum2D_Imos2D.test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "class Imos2D(T)\n  getter height : Int32\n  getter width : Int32\n\
    \  @builded = false\n\n  def initialize(@height, @width, init_val : T = T.zero)\n\
    \    @table = Array(Array(T)).new(@height + 1) do\n      Array(T).new(@width +\
    \ 1, init_val)\n    end\n  end\n\n  def add(ys : Int32, yc : Int32, xs : Int32,\
    \ xc : Int32, val : T) : Nil\n    raise \"self had been called `build`\" if @builded\n\
    \    raise ArgumentError.new \"Negative count: #{yc}\" if yc < 0\n    raise ArgumentError.new\
    \ \"Negative count: #{xc}\" if xc < 0\n    @table[ys + yc][xs + xc] += val\n \
    \   @table[ys + yc][xs] -= val\n    @table[ys][xs + xc] -= val\n    @table[ys][xs]\
    \ += val\n  end\n\n  def add(y : Range, x : Range, val : T)\n    ys, yc = Indexable.range_to_index_and_count(y,\
    \ height) || raise IndexError.new\n    xs, xc = Indexable.range_to_index_and_count(x,\
    \ width) || raise IndexError.new\n    add(ys, yc, xs, xc, val)\n  end\n\n  def\
    \ build : Array(Array(T))\n    raise \"self had been called `build`\" if @builded\n\
    \    @builded = true\n    (0..height).each do |y|\n      (1..width).each do |x|\n\
    \        @table[y][x] += @table[y][x - 1]\n      end\n    end\n    (1..height).each\
    \ do |y|\n      (0..width).each do |x|\n        @table[y][x] += @table[y - 1][x]\n\
    \      end\n    end\n    (0...height).map { |i| @table[i][0...width] }\n  end\n\
    \n  def [](y : Int32, x : Int32) : T\n    raise IndexError.new unless 0 <= y <\
    \ height\n    raise IndexError.new unless 0 <= x < width\n    @table[y][x]\n \
    \ end\nend\n"
  code: "class Imos2D(T)\n  getter height : Int32\n  getter width : Int32\n  @builded\
    \ = false\n\n  def initialize(@height, @width, init_val : T = T.zero)\n    @table\
    \ = Array(Array(T)).new(@height + 1) do\n      Array(T).new(@width + 1, init_val)\n\
    \    end\n  end\n\n  def add(ys : Int32, yc : Int32, xs : Int32, xc : Int32, val\
    \ : T) : Nil\n    raise \"self had been called `build`\" if @builded\n    raise\
    \ ArgumentError.new \"Negative count: #{yc}\" if yc < 0\n    raise ArgumentError.new\
    \ \"Negative count: #{xc}\" if xc < 0\n    @table[ys + yc][xs + xc] += val\n \
    \   @table[ys + yc][xs] -= val\n    @table[ys][xs + xc] -= val\n    @table[ys][xs]\
    \ += val\n  end\n\n  def add(y : Range, x : Range, val : T)\n    ys, yc = Indexable.range_to_index_and_count(y,\
    \ height) || raise IndexError.new\n    xs, xc = Indexable.range_to_index_and_count(x,\
    \ width) || raise IndexError.new\n    add(ys, yc, xs, xc, val)\n  end\n\n  def\
    \ build : Array(Array(T))\n    raise \"self had been called `build`\" if @builded\n\
    \    @builded = true\n    (0..height).each do |y|\n      (1..width).each do |x|\n\
    \        @table[y][x] += @table[y][x - 1]\n      end\n    end\n    (1..height).each\
    \ do |y|\n      (0..width).each do |x|\n        @table[y][x] += @table[y - 1][x]\n\
    \      end\n    end\n    (0...height).map { |i| @table[i][0...width] }\n  end\n\
    \n  def [](y : Int32, x : Int32) : T\n    raise IndexError.new unless 0 <= y <\
    \ height\n    raise IndexError.new unless 0 <= x < width\n    @table[y][x]\n \
    \ end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: datastructure/Imos2D.cr
  requiredBy: []
  timestamp: '2021-06-24 10:11:13+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/CulSum2D_Imos2D.test.cr
documentation_of: datastructure/Imos2D.cr
layout: document
redirect_from:
- /library/datastructure/Imos2D.cr
- /library/datastructure/Imos2D.cr.html
title: datastructure/Imos2D.cr
---
