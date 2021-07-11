require "spec"
require "../src/enumerable/scan"

describe Enumerable do
  it "#scan(init)" do
    [0, 1, 2, 3].scan(3).should eq [3, 3, 4, 6, 9]
    (0..3).scan(3).should eq [3, 3, 4, 6, 9]
  end

  it "#scan(init, &block)" do
    [1, 2, 3, 4].scan(1) { |x, y| x * y }.should eq [1, 1, 2, 6, 24]
    (1..4).scan(1) { |x, y| x * y }.should eq [1, 1, 2, 6, 24]
    [3, 1, 4, 1, 5].scan(0) { |x, y| Math.max(x, y) }.should eq [0, 3, 3, 4, 4, 5]
  end

  it "#scan" do
    [0, 1, 2, 3].scan.should eq [0, 0, 1, 3, 6]
    (0..3).scan.should eq [0, 0, 1, 3, 6]
  end
end
