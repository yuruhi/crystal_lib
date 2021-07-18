require "spec"
require "../../src/graph/edge"

describe WeightedEdge do
  it "#to, #cost" do
    WeightedEdge.new(2, 10i64).to.should eq 2
    WeightedEdge.new(2, 10i64).cost.should eq 10i64
  end

  it "#<=>" do
    (WeightedEdge.new(2, 10) <=> WeightedEdge.new(3, 4)).should eq 1
    (WeightedEdge.new(2, 10) <=> WeightedEdge.new(2, 11)).should eq -1
    (WeightedEdge.new(2, 10) <=> WeightedEdge.new(3, 10)).should eq -1
    (WeightedEdge.new(2, 10) <=> WeightedEdge.new(0, 11)).should eq -1
    (WeightedEdge.new(2, 10) <=> WeightedEdge.new(2, 10)).should eq 0
  end

  it "#to_s" do
    WeightedEdge.new(2, 3).to_s.should eq "(2, 3)"
  end

  it "#inspect" do
    WeightedEdge.new(2, 3).inspect.should eq "->2(3)"
  end
end

describe WeightedEdge2 do
  it "#from, #to, #cost" do
    WeightedEdge2.new(2, 3, 4).from.should eq 2
    WeightedEdge2.new(2, 3, 4).to.should eq 3
    WeightedEdge2.new(2, 3, 4).cost.should eq 4
  end

  it "#<=>" do
    (WeightedEdge2.new(2, 42, 10) <=> WeightedEdge2.new(3, 42, 4)).should eq 1
    (WeightedEdge2.new(2, 42, 10) <=> WeightedEdge2.new(2, 42, 11)).should eq -1
    (WeightedEdge2.new(2, 42, 10) <=> WeightedEdge2.new(3, 42, 10)).should eq -1
    (WeightedEdge2.new(2, 42, 10) <=> WeightedEdge2.new(0, 42, 11)).should eq -1
    (WeightedEdge2.new(2, 42, 10) <=> WeightedEdge2.new(2, 42, 10)).should eq 0
    (WeightedEdge2.new(2, 42, 10) <=> WeightedEdge2.new(2, 43, 10)).should eq -1
  end

  it "#reverse" do
    WeightedEdge2.new(2, 3, 4).reverse.should eq WeightedEdge2.new(3, 2, 4)
  end

  it "#sort" do
    WeightedEdge2.new(2, 3, 4).sort.should eq WeightedEdge2.new(2, 3, 4)
    WeightedEdge2.new(3, 2, 4).sort.should eq WeightedEdge2.new(2, 3, 4)
  end

  it "#to_s" do
    WeightedEdge2.new(2, 3, 4).to_s.should eq "(2, 3, 4)"
  end

  it "inspect" do
    WeightedEdge2.new(2, 3, 4).inspect.should eq "2->3(4)"
  end
end

describe UnweightedEdge do
  it "#to, #cost" do
    UnweightedEdge.new(2).to.should eq 2
    UnweightedEdge.new(2).cost.should eq 1
  end

  it "#to_s" do
    UnweightedEdge.new(2).to_s.should eq "2"
  end

  it "inspect" do
    UnweightedEdge.new(2).inspect.should eq "->2"
  end
end

describe UnweightedEdge2 do
  it "#from, #to, #cost" do
    UnweightedEdge2.new(2, 3).from.should eq 2
    UnweightedEdge2.new(2, 3).to.should eq 3
    UnweightedEdge2.new(2, 3).cost.should eq 1
  end

  it "#reverse" do
    UnweightedEdge2.new(2, 3).reverse.should eq UnweightedEdge2.new(3, 2)
  end

  it "#sort" do
    UnweightedEdge2.new(2, 3).sort.should eq UnweightedEdge2.new(2, 3)
    UnweightedEdge2.new(3, 2).sort.should eq UnweightedEdge2.new(2, 3)
  end

  it "#to_s" do
    UnweightedEdge2.new(2, 3).to_s.should eq "(2, 3)"
  end

  it "inspect" do
    UnweightedEdge2.new(2, 3).inspect.should eq "2->3"
  end
end
