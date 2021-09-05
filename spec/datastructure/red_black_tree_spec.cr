require "spec"
require "../../src/datastructure/red_black_tree"

N = 10**6

describe RedBlackTree do
  it ".new(enumerable)" do
    values = Array.new(N) { rand(Int32) }
    RedBlackTree.new(values).to_a.should eq values.sort
  end

  it "{}" do
    RedBlackTree{1, 3, 5, 5, 3, 1}.to_a.should eq [1, 1, 3, 3, 5, 5]
  end

  it "#add, #<<" do
    a = RedBlackTree(Int32).new
    (1..10).each { |x| a.add x }
    (11..20).each { |x| a << x }
    a.to_a.should eq (1..20).to_a
  end

  it "#delete" do
    a = RedBlackTree(Int32).new
    (1..100).each { |x| a << x << x }
    (1..100).select(&.odd?).each { |x|
      a.delete(x).should be_true
      a.delete(x).should be_true
      a.delete(x).should be_false
    }
    a.to_a.should eq (1..100).select(&.even?).flat_map { |x| [x, x] }
  end

  it "#min_node" do
    a = RedBlackTree(Int32).new
    a.min_node.nil_node?.should be_true

    expect = Int32::MAX
    N.times do
      x = rand(Int32)
      expect = {expect, x}.min
      a << x
      a.min_node.key.should eq expect
    end
  end

  it "#max_node" do
    a = RedBlackTree(Int32).new
    a.max_node.nil_node?.should be_true

    expect = Int32::MIN
    N.times do
      x = rand(Int32)
      expect = {expect, x}.max
      a << x
      a.max_node.key.should eq expect
    end
  end

  it "#min, #.min?" do
    a = RedBlackTree(Int32).new
    a.min?.should be_nil
    expect_raises(RedBlackTree::EmptyError) { a.min }

    expect = Int32::MAX
    N.times do
      x = rand(Int32)
      expect = {expect, x}.min
      a << x
      a.min?.should eq expect
      a.min.should eq expect
    end
  end

  it "#max, #.max?" do
    a = RedBlackTree(Int32).new
    a.max?.should be_nil
    expect_raises(RedBlackTree::EmptyError) { a.max }

    expect = Int32::MIN
    N.times do
      x = rand(Int32)
      expect = {expect, x}.max
      a << x
      a.max?.should eq expect
      a.max.should eq expect
    end
  end

  it "#succ" do
    values = Array.new(N) { rand(Int32) }
    a = RedBlackTree.new(values)
    values.sort!

    node = a.min_node
    values.each do |x|
      node.nil_node?.should be_false
      node.key.should eq x
      node = a.succ(node)
    end
    node.nil_node?.should be_true
  end

  it "#pred" do
    values = Array.new(N) { rand(Int32) }
    a = RedBlackTree.new(values)
    values.sort!

    node = a.max_node
    values.reverse_each do |x|
      node.nil_node?.should be_false
      node.key.should eq x
      node = a.pred(node)
    end
    node.nil_node?.should be_true
  end

  it "#each" do
    values = Array.new(N) { rand(Int32) }
    a = RedBlackTree.new(values)
    values.sort!
    i = 0
    a.each do |x|
      x.should eq values[i]
      i += 1
    end
  end

  it "#reverse_each" do
    values = Array.new(N) { rand(Int32) }
    a = RedBlackTree.new(values)
    values.sort!
    i = N - 1
    a.reverse_each { |x|
      x.should eq values[i]
      i -= 1
    }
  end

  it "#includes?" do
    values = Array.new(N) { rand(Int32) }
    a = RedBlackTree.new(values)
    values.sort!
    values.each do |x|
      a.includes?(x).should be_true
    end
    N.times do
      x = rand(Int32)
      i = values.bsearch_index { |y| y >= x }
      if i.nil? || values[i.not_nil!] != x
        a.includes?(x).should be_false
      end
    end
  end

  it "#search" do
    values = Array.new(N) { rand(Int32) }
    a = RedBlackTree.new(values)
    values.sort!
    values.each do |x|
      node = a.search(x)
      node.nil_node?.should be_false
      node.key.should eq x
    end
    N.times do
      x = rand(Int32)
      i = values.bsearch_index { |y| y >= x }
      if i.nil? || values[i.not_nil!] != x
        node = a.search(x)
        node.nil_node?.should be_true
      end
    end
  end

  it "#ge_node" do
    values = Array.new(N) { rand(Int32) }
    a = RedBlackTree.new(values)
    values.sort!

    test = ->(x : Int32) {
      expect = values.bsearch { |y| y >= x }

      node = a.ge_node(x)
      if expect.nil?
        node.nil_node?.should be_true
      else
        node.nil_node?.should be_false
        node.key.should eq expect
      end

      pred = a.pred(node)
      if values.first >= x
        pred.nil_node?.should be_true
      else
        pred.nil_node?.should be_false
        pred.key.should be < x
      end
    }

    values.each { |x| test.call x }
    N.times { test.call rand(Int32) }
  end

  it "#gt_node" do
    values = Array.new(N) { rand(Int32) }
    a = RedBlackTree.new(values)
    values.sort!

    test = ->(x : Int32) {
      expect = values.bsearch { |y| y > x }

      node = a.gt_node(x)
      if expect.nil?
        node.nil_node?.should be_true
      else
        node.nil_node?.should be_false
        node.key.should eq expect
      end

      pred = a.pred(node)
      if values.first > x
        pred.nil_node?.should be_true
      else
        pred.nil_node?.should be_false
        pred.key.should be <= x
      end
    }

    values.each { |x| test.call x }
    N.times { test.call rand(Int32) }
  end

  it "#le" do
    values = Array.new(N) { rand(Int32) }
    a = RedBlackTree.new(values)
    values.sort!

    test = ->(x : Int32) {
      i = values.bsearch_index { |y| y > x } || N
      expect = i == 0 ? nil : values[i - 1]
      a.le(x).should eq expect
    }

    values.each { |x| test.call x }
    N.times { test.call rand(Int32) }
  end

  it "#lt" do
    values = Array.new(N) { rand(Int32) }
    a = RedBlackTree.new(values)
    values.sort!

    test = ->(x : Int32) {
      i = values.bsearch_index { |y| y >= x } || N
      expect = i == 0 ? nil : values[i - 1]
      a.lt(x).should eq expect
    }

    values.each { |x| test.call x }
    N.times { test.call rand(Int32) }
  end

  it "#ge" do
    values = Array.new(N) { rand(Int32) }
    a = RedBlackTree.new(values)
    values.sort!

    test = ->(x : Int32) {
      expect = values.bsearch { |y| y >= x }
      a.ge(x).should eq expect
    }

    values.each { |x| test.call x }
    N.times { test.call rand(Int32) }
  end

  it "#gt" do
    values = Array.new(N) { rand(Int32) }
    a = RedBlackTree.new(values)
    values.sort!

    test = ->(x : Int32) {
      expect = values.bsearch { |y| y > x }
      a.gt(x).should eq expect
    }

    values.each { |x| test.call x }
    N.times { test.call rand(Int32) }
  end

  it "#to_s, #inspect" do
    a = RedBlackTree{1, 3, 5, 3, 5, 1}
    expect = "RedBlackTree{1, 1, 3, 3, 5, 5}"
    a.to_s.should eq expect
    a.inspect.should eq expect
  end
end
