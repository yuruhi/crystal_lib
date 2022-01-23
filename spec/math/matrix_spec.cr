require "spec"
require "../../src/math/matrix"
require "../../src/math/mint"

private M = Matrix[[1, 2], [3, 4]]
i_j_value = [
  {0, 0, 1}, {0, 1, 2}, {1, 0, 3}, {1, 1, 4},
  {-2, -2, 1}, {-2, -1, 2}, {-1, -2, 3}, {-1, -1, 4},
]
out_of_range = [
  {0, 2}, {2, 0}, {2, 2},
  {-3, 0}, {0, -3}, {-3, -3},
]

describe Matrix do
  it ".identity" do
    Matrix(Int32).identity(1).should eq Matrix[[1]]
    Matrix(Int32).identity(2).should eq Matrix[[1, 0], [0, 1]]
    Matrix(Int32).identity(3).should eq Matrix[[1, 0, 0], [0, 1, 0], [0, 0, 1]]
    expect_raises(ArgumentError) { Matrix(Int32).identity(-1) }
  end

  it "[]" do
    M.should eq Matrix.new [[1, 2], [3, 4]]
  end

  it ".from" do
    Matrix(Int64).from([1, 2], [3, 4]).should eq Matrix[[1i64, 2i64], [3i64, 4i64]]
    Matrix(Int64).from({1, 2}, {3, 4}).should eq Matrix[[1i64, 2i64], [3i64, 4i64]]
    Matrix(Int32).from(%w[1 2], %w[3 4]).should eq Matrix[[1, 2], [3, 4]]
    Matrix(Int32).from(1..2, 3..4).should eq Matrix[[1, 2], [3, 4]]
  end

  describe ".new" do
    it "receives initial value" do
      Matrix.new(1, 1, 0).should eq Matrix[[0]]
      Matrix.new(2, 3, 0).should eq Matrix[[0, 0, 0], [0, 0, 0]]
      expect_raises(ArgumentError) { Matrix.new(-1, 1, 0) }
      expect_raises(ArgumentError) { Matrix.new(1, -1, 0) }
    end

    it "receives block" do
      Matrix({Int32, Int32}).new(3, 3) { |i, j| {i, j} }.should eq Matrix[
        [{0, 0}, {0, 1}, {0, 2}],
        [{1, 0}, {1, 1}, {1, 2}],
        [{2, 0}, {2, 1}, {2, 2}],
      ]
      expect_raises(ArgumentError) { Matrix(Int32).new(-1, 1) { 0 } }
      expect_raises(ArgumentError) { Matrix(Int32).new(1, -1) { 0 } }
    end

    it "receives Array" do
      Matrix.new([[1, 2], [3, 4]]).should eq Matrix[[1, 2], [3, 4]]
      expect_raises(ArgumentError) { Matrix.new [[1, 2], [3]] }
    end
  end

  it "#fetch(i, j, &block)" do
    i_j_value.each do |i, j, value|
      M.fetch(i, j) { nil }.should eq value
    end
    out_of_range.each do |i, j|
      M.fetch(i, j) { |i, j| [i, j] }.should eq [i, j]
    end
  end

  it "#fetch(i, j, default)" do
    i_j_value.each do |i, j, value|
      M.fetch(i, j, nil).should eq value
    end
    out_of_range.each do |i, j|
      M.fetch(i, j, nil).should be_nil
    end
  end

  it "#[](i, j)" do
    i_j_value.each do |i, j, value|
      M[i, j].should eq value
    end
    out_of_range.each do |i, j|
      expect_raises(IndexError) { M[i, j] }
    end
  end

  it "#[]?(i, j)" do
    i_j_value.each do |i, j, value|
      M[i, j]?.should eq value
    end
    out_of_range.each do |i, j|
      M[i, j]?.should be_nil
    end
  end

  it "#unsafe_fetch(i, j)" do
    M.unsafe_fetch(0, 0).should eq 1
    M.unsafe_fetch(0, 1).should eq 2
    M.unsafe_fetch(1, 0).should eq 3
    M.unsafe_fetch(1, 1).should eq 4
  end

  it "#+(other)" do
    (Matrix[[1, 2], [3, 4]] + Matrix[[5, 6], [7, 8]]).should eq Matrix[[6, 8], [10, 12]]
    expect_raises(IndexError) { Matrix[[1, 2], [3, 4]] + Matrix[[1], [2]] }
  end

  it "#-(other)" do
    (Matrix[[5, 6], [7, 8]] - Matrix[[1, 2], [3, 4]]).should eq Matrix[[4, 4], [4, 4]]
    expect_raises(IndexError) { Matrix[[1, 2], [3, 4]] - Matrix[[1], [2]] }
  end

  it "#*(other)" do
    a = Matrix[[1, 2], [3, 4], [5, 6]]
    b = Matrix[[7, 8, 9], [10, 11, 12]]
    c = Matrix[[27, 30, 33], [61, 68, 75], [95, 106, 117]]
    (a * b).should eq c
    expect_raises(IndexError) { a * a }
    expect_raises(IndexError) { b * b }
  end

  it "#**(k)" do
    a1 = Matrix[[1, 2], [3, 4]]
    (a1 ** 0).should eq Matrix(Int32).identity(2)
    (a1 ** 1).should eq a1
    (a1 ** 2).should eq a1 * a1
    (a1 ** 3).should eq a1 * a1 * a1

    m1 = Matrix(Mint).from [1, 2], [3, 4]
    m2 = Matrix(Mint).from [414846427, 59557274], [89335911, 504182338]
    (m1 ** (10i64**18)).should eq m2
  end

  it "#to_s" do
    M.to_s.should eq "[[1, 2], [3, 4]]"
  end

  it "#inspect" do
    M.inspect.should eq "Matrix[[1, 2], [3, 4]]"
  end
end
