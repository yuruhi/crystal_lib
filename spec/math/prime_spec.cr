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

  it "#[](i)" do
    Prime[0].should eq 2
    Prime[1].should eq 3
    Prime[2].should eq 5
    expect_raises(IndexError) { Prime[-1] }
    expect_raises(IndexError) { Prime[10**9] }
  end

  it "#includes?(x)" do
    Prime.includes?(-1).should be_false
    Prime.includes?(-10**9).should be_false
    Prime.includes?(13).should be_true
    Prime.includes?(57).should be_false
    Prime.includes?(10**6 + 3).should be_true
    Prime.includes?(10**8 + 7).should be_true
  end
end
