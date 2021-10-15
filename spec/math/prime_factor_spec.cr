require "spec"
require "../../src/math/prime_factor"

describe Int do
  it "#prime_factor" do
    1.prime_factor.should eq [] of {Int32, Int32}
    -1.prime_factor.should eq [{-1, 1}]
    12.prime_factor.should eq [{2, 2}, {3, 1}]
    -12.prime_factor.should eq [{-1, 1}, {2, 2}, {3, 1}]
    24.prime_factor.should eq [{2, 3}, {3, 1}]
    60.prime_factor.should eq [{2, 2}, {3, 1}, {5, 1}]
    10108248702552000.prime_factor.should eq [
      {2, 6}, {3, 3}, {5, 3}, {7, 2}, {11, 1}, {13, 1}, {17, 1}, {19, 1}, {23, 1}, {29, 1}, {31, 1},
    ]
    [2, 3, 5, 7, 13, 10**9 + 7, 10i64**12 + 39, 10i64**15 + 37].each do |x|
      x.prime_factor.should eq [{x, 1}]
      (-x).prime_factor.should eq [{-1, 1}, {x, 1}]
    end
    expect_raises(DivisionByZeroError) { 0.prime_factor }
  end

  it "#divisors" do
    1.divisors.should eq [1]
    4.divisors.should eq [1, 2, 4]
    12.divisors.should eq [1, 2, 3, 4, 6, 12]
    60.divisors.should eq [1, 2, 3, 4, 5, 6, 10, 12, 15, 20, 30, 60]
    72.divisors.should eq [1, 2, 3, 4, 6, 8, 9, 12, 18, 24, 36, 72]
    [2, 3, 5, 7, 13, 10**9 + 7, 10i64**12 + 39, 10i64**15 + 37].each do |x|
      x.divisors.should eq [1, x]
    end
    expect_raises(DivisionByZeroError) { 0.divisors }
    expect_raises(ArgumentError) { -1.divisors }
  end
end
