require "spec"
require "big"
require "../../src/math/sqrt_digits10"

private def check(x, scale, d1, d2)
  Math.sqrt_digits10(x, scale).should eq({d1, d2})
end

describe Math do
  it "sqrt_digits10" do
    check 0, 10, [] of Int32, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    check 1, 10, [1], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    check 2, 10, [1], [4, 1, 4, 2, 1, 3, 5, 6, 2, 3]
    check 3, 10, [1], [7, 3, 2, 0, 5, 0, 8, 0, 7, 5]
    check 123456789, 0, [1, 1, 1, 1, 1], [] of Int32
    check Int32::MAX, 5, [4, 6, 3, 4, 0], [9, 5, 0, 0, 0]
    check Int64::MAX, 5, [3, 0, 3, 7, 0, 0, 0, 4, 9, 9], [9, 7, 6, 0, 4]
    x = (1..9).to_a * 64
    check x.join.to_big_i**2, 0, x, [] of Int32
    expect_raises(ArgumentError) { Math.sqrt_digits10(0, -1) }
    expect_raises(ArgumentError) { Math.sqrt_digits10(-1, 0) }
  end
end
