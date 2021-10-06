require "spec"
require "../../src/math/dynamic_mint"

private alias M = DynamicMint
init = 998244353

private macro check_binary_operator(mod, op)
  %mod = {{mod}}
  M.mod = %mod
  (0...%mod).each do |x|
    (0...%mod).each do |y|
      (M.new(x) {{op.id}} M.new(y)).should eq (x {{op.id}} y) % %mod
    end
  end
end

private macro check_method(mod, method)
  %mod = {{mod}}
  M.mod = %mod
  (0...%mod).each do |x|
    M.new(x).{{method}}.should eq x.{{method}}
  end
end

private macro check_method_mod(mod, method)
  %mod = {{mod}}
  M.mod = %mod
  (0...%mod).each do |x|
    M.new(x).{{method}}.should eq x.{{method}} % %mod
  end
end

describe "DynamicModint" do
  it ".mod and .setmod" do
    M.mod.should eq init
    M.mod = 42
    M.mod.should eq 42
    M.mod = Int32::MAX
    M.mod.should eq Int32::MAX
    expect_raises(ArgumentError) { M.mod = 0 }
    expect_raises(ArgumentError) { M.mod = -1 }
  end

  it ".zero" do
    M.mod = 60
    M.zero.should eq 0
  end

  it "#==(x)" do
    M.mod = 60
    (M.new(0) == M.new(0)).should be_true
    (M.new(0) == M.new(60)).should be_true
    (M.new(0) == 0).should be_true
    (M.new(0) == 1).should be_false
    (M.new(60) == 0).should be_true
    (M.new(60) == 60).should be_false
  end

  it "#+" do
    M.mod = init
    (+M.new(1)).should eq 1
    (+M.new(init)).should eq 0
  end

  it "#-" do
    M.mod = init
    x = M.new(1)
    (-x).should eq init - 1
    x = M.new(0)
    (-x).value.should eq 0

    M.mod = 3
    (-M.new(1)).should eq 2
  end

  it "#+(x)" do
    check_binary_operator(1, "+")
    check_binary_operator(60, "+")
    check_binary_operator(1009, "+")
  end

  it "#-(x)" do
    check_binary_operator(1, "-")
    check_binary_operator(60, "-")
    check_binary_operator(1009, "-")
  end

  it "#*(x)" do
    check_binary_operator(1, "*")
    check_binary_operator(60, "*")
    check_binary_operator(1009, "*")
  end

  it "#/(x)" do
    {1, 60, 1009}.each do |mod|
      M.mod = mod
      (0...mod).each do |x|
        (0...mod).each do |y|
          next unless y.gcd(mod) == 1
          z = M.new(x) / y
          (z * y).should eq x
        end
      end
    end
  end

  it "#//(x)" do
    {1, 60, 1009}.each do |mod|
      M.mod = mod
      (0...mod).each do |x|
        (0...mod).each do |y|
          next unless y.gcd(mod) == 1
          z = M.new(x) // y
          (z * y).should eq x
        end
      end
    end
  end

  it "#**(x)" do
    {1, 60, 1009}.each do |mod|
      M.mod = mod
      (0i64...mod.to_i64).each do |x|
        0i64.step(to: 10i64**18, by: 10i64**16) do |e|
          (M.new(x) ** e).should eq AtCoder::Math.pow_mod(x, e, mod)
        end
      end
    end
  end

  it "#inv" do
    {1, 60, 1009, 1000003}.each do |mod|
      M.mod = mod
      (1...mod).each do |x|
        next unless x.gcd(mod) == 1
        (M.new(x).inv * x).should eq 1
      end
    end
  end

  it "#succ" do
    check_method_mod(1, succ)
    check_method_mod(60, succ)
    check_method_mod(1009, succ)
    check_method_mod(1000003, succ)
  end

  it "#pred" do
    check_method_mod(1, pred)
    check_method_mod(60, pred)
    check_method_mod(1009, pred)
    check_method_mod(1000003, pred)
  end

  it "#abs" do
    check_method_mod(1, abs)
    check_method_mod(60, abs)
    check_method_mod(1009, abs)
    check_method_mod(1000003, abs)
  end

  it "#to_i64" do
    check_method_mod(1, to_i64)
    check_method_mod(60, to_i64)
    check_method_mod(1009, to_i64)
    check_method_mod(1000003, to_i64)
  end

  it "#to_s" do
    check_method(1, to_s)
    check_method(60, to_s)
    check_method(1009, to_s)
    check_method(1000003, to_s)
  end

  it "#inspect" do
    check_method(1, inspect)
    check_method(60, inspect)
    check_method(1009, inspect)
    check_method(1000003, inspect)
  end

  it "compare" do
    expect_raises(NotImplementedError) { M.new(0) < 0 }
    expect_raises(NotImplementedError) { M.new(0) <= 0 }
    expect_raises(NotImplementedError) { M.new(0) > 0 }
    expect_raises(NotImplementedError) { M.new(0) >= 0 }
  end
end
