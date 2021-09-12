require "spec"
require "../../../src/datastructure/smultiset/treap"

def verify_dfs(node : SMultiSet::Treap::Node)
  if node.nil_node?
    node.left.nil_node?.should be_true
    node.right.nil_node?.should be_true
  end

  if node.left.node?
    node.key.should be >= node.left.key
    node.priority.should be <= node.left.priority
    node.left.parent.should eq node
    verify_dfs(node.left)
  end

  if node.right.node?
    node.key.should be <= node.right.key
    node.priority.should be <= node.right.priority
    node.right.parent.should eq node
    verify_dfs(node.right)
  end
end

def verify(set : SMultiSet::Treap)
  if set.root.node?
    set.root.parent.nil_node?.should be_true
  end
  verify_dfs(set.root)
end

alias MSTreap = SMultiSet::Treap(Int32)

describe SMultiSet::Treap(Int32) do
  it "{}" do
    MSTreap{3, 1, 4, 1, 5}.to_a.should eq [1, 1, 3, 4, 5]
  end

  it "#root" do
    s = MSTreap.new
    s.root.nil_node?.should be_true
  end

  it "#size" do
    s = MSTreap.new
    s.size.should eq 0
    s.add 1
    s.size.should eq 1
    s.add 1
    s.size.should eq 2
    s.delete 1
    s.size.should eq 1
  end

  it "#empty?" do
    s = MSTreap.new
    s.empty?.should be_true
    s.add 1
    s.empty?.should be_false
  end

  it "#clear" do
    s = MSTreap.new
    s.add 1
    s.clear.size.should eq 0
  end

  it "#add?" do
    s = MSTreap.new
    s.add?(1).should be_true
    s.add?(1).should be_true
    verify(s)
  end

  it "#add, #<<" do
    s = MSTreap.new
    s.add(1).add(2).add(1)
    s.size.should eq 3
    s << 3 << 4 << 3
    s.size.should eq 6
    verify(s)
  end

  it "#min_node, #max_node" do
    s = MSTreap.new
    s.min_node.nil_node?.should be_true
    s.max_node.nil_node?.should be_true
    s << 1 << 2
    s.min_node.key?.should eq 1
    s.max_node.key?.should eq 2
  end

  it "#min?, #min, #max?, #max" do
    s = MSTreap.new
    s.min?.should be_nil
    s.max?.should be_nil
    expect_raises(SMultiSet::Treap::EmptyError) { s.min }
    expect_raises(SMultiSet::Treap::EmptyError) { s.max }
    s << 1 << 2
    s.min?.should eq 1
    s.max?.should eq 2
    s.min.should eq 1
    s.max.should eq 2
  end

  it "#split" do
    1000.times do
      s = MSTreap.new(1..10)
      l, r = s.split(5)
      l.to_a.should eq [1, 2, 3, 4, 5]
      r.to_a.should eq [6, 7, 8, 9, 10]
      verify(s)
    end
    10.times do
      s = MSTreap.new(1..1000)
      l, r = s.split(500)
      l.to_a.should eq (1..500).to_a
      r.to_a.should eq (501..1000).to_a
      verify(s)
    end
  end

  it "#each" do
    s = MSTreap{3, 1, 4, 1, 5}
    a = [] of Int32
    s.each { |x| a << x }
    a.should eq [1, 1, 3, 4, 5]
  end

  it "#reverse_each" do
    s = MSTreap{3, 1, 4, 1, 5}
    a = [] of Int32
    s.reverse_each { |x| a << x }
    a.should eq [5, 4, 3, 1, 1]
  end

  it "#includes?" do
    s = MSTreap{1, 3, 3, 5}
    {1, 3, 5}.each { |x| s.includes?(x).should be_true }
    {0, 2, 4}.each { |x| s.includes?(x).should be_false }
  end

  it "#search" do
    s = MSTreap{1, 3, 3, 5}
    {1, 3, 5}.each { |x| s.search(x).key?.should eq x }
    {0, 2, 4}.each { |x| s.search(x).nil_node?.should be_true }
  end

  it "#le, #le!, #le_node" do
    s = MSTreap{1, 3}
    [nil, 1, 1, 3, 3].each_with_index { |e, x| s.le(x).should eq e }
    expect_raises(NilAssertionError) { s.le!(0) }
    [1, 1, 3, 3].each_with_index(1) { |e, x| s.le!(x).should eq e }

    s = MSTreap{1, 1, 3}
    s.le_node(0).nil_node?.should be_true
    s.le_node(1).should eq s.min_node.succ
    s.le_node(2).should eq s.min_node.succ
    s.le_node(3).should eq s.max_node
    s.le_node(4).should eq s.max_node
  end

  it "#lt, #lt!, #lt_node" do
    s = MSTreap{1, 3}
    [nil, nil, 1, 1, 3, 3].each_with_index { |e, x| s.lt(x).should eq e }
    expect_raises(NilAssertionError) { s.lt!(0) }
    expect_raises(NilAssertionError) { s.lt!(1) }
    [1, 1, 3, 3].each_with_index(2) { |e, x| s.lt!(x).should eq e }

    s = MSTreap{1, 1, 3}
    s.lt_node(0).nil_node?.should be_true
    s.lt_node(1).nil_node?.should be_true
    s.lt_node(2).should eq s.min_node.succ
    s.lt_node(3).should eq s.min_node.succ
    s.lt_node(4).should eq s.max_node
  end

  it "#ge, #ge!, #ge_node" do
    s = MSTreap{1, 3}
    [1, 1, 3, 3, nil].each_with_index { |e, x| s.ge(x).should eq e }
    expect_raises(NilAssertionError) { s.ge!(4) }
    [1, 1, 3, 3].each_with_index { |e, x| s.ge!(x).should eq e }

    s = MSTreap{1, 1, 3}
    s.ge_node(0).should eq s.min_node
    s.ge_node(1).should eq s.min_node
    s.ge_node(2).should eq s.max_node
    s.ge_node(3).should eq s.max_node
    s.ge_node(4).nil_node?.should be_true
  end

  it "#gt, #gt!, #gt_node" do
    s = MSTreap{1, 3}
    [1, 3, 3, nil, nil].each_with_index { |e, x| s.gt(x).should eq e }
    expect_raises(NilAssertionError) { s.gt!(3) }
    expect_raises(NilAssertionError) { s.gt!(4) }
    [1, 3, 3].each_with_index { |e, x| s.gt!(x).should eq e }

    s = MSTreap{1, 1, 3}
    s.gt_node(0).should eq s.min_node
    s.gt_node(1).should eq s.max_node
    s.gt_node(2).should eq s.max_node
    s.gt_node(3).nil_node?.should be_true
  end

  it "#to_s, #inspect" do
    s = MSTreap{1, 2, 3, 4}
    s.to_s.should eq "SMultiSet::Treap{1, 2, 3, 4}"
    s.inspect.should eq "SMultiSet::Treap{1, 2, 3, 4}"
  end

  it "big" do
    n = 10**1
    s = MSTreap.new
    (1..n).each do |x|
      s << x
      s.size.should eq x
      s.min.should eq 1
      s.max.should eq x
      verify(s)
    end
    s.to_a.should eq (1..n).to_a
    (-n..n*2).each do |x|
      s.includes?(x).should (1 <= x <= n ? be_true : be_false)
    end
    (1..n).each do |x|
      s.delete(x).should be_true
      s.delete(x).should be_false
    end
  end
end

it SMultiSet::Treap(String) do
  SMultiSet::Treap{"a", "c", "b"}.to_a.should eq %w[a b c]
  SMultiSet::Treap{"a", "ab", "abc", "abc"}.to_a.should eq %w[a ab abc abc]
end
