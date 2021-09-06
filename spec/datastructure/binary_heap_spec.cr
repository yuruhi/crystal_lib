require "spec"
require "../../src/datastructure/binary_heap"

describe BinaryHeap do
  it "new" do
    a = BinaryHeap(Int32).new
    a << 1 << 2 << 3
    a.to_a.should eq [1, 2, 3]
  end

  it "new(enumerable)" do
    a = BinaryHeap.new 1..10
    a.to_a.should eq (1..10).to_a
  end

  it "new(&block)" do
    a = BinaryHeap(Int32).new { |a, b| b <=> a }
    a << 3 << 1 << 4 << 1 << 5
    a.to_a.should eq [5, 4, 3, 1, 1]
  end

  it "new(enumerable, &block)" do
    a = BinaryHeap.new(1..10) { |a, b| b <=> a }
    a.to_a.should eq (1..10).to_a.reverse
  end

  it "{}" do
    BinaryHeap{3, 1, 4}.top.should eq 1
  end

  it "#size" do
    BinaryHeap(Int32).new.size.should eq 0
    BinaryHeap{1, 2, 3}.size.should eq 3
  end

  it "#empty" do
    BinaryHeap(Int32).new.empty?.should be_true
    BinaryHeap{1, 2, 3}.empty?.should be_false
  end

  it "#clear" do
    a = BinaryHeap{1, 2, 3}
    a.clear.should eq BinaryHeap(Int32).new
    a.empty?.should be_true
  end

  it "#clone" do
    a = BinaryHeap{1, 2, 3}
    b = a.clone
    b.pop
    b.should eq BinaryHeap{2, 3}
    a.should eq BinaryHeap{1, 2, 3}
  end

  it "#==, #!=" do
    a = BinaryHeap{1, 2, 3}
    b = BinaryHeap{3, 2, 1}
    c = BinaryHeap{1, 2}
    (a == b).should be_true
    (a != b).should be_false
    (a == c).should be_false
    (a != c).should be_true
  end

  it "#top(&block), #top?, #top" do
    a = BinaryHeap{3, 1, 4}
    a.top.should eq 1
    a.top?.should eq 1
    a.top { "none" }.should eq 1

    a = BinaryHeap(Int32).new
    expect_raises(IndexError) { a.top }
    a.top?.should be_nil
    a.top { "none" }.should eq "none"
  end

  it "#add, #<<" do
    a = BinaryHeap(Int32).new
    a.add(1).add(2)
    a << 1 << 2 << 3
    a == BinaryHeap{1, 1, 2, 2, 3}
  end

  it "#pop(&block), #pop?, #pop" do
    a = BinaryHeap{1, 2, 3}
    a.pop.should eq 1
    a.pop?.should eq 2
    a.pop { "none" }.should eq 3
    expect_raises(IndexError) { a.pop }
    a.pop?.should be_nil
    a.pop { "none" }.should eq "none"
  end

  it "#pop(n)" do
    a = BinaryHeap{1, 2, 3, 4, 5}
    a.pop(3).should eq [1, 2, 3]
    a.pop(1).should eq [4]
    a.pop(3).should eq [5]
    a.pop(0).should eq [] of Int32
    a.pop(9).should eq [] of Int32
    expect_raises(ArgumentError) { a.pop(-1) }
  end

  it "#to_s, #inspect" do
    a = BinaryHeap{3, 1, 4}
    a.to_s.should eq "BinaryHeap{1, 3, 4}"
    a.inspect.should eq "BinaryHeap{1, 3, 4}"
  end

  it "include Enumerable" do
    a = BinaryHeap{1, 2, 3}
    a.to_a.should eq [1, 2, 3]
    a.min.should eq 1
    a.max.should eq 3
  end

  it "big test" do
    test = ->(values : Array(Int32)) {
      a = BinaryHeap(Int32).new
      values.each { |x| a << x }
      a.to_a.should eq values.sort
    }
    n = 1000
    test.call Array.new(n) { rand(Int32) }
    test.call Array.new(n) { rand(100) }
    test.call (1..n).to_a
    test.call (1..n).to_a.reverse
  end

  it "(Float64)" do
    BinaryHeap{1.1, 2.2, 3.3}.to_a.should eq [1.1, 2.2, 3.3]
  end

  it "(String)" do
    BinaryHeap.new(%w[D C B A]).to_a.should eq %w[A B C D]
  end
end
