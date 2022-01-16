require "spec"
require "../../src/point"

private macro check_direction(name, dy, dx)
  it ".{{name}}" do
    Point.{{name}}.should eq Point.new({{dy}}, {{dx}})
  end

  it "#" + "{{name}}" do
    Point.new(1, 1).{{name}}.should eq Point.new(1 + {{dy}}, 1 + {{dx}})
  end
end

private macro check_binary_operator(op)
  it "\#{{op.id}}" do
    a, b = Point.new(1, 2), Point.new(3, 4)
    (a {{op.id}} b).should eq Point.new(1 {{op.id}} 3, 2 {{op.id}} 4)
    (a {{op.id}} 5).should eq Point.new(1 {{op.id}} 5, 2 {{op.id}} 5)
  end
end

private H = 3
private W = 4

describe Point do
  it ".set_range and .height and .width" do
    Point.reset_range
    expect_raises(NilAssertionError) { Point.height }
    expect_raises(NilAssertionError) { Point.width }
    Point.height?.should be_nil
    Point.width?.should be_nil
    Point.set_range(H, W)
    Point.height.should eq H
    Point.width.should eq W
    Point.height?.should eq H
    Point.width?.should eq W
  end

  it ".size" do
    Point.size.should eq H*W
  end

  it "extend Indexable(Point)" do
    array = (0...H).to_a.product((0...W).to_a).map { |y, x| Point.new(y, x) }
    Point.to_a.should eq array
    Point[0].should eq Point.new(0, 0)
    expect_raises(IndexError) { Point[H*W] }
  end

  it ".new" do
    Point.new.should eq Point.new(0, 0)
    Point.new(H, W).should eq Point.new(H, W)
  end

  it ".from" do
    Point.from([0, 1]).should eq Point.new(0, 1)
    expect_raises(ArgumentError) { Point.from [0] }
    expect_raises(ArgumentError) { Point.from [0, 1, 2] }
  end

  it ".[](y, x)" do
    Point[1, 1].should eq Point.new(1, 1)
  end

  check_direction(zero, 0, 0)
  check_direction(up, -1, 0)
  check_direction(left, 0, -1)
  check_direction(down, 1, 0)
  check_direction(right, 0, 1)
  check_direction(ul, -1, -1)
  check_direction(ur, -1, 1)
  check_direction(dl, 1, -1)
  check_direction(dr, 1, 1)

  check_binary_operator("+")
  check_binary_operator("-")
  check_binary_operator("*")
  check_binary_operator("//")
  check_binary_operator("%")

  it "#xy" do
    Point.new(1, 2).xy.should eq Point.new(2, 1)
  end

  it "#yx" do
    Point.new(1, 2).yx.should eq Point.new(1, 2)
  end

  it "#dot" do
    Point[1, 2].dot(Point[2, 3]).should eq 8
  end

  it "#cross" do
    Point[1, 2].cross(Point[2, 3]).should eq 1
  end

  it "#rotate90" do
    Point[0, 0].rotate90.should eq Point[0, 2]
    Point[0, 1].rotate90.should eq Point[1, 2]
    Point[1, 0].rotate90.should eq Point[0, 1]
    Point[1, 1].rotate90.should eq Point[1, 1]
    x = Point[1, 2]
    x.rotate90!.should eq Point[2, 1]
    x.should eq Point[2, 1]
  end

  it "#flip_vertically" do
    Point[0, 0].flip_vertically.should eq Point[2, 0]
    Point[0, 1].flip_vertically.should eq Point[2, 1]
    Point[1, 0].flip_vertically.should eq Point[1, 0]
    Point[1, 1].flip_vertically.should eq Point[1, 1]
    x = Point[0, 0]
    x.flip_vertically!.should eq Point[2, 0]
    x.should eq Point[2, 0]
  end

  it "#flip_horizontally" do
    Point[0, 0].flip_horizontally.should eq Point[0, 3]
    Point[0, 1].flip_horizontally.should eq Point[0, 2]
    Point[1, 0].flip_horizontally.should eq Point[1, 3]
    Point[1, 1].flip_horizontally.should eq Point[1, 2]
    x = Point[0, 0]
    x.flip_horizontally!.should eq Point[0, 3]
    x.should eq Point[0, 3]
  end

  it "#==(other)" do
    Point.each do |p1|
      Point.each do |p2|
        (p1 == p2).should eq({p1.y, p1.x} == {p2.y, p2.x})
      end
    end
  end

  it "#<=>(other)" do
    Point.each do |p1|
      Point.each do |p2|
        (p1 <=> p2).should eq({p1.y, p1.x} <=> {p2.y, p2.x})
      end
    end
  end

  it "include Comparable(Point)" do
    Point.new(2, 2).clamp(Point.new(0, 0), Point.new(1, 1)).should eq Point.new(1, 1)
  end

  it "#[]" do
    a = Point.new(1, 2)
    a[0].should eq 1
    a[1].should eq 2
    expect_raises(IndexError) { a[-1] }
    expect_raises(IndexError) { a[2] }
    x, y = a
    [x, y].should eq [1, 2]
  end

  it "#succ" do
    Point.new(1, 2).succ.should eq Point.new(1, 3)
    Point.new(1, W - 1).succ.should eq Point.new(2, 0)
    expect_raises(IndexError) { Point.new(H - 1, W - 1).succ }
    expect_raises(IndexError) { Point.new(0, -1).succ }
    expect_raises(IndexError) { Point.new(H, 0).succ }
  end

  it "#pred" do
    Point.new(1, 2).pred.should eq Point.new(1, 1)
    Point.new(1, 0).pred.should eq Point.new(0, W - 1)
    expect_raises(IndexError) { Point.new(0, 0).pred }
    expect_raises(IndexError) { Point.new(0, -1).pred }
    expect_raises(IndexError) { Point.new(H, 0).pred }
  end

  it "#in_range?" do
    (-2..H + 2).each do |y|
      (-2..W + 2).each do |x|
        flag = (0...H).includes?(y) && (0...W).includes?(x)
        Point.new(y, x).in_range?.should eq flag
      end
    end
  end

  it "#to_i" do
    i = 0
    Point.each do |p|
      p.to_i.should eq i
      i += 1
    end
    expect_raises(IndexError) { Point.new(-1, 0).to_i }
    expect_raises(IndexError) { Point.new(H, 0).to_i }
  end

  it "#distance_square" do
    Point.new(3, 4).distance_square(Point.new(7, 9)).should eq 41
    Point.new(3, 4).distance_square(Point.new(3, 0)).should eq 16
    Point.new(3, 4).distance_square(Point.new(3, 4)).should eq 0
  end

  it "#distance" do
    Point.new(3, 4).distance(Point.new(7, 9)).should eq Math.sqrt(41)
    Point.new(3, 4).distance(Point.new(3, 0)).should eq 4.0
    Point.new(3, 4).distance(Point.new(3, 4)).should eq 0
  end

  it "#manhattan" do
    Point.new(3, 4).manhattan(Point.new(7, 9)).should eq 9
    Point.new(3, 4).manhattan(Point.new(3, 0)).should eq 4
    Point.new(3, 4).manhattan(Point.new(3, 4)).should eq 0
  end

  it "#chebyshev" do
    Point.new(3, 4).manhattan(Point.new(7, 9)).should eq 9
    Point.new(3, 4).manhattan(Point.new(3, 0)).should eq 4
    Point.new(3, 4).manhattan(Point.new(3, 4)).should eq 0
  end

  it "#adjacent4" do
    a = Point.new(3, 4)
    a.adjacent4.should be_a(Iterator(Point))
    expect = [a.up, a.left, a.down, a.right]
    a.adjacent4.to_a.should eq expect

    res = [] of Point
    a.adjacent4 { |p| res << p }
    res.should eq expect
  end

  it "#adj4_in_range" do
    Point.new.adj4_in_range.should be_a(Iterator(Point))
    a = Point.new(H - 1, W - 1)
    a.adj4_in_range.to_a.should eq [a.up, a.left]
    a = Point.new(0, 0)
    a.adj4_in_range.to_a.should eq [a.down, a.right]

    res = [] of Point
    a.adj4_in_range { |p| res << p }
    res.should eq [a.down, a.right]
  end

  it "#adjacent8" do
    a = Point.new(3, 4)
    a.adjacent8.should be_a(Iterator(Point))
    expect = [a.up, a.left, a.down, a.right, a.ul, a.ur, a.dl, a.dr]
    a.adjacent8.to_a.should eq expect

    res = [] of Point
    a.adjacent8 { |p| res << p }
    res.should eq expect
  end

  it "#adj8_in_range" do
    Point.new.adj8_in_range.should be_a(Iterator(Point))
    a = Point.new(H - 1, W - 1)
    a.adj8_in_range.to_a.should eq [a.up, a.left, a.ul]
    a = Point.new(0, 0)
    a.adj8_in_range.to_a.should eq [a.down, a.right, a.dr]

    res = [] of Point
    a.adj8_in_range { |p| res << p }
    res.should eq [a.down, a.right, a.dr]
  end

  it "#to_s" do
    Point.new(3, 4).to_s.should eq "(3, 4)"
  end

  it "#inspect" do
    Point.new(3, 4).inspect.should eq "(3, 4)"
  end

  it "to_direction_char?" do
    [
      {Point.left * 1, 'L'}, {Point.right * 1, 'R'}, {Point.up * 1, 'U'}, {Point.down * 1, 'D'},
      {Point.left * 9, 'L'}, {Point.right * 9, 'R'}, {Point.up * 9, 'U'}, {Point.down * 9, 'D'},
      {Point.dr, nil},
    ].each do |p, expected|
      p.to_direction_char?.should eq expected
    end

    {"<>^v", "1234"}.each do |str|
      [Point.left, Point.right, Point.up, Point.down].zip(str.chars) do |p, c|
        p.to_direction_char?(str).should eq c
      end
    end
  end

  it ".to_direction?(c : Char)" do
    Point.to_direction?('L').should eq Point.left
    Point.to_direction?('R').should eq Point.right
    Point.to_direction?('U').should eq Point.up
    Point.to_direction?('D').should eq Point.down
    Point.to_direction?('?').should be_nil
  end

  it ".to_direction?(s : String)" do
    [
      {"L", Point.left}, {"R", Point.right}, {"U", Point.up}, {"D", Point.down},
      {"LU", Point.ul}, {"UL", Point.ul}, {"LD", Point.dl}, {"DL", Point.dl},
      {"RU", Point.ur}, {"UR", Point.ur}, {"RD", Point.dr}, {"DR", Point.dr},
      {"?", nil}, {"LL", nil}, {"LR", nil}, {"UD", nil}, {"L?", nil}, {"", nil}, {"LRU", nil},
    ].each do |str, expected|
      Point.to_direction?(str).should eq expected
    end
  end
