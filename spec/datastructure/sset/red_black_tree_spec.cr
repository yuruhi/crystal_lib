require "./spec_helper"
require "../../../src/datastructure/sset/red_black_tree"

class SSet::RedBlackTree::Node
  def verify
    if nil_node?
      left.nil_node?.should be_true
      right.nil_node?.should be_true
    end

    if left.node?
      key.should be > left.key
      (red? && left.red?).should be_false
      left.parent.should eq self
      left.verify
    end

    if right.node?
      key.should be < right.key
      (red? && right.red?).should be_false
      right.parent.should eq self
      right.verify
    end
  end
end

class SSet::RedBlackTree
  def verify
    if root.node?
      root.parent.nil_node?.should be_true
    end
    root.verify
  end
end

sset_spec_run(SSet::RedBlackTree, "SSet::RedBlackTree")
