---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/point.cr
    title: src/point.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://onlinejudge.u-aizu.ac.jp/challenges/sources/VPC/HUPC/3185
  bundledCode: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/challenges/sources/VPC/HUPC/3185\n\
    # require \"../../src/point\"\nstruct Point\n  include Comparable(Point)\n  extend\
    \ Indexable(Point)\n\n  property y : Int32, x : Int32\n\n  Direction4 = [Point.up,\
    \ Point.left, Point.down, Point.right]\n  Direction8 = Direction4 + [Point.ul,\
    \ Point.ur, Point.dl, Point.dr]\n\n  class_getter! height : Int32, width : Int32\n\
    \n  def self.set_range(height : Int32, width : Int32)\n    raise ArgumentError.new\
    \ unless 0 < height && 0 < width\n    @@height, @@width = height, width\n  end\n\
    \n  def self.size\n    height * width\n  end\n\n  def self.unsafe_fetch(index\
    \ : Int)\n    Point.new(index // Point.width, index % Point.width)\n  end\n\n\
    \  def initialize\n    @y, @x = 0, 0\n  end\n\n  def initialize(@y : Int32, @x\
    \ : Int32)\n  end\n\n  def initialize(i : Int32)\n    raise ArgumentError.new\
    \ unless 0 <= i && i < Point.size\n    @y, @x = i // Point.width, i % Point.width\n\
    \  end\n\n  def self.from(array : Array(Int32)) : self\n    raise ArgumentError.new\
    \ unless array.size == 2\n    Point.new(array.unsafe_fetch(0), array.unsafe_fetch(1))\n\
    \  end\n\n  def self.[](y : Int32, x : Int32) : self\n    Point.new(y, x)\n  end\n\
    \n  private macro define_direction(name, dy, dx)\n    def self.{{name}}\n    \
    \  Point.new({{dy}}, {{dx}})\n    end\n\n    def {{name}}\n      Point.new(y +\
    \ {{dy}}, x + {{dx}})\n    end\n  end\n\n  define_direction(zero, 0, 0)\n  define_direction(up,\
    \ -1, 0)\n  define_direction(left, 0, -1)\n  define_direction(down, 1, 0)\n  define_direction(right,\
    \ 0, 1)\n  define_direction(ul, -1, -1)\n  define_direction(ur, -1, 1)\n  define_direction(dl,\
    \ 1, -1)\n  define_direction(dr, 1, 1)\n\n  {% for op in %w[+ - * // %] %}\n \
    \   def {{op.id}}(other : Point)\n      Point.new(y {{op.id}} other.y, x {{op.id}}\
    \ other.x)\n    end\n\n    def {{op.id}}(other : Int32)\n      Point.new(y {{op.id}}\
    \ other, x {{op.id}} other)\n    end\n  {% end %}\n\n  def xy\n    Point.new(x,\
    \ y)\n  end\n\n  def yx\n    self\n  end\n\n  def ==(other : Point)\n    x ==\
    \ other.x && y == other.y\n  end\n\n  def <=>(other : Point)\n    to_i <=> other.to_i\n\
    \  end\n\n  def [](i : Int32)\n    return y if i == 0\n    return x if i == 1\n\
    \    raise IndexError.new\n  end\n\n  def succ\n    raise IndexError.new unless\
    \ in_range? && self != Point.last\n    if x < Point.width - 1\n      Point.new(y,\
    \ x + 1)\n    else\n      Point.new(y + 1, 0)\n    end\n  end\n\n  def pred\n\
    \    raise IndexError.new unless in_range? && self != Point.first\n    if x >\
    \ 0\n      Point.new(y, x - 1)\n    else\n      Point.new(y - 1, Point.width -\
    \ 1)\n    end\n  end\n\n  def in_range?\n    (0...Point.height).includes?(y) &&\
    \ (0...Point.width).includes?(x)\n  end\n\n  def to_i : Int32\n    raise IndexError.new\
    \ unless in_range?\n    y * Point.width + x\n  end\n\n  def distance_square(other\
    \ : Point)\n    (y - other.y) ** 2 + (x - other.x) ** 2\n  end\n\n  def distance(other\
    \ : Point)\n    Math.sqrt(distance_square(other))\n  end\n\n  def manhattan(other\
    \ : Point)\n    (y - other.y).abs + (x - other.x).abs\n  end\n\n  def chebyshev(other\
    \ : Point)\n    Math.max((y - other.y).abs, (x - other.x).abs)\n  end\n\n  {%\
    \ for i in [4, 8] %}\n    def adjacent{{i}}(&block) : Nil\n      Direction{{i}}.each\
    \ do |d|\n        yield self + d\n      end\n    end\n\n    def adjacent{{i}}\n\
    \      Direction{{i}}.each.map { |p| self + p }\n    end\n\n    def adj{{i}}_in_range(&block)\
    \ : Nil\n      Direction{{i}}.each do |d|\n        point = self + d\n        yield\
    \ point if point.in_range?\n      end\n    end\n\n    def adj{{i}}_in_range\n\
    \      adjacent{{i}}.select(&.in_range?)\n    end\n  {% end %}\n\n  def to_s(io\
    \ : IO) : Nil\n    io << '(' << y << \", \" << x << ')'\n  end\n\n  def inspect(io\
    \ : IO) : Nil\n    to_s(io)\n  end\n\n  def to_direction_char?(lrud = \"LRUD\"\
    ) : Char?\n    if y == 0 && x != 0\n      x < 0 ? lrud[0] : lrud[1]\n    elsif\
    \ x == 0 && y != 0\n      y < 0 ? lrud[2] : lrud[3]\n    end\n  end\n\n  def self.to_direction?(c\
    \ : Char, lrud = \"LRUD\")\n    raise ArgumentError.new unless lrud.size == 4\n\
    \    lrud.index(c).try { |i| {left, right, up, down}[i] }\n  end\n\n  def self.to_direction?(s\
    \ : String, lrud = \"LRUD\")\n    case s.size\n    when 1\n      to_direction?(s[0],\
    \ lrud)\n    when 2\n      p1 = to_direction?(s[0], lrud) || return nil\n    \
    \  p2 = to_direction?(s[1], lrud) || return nil\n      return nil unless p1.x\
    \ ^ p2.x != 0 && p1.y ^ p2.y != 0\n      p1 + p2\n    end\n  end\nend\n\nmodule\
    \ Indexable(T)\n  private def check_index_out_of_bounds(point : Point)\n    check_index_out_of_bounds(point)\
    \ { raise IndexError.new }\n  end\n\n  private def check_index_out_of_bounds(point\
    \ : Point)\n    if 0 <= point.y < size && 0 <= point.x < unsafe_fetch(point.y).size\n\
    \      point\n    else\n      yield\n    end\n  end\n\n  def fetch(point : Point)\n\
    \    point = check_index_out_of_bounds(point) do\n      return yield point\n \
    \   end\n    unsafe_fetch(point.y)[point.x]\n  end\n\n  def [](point : Point)\n\
    \    fetch(point) { raise IndexError.new }\n  end\n\n  def []?(point : Point)\n\
    \    fetch(point, nil)\n  end\nend\n\nclass Array(T)\n  def []=(point : Point,\
    \ value)\n    index = check_index_out_of_bounds point\n    @buffer[index.y][index.x]\
    \ = value\n  end\nend\n\nh, w = read_line.split.map(&.to_i)\ns = (1..h).map {\
    \ read_line }\nd = Point.to_direction?(read_line, \"EWSN\").not_nil!\nPoint.set_range(h,\
    \ w)\nputs Point.select { |p| s[p] == '#' }.max_of { |p|\n  cnt = 0\n  while p.in_range?\n\
    \    cnt += 1\n    p += d\n  end\n  cnt\n}\n"
  code: "# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/challenges/sources/VPC/HUPC/3185\n\
    require \"../../src/point\"\nh, w = read_line.split.map(&.to_i)\ns = (1..h).map\
    \ { read_line }\nd = Point.to_direction?(read_line, \"EWSN\").not_nil!\nPoint.set_range(h,\
    \ w)\nputs Point.select { |p| s[p] == '#' }.max_of { |p|\n  cnt = 0\n  while p.in_range?\n\
    \    cnt += 1\n    p += d\n  end\n  cnt\n}\n"
  dependsOn:
  - src/point.cr
  isVerificationFile: true
  path: test/point/point_to_direction.test.cr
  requiredBy: []
  timestamp: '2021-07-18 13:52:56+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/point/point_to_direction.test.cr
layout: document
redirect_from:
- /verify/test/point/point_to_direction.test.cr
- /verify/test/point/point_to_direction.test.cr.html
title: test/point/point_to_direction.test.cr
---
