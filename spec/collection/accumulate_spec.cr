require "spec"
require "../../src/collection/accumulate"

describe Enumerable do
  it "#accumulate(init)" do
    [0, 1, 2, 3].accumulate(3).should eq [3, 3, 4, 6, 9]
    (0..3).accumulate(3).should eq [3, 3, 4, 6, 9]
  end

  it "#accumulate(init, &block)" do
    [1, 2, 3, 4].accumulate(1) { |x, y| x * y }.should eq [1, 1, 2, 6, 24]
    (1..4).accumulate(1) { |x, y| x * y }.should eq [1, 1, 2, 6, 24]
    [3, 1, 4, 1, 5].accumulate(0) { |x, y| Math.max(x, y) }.should eq [0, 3, 3, 4, 4, 5]
  end

  it "#accumulate" do
    [0, 1, 2, 3].accumulate.should eq [0, 1, 3, 6]
    (0..3).accumulate.should eq [0, 1, 3, 6]
  end
end
