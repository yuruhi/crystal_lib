require "spec"
require "../../src/datastructure/multi_set"

describe MultiSet do
  it "#initialize" do
    MultiSet(Int32).new.to_s.should eq "MultiSet{}"
    MultiSet.new([0, 1, 2, 2]).to_s.should eq "MultiSet{0, 1, 2, 2}"
    MultiSet{0, 1, 2, 2}.to_s.should eq "MultiSet{0, 1, 2, 2}"
  end

  it ".from_counts" do
    MultiSet.from_counts([{0, 1}]).should eq MultiSet{0}
    MultiSet.from_counts([{0, 3}]).should eq MultiSet{0, 0, 0}
    MultiSet.from_counts([{1, 1}, {2, 2}, {3, 3}]).should eq MultiSet{1, 2, 2, 3, 3, 3}
    expect_raises(ArgumentError) { MultiSet.from_counts [{1, 1}, {2, 2}, {1, 3}] }
    expect_raises(ArgumentError) { MultiSet.from_counts [{0, -1}] }
  end

  it "#size" do
    MultiSet{0, 0, 0, 1, 1, 2}.size.should eq 6
    MultiSet(Int32).new.size.should eq 0
  end

  it "#kind_count" do
    MultiSet{0, 0, 1, 2}.kind_count.should eq 3
    MultiSet(Int32).new.kind_count.should eq 0
  end

  it "#==" do
    a = MultiSet{1, 2, 2}
    (a == MultiSet{1, 2, 2}).should be_true
    (a == MultiSet{1, 2}).should be_false
    (a == MultiSet{1i64, 2i64, 2i64}).should be_true
  end

  it "#add, #<<" do
    a = MultiSet(Int32).new
    a.add(1).should be a
    a.add(2) << 1
    a.should eq MultiSet{1, 1, 2}

    a.add(3, 5).should be a
    a.add 2, 3
    a.should eq MultiSet.from_counts [{1, 2}, {2, 4}, {3, 5}]
  end

  it "#delete" do
    a = MultiSet{1, 1, 1, 1, 1, 2, 2, 3}
    a.delete(2).should be_true
    a.should eq MultiSet{1, 1, 1, 1, 1, 2, 3}
    a.delete(1, 3).should be_true
    a.should eq MultiSet{1, 1, 2, 3}
    a.delete(3, 128).should be_true
    a.should eq MultiSet{1, 1, 2}
    a.delete(3).should be_false
    a.should eq MultiSet{1, 1, 2}
    expect_raises(ArgumentError) { a.delete 1, -1 }
  end

  it "#concat" do
    a = MultiSet{1, 1, 1, 1, 1, 2, 2, 3}
    a.concat a
    a.should eq MultiSet.from_counts [{1, 10}, {2, 4}, {3, 2}]
    a.concat({0, 0, 0, 1, 2, 3})
    a.should eq MultiSet.from_counts [{1, 11}, {2, 5}, {3, 3}, {0, 3}]
  end

  it "#clear" do
    a = MultiSet{0, 0, 1, 1}
    a.clear.should be a
    a.should eq MultiSet(Int32).new
  end

  it "#count" do
    a = MultiSet{0, 0, 0, 1, 1, 2}
    a.count(0).should eq 3
    a.count(1).should eq 2
    a.count(2).should eq 1
    a.count(3).should eq 0
  end

  it "#includes?, #===" do
    a = MultiSet{0, 0, 0, 1, 1, 2}
    4.times do |i|
      a.includes?(i).should eq i < 3
      (a === i).should eq i < 3
    end
  end

  it "#empty?" do
    MultiSet{0}.should_not be_empty
    MultiSet(Int32).new.should be_empty
  end

  it "#intersects?" do
    a = MultiSet{0, 0, 0, 1, 1, 2}
    b = MultiSet{2, 3}
    c = MultiSet{3, 3, 3, 4, 4, 5}
    a.intersects?(b).should be_true
    b.intersects?(c).should be_true
    a.intersects?(c).should be_false
  end

  it "#subset_of?" do
    a = MultiSet{0, 0, 0, 1, 1, 2}
    b = MultiSet{0, 1, 0}
    c = MultiSet{-1, 0, 0, 1}
    a.subset_of?(b).should be_false
    b.subset_of?(a).should be_true
    c.subset_of?(a).should be_false
  end

  it "#superset_of?" do
    a = MultiSet{0, 0, 0, 1, 1, 2}
    b = MultiSet{0, 1, 0}
    c = MultiSet{-1, 0, 0, 1}
    a.superset_of?(b).should be_true
    b.superset_of?(a).should be_false
    c.superset_of?(a).should be_false
  end

  it "#each" do
    a = MultiSet{0, 0, 0, 1, 1, 2}
    a.each.to_a.should eq [0, 0, 0, 1, 1, 2]
    a.each.max.should eq 2
  end

  it "#each(&)" do
    a = [] of Int32
    MultiSet{0, 0, 0, 1, 1, 2}.each do |elem|
      a << elem
    end
    a.should eq [0, 0, 0, 1, 1, 2]
  end

  it "#each_count" do
    MultiSet{0, 0, 0, 1, 1, 2}.each_count.max.should eq({2, 1})
  end

  it "#each_count(&)" do
    a = [] of {Int32, Int32}
    MultiSet{0, 0, 0, 1, 1, 2}.each_count do |elem, cnt|
      a << {elem, cnt}
    end
    a.should eq [{0, 3}, {1, 2}, {2, 1}]
  end

  it "#&" do
    a = MultiSet{0, 0, 0, 1, 1, 2, 3}
    b = MultiSet{0, 1, 1, 2, 2, 2}
    (a & b).should eq MultiSet{0, 1, 1, 2}
    a = MultiSet{1, 2, 2, 3, 3, 3}
    b = MultiSet{2, 3, 3, 4}
    (a & b).should eq MultiSet{2, 3, 3}
  end

  it "#|, #+" do
    a = MultiSet{0, 0, 0, 1, 1, 2, 3}
    b = MultiSet{0, 1, 1, 2, 2, 2}
    c = MultiSet{0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3}
    (a | b).should eq c
    (a + b).should eq c
  end

  it "#-" do
    a = MultiSet{0, 1, 2, 2, 3, 3}
    b = MultiSet{1, 2, 3, 3, 3, 4}
    (a - b).should eq MultiSet{0, 2}
    (a - b.to_a).should eq MultiSet{0, 2}
  end

  it "#*" do
    a = MultiSet{1, 2, 2}
    (a * 10).should eq MultiSet.from_counts [{1, 10}, {2, 20}]
    (a * 0).should be_empty
    expect_raises(ArgumentError) { a * -1 }
  end

  it "#subtract" do
    a = MultiSet{1, 2, 2, 3}
    a.subtract(MultiSet{1, 1, 2}).should be a
    a.should eq MultiSet{2, 3}
    a = MultiSet{1, 2, 2, 3}
    a.subtract([1, 1, 2]).should be a
    a.should eq MultiSet{2, 3}
  end

  it "#dup" do
    a = MultiSet{1, 2, 2, 3}
    b = a.dup
    b.should eq a
    b.should_not be a
  end

  it "#clone" do
    a = MultiSet{[1, 2, 3]}
    b = a.clone
    b.should eq a
    b.should_not be a
    a.to_a[0].should_not be b.to_a[0]
  end

  it "#to_s" do
    MultiSet{0, 0, 0, 1, 1, 2}.to_s.should eq "MultiSet{0, 0, 0, 1, 1, 2}"
  end

  it "#inspect" do
    MultiSet{0, 0, 0, 1, 1, 2}.inspect.should eq "{0(3), 1(2), 2(1)}"
    MultiSet{0, 1, 2, 0, 1, 0}.inspect.should eq "{0(3), 1(2), 2(1)}"
  end

  it "includes Iterable" do
    MultiSet{0, 0, 0, 1, 1, 2}.each_slice(3).to_a.should eq [[0, 0, 0], [1, 1, 2]]
    MultiSet{0, 0, 0, 1, 1, 2}.each_cons(2).select { |(i, j)| i != j }.to_a.should eq [[0, 1], [1, 2]]
  end

  it "includes Enumeratable" do
    a = MultiSet{0, 0, 0, 1, 1, 2}
    a.all?(&.even?).should be_false
    a.all? { |i| i >= 0 }.should be_true
    a.max.should eq 2
    MultiSet{"a", "ab", "abc", "abcd"}.max_by(&.size).should eq "abcd"
    a.first.should eq 0
    a.index(1).should eq 3
    a.join.should eq "000112"
  end
end
