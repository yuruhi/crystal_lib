require "spec"
require "../../../src/datastructure/set/treap"

alias S = Set::Treap(Int32)

describe Set::Treap(Int32) do
  it "{}" do
    S{3, 1, 4, 1, 5}.to_a.should eq [1, 3, 4, 5]
  end

  it "#root" do
    s = S.new
    s.root.nil_node?.should be_true
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

  it "#min_node, #max_node" do
    s = S.new
    s.min_node.nil_node?.should be_true
    s.max_node.nil_node?.should be_true
    s << 1 << 2
    s.min_node.key?.should eq 1
    s.max_node.key?.should eq 2
  end

  it "#min?, #min, #max?, #max" do
    s = S.new
    s.min?.should be_nil
    s.max?.should be_nil
    expect_raises(Set::Treap::EmptyError) { s.min }
    expect_raises(Set::Treap::EmptyError) { s.max }
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
  end

  it "#reverse_each" do
    s = S{3, 1, 4, 1, 5}
    a = [] of Int32
    s.reverse_each { |x| a << x }
    a.should eq [5, 4, 3, 1]
  end

  it "#includes?" do
    s = S{1, 3, 5}
    {1, 3, 5}.each { |x| s.includes?(x).should be_true }
    {0, 2, 4}.each { |x| s.includes?(x).should be_false }
  end

  it "#search" do
    s = S{1, 3, 5}
    {1, 3, 5}.each { |x| s.search(x).key?.should eq x }
    {0, 2, 4}.each { |x| s.search(x).nil_node?.should be_true }
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
end

alias SS = Set::Treap(String)

it Set::Treap(String) do
  SS{"a", "c", "b"}.to_a.should eq %w[a b c]
  SS{"a", "ab", "abc", "abc"}.to_a.should eq %w[a ab abc]
end
