require "spec"
require "../../src/array/change"

describe Array do
  it "#chmin(i, value)" do
    a = [0, 1, 2, 3]
    a.chmin(3, 0).should be_true
    a.should eq [0, 1, 2, 0]
    a.chmin(0, 0).should be_false
    a.should eq [0, 1, 2, 0]
    a.chmin(-2, 0).should be_true
    a.should eq [0, 1, 0, 0]
    a.chmin(1, 10).should be_false
    a.should eq [0, 1, 0, 0]
  end

  it "#chmax(i, value)" do
    a = [0, 1, 2, 3]
    a.chmax(3, 4).should be_true
    a.should eq [0, 1, 2, 4]
    a.chmax(0, 0).should be_false
    a.should eq [0, 1, 2, 4]
    a.chmax(-2, 4).should be_true
    a.should eq [0, 1, 4, 4]
    a.chmax(1, -10).should be_false
    a.should eq [0, 1, 4, 4]
  end
end
