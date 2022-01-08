---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/array/new.cr
    title: src/array/new.cr
  - icon: ':x:'
    path: src/point.cr
    title: src/point.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "# https://yukicoder.me/problems/no/217\n# require \"../../src/point\"\
    \nstruct Point\n  include Comparable(Point)\n  extend Indexable(Point)\n\n  property\
    \ y : Int32, x : Int32\n\n  Direction4 = [Point.up, Point.left, Point.down, Point.right]\n\
    \  Direction8 = Direction4 + [Point.ul, Point.ur, Point.dl, Point.dr]\n\n  class_getter!\
    \ height : Int32, width : Int32\n\n  def self.set_range(height : Int, width :\
    \ Int)\n    raise ArgumentError.new unless 0 < height && 0 < width\n    @@height,\
    \ @@width = height, width\n  end\n\n  def self.size\n    height * width\n  end\n\
    \n  def self.unsafe_fetch(index : Int)\n    Point.new(index // Point.width, index\
    \ % Point.width)\n  end\n\n  def self.each(h : Int, w : Int, &block)\n    h.times\
    \ do |y|\n      w.times do |x|\n        yield Point[y, x]\n      end\n    end\n\
    \  end\n\n  def self.each(y : Int, w : Int)\n    size.times.map { |i| Point.new(i)\
    \ }\n  end\n\n  def initialize\n    @y, @x = 0, 0\n  end\n\n  def initialize(y\
    \ : Int, x : Int)\n    @y, @x = y.to_i, x.to_i\n  end\n\n  def initialize(i :\
    \ Int)\n    raise ArgumentError.new unless 0 <= i && i < Point.size\n    @y, @x\
    \ = i // Point.width, i % Point.width\n  end\n\n  # Creates point fomr given array.\n\
    \  def self.from(array : Array) : self\n    raise ArgumentError.new unless array.size\
    \ == 2\n    Point.new(array.unsafe_fetch(0), array.unsafe_fetch(1))\n  end\n\n\
    \  # Alias for `.new(y : Int, x : Int)`\n  def self.[](y : Int, x : Int) : self\n\
    \    Point.new(y, x)\n  end\n\n  def self.scan(scanner, io : IO) : self\n    Point.new(scanner.i(io),\
    \ scanner.i(io))\n  end\n\n  {% for name, d in {\n                      :zero\
    \ => {0, 0},\n                      :up => {-1, 0}, :down => {1, 0}, :left =>\
    \ {0, -1}, :right => {0, 1},\n                      :ul => {-1, -1}, :ur => {-1,\
    \ 1}, :dl => {1, -1}, :dr => {1, 1},\n                    } %}\n    {% dy = d[0];\
    \ dx = d[1] %}\n\n    # Returns `Point.new({{dy}}, {{dx}})`\n    def self.{{name.id}}\n\
    \      Point.new({{dy}}, {{dx}})\n    end\n\n    # Returns `self + Point.new({{dy}},\
    \ {{dx}})`\n    def {{name.id}}\n      Point.new(y + {{dy}}, x + {{dx}})\n   \
    \ end\n\n    # Adds `Point.new({{dy}}, {{dx}})`\n    def {{name.id}}!\n      @y\
    \ += {{dy}}\n      @x += {{dx}}\n      self\n    end\n  {% end %}\n\n  {% for\
    \ op in %w[+ - * // %] %}\n    def {{op.id}}(other : Point)\n      Point.new(y\
    \ {{op.id}} other.y, x {{op.id}} other.x)\n    end\n\n    def {{op.id}}(other\
    \ : Int)\n      Point.new(y {{op.id}} other, x {{op.id}} other)\n    end\n  {%\
    \ end %}\n\n  # Returns `Point.new(x, y)`\n  def xy\n    Point.new(x, y)\n  end\n\
    \n  # Returns `Point.new(y, x)`\n  def yx\n    self\n  end\n\n  def dot(other\
    \ : Point)\n    x * other.x + y * other.y\n  end\n\n  def cross(other : Point)\n\
    \    x * other.y - y * other.x\n  end\n\n  # Rotates 90 degrees clockwise.\n \
    \ #\n  # x....      ..x\n  # .....  ->  ...\n  # ....y      ...\n  #         \
    \   ...\n  #            y..\n  #\n  def rotate90!\n    @y, @x = x, Point.height\
    \ - 1 - y\n    self\n  end\n\n  # :ditto:\n  def rotate90\n    dup.rotate90!\n\
    \  end\n\n  # Flips the grid vertically.\n  #\n  # .x....      .....y\n  # ......\
    \  ->  ......\n  # .....y      .x....\n  #\n  def flip_vertically!\n    @y, @x\
    \ = Point.height - y - 1, x\n    self\n  end\n\n  # :ditto:\n  def flip_vertically\n\
    \    dup.flip_vertically!\n  end\n\n  # Flips the grid horizontally.\n  #\n  #\
    \ .x....      ....x.\n  # ......  ->  ......\n  # .....y      y.....\n  #\n  def\
    \ flip_horizontally!\n    @y, @x = y, Point.width - x - 1\n    self\n  end\n\n\
    \  # :ditto:\n  def flip_horizontally\n    dup.flip_horizontally!\n  end\n\n \
    \ def ==(other : Point)\n    x == other.x && y == other.y\n  end\n\n  def <=>(other\
    \ : Point)\n    {y, x} <=> {other.y, other.x}\n  end\n\n  def [](i : Int)\n  \
    \  return y if i == 0\n    return x if i == 1\n    raise IndexError.new\n  end\n\
    \n  def succ\n    raise IndexError.new unless in_range? && self != Point.last\n\
    \    if x < Point.width - 1\n      Point.new(y, x + 1)\n    else\n      Point.new(y\
    \ + 1, 0)\n    end\n  end\n\n  def pred\n    raise IndexError.new unless in_range?\
    \ && self != Point.first\n    if x > 0\n      Point.new(y, x - 1)\n    else\n\
    \      Point.new(y - 1, Point.width - 1)\n    end\n  end\n\n  def in_range?\n\
    \    (0...Point.height).includes?(y) && (0...Point.width).includes?(x)\n  end\n\
    \n  def to_i\n    raise IndexError.new unless in_range?\n    y * Point.width +\
    \ x\n  end\n\n  def distance_square(other : Point)\n    (y - other.y) ** 2 + (x\
    \ - other.x) ** 2\n  end\n\n  def distance(other : Point)\n    Math.sqrt(distance_square(other))\n\
    \  end\n\n  def manhattan(other : Point)\n    (y - other.y).abs + (x - other.x).abs\n\
    \  end\n\n  def chebyshev(other : Point)\n    Math.max((y - other.y).abs, (x -\
    \ other.x).abs)\n  end\n\n  {% for i in [4, 8] %}\n    def adjacent{{i}}(&block)\
    \ : Nil\n      Direction{{i}}.each do |d|\n        yield self + d\n      end\n\
    \    end\n\n    def adjacent{{i}}\n      Direction{{i}}.each.map { |p| self +\
    \ p }\n    end\n\n    def adj{{i}}_in_range(&block) : Nil\n      Direction{{i}}.each\
    \ do |d|\n        point = self + d\n        yield point if point.in_range?\n \
    \     end\n    end\n\n    def adj{{i}}_in_range\n      adjacent{{i}}.select(&.in_range?)\n\
    \    end\n  {% end %}\n\n  # Writes a string representation of the point to *io*.\n\
    \  #\n  # ```\n  # Point.new(1, 2).to_s # => \"(1, 2)\"\n  # ```\n  def to_s(io\
    \ : IO) : Nil\n    io << '(' << y << \", \" << x << ')'\n  end\n\n  # Writes a\
    \ string representation of the point to *io*.\n  #\n  # ```\n  # Point.new(1,\
    \ 2).inspect # => \"(1, 2)\"\n  # ```\n  def inspect(io : IO) : Nil\n    to_s(io)\n\
    \  end\n\n  # Convert `Point` into `Char` representing direction.\n  #\n  # ```\n\
    \  # Point.down.to_direction_char? # => 'D'\n  # Point.left.to_direction_char?\
    \ # => 'L'\n  # ```\n  def to_direction_char?(lrud = \"LRUD\") : Char?\n    if\
    \ y == 0 && x != 0\n      x < 0 ? lrud[0] : lrud[1]\n    elsif x == 0 && y !=\
    \ 0\n      y < 0 ? lrud[2] : lrud[3]\n    end\n  end\n\n  # Convert `Char` representing\
    \ direction into `Point`.\n  #\n  # ```\n  # Point.to_direction?('R') # => Point.new(0,\
    \ 1)\n  # ```\n  def self.to_direction?(c : Char, lrud = \"LRUD\")\n    raise\
    \ ArgumentError.new unless lrud.size == 4\n    lrud.index(c).try { |i| {left,\
    \ right, up, down}[i] }\n  end\n\n  # Convert `String` representing direction\
    \ into `Point`.\n  #\n  # ```\n  # Point.to_direction?(\"DR\") # => Point.new(1,\
    \ 1)\n  # ```\n  def self.to_direction?(s : String, lrud = \"LRUD\")\n    case\
    \ s.size\n    when 1\n      to_direction?(s[0], lrud)\n    when 2\n      p1 =\
    \ to_direction?(s[0], lrud) || return nil\n      p2 = to_direction?(s[1], lrud)\
    \ || return nil\n      return nil unless p1.x ^ p2.x != 0 && p1.y ^ p2.y != 0\n\
    \      p1 + p2\n    end\n  end\nend\n\nmodule Indexable(T)\n  private def check_index_out_of_bounds(point\
    \ : Point)\n    check_index_out_of_bounds(point) { raise IndexError.new }\n  end\n\
    \n  private def check_index_out_of_bounds(point : Point)\n    if 0 <= point.y\
    \ < size && 0 <= point.x < unsafe_fetch(point.y).size\n      point\n    else\n\
    \      yield\n    end\n  end\n\n  def fetch(point : Point)\n    point = check_index_out_of_bounds(point)\
    \ do\n      return yield point\n    end\n    unsafe_fetch(point.y)[point.x]\n\
    \  end\n\n  def [](point : Point)\n    fetch(point) { raise IndexError.new }\n\
    \  end\n\n  def []?(point : Point)\n    fetch(point, nil)\n  end\nend\n\nclass\
    \ Array(T)\n  def []=(point : Point, value)\n    index = check_index_out_of_bounds\
    \ point\n    @buffer[index.y][index.x] = value\n  end\nend\n\n# require \"../../src/array/new\"\
    \nclass Array\n  def self.new(sizes : Tuple(*T), initial_value) forall T\n   \
    \ {% begin %}\n      {% for i in 0...T.size %} Array.new(sizes[{{i}}]) { {% end\
    \ %}\n      initial_value\n      {% for i in 0...T.size %} } {% end %}\n    {%\
    \ end %}\n  end\n\n  def self.new(sizes : Tuple(*T), &block) forall T\n    {%\
    \ begin %}\n      {% for i in 0...T.size %} Array.new(sizes[{{i}}]) { |index{{i}}|\
    \ {% end %}\n      yield({% for i in 0...T.size %} index{{i}}, {% end %})\n  \
    \    {% for i in 0...T.size %} } {% end %}\n    {% end %}\n  end\nend\n\nrequire\
    \ \"spec\"\n\nprivate module MagicSquare\n  extend self\n\n  def generate_odd(n)\n\
    \    a = Array.new({n, n}, nil.as(Int32?))\n    k = 0\n    p = Point[0, n // 2]\n\
    \    loop do\n      a[p %= n] = (k += 1)\n      if a[p.ur % n].nil?\n        p.ur!\n\
    \      elsif a[p.down % n].nil?\n        p.down!\n      else\n        break\n\
    \      end\n    end\n    a.map &.map &.not_nil!\n  end\n\n  def generate_4x(n)\n\
    \    a = Array.new({n, n}, nil.as(Int32?))\n    Point.each do |p|\n      p2 =\
    \ p % 4\n      if p2.x == p2.y || p2.x + p2.y == 3\n        a[p] = p.to_i + 1\n\
    \      end\n    end\n    Point.reverse_each do |p|\n      if a[p].nil?\n     \
    \   a[p] = n * n - p.to_i\n      end\n    end\n    a.map &.map &.not_nil!\n  end\n\
    \n  LUX = [\n    [[4, 1], [2, 3]],\n    [[1, 4], [2, 3]],\n    [[1, 4], [3, 2]],\n\
    \  ]\n\n  def generate_4x2(n)\n    k = n // 4\n    m = k * 2 + 1\n    b = generate_odd(m).map\
    \ &.map { |x| x.pred * 4 }\n    a = Array.new({n, n}, 0)\n    Point.each(m, m)\
    \ do |p|\n      index = if (p.y <= k && p != Point[k, k]) || p == Point[k + 1,\
    \ k]\n                0\n              elsif p.y <= k + 1\n                1\n\
    \              else\n                2\n              end\n      {Point.zero,\
    \ Point.right, Point.down, Point.dr}.each do |d|\n        a[p * 2 + d] = LUX[index][d]\
    \ + b[p]\n      end\n    end\n    a\n  end\n\n  def generate(n)\n    Point.set_range(n,\
    \ n)\n    case n\n    when .odd?             then generate_odd(n)\n    when .divisible_by?(4)\
    \ then generate_4x(n)\n    else                        generate_4x2(n)\n    end\n\
    \  end\n\n  def check(n, a)\n    sum = n * (n * n + 1) // 2\n    a.size == n &&\n\
    \      a.all? { |b| b.size == n } &&\n      a.flatten.sort! == (1..n * n).to_a\
    \ &&\n      a.all? { |b| b.sum == sum } &&\n      a.transpose.all? { |b| b.sum\
    \ == sum }\n  end\nend\n\ndescribe Point do\n  it \"magic square\" do\n    (3..500).each\
    \ do |n|\n      magic_square = MagicSquare.generate(n)\n      MagicSquare.check(n,\
    \ magic_square).should be_true\n    end\n  end\nend\n"
  code: "# https://yukicoder.me/problems/no/217\nrequire \"../../src/point\"\nrequire\
    \ \"../../src/array/new\"\nrequire \"spec\"\n\nprivate module MagicSquare\n  extend\
    \ self\n\n  def generate_odd(n)\n    a = Array.new({n, n}, nil.as(Int32?))\n \
    \   k = 0\n    p = Point[0, n // 2]\n    loop do\n      a[p %= n] = (k += 1)\n\
    \      if a[p.ur % n].nil?\n        p.ur!\n      elsif a[p.down % n].nil?\n  \
    \      p.down!\n      else\n        break\n      end\n    end\n    a.map &.map\
    \ &.not_nil!\n  end\n\n  def generate_4x(n)\n    a = Array.new({n, n}, nil.as(Int32?))\n\
    \    Point.each do |p|\n      p2 = p % 4\n      if p2.x == p2.y || p2.x + p2.y\
    \ == 3\n        a[p] = p.to_i + 1\n      end\n    end\n    Point.reverse_each\
    \ do |p|\n      if a[p].nil?\n        a[p] = n * n - p.to_i\n      end\n    end\n\
    \    a.map &.map &.not_nil!\n  end\n\n  LUX = [\n    [[4, 1], [2, 3]],\n    [[1,\
    \ 4], [2, 3]],\n    [[1, 4], [3, 2]],\n  ]\n\n  def generate_4x2(n)\n    k = n\
    \ // 4\n    m = k * 2 + 1\n    b = generate_odd(m).map &.map { |x| x.pred * 4\
    \ }\n    a = Array.new({n, n}, 0)\n    Point.each(m, m) do |p|\n      index =\
    \ if (p.y <= k && p != Point[k, k]) || p == Point[k + 1, k]\n                0\n\
    \              elsif p.y <= k + 1\n                1\n              else\n   \
    \             2\n              end\n      {Point.zero, Point.right, Point.down,\
    \ Point.dr}.each do |d|\n        a[p * 2 + d] = LUX[index][d] + b[p]\n      end\n\
    \    end\n    a\n  end\n\n  def generate(n)\n    Point.set_range(n, n)\n    case\
    \ n\n    when .odd?             then generate_odd(n)\n    when .divisible_by?(4)\
    \ then generate_4x(n)\n    else                        generate_4x2(n)\n    end\n\
    \  end\n\n  def check(n, a)\n    sum = n * (n * n + 1) // 2\n    a.size == n &&\n\
    \      a.all? { |b| b.size == n } &&\n      a.flatten.sort! == (1..n * n).to_a\
    \ &&\n      a.all? { |b| b.sum == sum } &&\n      a.transpose.all? { |b| b.sum\
    \ == sum }\n  end\nend\n\ndescribe Point do\n  it \"magic square\" do\n    (3..500).each\
    \ do |n|\n      magic_square = MagicSquare.generate(n)\n      MagicSquare.check(n,\
    \ magic_square).should be_true\n    end\n  end\nend\n"
  dependsOn:
  - src/point.cr
  - src/array/new.cr
  isVerificationFile: false
  path: spec/point/magic_square_spec.cr
  requiredBy: []
  timestamp: '2022-01-08 20:25:18+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/point/magic_square_spec.cr
layout: document
redirect_from:
- /library/spec/point/magic_square_spec.cr
- /library/spec/point/magic_square_spec.cr.html
title: spec/point/magic_square_spec.cr
---