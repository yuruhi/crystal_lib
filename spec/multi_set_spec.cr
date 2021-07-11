require "spec"
require "../src/datastructure/multi_set"

describe "MultiSet" do
  it "initialize" do
    MultiSet(Int32).new.to_s.should eq "{}"
    MultiSet.new([0, 1, 2, 2]).to_s.should eq "{0 => 1, 1 => 1, 2 => 2}"
    MultiSet{0, 1, 2, 2}.to_s.should eq "{0 => 1, 1 => 1, 2 => 2}"
  end

  it "size" do
    MultiSet{0, 0, 0, 1, 1, 2}.size.should eq 6
    MultiSet(Int32).new.size.should eq 0
  end

  it "kind_count" do
    MultiSet{0, 0, 1, 2}.kind_count.should eq 3
    MultiSet(Int32).new.kind_count.should eq 0
  end

  it "add" do
    a = MultiSet(Int32).new
    a.add 1
    a.add 2
    a << 1
    a.to_s.should eq "{1 => 2, 2 => 1}"

    a.add 3, 5
    a.add 2, 3
    a.to_s.should eq "{1 => 2, 2 => 4, 3 => 5}"
  end

  it "delete" do
    a = MultiSet{1, 1, 1, 1, 1, 2, 2, 3}
    a.delete 2
    a.to_s.should eq "{1 => 5, 2 => 1, 3 => 1}"
    a.delete 1, 3
    a.to_s.should eq "{1 => 2, 2 => 1, 3 => 1}"
  end

  it "concat" do
    a = MultiSet{1, 1, 1, 1, 1, 2, 2, 3}
    a.concat a
    a.to_s.should eq "{1 => 10, 2 => 4, 3 => 2}"
    a.concat({0, 0, 0, 1, 2, 3})
    a.to_s.should eq "{1 => 11, 2 => 5, 3 => 3, 0 => 3}"
  end

  it "clear" do
    a = MultiSet{0, 0, 1, 1}
    a.clear
  end

  it "count" do
    a = MultiSet{0, 0, 0, 1, 1, 2}
    a.count(0).should eq 3
    a.count(1).should eq 2
    a.count(2).should eq 1
    a.count(3).should eq 0
  end

  it "includes?" do
    a = MultiSet{0, 0, 0, 1, 1, 2}
    a.includes?(0).should eq true
    a.includes?(1).should eq true
    a.includes?(2).should eq true
    a.includes?(3).should eq false
  end

  it "empty?" do
    MultiSet{0, 0, 0, 1, 1, 2}.empty?.should eq false
    MultiSet(Int32).new.empty?.should eq true
  end

  it "intersects?" do
    a = MultiSet{0, 0, 0, 1, 1, 2}
    b = MultiSet{2, 3}
    c = MultiSet{3, 3, 3, 4, 4, 5}
    a.intersects?(b).should eq true
    b.intersects?(c).should eq true
    a.intersects?(c).should eq false
  end

  it "subset_of?" do
    a = MultiSet{0, 0, 0, 1, 1, 2}
    b = MultiSet{0, 1, 0}
    c = MultiSet{-1, 0, 0, 1}
    a.subset_of?(b).should eq false
    b.subset_of?(a).should eq true
    c.subset_of?(a).should eq false
  end

  it "superset_of?" do
    a = MultiSet{0, 0, 0, 1, 1, 2}
    b = MultiSet{0, 1, 0}
    c = MultiSet{-1, 0, 0, 1}
    a.superset_of?(b).should eq true
    b.superset_of?(a).should eq false
    c.superset_of?(a).should eq false
  end

  it "each" do
    a = MultiSet{0, 0, 0, 1, 1, 2}
    a.each.to_a.should eq [0, 0, 0, 1, 1, 2]
    a.each.max.should eq 2
  end

  it "each(&)" do
    a = [] of Int32
    MultiSet{0, 0, 0, 1, 1, 2}.each do |elem|
      a << elem
    end
    a.should eq [0, 0, 0, 1, 1, 2]
  end

  it "each_count" do
    MultiSet{0, 0, 0, 1, 1, 2}.each_count.max.should eq({2, 1})
  end

  it "each_count(&)" do
    a = [] of {Int32, Int32}
    MultiSet{0, 0, 0, 1, 1, 2}.each_count do |(elem, cnt)|
      a << {elem, cnt}
    end
    a.should eq [{0, 3}, {1, 2}, {2, 1}]
  end

  it "&" do
    a = MultiSet{0, 0, 0, 1, 1, 2, 3}
    b = MultiSet{0, 1, 1, 2, 2, 2}
    (a & b).to_s.should eq "{0 => 1, 1 => 2, 2 => 1}"
  end

  it "|" do
    a = MultiSet{0, 0, 0, 1, 1, 2, 3}
    b = MultiSet{0, 1, 1, 2, 2, 2}
    (a | b).to_s.should eq "{0 => 4, 1 => 4, 2 => 4, 3 => 1}"
    (a + b).to_s.should eq "{0 => 4, 1 => 4, 2 => 4, 3 => 1}"
  end

  it "to_s" do
    MultiSet{0, 0, 0, 1, 1, 2}.to_s.should eq "{0 => 3, 1 => 2, 2 => 1}"
  end

  it "inspect" do
    io = IO::Memory.new
    MultiSet{0, 0, 0, 1, 1, 2}.inspect(io)
    io.to_s.should eq "[0, 0, 0, 1, 1, 2]"
  end

  it "Iterable" do
    MultiSet{0, 0, 0, 1, 1, 2}.each_slice(3).to_a.should eq [[0, 0, 0], [1, 1, 2]]
    MultiSet{0, 0, 0, 1, 1, 2}.each_cons(2).select { |(i, j)| i != j }.to_a.should eq [[0, 1], [1, 2]]
  end

  it "Enumeratable" do
    MultiSet{0, 0, 0, 1, 1, 2}.all?(&.even?).should eq false
    MultiSet{0, 0, 0, 1, 1, 2}.all? { |i| i >= 0 }.should eq true
    MultiSet{0, 0, 0, 1, 1, 2}.max.should eq 2
    MultiSet{"a", "ab", "abc", "abcd"}.max_by(&.size).should eq "abcd"
    MultiSet{0, 0, 0, 1, 1, 2}.first.should eq 0
    MultiSet{0, 0, 0, 1, 1, 2}.index(1).should eq 3
    MultiSet{0, 0, 0, 1, 1, 2}.join.should eq "000112"
  end
end
