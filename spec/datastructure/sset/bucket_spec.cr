require "spec"
require "../../../src/datastructure/sset/bucket"

private alias S = SSet::Bucket(Int32, 1, 170, 1)

describe "SSet::Bucket(Int32)" do
  it "{}" do
    S{3, 1, 4, 1, 5}.to_a.should eq [1, 3, 4, 5]
  end

  it ".new" do
    s = S.new [1, 2, 1, 3, 4]
    s.to_a.should eq [1, 2, 3, 4]
  end

  it "#size" do
    s = S.new
    s.size.should eq 0
    s.add 1
    s.size.should eq 1
    s.add 1
    s.size.should eq 1
    s.delete 1
    s.size.should eq 0
  end

  it "#empty?" do
    s = S.new
    s.empty?.should be_true
    s.add 1
    s.empty?.should be_false
  end

  it "#clear" do
    s = S.new
    s.add 1
    s.clear.size.should eq 0
  end

  it "#add?" do
    s = S.new
    s.add?(1).should be_true
    s.add?(1).should be_false
  end

  it "#add, #<<" do
    s = S.new
    s.add(1).add(2).add(1)
    s.size.should eq 2
    s << 3 << 4 << 3
    s.size.should eq 4
  end

  it "#min?, #min, #max?, #max" do
    s = S.new
    s.min?.should be_nil
    s.max?.should be_nil
    expect_raises(S::EmptyError) { s.min }
    expect_raises(S::EmptyError) { s.max }
    s << 1 << 2
    s.min?.should eq 1
    s.max?.should eq 2
    s.min.should eq 1
    s.max.should eq 2
  end

  it "#each" do
    s = S{3, 1, 4, 1, 5}

    a = [] of Int32
    s.each { |x| a << x }
    a.should eq [1, 3, 4, 5]

    a.each.to_a.should eq [1, 3, 4, 5]
  end

  it "#reverse_each" do
    s = S{3, 1, 4, 1, 5}

    a = [] of Int32
    s.reverse_each { |x| a << x }
    a.should eq [5, 4, 3, 1]
  end

  it "#[]" do
    s = S{3, 1, 4, 1, 5}
    s[0].should eq 1
    s[1].should eq 3
    s[2].should eq 4
    s[3].should eq 5
    s[-1].should eq 5
    s[-2].should eq 4
    s[-3].should eq 3
    s[-4].should eq 1
    expect_raises(IndexError) { s[4] }
    expect_raises(IndexError) { s[-5] }
  end

  it "#includes?" do
    s = S{1, 3, 5}
    {1, 3, 5}.each { |x| s.includes?(x).should be_true }
    {0, 2, 4}.each { |x| s.includes?(x).should be_false }
  end

  it "#le, #le!" do
    s = S{1, 3}
    [nil, 1, 1, 3, 3].each_with_index { |e, x| s.le(x).should eq e }
    expect_raises(NilAssertionError) { s.le!(0) }
    [1, 1, 3, 3].each_with_index(1) { |e, x| s.le!(x).should eq e }
  end

  it "#lt, #lt!" do
    s = S{1, 3}
    [nil, nil, 1, 1, 3, 3].each_with_index { |e, x| s.lt(x).should eq e }
    expect_raises(NilAssertionError) { s.lt!(0) }
    expect_raises(NilAssertionError) { s.lt!(1) }
    [1, 1, 3, 3].each_with_index(2) { |e, x| s.lt!(x).should eq e }
  end

  it "#ge, #ge!" do
    s = S{1, 3}
    [1, 1, 3, 3, nil].each_with_index { |e, x| s.ge(x).should eq e }
    expect_raises(NilAssertionError) { s.ge!(4) }
    [1, 1, 3, 3].each_with_index { |e, x| s.ge!(x).should eq e }
  end

  it "#gt, #gt!" do
    s = S{1, 3}
    [1, 3, 3, nil, nil].each_with_index { |e, x| s.gt(x).should eq e }
    expect_raises(NilAssertionError) { s.gt!(3) }
    expect_raises(NilAssertionError) { s.gt!(4) }
    [1, 3, 3].each_with_index { |e, x| s.gt!(x).should eq e }
  end

  {% for op in [:&, :|, :+, :-] %}
    it "\#{{op.id}}" do
      a = S{0, 1, 2, 2, 3}
      b = {1, 1, 2, 3, 4, 5}
      expected = a.to_set {{op.id}} b.to_set
      (a {{op.id}} b).to_a.should eq expected.to_a
    end
  {% end %}

  it "#to_a" do
    s = S{1, 3, 2, 4}
    s.to_a.should eq [1, 2, 3, 4]
  end

  it "#to_s" do
    s = S{1, 2, 3, 4}
    s.to_s.should eq "SSet::Bucket{1, 2, 3, 4}"
  end

  it "includes Enumerable" do
    s = S{1, 2, 3, 4}
    s.all? { |x| x > 0 }.should be_true
  end

  it "includes Iterable" do
    s = S{1, 2, 3, 4}
    s.cycle(2).to_a.should eq [1, 2, 3, 4, 1, 2, 3, 4]
  end

  it "includes Indexable" do
    s = S{1, 2, 3, 4}
    s.values_at(0, 1, 2, 3).should eq({1, 2, 3, 4})
  end
end
