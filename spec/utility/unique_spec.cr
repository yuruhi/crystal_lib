require "spec"
require "../../src/utility/unique"

describe Enumerable do
  it "#unique" do
    [0, 0, 1, 1, 0, 0].unique.should eq [0, 1, 0]
    [0].unique.should eq [0]
    [0, 0, nil, nil, 0, 0, nil, nil].unique.should eq [0, nil, 0, nil]
    Array(Int32).new.unique.should eq Array(Int32).new
  end

  it "#unique(&)" do
    [0, 2, 1, 3, 0, 0, 2].unique(&.% 2).should eq [0, 1, 0]
    [0, 1, 2, 3, 4].unique { 42 }.should eq [0]
    [0].unique(&.itself).should eq [0]
    Array(Int32).new.unique { raise "" }.should eq Array(Int32).new
  end
end

describe Iterator do
  it "#unique" do
    [0, 0, 1, 1, 0, 0].each.unique.to_a.should eq [0, 1, 0]
    [0].each.unique.to_a.should eq [0]
    [0, 0, nil, nil, 0, 0, nil, nil].each.unique.to_a.should eq [0, nil, 0, nil]
    Array(Int32).new.each.unique.to_a.should eq Array(Int32).new
  end

  it "#unique(&)" do
    [0, 2, 1, 3, 0, 0, 2].each.unique(&.% 2).to_a.should eq [0, 1, 0]
    [0, 1, 2, 3, 4].each.unique { 42 }.to_a.should eq [0]
    [0].each.unique(&.itself).to_a.should eq [0]
    Array(Int32).new.each.unique { raise "" }.to_a.should eq Array(Int32).new
  end
end
