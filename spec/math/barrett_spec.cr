require "spec"
require "../../src/math/barrett"

private def check_all(mod : UInt32)
  bt = Barrett.new(mod)
  (0u32...mod).each do |x|
    (0u32...mod).each do |y|
      bt.mul(x, y).should eq x * y % mod
    end
  end
end

private def check(mod : UInt32, trial : Int32)
  bt = Barrett.new(mod)
  trial.times do
    a, b = rand(mod), rand(mod)
    mul = a.to_u64 * b % mod
    if bt.mul(a, b) != mul
      p [a, b, mod, mul, bt.mul(a, b)]
    end
    bt.mul(a, b).should eq mul
  end
end

describe Barrett do
  it "#mul" do
    (1u32..1000u32).each { |mod| check_all(mod) }
    (1000u32..10000u32).step(by: 1000) { |mod| check_all(mod) }
    max = 2u32**31 - 1
    {
      10u32**5, 10u32**6, 10u32**7, 10u32**8, 10u32**9,
      2u32**26, 2u32**27, 2u32**28, 2u32**29, 2u32**30,
      max - 5, max - 4, max - 3, max - 2, max - 1, max,
    }.each do |mod|
      check(mod, 10000000)
    end
  end
end
