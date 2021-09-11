require "spec"
require "../../../src/datastructure/set/red_black_tree"

def verify_dfs(node : Set::RedBlackTree::Node)
  if node.nil_node?
    node.left.nil_node?.should be_true
    node.right.nil_node?.should be_true
  end

  if node.left.node?
    node.key.should be > node.left.key
    (node.red? && node.left.red?).should be_false
    node.left.parent.should eq node
    verify_dfs(node.left)
  end

  if node.right.node?
    node.key.should be < node.right.key
    (node.red? && node.right.red?).should be_false
    node.right.parent.should eq node
    verify_dfs(node.right)
  end
end

def verify(set : Set::RedBlackTree)
  if set.root.node?
    set.root.parent.nil_node?.should be_true
  end
  verify_dfs(set.root)
end

alias RBT = Set::RedBlackTree(Int32)

describe Set::RedBlackTree(Int32) do
  it "{}" do
    RBT{3, 1, 4, 1, 5}.to_a.should eq [1, 3, 4, 5]
  end

  it "#root" do
    s = RBT.new
    s.root.nil_node?.should be_true
  end

  it "#size" do
    s = RBT.new
    s.size.should eq 0
    s.add 1
    s.size.should eq 1
    s.add 1
    s.size.should eq 1
    s.delete 1
    s.size.should eq 0
  end

  it "#empty?" do
    s = RBT.new
    s.empty?.should be_true
    s.add 1
    s.empty?.should be_false
  end

  it "#clear" do
    s = RBT.new
    s.add 1
    s.clear.size.should eq 0
  end

  it "#add?" do
    s = RBT.new
    s.add?(1).should be_true
    s.add?(1).should be_false
    verify(s)
  end

  it "#add, #<<" do
    s = RBT.new
    s.add(1).add(2).add(1)
    s.size.should eq 2
    s << 3 << 4 << 3
    s.size.should eq 4
    verify(s)
  end

  it "#min_node, #max_node" do
    s = RBT.new
    s.min_node.nil_node?.should be_true
    s.max_node.nil_node?.should be_true
    s << 1 << 2
    s.min_node.key?.should eq 1
    s.max_node.key?.should eq 2
  end

  it "#min?, #min, #max?, #max" do
    s = RBT.new
    s.min?.should be_nil
    s.max?.should be_nil
    expect_raises(Set::RedBlackTree::EmptyError) { s.min }
    expect_raises(Set::RedBlackTree::EmptyError) { s.max }
    s << 1 << 2
    s.min?.should eq 1
    s.max?.should eq 2
    s.min.should eq 1
    s.max.should eq 2
  end

  it "#split" do
    1000.times do
      s = RBT.new(1..10)
      l, r = s.split(5)
      l.to_a.should eq [1, 2, 3, 4, 5]
      r.to_a.should eq [6, 7, 8, 9, 10]
      verify(s)
    end
    10.times do
      s = RBT.new(1..1000)
      l, r = s.split(500)
      l.to_a.should eq (1..500).to_a
      r.to_a.should eq (501..1000).to_a
      verify(s)
    end
  end

  it "#each" do
    s = RBT{3, 1, 4, 1, 5}
    a = [] of Int32
    s.each { |x| a << x }
    a.should eq [1, 3, 4, 5]
  end

  it "#reverse_each" do
    s = RBT{3, 1, 4, 1, 5}
    a = [] of Int32
    s.reverse_each { |x| a << x }
    a.should eq [5, 4, 3, 1]
  end

  it "#includes?" do
    s = RBT{1, 3, 5}
    {1, 3, 5}.each { |x| s.includes?(x).should be_true }
    {0, 2, 4}.each { |x| s.includes?(x).should be_false }
  end

  it "#search" do
    s = RBT{1, 3, 5}
    {1, 3, 5}.each { |x| s.search(x).key?.should eq x }
    {0, 2, 4}.each { |x| s.search(x).nil_node?.should be_true }
  end

  it "#le, #le!" do
    s = RBT{1, 3}
    [nil, 1, 1, 3, 3].each_with_index { |e, x| s.le(x).should eq e }
    expect_raises(NilAssertionError) { s.le!(0) }
    [1, 1, 3, 3].each_with_index(1) { |e, x| s.le!(x).should eq e }
  end

  it "#lt, #lt!" do
    s = RBT{1, 3}
    [nil, nil, 1, 1, 3, 3].each_with_index { |e, x| s.lt(x).should eq e }
    expect_raises(NilAssertionError) { s.lt!(0) }
    expect_raises(NilAssertionError) { s.lt!(1) }
    [1, 1, 3, 3].each_with_index(2) { |e, x| s.lt!(x).should eq e }
  end

  it "#ge, #ge!" do
    s = RBT{1, 3}
    [1, 1, 3, 3, nil].each_with_index { |e, x| s.ge(x).should eq e }
    expect_raises(NilAssertionError) { s.ge!(4) }
    [1, 1, 3, 3].each_with_index { |e, x| s.ge!(x).should eq e }
  end

  it "#gt, #gt!" do
    s = RBT{1, 3}
    [1, 3, 3, nil, nil].each_with_index { |e, x| s.gt(x).should eq e }
    expect_raises(NilAssertionError) { s.gt!(3) }
    expect_raises(NilAssertionError) { s.gt!(4) }
    [1, 3, 3].each_with_index { |e, x| s.gt!(x).should eq e }
  end

  it "#to_s, #inspect" do
    s = RBT{1, 2, 3, 4}
    s.to_s.should eq "Set::RedBlackTree{1, 2, 3, 4}"
    s.inspect.should eq "Set::RedBlackTree{1, 2, 3, 4}"
  end

  it "big" do
    n = 10**4
    s = RBT.new
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

it Set::RedBlackTree(String) do
  Set::RedBlackTree{"a", "c", "b"}.to_a.should eq %w[a b c]
  Set::RedBlackTree{"a", "ab", "abc", "abc"}.to_a.should eq %w[a ab abc]
end
