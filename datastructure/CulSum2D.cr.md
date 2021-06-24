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
  bundledCode: "class CulSum2D(T)\n  getter height : Int32\n  getter width : Int32\n\
    \n  def initialize(a : Array(Array(T)))\n    @height = a.size\n    raise ArgumentError.new\
    \ unless height > 0\n    @width = a[0].size\n    raise ArgumentError.new unless\
    \ a.map(&.size).all?(width)\n\n    @s = Array(Array(T)).new(height + 1) { Array.new(width\
    \ + 1, T.zero) }\n    (0...height).each do |i|\n      (0...width).each do |j|\n\
    \        @s[i + 1][j + 1] = @s[i][j + 1] + @s[i + 1][j] - @s[i][j] + a[i][j]\n\
    \      end\n    end\n  end\n\n  def initialize(@height : Int32, @width : Int32,\
    \ &f : Int32, Int32 -> T)\n    raise ArgumentError.new unless height > 0\n   \
    \ raise ArgumentError.new unless width > 0\n    @s = Array(Array(T)).new(height\
    \ + 1) { Array.new(width + 1, T.zero) }\n    (0...height).each do |i|\n      (0...width).each\
    \ do |j|\n        @s[i + 1][j + 1] = @s[i][j + 1] + @s[i + 1][j] - @s[i][j] +\
    \ yield(i, j)\n      end\n    end\n  end\n\n  def [](y_start, y_count, x_start,\
    \ x_count)\n    @s[y_start + y_count][x_start + x_count] - @s[y_start + y_count][x_start]\
    \ -\n      @s[y_start][x_start + x_count] + @s[y_start][x_start]\n  end\n\n  def\
    \ [](y_range : Range, x_range : Range)\n    ys, yc = Indexable.range_to_index_and_count(y_range,\
    \ height) || raise IndexError.new\n    xs, xc = Indexable.range_to_index_and_count(x_range,\
    \ width) || raise IndexError.new\n    self[ys, yc, xs, xc]\n  end\n\n  def to_a\n\
    \    (0...@n).map { |i| self[i..i] }\n  end\nend\n"
  code: "class CulSum2D(T)\n  getter height : Int32\n  getter width : Int32\n\n  def\
    \ initialize(a : Array(Array(T)))\n    @height = a.size\n    raise ArgumentError.new\
    \ unless height > 0\n    @width = a[0].size\n    raise ArgumentError.new unless\
    \ a.map(&.size).all?(width)\n\n    @s = Array(Array(T)).new(height + 1) { Array.new(width\
    \ + 1, T.zero) }\n    (0...height).each do |i|\n      (0...width).each do |j|\n\
    \        @s[i + 1][j + 1] = @s[i][j + 1] + @s[i + 1][j] - @s[i][j] + a[i][j]\n\
    \      end\n    end\n  end\n\n  def initialize(@height : Int32, @width : Int32,\
    \ &f : Int32, Int32 -> T)\n    raise ArgumentError.new unless height > 0\n   \
    \ raise ArgumentError.new unless width > 0\n    @s = Array(Array(T)).new(height\
    \ + 1) { Array.new(width + 1, T.zero) }\n    (0...height).each do |i|\n      (0...width).each\
    \ do |j|\n        @s[i + 1][j + 1] = @s[i][j + 1] + @s[i + 1][j] - @s[i][j] +\
    \ yield(i, j)\n      end\n    end\n  end\n\n  def [](y_start, y_count, x_start,\
    \ x_count)\n    @s[y_start + y_count][x_start + x_count] - @s[y_start + y_count][x_start]\
    \ -\n      @s[y_start][x_start + x_count] + @s[y_start][x_start]\n  end\n\n  def\
    \ [](y_range : Range, x_range : Range)\n    ys, yc = Indexable.range_to_index_and_count(y_range,\
    \ height) || raise IndexError.new\n    xs, xc = Indexable.range_to_index_and_count(x_range,\
    \ width) || raise IndexError.new\n    self[ys, yc, xs, xc]\n  end\n\n  def to_a\n\
    \    (0...@n).map { |i| self[i..i] }\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: datastructure/CulSum2D.cr
  requiredBy: []
  timestamp: '2021-06-24 10:34:19+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/CulSum2D_Imos2D.test.cr
documentation_of: datastructure/CulSum2D.cr
layout: document
redirect_from:
- /library/datastructure/CulSum2D.cr
- /library/datastructure/CulSum2D.cr.html
title: datastructure/CulSum2D.cr
---
