require "spec"
require "../../src/collection/change"

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

  it "#chmin(indexes, value)" do
    a = [[0, 1], [2, 3], [4, 5]]
    a.chmin({1, 1}, 0).should be_true
    a.should eq [[0, 1], [2, 0], [4, 5]]
    a.chmin({0, 0}, 0).should be_false
    a.should eq [[0, 1], [2, 0], [4, 5]]
    a.chmin({2, 1}, 3).should be_true
    a.should eq [[0, 1], [2, 0], [4, 3]]
    a[1].chmin({0}, 42).should be_false
    a.should eq [[0, 1], [2, 0], [4, 3]]
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

  it "#chmax(indexes, value)" do
    a = [[0, 1], [2, 3], [4, 5]]
    a.chmax({1, 1}, 10).should be_true
    a.should eq [[0, 1], [2, 10], [4, 5]]
    a.chmax({0, 0}, 0).should be_false
    a.should eq [[0, 1], [2, 10], [4, 5]]
    a.chmax({2, 1}, 11).should be_true
    a.should eq [[0, 1], [2, 10], [4, 11]]
    a[1].chmax({0}, -42).should be_false
    a.should eq [[0, 1], [2, 10], [4, 11]]
  end
end
