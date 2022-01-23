require "spec"
require "../../src/math/mint"
require "../../atcoder/src/Math"
private MOD1 = 1000000007i64
private MOD2 =  998244353i64

private macro check_binary_operator(type, op)
  %mod = {{type}}.mod
  0i64.step(to: %mod, by: %mod // 1000).each do |x|
    0i64.step(to: %mod, by: %mod // 999).each do |y|
      m = {{type}}.new(x) {{op.id}} {{type}}.new(y)
      expect = (x {{op.id}} y) % %mod
      m.should eq expect
    end
  end
end

private macro check_method(type, method)
  %mod = {{type}}.mod
  0i64.step(to: %mod, by: %mod // 1000000).each do |x|
    {{type}}.new(x).{{method}}.should eq x.{{method}}
  end
end

private macro check_method_mod(type, method)
  %mod = {{type}}.mod
  0i64.step(to: %mod, by: %mod // 1000000).each do |x|
    {{type}}.new(x).{{method}}.should eq x.{{method}} % %mod
  end
end

describe "Mint" do
  it ".[]" do
    Mint[0, 1, 2, 3, MOD1, MOD1 + 1].should eq [0, 1, 2, 3, 0, 1].map(&.to_m(Mint))
    Mint2[0, 1, 2, 3, MOD2, MOD2 + 1].should eq [0, 1, 2, 3, 0, 1].map(&.to_m(Mint2))
    Mint[0, 1, MOD1, MOD1 + 1, MOD1 * 2].map(&.value).should eq [0, 1, 0, 1, 0]
  end

  it ".mod" do
    Mint.mod.should eq MOD1
    ModInt(42).mod.should eq 42
  end

  it ".zero" do
    Mint.zero.should eq 0
  end

  it "#initialize" do
    Mint.new.should eq 0
    Mint.new(Int64::MIN).should eq Int64::MIN % MOD1
    Mint.new(0).should eq 0
    Mint.new(42).should eq 42
    Mint.new(42i64).should eq 42
    Mint.new(42i8).should eq 42
    Mint.new(MOD1).should eq 0
    Mint.new(MOD1 + 1).should eq 1
    Mint.new(MOD1 * MOD1).should eq 0
    Mint.new(Int64::MAX).should eq Int64::MAX % MOD1
  end

  it "#+" do
    (+Mint.new).should eq 0
    (+Mint.new(12)).should eq 12
  end

  it "#-" do
    (-Mint.new).should eq 0
    (-Mint.new(12)).should eq MOD1 - 12
  end

  it "#+(other)" do
    a, b = Mint.new(1), Mint.new(-1)
    (a + a).should eq 2
    (a + 3).should eq 4
    (a + 3i64).should eq 4
    (a + 3i8).should eq 4
    (a + MOD1).should eq 1
    (a + MOD1 * 2).should eq 1
    (b + b).should eq MOD1 - 2
    check_binary_operator(Mint, :+)
    check_binary_operator(Mint2, :+)
  end

  it "#-(other)" do
    a, b = Mint.new(3), Mint.new(-1)
    (a - Mint.new(4)).should eq MOD1 - 1
    (a - 3).should eq 0
    (a - 3i64).should eq 0
    (a - 3i8).should eq 0
    (a - 4).should eq MOD1 - 1
    (a - MOD1).should eq 3
    (Mint.zero - b).should eq 1
    check_binary_operator(Mint, :-)
    check_binary_operator(Mint2, :-)
  end

  it "#*(other)" do
    a, b = Mint.new(3), Mint.new(-1)
    (a * 3).should eq 9
    (a * a).should eq 9
    (a * MOD1).should eq 0
    (b * MOD1).should eq 0
    (b * b).should eq 1
    (b * Int64::MAX).should eq MOD1.pred * (Int64::MAX % MOD1) % MOD1
    check_binary_operator(Mint, :*)
    check_binary_operator(Mint2, :*)
  end

  it "#/(other)" do
    a = Mint.new(3)
    (a / 1).should eq 3
    (a / 2).should eq MOD1 // 2 + 2
    (a / 3).should eq 1

    {% for type in [Mint, Mint2] %}
      %mod = {{type}}.mod
      0i64.step(by: %mod, to: %mod // 1000) do |x|
        0i64.step(by: %mod, to: %mod // 999) do |y|
          next unless y.gcd(%mod) == 1
          z = {{type}}.new(x) / y
          (z * y).should eq x
        end
      end
    {% end %}

    expect_raises(DivisionByZeroError) { a / 0 }
    expect_raises(DivisionByZeroError) { a / 0i8 }
    expect_raises(DivisionByZeroError) { a / MOD1 }
    expect_raises(DivisionByZeroError) { a / Mint.zero }
  end

  it "#//(other)" do
    a = Mint.new(3)
    (a // 1).should eq 3
    (a // 2).should eq MOD1 // 2 + 2
    (a // 3).should eq 1

    {% for type in [Mint, Mint2] %}
      %mod = {{type}}.mod
      0i64.step(by: %mod, to: %mod // 1000) do |x|
        0i64.step(by: %mod, to: %mod // 999) do |y|
          next unless y.gcd(%mod) == 1
          z = {{type}}.new(x) // y
          (z * y).should eq x
        end
      end
    {% end %}

    expect_raises(DivisionByZeroError) { a // 0 }
    expect_raises(DivisionByZeroError) { a // 0i8 }
    expect_raises(DivisionByZeroError) { a // MOD1 }
    expect_raises(DivisionByZeroError) { a // Mint.zero }
  end

  it "#**(other)" do
    a = Mint.new(3)
    (a ** 0).should eq 1
    (a ** 1).should eq 3
    (a ** 2).should eq 9
    (a ** 20).should eq 486784380
    (a ** (10i64**18)).should eq 246336683
    (a.pred ** (10i64**18)).should eq 719476260

    {% for type in [Mint, Mint2] %}
      %mod = {{type}}.mod
      0i64.step(by: %mod, to: %mod // 1000) do |x|
        0i64.step(by: Int64::MAX, to: Int64::MAX // 1000) do |e|
          m = {{type}}.new(x) ** e
          expect = AtCoder::Math.pow_mod(x, e, %mod)
          m.should eq expect
        end
      end
    {% end %}
  end

  it "#inv" do
    {% for type in [Mint, Mint2] %}
      %mod = {{type}}.mod
      0i64.step(by: %mod, to: %mod // 1000000) do |x|
        next unless x.gcd(%mod) == 1
        ({{type}}.new(x).inv * x).should eq 1
      end
    {% end %}
  end

  it "#==(other)" do
    a = Mint.new(3)
    (a == a).should be_true
    (a == 3).should be_true
    (a == MOD1 + 3).should be_false
    (a == Mint.new(MOD1 + 3)).should be_true
  end

  it "#!=(other)" do
    a = Mint.new(3)
    (a != a).should be_false
    (a != MOD1 + 3).should be_true
    (a != Mint.new(MOD1 + 3)).should be_false
  end

  it "#succ" do
    Mint.new(0).succ.should eq 1
    Mint.new(3).succ.should eq 4
    Mint.new(MOD1).succ.should eq 1
    Mint.new(-1).succ.should eq 0
    check_method_mod(Mint, succ)
    check_method_mod(Mint2, succ)
  end

  it "#pred" do
    Mint.new(0).pred.should eq MOD1 - 1
    Mint.new(3).pred.should eq 2
    Mint.new(MOD1).pred.should eq MOD1 - 1
    Mint.new(-1).pred.should eq MOD1 - 2
    check_method_mod(Mint, pred)
    check_method_mod(Mint2, pred)
  end

  it "#abs" do
    Mint.new(0).abs.should eq 0
    Mint.new(3).abs.should eq 3
    Mint.new(MOD1).abs.should eq 0
    Mint.new(-1).abs.should eq MOD1 - 1
    check_method_mod(Mint, abs)
    check_method_mod(Mint2, abs)
  end

  it "#value" do
    Mint.new(0).value.should eq 0
    Mint.new(3).value.should eq 3
    Mint.new(MOD1).value.should eq 0
    Mint.new(-1).value.should eq MOD1 - 1
  end

  it "#to_s" do
    Mint.new(0).to_s.should eq "0"
    Mint.new(3).to_s.should eq "3"
    Mint.new(MOD1).to_s.should eq "0"
    Mint.new(-1).to_s.should eq MOD1.pred.to_s
    check_method(Mint, to_s)
    check_method(Mint2, to_s)
  end

  it "#inspect" do
    Mint.new(0).inspect.should eq "0"
    Mint.new(3).inspect.should eq "3"
    Mint.new(MOD1).inspect.should eq "0"
    Mint.new(-1).inspect.should eq (MOD1 - 1).inspect
    check_method(Mint, inspect)
    check_method(Mint2, inspect)
  end
end

describe Int do
  it "#to_m" do
    (-1).to_m(Mint).should eq MOD1 - 1
    (-1i8).to_m(Mint).should eq MOD1 - 1
    0.to_m(Mint).should eq 0
    1i64.to_m(Mint).should eq 1
    MOD1.to_m(Mint).should eq 0

    (-1).to_m(Mint2).should eq MOD2 - 1
  end
end

describe String do
  it "#to_m" do
    "-1".to_m(Mint).should eq MOD1 - 1
    "0".to_m(Mint).should eq 0
    "1".to_m(Mint).should eq 1
    MOD1.pred.to_s.to_m(Mint).should eq MOD1 - 1
    MOD1.to_s.to_m(Mint).should eq 0
    "-1".to_m(Mint2).should eq MOD2 - 1
  end
end
