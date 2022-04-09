require "spec"
require "../../src/collection/compress"

describe Array do
  it "#compress" do
    a = [0, 3, 7, 0, 5]
    a.compress.should eq [0, 1, 3, 0, 2]
    a.compress(index: 1).should eq [1, 2, 4, 1, 3]
    a.compress([0, 1, 3, 5, 7]).should eq [0, 2, 4, 0, 3]
    a.compress([0, 1, 3, 5, 7], index: 1).should eq [1, 3, 5, 1, 4]
  end
end
