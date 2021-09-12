require "../../../src/datastructure/smultiset/treap"
require "./spec_helper"

class SMultiSet::Treap::Node
  def verify
    if nil_node?
      left.nil_node?.should be_true
      right.nil_node?.should be_true
    end

    if left.node?
      key.should be >= left.key
      priority.should be <= left.priority
      left.parent.should eq self
      left.verify
    end

    if right.node?
      key.should be <= right.key
      priority.should be <= right.priority
      right.parent.should eq self
      right.verify
    end
  end
end

class SMultiSet::Treap
  def verify
    if root.node?
      root.parent.nil_node?.should be_true
    end
    root.verify
  end
end

run_smultiset_spec(SMultiSet::Treap, "SMultiSet::Treap")
