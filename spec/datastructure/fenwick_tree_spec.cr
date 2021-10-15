require "spec"
require "../../src/datastructure/fenwick_tree"

describe FenwickTree do
  it ".new(size)" do
    a = FenwickTree(Int32).new(3)
    a.to_a.should eq [0, 0, 0]
  end

  it ".new(array)" do
    a = FenwickTree.new [1, 2, 3]
    a.to_a.should eq [1, 2, 3]
  end

  it "#add" do
    a = FenwickTree(Int32).new(3)
    a.add(0, 3)
    a.to_a.should eq [3, 0, 0]
    a.add(1, 4)
    a.to_a.should eq [3, 4, 0]
    a.add(2, 5)
    a.to_a.should eq [3, 4, 5]
    a.add(1, 2i64)
    a.to_a.should eq [3, 6, 5]
    expect_raises(IndexError) { a.add(-1, 0) }
    expect_raises(IndexError) { a.add(3, 0) }
  end

  it "#set, #[]=" do
    a = FenwickTree(Int32).new(3)
    a.set(0, 3)
    a.to_a.should eq [3, 0, 0]
    a[1] = 4
    a.to_a.should eq [3, 4, 0]
    a.set(2, 5)
    a.to_a.should eq [3, 4, 5]
    a[1] = 2i64
    a.to_a.should eq [3, 2, 5]
    expect_raises(IndexError) { a.set(-1, 0) }
    expect_raises(IndexError) { a.set(3, 0) }
    expect_raises(IndexError) { a[-1] = 0 }
    expect_raises(IndexError) { a[3] = 0 }
  end

  it "#left_sum" do
    a = FenwickTree.new [1, 2, 3]
    a.left_sum(0).should eq 0
    a.left_sum(1).should eq 1
    a.left_sum(2).should eq 3
    a.left_sum(3).should eq 6
    expect_raises(IndexError) { a.left_sum(-1) }
    expect_raises(IndexError) { a.left_sum(4) }
  end

  it "#[](index)" do
    a = FenwickTree.new [1, 2, 3]
    a[0].should eq 1
    a[1].should eq 2
    a[2].should eq 3
    expect_raises(IndexError) { a[-1] }
    expect_raises(IndexError) { a[4] }
  end

  it "#[](start, count)" do
    a = FenwickTree.new [1, 2, 3]
    [
      [0, 1, 3, 6],
      [0, 2, 5],
      [0, 3],
      [0],
    ].each_with_index do |sums, start|
      sums.each_with_index do |sum, count|
        a[start, count].should eq sum
      end
    end
  end

  it "#[](range)" do
    a = FenwickTree.new [1, 2, 3]
    [
      {0..0, 1}, {0..1, 3}, {0..2, 6},
      {1..1, 2}, {1..2, 5},
      {2..2, 3},
    ].each do |range, sum|
      a[range].should eq sum
    end
  end

  it "#to_a" do
    a = FenwickTree.new [1, 2, 3]
    a.to_a.should eq [1, 2, 3]
  end
end
