require "../math/Mint"
static_modint(Mint, 1000000007)
mod = 10i64**9 + 7
x = Mint.new(mod - 1)
max = Int64::MAX % mod

describe "Mint" do
  it "mod" do
    Mint::MOD.should eq mod
  end

  it "self.zero" do
    Mint.zero.value.should eq 0
  end

  it "initialize" do
    Mint.new.value.should eq 0
    Mint.new(Int64::MIN).value.should eq Int64::MIN % mod
    Mint.new(0).value.should eq 0
    Mint.new(42).value.should eq 42
    Mint.new(42i64).value.should eq 42
    Mint.new(42i8).value.should eq 42
    Mint.new(mod).value.should eq 0
    Mint.new(mod + 1).value.should eq 1
    Mint.new(mod * mod).value.should eq 0
    Mint.new(Int64::MAX).value.should eq max
  end

  it "+" do
    (+Mint.new).value.should eq 0
    (+Mint.new(12)).value.should eq 12
  end

  it "-" do
    (-Mint.new).value.should eq 0
    (-Mint.new(12)).value.should eq mod - 12
  end

  it "+(other)" do
    a = Mint.new(1)
    (a + a).value.should eq 2
    (a + 3).value.should eq 4
    (a + 3i64).value.should eq 4
    (a + 3i8).value.should eq 4
    (a + mod).value.should eq 1
    (a + mod * 2).value.should eq 1
    (x + x).value.should eq mod - 2
  end

  it "-(other)" do
    a = Mint.new(3)
    (a - Mint.new(4)).value.should eq mod - 1
    (a - 3).value.should eq 0
    (a - 3i64).value.should eq 0
    (a - 3i8).value.should eq 0
    (a - 4).value.should eq mod - 1
    (a - mod).value.should eq 3
    (Mint.zero - x).value.should eq 1
  end

  it "*(other)" do
    a = Mint.new(3)
    (a * 3).value.should eq 9
    (a * a).value.should eq 9
    (a * mod).value.should eq 0
    (x * mod).value.should eq 0
    (x * x).value.should eq 1
    (x * Int64::MAX).value.should eq mod.pred * max % mod
  end

  it "/(other)" do
    a = Mint.new(3)
    (a / 1).value.should eq 3
    (a / 2).value.should eq mod // 2 + 2
    (a / 3).value.should eq 1
    expect_raises(DivisionByZeroError) { a / 0 }
    expect_raises(DivisionByZeroError) { a / 0i8 }
    expect_raises(DivisionByZeroError) { a / mod }
    expect_raises(DivisionByZeroError) { a / Mint.zero }
  end

  it "//(other)" do
    a = Mint.new(3)
    (a // 1).value.should eq 3
    (a // 2).value.should eq mod // 2 + 2
    (a // 3).value.should eq 1
    expect_raises(DivisionByZeroError) { a // 0 }
    expect_raises(DivisionByZeroError) { a // 0i8 }
    expect_raises(DivisionByZeroError) { a // mod }
    expect_raises(DivisionByZeroError) { a // Mint.zero }
  end

  it "**(other)" do
    a = Mint.new(3)
    (a ** 0).value.should eq 1
    (a ** 1).value.should eq 3
    (a ** 2).value.should eq 9
    (a ** 20).value.should eq 486784380
    (a ** (10i64**18)).value.should eq 246336683
    (a.pred ** (10i64**18)).value.should eq 719476260
  end

  it "==(other)" do
    a = Mint.new(3)
    (a == a).should be_true
    expect_raises(NotImplementedError) { a == 3 }
    (a == Mint.new(mod + 3)).should be_true
  end

  it "!=(other)" do
    a = Mint.new(3)
    (a != a).should be_false
    expect_raises(NotImplementedError) { a != 3 }
    (a != Mint.new(mod + 3)).should be_false
  end

  it "succ" do
    Mint.new(0).succ.value.should eq 1
    Mint.new(3).succ.value.should eq 4
    Mint.new(mod).succ.value.should eq 1
    x.succ.value.should eq 0
  end

  it "pred" do
    Mint.new(0).pred.value.should eq mod - 1
    Mint.new(3).pred.value.should eq 2
    Mint.new(mod).pred.value.should eq mod - 1
    x.pred.value.should eq mod - 2
  end

  it "abs" do
    Mint.new(0).abs.value.should eq 0
    Mint.new(3).abs.value.should eq 3
    Mint.new(mod).abs.value.should eq 0
    x.abs.value.should eq mod - 1
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
  end

  it "inspect" do
    Mint.new(0).inspect.should eq "0"
    Mint.new(3).inspect.should eq "3"
    Mint.new(mod).inspect.should eq "0"
    x.inspect.should eq (mod - 1).to_s
  end

  it "Int#+" do
    a = Mint.new(1)
    (3 + a).value.should eq 4
    (3i64 + a).value.should eq 4
    (3i8 + a).value.should eq 4
    (mod + a).value.should eq 1
    (mod * 2 + a).value.should eq 1
  end

  it "Int#-" do
    a = Mint.new(3)
    (3 - a).value.should eq 0
    (3i64 - a).value.should eq 0
    (3i8 - a).value.should eq 0
    (4 - a).value.should eq 1
    (mod - a).value.should eq mod - 3
    (0 - x).value.should eq 1
  end

  it "Int#*" do
    a = Mint.new(3)
    (3 * a).value.should eq 9
    (mod * a).value.should eq 0
    (Int64::MAX * x).value.should eq mod.pred * max % mod
  end

  it "Int#/" do
    a = Mint.new(3)
    (3 / Mint.new(1)).value.should eq 3
    (3 / Mint.new(2)).value.should eq mod // 2 + 2
    (3 / Mint.new(3)).value.should eq 1
    expect_raises(DivisionByZeroError) { 0 / Mint.zero }
    expect_raises(DivisionByZeroError) { mod / Mint.new mod }
  end

  it "Int#//" do
    a = Mint.new(3)
    (3 // Mint.new(1)).value.should eq 3
    (3 // Mint.new(2)).value.should eq mod // 2 + 2
    (3 // Mint.new(3)).value.should eq 1
    expect_raises(DivisionByZeroError) { 0 // Mint.zero }
    expect_raises(DivisionByZeroError) { mod // Mint.new mod }
  end

  it "Int#to_m" do
    (-1).to_m.value.should eq mod - 1
    (-1i8).to_m.value.should eq mod - 1
    0.to_m.value.should eq 0
    1i64.to_m.value.should eq 1
    mod.to_m.value.should eq 0
  end

  it "String#to_m" do
    "-1".to_m.value.should eq mod - 1
    "0".to_m.value.should eq 0
    "1".to_m.value.should eq 1
    (mod - 1).to_s.to_m.value.should eq mod - 1
    mod.to_s.to_m.value.should eq 0
  end

  it "compare" do
    a = Mint.new(3)
    expect_raises(NotImplementedError) { a < 1 }
    expect_raises(NotImplementedError) { a <= 1 }
    expect_raises(NotImplementedError) { a > 1 }
    expect_raises(NotImplementedError) { a >= 1 }
    expect_raises(NotImplementedError) { 1 == a }
    expect_raises(NotImplementedError) { 1 != a }
    expect_raises(NotImplementedError) { 1 < a }
    expect_raises(NotImplementedError) { 1 <= a }
    expect_raises(NotImplementedError) { 1 > a }
    expect_raises(NotImplementedError) { 1 >= a }
  end
end
