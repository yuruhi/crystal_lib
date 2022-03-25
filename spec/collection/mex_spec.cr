require "spec"
require "../../src/collection/mex"

describe Enumerable do
  it "#mex_sorted" do
    (0...100).mex_sorted.should eq 100
    (1..).mex_sorted.should eq 0
    Array(Int32).new.mex_sorted.should eq 0
    [0, 1, 2, 4].mex_sorted.should eq 3
    [0, 0, 1, 2, 2, 4].mex_sorted.should eq 3
    [-3, -2, 0, 2].mex_sorted.should eq 1
  end

  it "#mex" do
    a = (0...100).to_a
    a.mex.should eq 100
    a.shuffle.mex.should eq 100
    (a * 2).shuffle.mex.should eq 100
    Set{3, 4, 0, 7, 1, 2, 6, 3}.mex.should eq 5
  end
end
