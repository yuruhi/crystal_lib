require "spec"
require "../math/Mint"
require "../atcoder/src/Math"
mod = 10i64**9 + 7
x = Mint.new(mod - 1)
max = Int64::MAX % mod

macro check_binary_operator(type, op)
  %mod = {{type}}::MOD
  0i64.step(to: %mod, by: %mod // 1000).each do |x|
    0i64.step(to: %mod, by: %mod // 999).each do |y|
      m = {{type}}.new(x) {{op.id}} {{type}}.new(y)
      expect = (x {{op.id}} y) % %mod
      m.should eq expect
    end
  end
end

macro check_method(type, method)
  %mod = {{type}}::MOD
  0i64.step(to: %mod, by: %mod // 1000000).each do |x|
    {{type}}.new(x).{{method}}.should eq x.{{method}}
  end
end

macro check_method_mod(type, method)
  %mod = {{type}}::MOD
  0i64.step(to: %mod, by: %mod // 1000000).each do |x|
    {{type}}.new(x).{{method}}.should eq x.{{method}} % %mod
  end
end

describe "Mint" do
  it "mod" do
    Mint::MOD.should eq mod
  end

  it "self.zero" do
    Mint.zero.should eq 0
  end

  it "initialize" do
    Mint.new.should eq 0
    Mint.new(Int64::MIN).should eq Int64::MIN % mod
    Mint.new(0).should eq 0
    Mint.new(42).should eq 42
    Mint.new(42i64).should eq 42
    Mint.new(42i8).should eq 42
    Mint.new(mod).should eq 0
    Mint.new(mod + 1).should eq 1
    Mint.new(mod * mod).should eq 0
    Mint.new(Int64::MAX).should eq max
  end

  it "+" do
    (+Mint.new).should eq 0
    (+Mint.new(12)).should eq 12
  end

  it "-" do
    (-Mint.new).should eq 0
    (-Mint.new(12)).should eq mod - 12
  end

  it "+(other)" do
    a = Mint.new(1)
    (a + a).should eq 2
    (a + 3).should eq 4
    (a + 3i64).should eq 4
    (a + 3i8).should eq 4
    (a + mod).should eq 1
    (a + mod * 2).should eq 1
    (x + x).should eq mod - 2
    check_binary_operator(Mint, "+")
    check_binary_operator(Mint2, "+")
  end

  it "-(other)" do
    a = Mint.new(3)
    (a - Mint.new(4)).should eq mod - 1
    (a - 3).should eq 0
    (a - 3i64).should eq 0
    (a - 3i8).should eq 0
    (a - 4).should eq mod - 1
    (a - mod).should eq 3
    (Mint.zero - x).should eq 1
    check_binary_operator(Mint, "-")
    check_binary_operator(Mint2, "-")
  end

  it "*(other)" do
    a = Mint.new(3)
    (a * 3).should eq 9
    (a * a).should eq 9
    (a * mod).should eq 0
    (x * mod).should eq 0
    (x * x).should eq 1
    (x * Int64::MAX).should eq mod.pred * max % mod
    check_binary_operator(Mint, "*")
    check_binary_operator(Mint2, "*")
  end

  it "/(other)" do
    a = Mint.new(3)
    (a / 1).should eq 3
    (a / 2).should eq mod // 2 + 2
    (a / 3).should eq 1

    {% for type in [Mint, Mint2] %}
      %mod = {{type}}::MOD
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
    expect_raises(DivisionByZeroError) { a / mod }
    expect_raises(DivisionByZeroError) { a / Mint.zero }
  end

  it "//(other)" do
    a = Mint.new(3)
    (a // 1).should eq 3
    (a // 2).should eq mod // 2 + 2
    (a // 3).should eq 1

    {% for type in [Mint, Mint2] %}
      %mod = {{type}}::MOD
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
    expect_raises(DivisionByZeroError) { a // mod }
    expect_raises(DivisionByZeroError) { a // Mint.zero }
  end

  it "**(other)" do
    a = Mint.new(3)
    (a ** 0).should eq 1
    (a ** 1).should eq 3
    (a ** 2).should eq 9
    (a ** 20).should eq 486784380
    (a ** (10i64**18)).should eq 246336683
    (a.pred ** (10i64**18)).should eq 719476260

    {% for type in [Mint, Mint2] %}
      %mod = {{type}}::MOD
      0i64.step(by: %mod, to: %mod // 1000) do |x|
        0i64.step(by: Int64::MAX, to: Int64::MAX // 1000) do |e|
          m = {{type}}.new(x) ** e
          expect = AtCoder::Math.pow_mod(x, e, mod)
          m.should eq expect
        end
      end
    {% end %}
  end

  it "#inv" do
    {% for type in [Mint, Mint2] %}
      %mod = {{type}}::MOD
      0i64.step(by: %mod, to: %mod // 1000000) do |x|
        next unless x.gcd(%mod) == 1
        ({{type}}.new(x).inv * x).should eq 1
      end
    {% end %}
  end

  it "==(other)" do
    a = Mint.new(3)
    (a == a).should be_true
    (a == 3).should be_true
    (a == mod + 3).should be_false
    (a == Mint.new(mod + 3)).should be_true
  end

  it "!=(other)" do
    a = Mint.new(3)
    (a != a).should be_false
    (a != mod + 3).should be_true
    (a != Mint.new(mod + 3)).should be_false
  end

  it "succ" do
    Mint.new(0).succ.should eq 1
    Mint.new(3).succ.should eq 4
    Mint.new(mod).succ.should eq 1
    x.succ.should eq 0
    check_method_mod(Mint, succ)
    check_method_mod(Mint2, succ)
  end

  it "pred" do
    Mint.new(0).pred.should eq mod - 1
    Mint.new(3).pred.should eq 2
    Mint.new(mod).pred.should eq mod - 1
    x.pred.should eq mod - 2
    check_method_mod(Mint, pred)
    check_method_mod(Mint2, pred)
  end

  it "abs" do
    Mint.new(0).abs.should eq 0
    Mint.new(3).abs.should eq 3
    Mint.new(mod).abs.should eq 0
    x.abs.should eq mod - 1
    check_method_mod(Mint, abs)
    check_method_mod(Mint2, abs)
  end

  it "value" do
    Mint.new(0).value.should eq 0
    Mint.new(3).value.should eq 3
    Mint.new(mod).value.should eq 0
    x.value.should eq mod - 1
  end

  it "to_s" do
    Mint.new(0).to_s.should eq "0"
    Mint.new(3).to_s.should eq "3"
    Mint.new(mod).to_s.should eq "0"
    x.to_s.should eq (mod - 1).to_s
    check_method(Mint, to_s)
    check_method(Mint2, to_s)
  end

  it "inspect" do
    Mint.new(0).inspect.should eq "0"
    Mint.new(3).inspect.should eq "3"
    Mint.new(mod).inspect.should eq "0"
    x.inspect.should eq (mod - 1).inspect
    check_method(Mint, inspect)
    check_method(Mint2, inspect)
  end

  it "Int#+" do
    a = Mint.new(1)
    (3 + a).should eq 4
    (3i64 + a).should eq 4
    (3i8 + a).should eq 4
    (mod + a).should eq 1
    (mod * 2 + a).should eq 1
  end

  it "Int#-" do
    a = Mint.new(3)
    (3 - a).should eq 0
    (3i64 - a).should eq 0
    (3i8 - a).should eq 0
    (4 - a).should eq 1
    (mod - a).should eq mod - 3
    (0 - x).should eq 1
  end

  it "Int#*" do
    a = Mint.new(3)
    (3 * a).should eq 9
    (mod * a).should eq 0
    (Int64::MAX * x).should eq mod.pred * max % mod
  end

  it "Int#/" do
    a = Mint.new(3)
    (3 / Mint.new(1)).should eq 3
    (3 / Mint.new(2)).should eq mod // 2 + 2
    (3 / Mint.new(3)).should eq 1
    expect_raises(DivisionByZeroError) { 0 / Mint.zero }
    expect_raises(DivisionByZeroError) { mod / Mint.new mod }
  end

  it "Int#//" do
    a = Mint.new(3)
    (3 // Mint.new(1)).should eq 3
    (3 // Mint.new(2)).should eq mod // 2 + 2
    (3 // Mint.new(3)).should eq 1
    expect_raises(DivisionByZeroError) { 0 // Mint.zero }
    expect_raises(DivisionByZeroError) { mod // Mint.new mod }
  end

  it "Int#to_m" do
    (-1).to_m.should eq mod - 1
    (-1i8).to_m.should eq mod - 1
    0.to_m.should eq 0
    1i64.to_m.should eq 1
    mod.to_m.should eq 0

    (-1).to_m2.should eq Mint2::MOD - 1
  end

  it "String#to_m" do
    "-1".to_m.should eq mod - 1
    "0".to_m.should eq 0
    "1".to_m.should eq 1
    (mod - 1).to_s.to_m.should eq mod - 1
    mod.to_s.to_m.should eq 0
  end

  it "compare" do
    a = Mint.new(3)
    expect_raises(NotImplementedError) { a < 1 }
    expect_raises(NotImplementedError) { a <= 1 }
    expect_raises(NotImplementedError) { a > 1 }
    expect_raises(NotImplementedError) { a >= 1 }
    expect_raises(NotImplementedError) { 1 < a }
    expect_raises(NotImplementedError) { 1 <= a }
    expect_raises(NotImplementedError) { 1 > a }
    expect_raises(NotImplementedError) { 1 >= a }
  end
end
