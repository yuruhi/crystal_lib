---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
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
  bundledCode: "class CulSum2D(T)\n  getter height : Int32, width : Int32\n\n  def\
    \ initialize(a : Array(Array(T)))\n    @height = a.size\n    raise ArgumentError.new\
    \ unless height > 0\n    @width = a[0].size\n    raise ArgumentError.new unless\
    \ a.all? { |b| b.size == width }\n\n    @sum = Array(Array(T)).new(height + 1)\
    \ { |i|\n      i == 0 ? Array.new(width + 1, T.zero) : [T.zero] + a[i - 1]\n \
    \   }\n    height.times do |i|\n      width.succ.times do |j|\n        @sum[i\
    \ + 1][j] += @sum[i][j]\n      end\n    end\n    height.succ.times do |i|\n  \
    \    width.times do |j|\n        @sum[i][j + 1] += @sum[i][j]\n      end\n   \
    \ end\n  end\n\n  def initialize(@height : Int32, @width : Int32, &block : Int32,\
    \ Int32 -> T)\n    raise ArgumentError.new unless height > 0 && width > 0\n  \
    \  @sum = Array(Array(T)).new(height + 1) { Array.new(width + 1, T.zero) }\n \
    \   height.times do |i|\n      width.times do |j|\n        @sum[i + 1][j + 1]\
    \ = yield(i, j)\n      end\n    end\n    height.times do |i|\n      width.succ.times\
    \ do |j|\n        @sum[i + 1][j] += @sum[i][j]\n      end\n    end\n    height.succ.times\
    \ do |i|\n      width.times do |j|\n        @sum[i][j + 1] += @sum[i][j]\n   \
    \   end\n    end\n  end\n\n  def []?(y_start : Int, y_count : Int, x_start : Int,\
    \ x_count : Int) : T?\n    raise ArgumentError.new \"Negative y_count: #{y_count}\"\
    \ unless y_count >= 0\n    raise ArgumentError.new \"Negative x_count: #{x_count}\"\
    \ unless x_count >= 0\n    y_start += height if y_start < 0\n    x_start += width\
    \ if x_start < 0\n\n    if 0 <= y_start <= height && 0 <= x_start <= width\n \
    \     y_count = Math.min(y_count, height - y_start)\n      x_count = Math.min(x_count,\
    \ width - x_start)\n\n      @sum[y_start + y_count][x_start + x_count] - @sum[y_start\
    \ + y_count][x_start] -\n        @sum[y_start][x_start + x_count] + @sum[y_start][x_start]\n\
    \    end\n  end\n\n  def []?(y_range : Range, x_range : Range) : T?\n    ys, yc\
    \ = Indexable.range_to_index_and_count(y_range, height) || return nil\n    xs,\
    \ xc = Indexable.range_to_index_and_count(x_range, width) || return nil\n    self[ys,\
    \ yc, xs, xc]?\n  end\n\n  def [](ys : Int, yc : Int, xs : Int, xc : Int) : T\n\
    \    self[ys, yc, xs, xc]? || raise IndexError.new\n  end\n\n  def [](y_range\
    \ : Range, x_range : Range) : T\n    self[y_range, x_range]? || raise IndexError.new\n\
    \  end\n\n  def to_a : Array(Array(T))\n    Array.new(height) do |i|\n      Array.new(width)\
    \ do |j|\n        self[i, 1, j, 1]\n      end\n    end\n  end\nend\n"
  code: "class CulSum2D(T)\n  getter height : Int32, width : Int32\n\n  def initialize(a\
    \ : Array(Array(T)))\n    @height = a.size\n    raise ArgumentError.new unless\
    \ height > 0\n    @width = a[0].size\n    raise ArgumentError.new unless a.all?\
    \ { |b| b.size == width }\n\n    @sum = Array(Array(T)).new(height + 1) { |i|\n\
    \      i == 0 ? Array.new(width + 1, T.zero) : [T.zero] + a[i - 1]\n    }\n  \
    \  height.times do |i|\n      width.succ.times do |j|\n        @sum[i + 1][j]\
    \ += @sum[i][j]\n      end\n    end\n    height.succ.times do |i|\n      width.times\
    \ do |j|\n        @sum[i][j + 1] += @sum[i][j]\n      end\n    end\n  end\n\n\
    \  def initialize(@height : Int32, @width : Int32, &block : Int32, Int32 -> T)\n\
    \    raise ArgumentError.new unless height > 0 && width > 0\n    @sum = Array(Array(T)).new(height\
    \ + 1) { Array.new(width + 1, T.zero) }\n    height.times do |i|\n      width.times\
    \ do |j|\n        @sum[i + 1][j + 1] = yield(i, j)\n      end\n    end\n    height.times\
    \ do |i|\n      width.succ.times do |j|\n        @sum[i + 1][j] += @sum[i][j]\n\
    \      end\n    end\n    height.succ.times do |i|\n      width.times do |j|\n\
    \        @sum[i][j + 1] += @sum[i][j]\n      end\n    end\n  end\n\n  def []?(y_start\
    \ : Int, y_count : Int, x_start : Int, x_count : Int) : T?\n    raise ArgumentError.new\
    \ \"Negative y_count: #{y_count}\" unless y_count >= 0\n    raise ArgumentError.new\
    \ \"Negative x_count: #{x_count}\" unless x_count >= 0\n    y_start += height\
    \ if y_start < 0\n    x_start += width if x_start < 0\n\n    if 0 <= y_start <=\
    \ height && 0 <= x_start <= width\n      y_count = Math.min(y_count, height -\
    \ y_start)\n      x_count = Math.min(x_count, width - x_start)\n\n      @sum[y_start\
    \ + y_count][x_start + x_count] - @sum[y_start + y_count][x_start] -\n       \
    \ @sum[y_start][x_start + x_count] + @sum[y_start][x_start]\n    end\n  end\n\n\
    \  def []?(y_range : Range, x_range : Range) : T?\n    ys, yc = Indexable.range_to_index_and_count(y_range,\
    \ height) || return nil\n    xs, xc = Indexable.range_to_index_and_count(x_range,\
    \ width) || return nil\n    self[ys, yc, xs, xc]?\n  end\n\n  def [](ys : Int,\
    \ yc : Int, xs : Int, xc : Int) : T\n    self[ys, yc, xs, xc]? || raise IndexError.new\n\
    \  end\n\n  def [](y_range : Range, x_range : Range) : T\n    self[y_range, x_range]?\
    \ || raise IndexError.new\n  end\n\n  def to_a : Array(Array(T))\n    Array.new(height)\
    \ do |i|\n      Array.new(width) do |j|\n        self[i, 1, j, 1]\n      end\n\
    \    end\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/datastructure/cul_sum_2d.cr
  requiredBy: []
  timestamp: '2021-09-05 07:43:33+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/datastructure/cul_sum_2d_2_test.cr
  - test/datastructure/cul_sum_2d_imos_2d_test.cr
documentation_of: src/datastructure/cul_sum_2d.cr
layout: document
redirect_from:
- /library/src/datastructure/cul_sum_2d.cr
- /library/src/datastructure/cul_sum_2d.cr.html
title: src/datastructure/cul_sum_2d.cr
---