end

describe Indexable do
  it "#[](point : Point)" do
    a = [[0, 1], [2, 3], [4]]
    [{0, 0, 0}, {0, 1, 1}, {1, 0, 2}, {1, 1, 3}, {2, 0, 4}].each do |y, x, value|
      a[Point.new(y, x)].should eq value
    end
    [{2, 1}, {0, 2}, {0, -1}, {-1, 0}, {3, 0}].each do |y, x|
      expect_raises(IndexError) { a[Point.new(y, x)] }
    end

    b = %w[ab cd e]
    [{0, 0, 'a'}, {0, 1, 'b'}, {1, 0, 'c'}, {1, 1, 'd'}, {2, 0, 'e'}].each do |y, x, char|
      b[Point.new(y, x)].should eq char
    end
    [{2, 1}, {0, 2}, {0, -1}, {-1, 0}, {3, 0}].each do |y, x|
      expect_raises(IndexError) { b[Point.new(y, x)] }
    end
  end

  it "#[]?(point : Point)" do
    a = [[0, 1], [2, 3], [4]]
    [
      {0, 0, 0}, {0, 1, 1}, {1, 0, 2}, {1, 1, 3}, {2, 0, 4},
      {0, 2, nil}, {0, -1, nil}, {-1, 0, nil}, {3, 0, nil},
    ].each do |y, x, value|
      a[Point.new(y, x)]?.should eq value
    end

    b = %w[ab cd e]
    [
      {0, 0, 'a'}, {0, 1, 'b'}, {1, 0, 'c'}, {1, 1, 'd'}, {2, 0, 'e'},
      {2, 1, nil}, {0, 2, nil}, {0, -1, nil}, {-1, 0, nil}, {3, 0, nil},
    ].each do |y, x, value|
      b[Point.new(y, x)]?.should eq value
    end
  end
end

describe Array do
  it "#[]=(point : Point, value)" do
    a = [[0, 1], [2]]
    a[Point.new(0, 0)] = 3
    a[Point.new(0, 1)] = 4
    a[Point.new(1, 0)] = 5
    expect_raises(IndexError) { a[Point.new(2, 1)] = 0 }
    expect_raises(IndexError) { a[Point.new(0, 2)] = 0 }
    expect_raises(IndexError) { a[Point.new(0, -1)] = 0 }
    expect_raises(IndexError) { a[Point.new(-1, 0)] = 0 }
    expect_raises(IndexError) { a[Point.new(3, 0)] = 0 }
    a.should eq [[3, 4], [5]]
  end
end
