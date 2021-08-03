---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/datastructure/cul_sum_2d.cr
    title: src/datastructure/cul_sum_2d.cr
  - icon: ':heavy_check_mark:'
    path: src/datastructure/imos_2d.cr
    title: src/datastructure/imos_2d.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://yukicoder.me/problems/no/1490
  bundledCode: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/1490\n\
    # require \"../../src/datastructure/imos_2d\"\nclass Imos2D(T)\n  getter height\
    \ : Int32, width : Int32\n  @builded = false\n\n  def initialize(@height, @width,\
    \ init_val : T = T.zero)\n    @table = Array(Array(T)).new(@height + 1) do\n \
    \     Array(T).new(@width + 1, init_val)\n    end\n  end\n\n  def add(ys : Int,\
    \ yc : Int, xs : Int, xc : Int, val : T) : Nil\n    raise \"self had been called\
    \ `build`\" if @builded\n    raise ArgumentError.new \"Negative count: #{yc}\"\
    \ if yc < 0\n    raise ArgumentError.new \"Negative count: #{xc}\" if xc < 0\n\
    \    @table[ys + yc][xs + xc] += val\n    @table[ys + yc][xs] -= val\n    @table[ys][xs\
    \ + xc] -= val\n    @table[ys][xs] += val\n  end\n\n  def add(y : Range, x : Range,\
    \ val : T) : Nil\n    ys, yc = Indexable.range_to_index_and_count(y, height) ||\
    \ raise IndexError.new\n    xs, xc = Indexable.range_to_index_and_count(x, width)\
    \ || raise IndexError.new\n    add(ys, yc, xs, xc, val)\n  end\n\n  def build\
    \ : Array(Array(T))\n    raise \"self had been called `#build`\" if @builded\n\
    \    @builded = true\n    (0..height).each do |y|\n      (1..width).each do |x|\n\
    \        @table[y][x] += @table[y][x - 1]\n      end\n    end\n    (1..height).each\
    \ do |y|\n      (0..width).each do |x|\n        @table[y][x] += @table[y - 1][x]\n\
    \      end\n    end\n    (0...height).map { |i| @table[i][0...width] }\n  end\n\
    \n  def [](y : Int32, x : Int32) : T\n    raise \"self had not been called `#build`\"\
    \ unless @builded\n    @table[y][x]\n  end\nend\n\n# require \"../../src/datastructure/cul_sum_2d\"\
    \nclass CulSum2D(T)\n  getter height : Int32, width : Int32\n\n  def initialize(a\
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
    \    end\n  end\nend\n\nh, w, n, m = read_line.split.map(&.to_i)\ntulra = (1..n).map\
    \ { read_line.split.map(&.to_i) }\nimos = Imos2D(Int64).new(h, w)\nm.times do\n\
    \  x, y, b, c = read_line.split.map(&.to_i)\n  x_range = {x - 1 - b, 0}.max...{x\
    \ + b, h}.min\n  y_range = {y - 1 - b, 0}.max...{y + b, w}.min\n  imos.add(x_range,\
    \ y_range, c.to_i64)\nend\nimos.build\nsum = CulSum2D(Int64).new(h, w) { |i, j|\
    \ imos[i, j] }\n\nputs tulra.count { |(t, u, l, r, a)|\n  sum[t - 1...u, l - 1...r]\
    \ < a\n}\n"
  code: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/1490\nrequire\
    \ \"../../src/datastructure/imos_2d\"\nrequire \"../../src/datastructure/cul_sum_2d\"\
    \nh, w, n, m = read_line.split.map(&.to_i)\ntulra = (1..n).map { read_line.split.map(&.to_i)\
    \ }\nimos = Imos2D(Int64).new(h, w)\nm.times do\n  x, y, b, c = read_line.split.map(&.to_i)\n\
    \  x_range = {x - 1 - b, 0}.max...{x + b, h}.min\n  y_range = {y - 1 - b, 0}.max...{y\
    \ + b, w}.min\n  imos.add(x_range, y_range, c.to_i64)\nend\nimos.build\nsum =\
    \ CulSum2D(Int64).new(h, w) { |i, j| imos[i, j] }\n\nputs tulra.count { |(t, u,\
    \ l, r, a)|\n  sum[t - 1...u, l - 1...r] < a\n}\n"
  dependsOn:
  - src/datastructure/imos_2d.cr
  - src/datastructure/cul_sum_2d.cr
  isVerificationFile: true
  path: test/datastructure/cul_sum_2d_2.test.cr
  requiredBy: []
  timestamp: '2021-08-02 17:45:48+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/datastructure/cul_sum_2d_2.test.cr
layout: document
redirect_from:
- /verify/test/datastructure/cul_sum_2d_2.test.cr
- /verify/test/datastructure/cul_sum_2d_2.test.cr.html
title: test/datastructure/cul_sum_2d_2.test.cr
---
