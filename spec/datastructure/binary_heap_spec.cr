require "spec"
require "../../src/datastructure/binary_heap"

describe BinaryHeap do
  describe ".new" do
    it "creates empty heap" do
      a = BinaryHeap(Int32).new
      a << 3 << 1 << 2
      a.sort.should eq [1, 2, 3]
    end

    it "creates with enumerable" do
      a = BinaryHeap(Int32).new(1..9)
      a.sort.should eq (1..9).to_a
    end

    it "creates with compare block" do
      a = BinaryHeap(Int32).new { |a, b| b <=> a }
      a << 3 << 1 << 2
      a.sort.should eq [3, 2, 1]
    end

    it "creates with enumerable and compare block" do
      a = BinaryHeap(Int32).new(1..9) { |a, b| b <=> a }
      a.sort.should eq (1..9).reverse_each.to_a
    end
  end

  it "BinaryHeap{}" do
    a = BinaryHeap{3, 1, 2}
    a.sort.should eq [1, 2, 3]
  end

  it "#size" do
    BinaryHeap(Int32).new.size.should eq 0
    BinaryHeap{1, 2, 3}.size.should eq 3
  end

  it "#empty?" do
    BinaryHeap(Int32).new.should be_empty
    BinaryHeap{1, 2, 3}.should_not be_empty
  end

  it "#clear" do
    a = BinaryHeap{1, 2, 3}
    a.clear.should be a
    a.should be_empty
  end

  it "#dup" do
    a = BinaryHeap{[1], [2], [3]}
    b = a.dup
    b.should eq a
    b.should_not be a
    a.top.should be b.top
  end

  it "#clone" do
    a = BinaryHeap{[1], [2], [3]}
    b = a.clone
    b.should eq a
    b.should_not be a
    a.top.should_not be b.top
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
    context "when heap is not empty" do
      it "returns top element" do
        a = BinaryHeap{3, 1, 2}
        a.top.should eq 1
        a.top?.should eq 1
        a.top { "none" }.should eq 1
      end
    end

    context "when heap is empty" do
      it "returns top element" do
        a = BinaryHeap(Int32).new
        expect_raises(IndexError) { a.top }
        a.top?.should be_nil
        a.top { "none" }.should eq "none"
      end
    end
  end

  it "#add, #<<" do
    a = BinaryHeap(Int32).new
    a.add(1).add(2).should be a
    (a << 1 << 2 << 3).should be a
    a.sort.should eq [1, 1, 2, 2, 3]
  end

  describe "#pop" do
    it "pops when heap is not empty" do
      a = BinaryHeap{1, 2, 3}
      a.pop.should eq 1
      a.pop?.should eq 2
      a.pop { "none" }.should eq 3
    end

    it "pops when heap is empty" do
      a = BinaryHeap(Int32).new
      expect_raises(IndexError) { a.pop }
      a.pop?.should be_nil
      a.pop { "none" }.should eq "none"
    end

    it "pops many elements" do
      a = BinaryHeap{1, 2, 3, 4, 5}
      a.pop(3).should eq [1, 2, 3]
      a.sort.should eq [4, 5]
      a.pop(2).should eq [4, 5]
      a.sort.should eq [] of Int32
    end

    it "pops more elements that what is available" do
      a = BinaryHeap{1, 2, 3, 4, 5}
      a.pop(9).should eq [1, 2, 3, 4, 5]
      a.should be_empty
      a.pop(1).should eq [] of Int32
    end

    it "raises if pops negative number of elements" do
      a = BinaryHeap{1, 2}
      expect_raises(ArgumentError) { a.pop(-1) }
    end
  end

  describe "#each" do
    a = BinaryHeap{3, 1, 2}

    it "receives block" do
      b = [] of Int32
      a.each { |x| b << x }
      b.sort.should eq [1, 2, 3]
    end

    it "returns Iterator" do
      a.each.should be_a Iterator(Int32)
      a.each.min.should eq 1
      a.each.max.should eq 3
      a.each.cycle(2).to_a.sort.should eq [1, 1, 2, 2, 3, 3]
    end
  end

  it "#sort" do
    a = BinaryHeap{3, 1, 2}
    a.sort.should eq [1, 2, 3]
    b = BinaryHeap.new([1, 2, 3]) { |a, b| b <=> a }
    b.sort.should eq [3, 2, 1]
  end

  it "#to_a" do
    a = BinaryHeap{3, 1, 2}
    a.to_a.sort.should eq [1, 2, 3]
    a = BinaryHeap{3, 1, 4, 1, 5}
    a.to_a.sort.should eq [1, 1, 3, 4, 5]
  end

  it "#to_s, #inspect" do
    a = BinaryHeap{3, 1, 4}
    a.to_s.should eq "BinaryHeap{1, 3, 4}"
    a.inspect.should eq "BinaryHeap{1, 3, 4}"
  end

  it "includes Enumerable(T)" do
    a = BinaryHeap{1, 2, 3}
    a.sort.should eq [1, 2, 3]
    a.min.should eq 1
    a.max.should eq 3
  end

  it "includes Iterable(T)" do
    a = BinaryHeap{1, 2, 3}
    a.cycle(2).should be_a Iterator(Int32)
    a.cycle(2).to_a.should eq [1, 2, 3, 1, 2, 3]
    a.each_cons(2).to_a.should eq [[1, 2], [2, 3]]
  end

  describe "big test" do
    it "hasn't compare proc" do
      n = 100000
      [
        Array.new(n) { rand(Int32) },
        Array.new(n) { rand(100) },
        (1..n).to_a,
        (1..n).to_a.reverse,
      ].each do |values|
        a = BinaryHeap(Int32).new
        values.each { |x| a << x }
        a.sort.should eq values.sort
      end
    end

    it "has compare proc" do
      n = 100000
      [
        Array.new(n) { rand(Int32) },
        Array.new(n) { rand(100) },
        (1..n).to_a,
        (1..n).to_a.reverse,
      ].each do |values|
        a = BinaryHeap(Int32).new { |a, b| b <=> a }
        values.each { |x| a << x }
        a.sort.should eq values.sort_by(&.-)
      end
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
