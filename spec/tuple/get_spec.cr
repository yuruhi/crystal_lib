require "spec"
require "../../src/tuple/get"

describe Tuple do
  it "#_N" do
    a = {0}
    a._0.should eq 0
    b = {0, 1}
    b._0.should eq 0
    b._1.should eq 1
    c = {0, 1, 2}
    c._0.should eq 0
    c._1.should eq 1
    c._2.should eq 2
  end
end
