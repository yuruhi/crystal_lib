require "spec"
require "../../src/collection/tally"

describe Enumerable do
  it "#tally(*, default)" do
    c = [1, 2, 2, 3, 3, 3].tally(default: 0)
    c.should eq({1 => 1, 2 => 2, 3 => 3})
    c[0].should eq 0

    c = [1, 2, 2, 3, 3, 3].tally(default: 100)
    c.should eq({1 => 101, 2 => 102, 3 => 103})
    c[0].should eq 100
  end
end
