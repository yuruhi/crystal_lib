---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: datastructure/CulSum2D.cr
    title: datastructure/CulSum2D.cr
  - icon: ':heavy_check_mark:'
    path: datastructure/Imos2D.cr
    title: datastructure/Imos2D.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://yukicoder.me/problems/no/1490
  bundledCode: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/1490\n\
    # require \"../datastructure/Imos2D\"\nclass Imos2D(T)\n  getter height : Int32\n\
    \  getter width : Int32\n  @builded = false\n\n  def initialize(@height, @width,\
    \ init_val : T = T.zero)\n    @table = Array(Array(T)).new(@height + 1) do\n \
    \     Array(T).new(@width + 1, init_val)\n    end\n  end\n\n  def add(ys : Int32,\
    \ yc : Int32, xs : Int32, xc : Int32, val : T) : Nil\n    raise \"self had been\
    \ called `build`\" if @builded\n    raise ArgumentError.new \"Negative count:\
    \ #{yc}\" if yc < 0\n    raise ArgumentError.new \"Negative count: #{xc}\" if\
    \ xc < 0\n    @table[ys + yc][xs + xc] += val\n    @table[ys + yc][xs] -= val\n\
    \    @table[ys][xs + xc] -= val\n    @table[ys][xs] += val\n  end\n\n  def add(y\
    \ : Range, x : Range, val : T)\n    ys, yc = Indexable.range_to_index_and_count(y,\
    \ height) || raise IndexError.new\n    xs, xc = Indexable.range_to_index_and_count(x,\
    \ width) || raise IndexError.new\n    add(ys, yc, xs, xc, val)\n  end\n\n  def\
    \ build : Array(Array(T))\n    raise \"self had been called `build`\" if @builded\n\
    \    @builded = true\n    (0..height).each do |y|\n      (1..width).each do |x|\n\
    \        @table[y][x] += @table[y][x - 1]\n      end\n    end\n    (1..height).each\
    \ do |y|\n      (0..width).each do |x|\n        @table[y][x] += @table[y - 1][x]\n\
    \      end\n    end\n    (0...height).map { |i| @table[i][0...width] }\n  end\n\
    \n  def [](y : Int32, x : Int32) : T\n    raise IndexError.new unless 0 <= y <\
    \ height\n    raise IndexError.new unless 0 <= x < width\n    @table[y][x]\n \
    \ end\nend\n\n# require \"../datastructure/CulSum2D\"\nclass CulSum2D(T)\n  getter\
    \ height : Int32\n  getter width : Int32\n\n  def initialize(a : Array(Array(T)))\n\
    \    @height = a.size\n    raise ArgumentError.new unless height > 0\n    @width\
    \ = a[0].size\n    raise ArgumentError.new unless a.map(&.size).all?(width)\n\n\
    \    @s = Array(Array(T)).new(height + 1) { Array.new(width + 1, T.zero) }\n \
    \   (0...height).each do |i|\n      (0...width).each do |j|\n        @s[i + 1][j\
    \ + 1] = @s[i][j + 1] + @s[i + 1][j] - @s[i][j] + a[i][j]\n      end\n    end\n\
    \  end\n\n  def initialize(@height : Int32, @width : Int32, &f : Int32, Int32\
    \ -> T)\n    raise ArgumentError.new unless height > 0\n    raise ArgumentError.new\
    \ unless width > 0\n    @s = Array(Array(T)).new(height + 1) { Array.new(width\
    \ + 1, T.zero) }\n    (0...height).each do |i|\n      (0...width).each do |j|\n\
    \        @s[i + 1][j + 1] = @s[i][j + 1] + @s[i + 1][j] - @s[i][j] + yield(i,\
    \ j)\n      end\n    end\n  end\n\n  def [](y_start, y_count, x_start, x_count)\n\
    \    @s[y_start + y_count][x_start + x_count] - @s[y_start + y_count][x_start]\
    \ -\n      @s[y_start][x_start + x_count] + @s[y_start][x_start]\n  end\n\n  def\
    \ [](y_range : Range, x_range : Range)\n    ys, yc = Indexable.range_to_index_and_count(y_range,\
    \ height) || raise IndexError.new\n    xs, xc = Indexable.range_to_index_and_count(x_range,\
    \ width) || raise IndexError.new\n    self[ys, yc, xs, xc]\n  end\n\n  def to_a\n\
    \    (0...@n).map { |i| self[i..i] }\n  end\nend\n\nh, w, n, m = read_line.split.map(&.to_i)\n\
    tulra = (1..n).map { read_line.split.map(&.to_i) }\nimos = Imos2D(Int64).new(h,\
    \ w)\nm.times do\n  x, y, b, c = read_line.split.map(&.to_i)\n  x_range = {x -\
    \ 1 - b, 0}.max...{x + b, h}.min\n  y_range = {y - 1 - b, 0}.max...{y + b, w}.min\n\
    \  imos.add(x_range, y_range, c.to_i64)\nend\nsum = CulSum2D.new(imos.build)\n\
    \nputs tulra.count { |(t, u, l, r, a)|\n  sum[t - 1...u, l - 1...r] < a\n}\n"
  code: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/1490\nrequire\
    \ \"../datastructure/Imos2D\"\nrequire \"../datastructure/CulSum2D\"\nh, w, n,\
    \ m = read_line.split.map(&.to_i)\ntulra = (1..n).map { read_line.split.map(&.to_i)\
    \ }\nimos = Imos2D(Int64).new(h, w)\nm.times do\n  x, y, b, c = read_line.split.map(&.to_i)\n\
    \  x_range = {x - 1 - b, 0}.max...{x + b, h}.min\n  y_range = {y - 1 - b, 0}.max...{y\
    \ + b, w}.min\n  imos.add(x_range, y_range, c.to_i64)\nend\nsum = CulSum2D.new(imos.build)\n\
    \nputs tulra.count { |(t, u, l, r, a)|\n  sum[t - 1...u, l - 1...r] < a\n}\n"
  dependsOn:
  - datastructure/Imos2D.cr
  - datastructure/CulSum2D.cr
  isVerificationFile: true
  path: test/CulSum2D_Imos2D.test.cr
  requiredBy: []
  timestamp: '2021-06-13 15:10:12+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/CulSum2D_Imos2D.test.cr
layout: document
redirect_from:
- /verify/test/CulSum2D_Imos2D.test.cr
- /verify/test/CulSum2D_Imos2D.test.cr.html
title: test/CulSum2D_Imos2D.test.cr
---
