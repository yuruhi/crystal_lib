require "spec"
require "../../src/datastructure/binary_heap"

describe BinaryHeap do
  describe ".new" do
    it "creates empty heap" do
      a = BinaryHeap(Int32).new
      a << 3 << 1 << 2
      a.to_a.should eq [1, 2, 3]
    end

    it "creates with enumerable" do
      a = BinaryHeap(Int32).new(1..9)
      a.to_a.should eq (1..9).to_a
    end

    it "creates with compare block" do
      a = BinaryHeap(Int32).new { |a, b| b <=> a }
      a << 3 << 1 << 2
      a.to_a.should eq [3, 2, 1]
    end

    it "creates with enumerable and compare block" do
      a = BinaryHeap(Int32).new(1..9) { |a, b| b <=> a }
      a.to_a.should eq (1..9).reverse_each.to_a
    end
  end

  it "BinaryHeap{}" do
    a = BinaryHeap{3, 1, 2}
    a.to_a.should eq [1, 2, 3]
  end

  it "#size" do
    BinaryHeap(Int32).new.size.should eq 0
    BinaryHeap{1, 2, 3}.size.should eq 3
  end

  it "#empty?" do
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

  describe "compare" do
    a = BinaryHeap{1, 2, 3}
    b = BinaryHeap{3, 2, 1}
    c = BinaryHeap{1, 2}

    it "#==" do
      (a == b).should be_true
      (a == c).should be_false
    end

    it "#!=" do
      (a != b).should be_false
      (a != c).should be_true
    end
  end

  describe "#top" do
    it "gets top element when non empty" do
      a = BinaryHeap{3, 1, 2}
      a.top.should eq 1
      a.top?.should eq 1
      a.top { "none" }.should eq 1
    end

    it "gets top element when empty" do
      a = BinaryHeap(Int32).new
      expect_raises(IndexError) { a.top }
      a.top?.should be_nil
      a.top { "none" }.should eq "none"
    end
  end

  it "#add, #<<" do
    a = BinaryHeap(Int32).new
    a.add(1).add(2).should be a
    (a << 1 << 2 << 3).should be a
    a.to_a.should eq [1, 1, 2, 2, 3]
  end

  describe "#pop" do
    it "pops when non empty" do
      a = BinaryHeap{1, 2, 3}
      a.pop.should eq 1
      a.pop?.should eq 2
      a.pop { "none" }.should eq 3
    end

    it "pops when empty" do
      a = BinaryHeap(Int32).new
      expect_raises(IndexError) { a.pop }
      a.pop?.should be_nil
      a.pop { "none" }.should eq "none"
    end

    it "pops many elements" do
      a = BinaryHeap{1, 2, 3, 4, 5}
      a.pop(3).should eq [1, 2, 3]
      a.to_a.should eq [4, 5]
      a.pop(2).should eq [4, 5]
      a.to_a.should eq [] of Int32
    end

    it "pops more elements that what is available" do
      a = BinaryHeap{1, 2, 3, 4, 5}
      a.pop(9).should eq [1, 2, 3, 4, 5]
      a.empty?.should be_true
      a.pop(1).should eq [] of Int32
    end

    it "pops negative count raises" do
      a = BinaryHeap{1, 2}
      expect_raises(ArgumentError) { a.pop(-1) }
    end
  end

  it "#to_a" do
    a = BinaryHeap{3, 1, 2}
    a.to_a.should eq [1, 2, 3]
  end

  it "#to_s, #inspect" do
    a = BinaryHeap{3, 1, 4}
    a.to_s.should eq "BinaryHeap{1, 3, 4}"
    a.inspect.should eq "BinaryHeap{1, 3, 4}"
  end

  it "includes Enumerable" do
    a = BinaryHeap{1, 2, 3}
    a.to_a.should eq [1, 2, 3]
    a.min.should eq 1
    a.max.should eq 3
  end

  describe "big test" do
    it "hasn't compare proc" do
      test = ->(values : Array(Int32)) {
        a = BinaryHeap(Int32).new
        values.each { |x| a << x }
        a.to_a.should eq values.sort
      }
      n = 100000
      test.call Array.new(n) { rand(Int32) }
      test.call Array.new(n) { rand(100) }
      test.call (1..n).to_a
      test.call (1..n).to_a.reverse
    end

    it "has compare proc" do
      test = ->(values : Array(Int32)) {
        a = BinaryHeap(Int32).new { |a, b| b <=> a }
        values.each { |x| a << x }
        a.to_a.should eq values.sort.reverse
      }
      n = 100000
      test.call Array.new(n) { rand(Int32) }
      test.call Array.new(n) { rand(100) }
      test.call (1..n).to_a
      test.call (1..n).to_a.reverse
    end
  end

  describe "generics" do
    it "Float64" do
      BinaryHeap{1.1, 2.2, 3.3}.to_a.should eq [1.1, 2.2, 3.3]
    end

    it "String" do
      BinaryHeap.new(%w[D C B A]).to_a.should eq %w[A B C D]
    end
  end
end
