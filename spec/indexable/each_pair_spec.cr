require "spec"
require "../../src/indexable/each_pair"

describe Indexable do
  it "#each_pair(&)" do
    result = [] of {Int32, Int32}
    [0, 1, 2, 3].each_pair { |i, j| result << {i, j} }
    result.should eq [{0, 1}, {0, 2}, {0, 3}, {1, 2}, {1, 3}, {2, 3}]
  end

  it "#each_pair" do
    [0, 1, 2, 3].each_pair.to_a.should eq [
      {0, 1}, {0, 2}, {0, 3},
      {1, 2}, {1, 3},
      {2, 3},
    ]
    (0...1000).to_a.each_pair.max_of(&.sum).should eq 998 + 999
  end
end
