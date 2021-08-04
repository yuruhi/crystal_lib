---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: src/point.cr
    title: src/point.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../src/point\"\nstruct Point\n  include\
    \ Comparable(Point)\n  extend Indexable(Point)\n\n  property y : Int32, x : Int32\n\
    \n  Direction4 = [Point.up, Point.left, Point.down, Point.right]\n  Direction8\
    \ = Direction4 + [Point.ul, Point.ur, Point.dl, Point.dr]\n\n  class_getter! height\
    \ : Int32, width : Int32\n\n  def self.set_range(height : Int32, width : Int32)\n\
    \    raise ArgumentError.new unless 0 < height && 0 < width\n    @@height, @@width\
    \ = height, width\n  end\n\n  def self.size\n    height * width\n  end\n\n  def\
    \ self.unsafe_fetch(index : Int)\n    Point.new(index // Point.width, index %\
    \ Point.width)\n  end\n\n  def initialize\n    @y, @x = 0, 0\n  end\n\n  def initialize(@y\
    \ : Int32, @x : Int32)\n  end\n\n  def initialize(i : Int32)\n    raise ArgumentError.new\
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
    \ = value\n  end\nend\n\nmacro check_direction(name, dy, dx)\n\tit \".{{name}}\"\
    \ do\n\t  Point.{{name}}.should eq Point.new({{dy}}, {{dx}})\n\tend\n\tit \"#\"\
    \ + \"{{name}}\" do\n\t\tPoint.new(1, 1).{{name}}.should eq Point.new(1 + {{dy}},\
    \ 1 + {{dx}})\n\tend\nend\n\nmacro check_binary_operator(op)\n\tit \"\\#{{op.id}}\"\
    \ do\n\t\ta, b = Point.new(1, 2), Point.new(3, 4)\n\t\t(a {{op.id}} b).should\
    \ eq Point.new(1 {{op.id}} 3, 2 {{op.id}} 4)\n\t\t(a {{op.id}} 5).should eq Point.new(1\
    \ {{op.id}} 5, 2 {{op.id}} 5)\n\tend\nend\n\nH = 3\nW = 4\n\ndescribe Point do\n\
    \  it \".set_range and .height and .width\" do\n    expect_raises(NilAssertionError)\
    \ { Point.height }\n    expect_raises(NilAssertionError) { Point.width }\n   \
    \ Point.height?.should be_nil\n    Point.width?.should be_nil\n    Point.set_range(H,\
    \ W)\n    Point.height.should eq H\n    Point.width.should eq W\n    Point.height?.should\
    \ eq H\n    Point.width?.should eq W\n  end\n\n  it \".size\" do\n    Point.size.should\
    \ eq H*W\n  end\n\n  it \"extend Indexable(Point)\" do\n    array = (0...H).to_a.product((0...W).to_a).map\
    \ { |y, x| Point.new(y, x) }\n    Point.to_a.should eq array\n    Point[0].should\
    \ eq Point.new(0, 0)\n    expect_raises(IndexError) { Point[H*W] }\n  end\n\n\
    \  it \".new\" do\n    Point.new.should eq Point.new(0, 0)\n    Point.new(H, W).should\
    \ eq Point.new(H, W)\n  end\n\n  it \".from\" do\n    Point.from([0, 1]).should\
    \ eq Point.new(0, 1)\n    expect_raises(ArgumentError) do\n      Point.from [0]\n\
    \      Point.from [0, 1, 2]\n    end\n  end\n\n  it \".[](y, x)\" do\n    Point[1,\
    \ 1].should eq Point.new(1, 1)\n  end\n\n  check_direction(zero, 0, 0)\n  check_direction(up,\
    \ -1, 0)\n  check_direction(left, 0, -1)\n  check_direction(down, 1, 0)\n  check_direction(right,\
    \ 0, 1)\n  check_direction(ul, -1, -1)\n  check_direction(ur, -1, 1)\n  check_direction(dl,\
    \ 1, -1)\n  check_direction(dr, 1, 1)\n\n  check_binary_operator(\"+\")\n  check_binary_operator(\"\
    -\")\n  check_binary_operator(\"*\")\n  check_binary_operator(\"//\")\n  check_binary_operator(\"\
    %\")\n\n  it \"#xy\" do\n    Point.new(1, 2).xy.should eq Point.new(2, 1)\n  end\n\
    \n  it \"#yx\" do\n    Point.new(1, 2).yx.should eq Point.new(1, 2)\n  end\n\n\
    \  it \"#==(other)\" do\n    Point.each do |p1|\n      Point.each do |p2|\n  \
    \      (p1 == p2).should eq ({p1.y, p1.x} == {p2.y, p2.x})\n      end\n    end\n\
    \  end\n\n  it \"#<=>(other)\" do\n    Point.each do |p1|\n      Point.each do\
    \ |p2|\n        (p1 <=> p2).should eq ({p1.y, p1.x} <=> {p2.y, p2.x})\n      end\n\
    \    end\n  end\n\n  it \"include Comparable(Point)\" do\n    Point.new(2, 2).clamp(Point.new(0,\
    \ 0), Point.new(1, 1)).should eq Point.new(1, 1)\n  end\n\n  it \"#[]\" do\n \
    \   a = Point.new(1, 2)\n    a[0].should eq 1\n    a[1].should eq 2\n    expect_raises(IndexError)\
    \ { a[-1] }\n    expect_raises(IndexError) { a[2] }\n    x, y = a\n    [x, y].should\
    \ eq [1, 2]\n  end\n\n  it \"#succ\" do\n    Point.new(1, 2).succ.should eq Point.new(1,\
    \ 3)\n    Point.new(1, W - 1).succ.should eq Point.new(2, 0)\n    expect_raises(IndexError)\
    \ { Point.new(H - 1, W - 1).succ }\n    expect_raises(IndexError) { Point.new(0,\
    \ -1).succ }\n    expect_raises(IndexError) { Point.new(H, 0).succ }\n  end\n\n\
    \  it \"#pred\" do\n    Point.new(1, 2).pred.should eq Point.new(1, 1)\n    Point.new(1,\
    \ 0).pred.should eq Point.new(0, W - 1)\n    expect_raises(IndexError) { Point.new(0,\
    \ 0).pred }\n    expect_raises(IndexError) { Point.new(0, -1).pred }\n    expect_raises(IndexError)\
    \ { Point.new(H, 0).pred }\n  end\n\n  it \"#in_range?\" do\n    (-2..H + 2).each\
    \ do |y|\n      (-2..W + 2).each do |x|\n        flag = (0...H).includes?(y) &&\
    \ (0...W).includes?(x)\n        Point.new(y, x).in_range?.should eq flag\n   \
    \   end\n    end\n  end\n\n  it \"#to_i\" do\n    i = 0\n    Point.each do |p|\n\
    \      p.to_i.should eq i\n      i += 1\n    end\n    expect_raises(IndexError)\
    \ { Point.new(-1, 0).to_i }\n    expect_raises(IndexError) { Point.new(H, 0).to_i\
    \ }\n  end\n\n  it \"#distance_square\" do\n    Point.new(3, 4).distance_square(Point.new(7,\
    \ 9)).should eq 41\n    Point.new(3, 4).distance_square(Point.new(3, 0)).should\
    \ eq 16\n    Point.new(3, 4).distance_square(Point.new(3, 4)).should eq 0\n  end\n\
    \n  it \"#distance\" do\n    Point.new(3, 4).distance(Point.new(7, 9)).should\
    \ eq Math.sqrt(41)\n    Point.new(3, 4).distance(Point.new(3, 0)).should eq 4.0\n\
    \    Point.new(3, 4).distance(Point.new(3, 4)).should eq 0\n  end\n\n  it \"#manhattan\"\
    \ do\n    Point.new(3, 4).manhattan(Point.new(7, 9)).should eq 9\n    Point.new(3,\
    \ 4).manhattan(Point.new(3, 0)).should eq 4\n    Point.new(3, 4).manhattan(Point.new(3,\
    \ 4)).should eq 0\n  end\n\n  it \"#chebyshev\" do\n    Point.new(3, 4).manhattan(Point.new(7,\
    \ 9)).should eq 9\n    Point.new(3, 4).manhattan(Point.new(3, 0)).should eq 4\n\
    \    Point.new(3, 4).manhattan(Point.new(3, 4)).should eq 0\n  end\n\n  it \"\
    #adjacent4\" do\n    a = Point.new(3, 4)\n    a.adjacent4.should be_a(Iterator(Point))\n\
    \    expect = [a.up, a.left, a.down, a.right]\n    a.adjacent4.to_a.should eq\
    \ expect\n\n    res = [] of Point\n    a.adjacent4 { |p| res << p }\n    res.should\
    \ eq expect\n  end\n\n  it \"#adj4_in_range\" do\n    Point.new.adj4_in_range.should\
    \ be_a(Iterator(Point))\n    a = Point.new(H - 1, W - 1)\n    a.adj4_in_range.to_a.should\
    \ eq [a.up, a.left]\n    a = Point.new(0, 0)\n    a.adj4_in_range.to_a.should\
    \ eq [a.down, a.right]\n\n    res = [] of Point\n    a.adj4_in_range { |p| res\
    \ << p }\n    res.should eq [a.down, a.right]\n  end\n\n  it \"#adjacent8\" do\n\
    \    a = Point.new(3, 4)\n    a.adjacent8.should be_a(Iterator(Point))\n    expect\
    \ = [a.up, a.left, a.down, a.right, a.ul, a.ur, a.dl, a.dr]\n    a.adjacent8.to_a.should\
    \ eq expect\n\n    res = [] of Point\n    a.adjacent8 { |p| res << p }\n    res.should\
    \ eq expect\n  end\n\n  it \"#adj8_in_range\" do\n    Point.new.adj8_in_range.should\
    \ be_a(Iterator(Point))\n    a = Point.new(H - 1, W - 1)\n    a.adj8_in_range.to_a.should\
    \ eq [a.up, a.left, a.ul]\n    a = Point.new(0, 0)\n    a.adj8_in_range.to_a.should\
    \ eq [a.down, a.right, a.dr]\n\n    res = [] of Point\n    a.adj8_in_range { |p|\
    \ res << p }\n    res.should eq [a.down, a.right, a.dr]\n  end\n\n  it \"#to_s\"\
    \ do\n    Point.new(3, 4).to_s.should eq \"(3, 4)\"\n  end\n\n  it \"#inspect\"\
    \ do\n    Point.new(3, 4).inspect.should eq \"(3, 4)\"\n  end\n\n  it \"to_direction_char?\"\
    \ do\n    Point.left.to_direction_char?.should eq 'L'\n    Point.right.to_direction_char?.should\
    \ eq 'R'\n    Point.up.to_direction_char?.should eq 'U'\n    Point.down.to_direction_char?.should\
    \ eq 'D'\n    Point.new(1, 1).to_direction_char?.should be_nil\n    (Point.left\
    \ * 10).to_direction_char?.should eq 'L'\n    (Point.right * 10).to_direction_char?.should\
    \ eq 'R'\n    (Point.up * 10).to_direction_char?.should eq 'U'\n    (Point.down\
    \ * 10).to_direction_char?.should eq 'D'\n\n    {\"<>^v\", \"1234\"}.each do |str|\n\
    \      Point.left.to_direction_char?(str).should eq str[0]\n      Point.right.to_direction_char?(str).should\
    \ eq str[1]\n      Point.up.to_direction_char?(str).should eq str[2]\n      Point.down.to_direction_char?(str).should\
    \ eq str[3]\n    end\n  end\n\n  it \".to_direction?(c : Char)\" do\n    Point.to_direction?('L').should\
    \ eq Point.left\n    Point.to_direction?('R').should eq Point.right\n    Point.to_direction?('U').should\
    \ eq Point.up\n    Point.to_direction?('D').should eq Point.down\n    Point.to_direction?('?').should\
    \ be_nil\n  end\n\n  it \".to_direction?(s : String)\" do\n    Point.to_direction?(\"\
    L\").should eq Point.left\n    Point.to_direction?(\"R\").should eq Point.right\n\
    \    Point.to_direction?(\"U\").should eq Point.up\n    Point.to_direction?(\"\
    D\").should eq Point.down\n    Point.to_direction?(\"?\").should be_nil\n    Point.to_direction?(\"\
    LU\").should eq Point.ul\n    Point.to_direction?(\"UL\").should eq Point.ul\n\
    \    Point.to_direction?(\"LD\").should eq Point.dl\n    Point.to_direction?(\"\
    DL\").should eq Point.dl\n    Point.to_direction?(\"RU\").should eq Point.ur\n\
    \    Point.to_direction?(\"UR\").should eq Point.ur\n    Point.to_direction?(\"\
    RD\").should eq Point.dr\n    Point.to_direction?(\"DR\").should eq Point.dr\n\
    \    Point.to_direction?(\"LL\").should be_nil\n    Point.to_direction?(\"LR\"\
    ).should be_nil\n    Point.to_direction?(\"UD\").should be_nil\n    Point.to_direction?(\"\
    L?\").should be_nil\n    Point.to_direction?(\"\").should be_nil\n    Point.to_direction?(\"\
    LRU\").should be_nil\n  end\nend\n\ndescribe Indexable do\n  it \"#[](point :\
    \ Point)\" do\n    a = [[0, 1], [2, 3], [4]]\n    a[Point.new(0, 0)].should eq\
    \ 0\n    a[Point.new(0, 1)].should eq 1\n    a[Point.new(1, 0)].should eq 2\n\
    \    a[Point.new(1, 1)].should eq 3\n    a[Point.new(2, 0)].should eq 4\n    expect_raises(IndexError)\
    \ { a[Point.new(2, 1)] }\n    expect_raises(IndexError) { a[Point.new(0, 2)] }\n\
    \    expect_raises(IndexError) { a[Point.new(0, -1)] }\n    expect_raises(IndexError)\
    \ { a[Point.new(-1, 0)] }\n    expect_raises(IndexError) { a[Point.new(3, 0)]\
    \ }\n\n    b = %w[ab cd e]\n    b[Point.new(0, 0)].should eq 'a'\n    b[Point.new(0,\
    \ 1)].should eq 'b'\n    b[Point.new(1, 0)].should eq 'c'\n    b[Point.new(1,\
    \ 1)].should eq 'd'\n    b[Point.new(2, 0)].should eq 'e'\n    expect_raises(IndexError)\
    \ { b[Point.new(2, 1)] }\n    expect_raises(IndexError) { b[Point.new(0, 2)] }\n\
    \    expect_raises(IndexError) { b[Point.new(0, -1)] }\n    expect_raises(IndexError)\
    \ { b[Point.new(-1, 0)] }\n    expect_raises(IndexError) { b[Point.new(3, 0)]\
    \ }\n  end\n\n  it \"#[]?(point : Point)\" do\n    a = [[0, 1], [2, 3], [4]]\n\
    \    a[Point.new(0, 0)]?.should eq 0\n    a[Point.new(0, 1)]?.should eq 1\n  \
    \  a[Point.new(1, 0)]?.should eq 2\n    a[Point.new(1, 1)]?.should eq 3\n    a[Point.new(2,\
    \ 0)]?.should eq 4\n    a[Point.new(2, 1)]?.should be_nil\n    a[Point.new(0,\
    \ 2)]?.should be_nil\n    a[Point.new(0, -1)]?.should be_nil\n    a[Point.new(-1,\
    \ 0)]?.should be_nil\n    a[Point.new(3, 0)]?.should be_nil\n\n    b = %w[ab cd\
    \ e]\n    b[Point.new(0, 0)]?.should eq 'a'\n    b[Point.new(0, 1)]?.should eq\
    \ 'b'\n    b[Point.new(1, 0)]?.should eq 'c'\n    b[Point.new(1, 1)]?.should eq\
    \ 'd'\n    b[Point.new(2, 0)]?.should eq 'e'\n    b[Point.new(2, 1)]?.should be_nil\n\
    \    b[Point.new(0, 2)]?.should be_nil\n    b[Point.new(0, -1)]?.should be_nil\n\
    \    b[Point.new(-1, 0)]?.should be_nil\n    b[Point.new(3, 0)]?.should be_nil\n\
    \  end\nend\n\ndescribe Array do\n  it \"#[]=(point : Point, value)\" do\n   \
    \ a = [[0, 1], [2]]\n    a[Point.new(0, 0)] = 3\n    a[Point.new(0, 1)] = 4\n\
    \    a[Point.new(1, 0)] = 5\n    expect_raises(IndexError) { a[Point.new(2, 1)]\
    \ }\n    expect_raises(IndexError) { a[Point.new(0, 2)] }\n    expect_raises(IndexError)\
    \ { a[Point.new(0, -1)] }\n    expect_raises(IndexError) { a[Point.new(-1, 0)]\
    \ }\n    expect_raises(IndexError) { a[Point.new(3, 0)] }\n    a.should eq [[3,\
    \ 4], [5]]\n  end\nend\n"
  code: "require \"spec\"\nrequire \"../src/point\"\n\nmacro check_direction(name,\
    \ dy, dx)\n\tit \".{{name}}\" do\n\t  Point.{{name}}.should eq Point.new({{dy}},\
    \ {{dx}})\n\tend\n\tit \"#\" + \"{{name}}\" do\n\t\tPoint.new(1, 1).{{name}}.should\
    \ eq Point.new(1 + {{dy}}, 1 + {{dx}})\n\tend\nend\n\nmacro check_binary_operator(op)\n\
    \tit \"\\#{{op.id}}\" do\n\t\ta, b = Point.new(1, 2), Point.new(3, 4)\n\t\t(a\
    \ {{op.id}} b).should eq Point.new(1 {{op.id}} 3, 2 {{op.id}} 4)\n\t\t(a {{op.id}}\
    \ 5).should eq Point.new(1 {{op.id}} 5, 2 {{op.id}} 5)\n\tend\nend\n\nH = 3\n\
    W = 4\n\ndescribe Point do\n  it \".set_range and .height and .width\" do\n  \
    \  expect_raises(NilAssertionError) { Point.height }\n    expect_raises(NilAssertionError)\
    \ { Point.width }\n    Point.height?.should be_nil\n    Point.width?.should be_nil\n\
    \    Point.set_range(H, W)\n    Point.height.should eq H\n    Point.width.should\
    \ eq W\n    Point.height?.should eq H\n    Point.width?.should eq W\n  end\n\n\
    \  it \".size\" do\n    Point.size.should eq H*W\n  end\n\n  it \"extend Indexable(Point)\"\
    \ do\n    array = (0...H).to_a.product((0...W).to_a).map { |y, x| Point.new(y,\
    \ x) }\n    Point.to_a.should eq array\n    Point[0].should eq Point.new(0, 0)\n\
    \    expect_raises(IndexError) { Point[H*W] }\n  end\n\n  it \".new\" do\n   \
    \ Point.new.should eq Point.new(0, 0)\n    Point.new(H, W).should eq Point.new(H,\
    \ W)\n  end\n\n  it \".from\" do\n    Point.from([0, 1]).should eq Point.new(0,\
    \ 1)\n    expect_raises(ArgumentError) do\n      Point.from [0]\n      Point.from\
    \ [0, 1, 2]\n    end\n  end\n\n  it \".[](y, x)\" do\n    Point[1, 1].should eq\
    \ Point.new(1, 1)\n  end\n\n  check_direction(zero, 0, 0)\n  check_direction(up,\
    \ -1, 0)\n  check_direction(left, 0, -1)\n  check_direction(down, 1, 0)\n  check_direction(right,\
    \ 0, 1)\n  check_direction(ul, -1, -1)\n  check_direction(ur, -1, 1)\n  check_direction(dl,\
    \ 1, -1)\n  check_direction(dr, 1, 1)\n\n  check_binary_operator(\"+\")\n  check_binary_operator(\"\
    -\")\n  check_binary_operator(\"*\")\n  check_binary_operator(\"//\")\n  check_binary_operator(\"\
    %\")\n\n  it \"#xy\" do\n    Point.new(1, 2).xy.should eq Point.new(2, 1)\n  end\n\
    \n  it \"#yx\" do\n    Point.new(1, 2).yx.should eq Point.new(1, 2)\n  end\n\n\
    \  it \"#==(other)\" do\n    Point.each do |p1|\n      Point.each do |p2|\n  \
    \      (p1 == p2).should eq ({p1.y, p1.x} == {p2.y, p2.x})\n      end\n    end\n\
    \  end\n\n  it \"#<=>(other)\" do\n    Point.each do |p1|\n      Point.each do\
    \ |p2|\n        (p1 <=> p2).should eq ({p1.y, p1.x} <=> {p2.y, p2.x})\n      end\n\
    \    end\n  end\n\n  it \"include Comparable(Point)\" do\n    Point.new(2, 2).clamp(Point.new(0,\
    \ 0), Point.new(1, 1)).should eq Point.new(1, 1)\n  end\n\n  it \"#[]\" do\n \
    \   a = Point.new(1, 2)\n    a[0].should eq 1\n    a[1].should eq 2\n    expect_raises(IndexError)\
    \ { a[-1] }\n    expect_raises(IndexError) { a[2] }\n    x, y = a\n    [x, y].should\
    \ eq [1, 2]\n  end\n\n  it \"#succ\" do\n    Point.new(1, 2).succ.should eq Point.new(1,\
    \ 3)\n    Point.new(1, W - 1).succ.should eq Point.new(2, 0)\n    expect_raises(IndexError)\
    \ { Point.new(H - 1, W - 1).succ }\n    expect_raises(IndexError) { Point.new(0,\
    \ -1).succ }\n    expect_raises(IndexError) { Point.new(H, 0).succ }\n  end\n\n\
    \  it \"#pred\" do\n    Point.new(1, 2).pred.should eq Point.new(1, 1)\n    Point.new(1,\
    \ 0).pred.should eq Point.new(0, W - 1)\n    expect_raises(IndexError) { Point.new(0,\
    \ 0).pred }\n    expect_raises(IndexError) { Point.new(0, -1).pred }\n    expect_raises(IndexError)\
    \ { Point.new(H, 0).pred }\n  end\n\n  it \"#in_range?\" do\n    (-2..H + 2).each\
    \ do |y|\n      (-2..W + 2).each do |x|\n        flag = (0...H).includes?(y) &&\
    \ (0...W).includes?(x)\n        Point.new(y, x).in_range?.should eq flag\n   \
    \   end\n    end\n  end\n\n  it \"#to_i\" do\n    i = 0\n    Point.each do |p|\n\
    \      p.to_i.should eq i\n      i += 1\n    end\n    expect_raises(IndexError)\
    \ { Point.new(-1, 0).to_i }\n    expect_raises(IndexError) { Point.new(H, 0).to_i\
    \ }\n  end\n\n  it \"#distance_square\" do\n    Point.new(3, 4).distance_square(Point.new(7,\
    \ 9)).should eq 41\n    Point.new(3, 4).distance_square(Point.new(3, 0)).should\
    \ eq 16\n    Point.new(3, 4).distance_square(Point.new(3, 4)).should eq 0\n  end\n\
    \n  it \"#distance\" do\n    Point.new(3, 4).distance(Point.new(7, 9)).should\
    \ eq Math.sqrt(41)\n    Point.new(3, 4).distance(Point.new(3, 0)).should eq 4.0\n\
    \    Point.new(3, 4).distance(Point.new(3, 4)).should eq 0\n  end\n\n  it \"#manhattan\"\
    \ do\n    Point.new(3, 4).manhattan(Point.new(7, 9)).should eq 9\n    Point.new(3,\
    \ 4).manhattan(Point.new(3, 0)).should eq 4\n    Point.new(3, 4).manhattan(Point.new(3,\
    \ 4)).should eq 0\n  end\n\n  it \"#chebyshev\" do\n    Point.new(3, 4).manhattan(Point.new(7,\
    \ 9)).should eq 9\n    Point.new(3, 4).manhattan(Point.new(3, 0)).should eq 4\n\
    \    Point.new(3, 4).manhattan(Point.new(3, 4)).should eq 0\n  end\n\n  it \"\
    #adjacent4\" do\n    a = Point.new(3, 4)\n    a.adjacent4.should be_a(Iterator(Point))\n\
    \    expect = [a.up, a.left, a.down, a.right]\n    a.adjacent4.to_a.should eq\
    \ expect\n\n    res = [] of Point\n    a.adjacent4 { |p| res << p }\n    res.should\
    \ eq expect\n  end\n\n  it \"#adj4_in_range\" do\n    Point.new.adj4_in_range.should\
    \ be_a(Iterator(Point))\n    a = Point.new(H - 1, W - 1)\n    a.adj4_in_range.to_a.should\
    \ eq [a.up, a.left]\n    a = Point.new(0, 0)\n    a.adj4_in_range.to_a.should\
    \ eq [a.down, a.right]\n\n    res = [] of Point\n    a.adj4_in_range { |p| res\
    \ << p }\n    res.should eq [a.down, a.right]\n  end\n\n  it \"#adjacent8\" do\n\
    \    a = Point.new(3, 4)\n    a.adjacent8.should be_a(Iterator(Point))\n    expect\
    \ = [a.up, a.left, a.down, a.right, a.ul, a.ur, a.dl, a.dr]\n    a.adjacent8.to_a.should\
    \ eq expect\n\n    res = [] of Point\n    a.adjacent8 { |p| res << p }\n    res.should\
    \ eq expect\n  end\n\n  it \"#adj8_in_range\" do\n    Point.new.adj8_in_range.should\
    \ be_a(Iterator(Point))\n    a = Point.new(H - 1, W - 1)\n    a.adj8_in_range.to_a.should\
    \ eq [a.up, a.left, a.ul]\n    a = Point.new(0, 0)\n    a.adj8_in_range.to_a.should\
    \ eq [a.down, a.right, a.dr]\n\n    res = [] of Point\n    a.adj8_in_range { |p|\
    \ res << p }\n    res.should eq [a.down, a.right, a.dr]\n  end\n\n  it \"#to_s\"\
    \ do\n    Point.new(3, 4).to_s.should eq \"(3, 4)\"\n  end\n\n  it \"#inspect\"\
    \ do\n    Point.new(3, 4).inspect.should eq \"(3, 4)\"\n  end\n\n  it \"to_direction_char?\"\
    \ do\n    Point.left.to_direction_char?.should eq 'L'\n    Point.right.to_direction_char?.should\
    \ eq 'R'\n    Point.up.to_direction_char?.should eq 'U'\n    Point.down.to_direction_char?.should\
    \ eq 'D'\n    Point.new(1, 1).to_direction_char?.should be_nil\n    (Point.left\
    \ * 10).to_direction_char?.should eq 'L'\n    (Point.right * 10).to_direction_char?.should\
    \ eq 'R'\n    (Point.up * 10).to_direction_char?.should eq 'U'\n    (Point.down\
    \ * 10).to_direction_char?.should eq 'D'\n\n    {\"<>^v\", \"1234\"}.each do |str|\n\
    \      Point.left.to_direction_char?(str).should eq str[0]\n      Point.right.to_direction_char?(str).should\
    \ eq str[1]\n      Point.up.to_direction_char?(str).should eq str[2]\n      Point.down.to_direction_char?(str).should\
    \ eq str[3]\n    end\n  end\n\n  it \".to_direction?(c : Char)\" do\n    Point.to_direction?('L').should\
    \ eq Point.left\n    Point.to_direction?('R').should eq Point.right\n    Point.to_direction?('U').should\
    \ eq Point.up\n    Point.to_direction?('D').should eq Point.down\n    Point.to_direction?('?').should\
    \ be_nil\n  end\n\n  it \".to_direction?(s : String)\" do\n    Point.to_direction?(\"\
    L\").should eq Point.left\n    Point.to_direction?(\"R\").should eq Point.right\n\
    \    Point.to_direction?(\"U\").should eq Point.up\n    Point.to_direction?(\"\
    D\").should eq Point.down\n    Point.to_direction?(\"?\").should be_nil\n    Point.to_direction?(\"\
    LU\").should eq Point.ul\n    Point.to_direction?(\"UL\").should eq Point.ul\n\
    \    Point.to_direction?(\"LD\").should eq Point.dl\n    Point.to_direction?(\"\
    DL\").should eq Point.dl\n    Point.to_direction?(\"RU\").should eq Point.ur\n\
    \    Point.to_direction?(\"UR\").should eq Point.ur\n    Point.to_direction?(\"\
    RD\").should eq Point.dr\n    Point.to_direction?(\"DR\").should eq Point.dr\n\
    \    Point.to_direction?(\"LL\").should be_nil\n    Point.to_direction?(\"LR\"\
    ).should be_nil\n    Point.to_direction?(\"UD\").should be_nil\n    Point.to_direction?(\"\
    L?\").should be_nil\n    Point.to_direction?(\"\").should be_nil\n    Point.to_direction?(\"\
    LRU\").should be_nil\n  end\nend\n\ndescribe Indexable do\n  it \"#[](point :\
    \ Point)\" do\n    a = [[0, 1], [2, 3], [4]]\n    a[Point.new(0, 0)].should eq\
    \ 0\n    a[Point.new(0, 1)].should eq 1\n    a[Point.new(1, 0)].should eq 2\n\
    \    a[Point.new(1, 1)].should eq 3\n    a[Point.new(2, 0)].should eq 4\n    expect_raises(IndexError)\
    \ { a[Point.new(2, 1)] }\n    expect_raises(IndexError) { a[Point.new(0, 2)] }\n\
    \    expect_raises(IndexError) { a[Point.new(0, -1)] }\n    expect_raises(IndexError)\
    \ { a[Point.new(-1, 0)] }\n    expect_raises(IndexError) { a[Point.new(3, 0)]\
    \ }\n\n    b = %w[ab cd e]\n    b[Point.new(0, 0)].should eq 'a'\n    b[Point.new(0,\
    \ 1)].should eq 'b'\n    b[Point.new(1, 0)].should eq 'c'\n    b[Point.new(1,\
    \ 1)].should eq 'd'\n    b[Point.new(2, 0)].should eq 'e'\n    expect_raises(IndexError)\
    \ { b[Point.new(2, 1)] }\n    expect_raises(IndexError) { b[Point.new(0, 2)] }\n\
    \    expect_raises(IndexError) { b[Point.new(0, -1)] }\n    expect_raises(IndexError)\
    \ { b[Point.new(-1, 0)] }\n    expect_raises(IndexError) { b[Point.new(3, 0)]\
    \ }\n  end\n\n  it \"#[]?(point : Point)\" do\n    a = [[0, 1], [2, 3], [4]]\n\
    \    a[Point.new(0, 0)]?.should eq 0\n    a[Point.new(0, 1)]?.should eq 1\n  \
    \  a[Point.new(1, 0)]?.should eq 2\n    a[Point.new(1, 1)]?.should eq 3\n    a[Point.new(2,\
    \ 0)]?.should eq 4\n    a[Point.new(2, 1)]?.should be_nil\n    a[Point.new(0,\
    \ 2)]?.should be_nil\n    a[Point.new(0, -1)]?.should be_nil\n    a[Point.new(-1,\
    \ 0)]?.should be_nil\n    a[Point.new(3, 0)]?.should be_nil\n\n    b = %w[ab cd\
    \ e]\n    b[Point.new(0, 0)]?.should eq 'a'\n    b[Point.new(0, 1)]?.should eq\
    \ 'b'\n    b[Point.new(1, 0)]?.should eq 'c'\n    b[Point.new(1, 1)]?.should eq\
    \ 'd'\n    b[Point.new(2, 0)]?.should eq 'e'\n    b[Point.new(2, 1)]?.should be_nil\n\
    \    b[Point.new(0, 2)]?.should be_nil\n    b[Point.new(0, -1)]?.should be_nil\n\
    \    b[Point.new(-1, 0)]?.should be_nil\n    b[Point.new(3, 0)]?.should be_nil\n\
    \  end\nend\n\ndescribe Array do\n  it \"#[]=(point : Point, value)\" do\n   \
    \ a = [[0, 1], [2]]\n    a[Point.new(0, 0)] = 3\n    a[Point.new(0, 1)] = 4\n\
    \    a[Point.new(1, 0)] = 5\n    expect_raises(IndexError) { a[Point.new(2, 1)]\
    \ }\n    expect_raises(IndexError) { a[Point.new(0, 2)] }\n    expect_raises(IndexError)\
    \ { a[Point.new(0, -1)] }\n    expect_raises(IndexError) { a[Point.new(-1, 0)]\
    \ }\n    expect_raises(IndexError) { a[Point.new(3, 0)] }\n    a.should eq [[3,\
    \ 4], [5]]\n  end\nend\n"
  dependsOn:
  - src/point.cr
  isVerificationFile: false
  path: spec/point_spec.cr
  requiredBy: []
  timestamp: '2021-07-11 19:42:16+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/point_spec.cr
layout: document
redirect_from:
- /library/spec/point_spec.cr
- /library/spec/point_spec.cr.html
title: spec/point_spec.cr
---
