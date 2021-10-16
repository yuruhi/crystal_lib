require "spec"
require "../../src/math/combination"
require "../../src/math/mint"

private C = Combination(Mint).new

private def iterator
  Iterator(Int32).chain [
    (0...10).step(1),
    (10...100).step(10),
    (100...1000).step(100),
    (1000...10000).step(1000),
    (10000...100000).step(10000),
    (100000...1000000).step(100000),
  ]
end

describe Combination do
  it "#factorial" do
    iterator.each do |x|
      C.factorial(x).should eq (1..x).reduce(1.to_m) { |acc, x| acc * x }
    end
    expect_raises(IndexError) { C.factorial(-1) }
  end

  it "#inv" do
    iterator.each do |x|
      next if x == 0
      (C.inv(x) * x).should eq 1
    end
    expect_raises(DivisionByZeroError) { C.inv(0) }
    expect_raises(IndexError) { C.inv(-1) }
  end

  it "#finv" do
    iterator.each do |x|
      expected = (1..x).reduce(1.to_m) { |acc, x| acc * x.to_m.inv }
      C.finv(x).should eq expected
    end
    expect_raises(IndexError) { C.finv(-1) }
  end

  it "#permutation" do
    [
      [1, 0, 0],
      [1, 1, 0, 0],
      [1, 2, 2, 0, 0],
      [1, 3, 6, 6, 0, 0],
      [1, 4, 12, 24, 24, 0, 0],
    ].each_with_index do |arr, n|
      arr.each_with_index do |x, r|
        C.permutation(n, r).should eq x
      end
    end
    [{-1, 1}, {1, -1}, {-2, 1}, {1, -2}].each do |n, r|
      C.permutation(n, r).should eq 0
    end
  end

  it "#combination" do
    [
      [1, 0, 0],
      [1, 1, 0, 0],
      [1, 2, 1, 0, 0],
      [1, 3, 3, 1, 0, 0],
      [1, 4, 6, 4, 1, 0, 0],
    ].each_with_index do |arr, n|
      arr.each_with_index do |x, r|
        C.combination(n, r).should eq x
      end
    end
    [{-1, 1}, {1, -1}, {-2, 1}, {1, -2}].each do |n, r|
      C.combination(n, r).should eq 0
    end
  end

  it "#repeated_permutation" do
    [
      [1, 0, 0],
      [1, 1, 1, 1],
      [1, 2, 3, 4, 5],
      [1, 3, 6, 10, 15, 21],
      [1, 4, 10, 20, 35, 56, 84],
    ].each_with_index do |arr, n|
      arr.each_with_index do |x, r|
        C.repeated_combination(n, r).should eq x
      end
    end
    [{-1, 1}, {1, -1}, {-2, 1}, {1, -2}].each do |n, r|
      C.repeated_combination(n, r).should eq 0
    end
  end

  it ".table" do
    Combination(Int32).table(5).should eq [
      [1, 0, 0, 0, 0, 0],
      [1, 1, 0, 0, 0, 0],
      [1, 2, 1, 0, 0, 0],
      [1, 3, 3, 1, 0, 0],
      [1, 4, 6, 4, 1, 0],
      [1, 5, 10, 10, 5, 1],
    ]
  end
end
