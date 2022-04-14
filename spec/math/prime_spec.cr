require "spec"
require "../../src/math/prime"

describe Prime do
  it "#unsafe_fetch(i)" do
    Prime.unsafe_fetch(0).should eq 2
    Prime.unsafe_fetch(1).should eq 3
    Prime.unsafe_fetch(2).should eq 5
    Prime.unsafe_fetch(999999).should eq 15485863
  end

  it "#size" do
    Prime.size.should eq 10**9
  end

  it "#each(x, &)" do
    primes = [] of Int32
    Prime.each(20) { |x| primes << x }
    primes.should eq [2, 3, 5, 7, 11, 13, 17, 19]
  end

  it "#each(x)" do
    Prime.each(20).to_a.should eq [2, 3, 5, 7, 11, 13, 17, 19]
    Prime.each(20).index(19).should eq 7
    Prime.each(20).index(23).should be_nil
    Prime.each(10**8).size.should eq 5761455
  end

  describe "includes Indexable" do
    it "#[](i)" do
      Prime[0].should eq 2
      Prime[1].should eq 3
      Prime[2].should eq 5
      expect_raises(IndexError) { Prime[-1] }
      expect_raises(IndexError) { Prime[10**9] }
    end

    it "#first" do
      Prime.first.should eq 2
    end
  end

  it "#[]?(start, count)" do
    Prime[0, 3]?.should eq [2, 3, 5]
    Prime[1, 3]?.should eq [3, 5, 7]
    Prime[2, 3]?.should eq [5, 7, 11]
    Prime[-2, 3]?.should be_nil
    expect_raises(ArgumentError) { Prime[0, -3]? }
  end

  it "#[](start, count)" do
    Prime[0, 3].should eq [2, 3, 5]
    Prime[1, 3].should eq [3, 5, 7]
    Prime[2, 3].should eq [5, 7, 11]
    expect_raises(IndexError) { Prime[-2, 3] }
    expect_raises(ArgumentError) { Prime[0, -3] }
  end

  it "#[]?(range)" do
    Prime[0...3]?.should eq [2, 3, 5]
    Prime[1...4]?.should eq [3, 5, 7]
    Prime[2...5]?.should eq [5, 7, 11]
    Prime[0..-3]?.should eq [] of Int32
    Prime[5..2]?.should eq [] of Int32
    Prime[...3]?.should eq [2, 3, 5]
    Prime[...-3]?.should eq [] of Int32
    expect_raises(IndexError) { Prime[-2..3]? }
    expect_raises(ArgumentError) { Prime[3..]? }
  end

  it "#[](range)" do
    Prime[0...3].should eq [2, 3, 5]
    Prime[1...4].should eq [3, 5, 7]
    Prime[2...5].should eq [5, 7, 11]
    Prime[0..-3].should eq [] of Int32
    Prime[5..2].should eq [] of Int32
    Prime[...3].should eq [2, 3, 5]
    Prime[...-3].should eq [] of Int32
    expect_raises(IndexError) { Prime[-2..3] }
    expect_raises(ArgumentError) { Prime[3..] }
  end

  it "#includes?(x)" do
    Prime.should_not contain -10**9
    Prime.should_not contain -1
    Prime.should_not contain 0
    Prime.should_not contain 57
    Prime.should_not contain 91
    Prime.should_not contain 9943081

    Prime.should contain 13
    Prime.should contain 10**6 + 3
    Prime.should contain 10**8 + 7
  end

  it "#index(x)" do
    Prime.index(2).should eq 0
    Prime.index(3).should eq 1
    Prime.index(5).should eq 2
    Prime.index(7).should eq 3
    Prime.index(10**8 + 7).should eq 5761455

    Prime.index(-10**9).should be_nil
    Prime.index(-1).should be_nil
    Prime.index(0).should be_nil
    Prime.index(1).should be_nil
    Prime.index(57).should be_nil
    Prime.index(91).should be_nil
    Prime.index(9943081).should be_nil
  end
end
