require "../math/Mint"
MOD = 10i64**9 + 7

describe "Mint" do
  it "self.mod" do
    Mint.mod.should eq MOD
  end

  it "self.zero" do
    Mint.zero.value.should eq 0
  end

  it "initialize" do
    Mint.new.value.should eq 0
    Mint.new(0).value.should eq 0
    Mint.new(42).value.should eq 42
    Mint.new(42i64).value.should eq 42
    Mint.new(42i8).value.should eq 42
    Mint.new(10**9 + 7).value.should eq 0
    Mint.new(10**9 + 8).value.should eq 1
    Mint.new(MOD * MOD).value.should eq 0
  end

  it "+" do
    (+Mint.new).value.should eq 0
    (+Mint.new(12)).value.should eq 12
  end

  it "-" do
    (-Mint.new).value.should eq 0
    (-Mint.new(12)).value.should eq MOD - 12
  end

  it "+(other)" do
    a = Mint.new(1)
    (a + a).value.should eq 2
    (a + 3).value.should eq 4
    (a + 3i64).value.should eq 4
    (a + 3i8).value.should eq 4
    (a + MOD).value.should eq 1
    (a + MOD * 2).value.should eq 1
  end

  it "-(other)" do
    a = Mint.new(3)
    (a - Mint.new(4)).value.should eq MOD - 1
    (a - 3).value.should eq 0
    (a - 3i64).value.should eq 0
    (a - 3i8).value.should eq 0
    (a - 4).value.should eq MOD - 1
    (a - MOD).value.should eq 3
    (a + MOD * 2).value.should eq 3
  end

  it "*(other)" do
    a = Mint.new(3)
    (a * 3).value.should eq 9
    (a * a).value.should eq 9
    (a * MOD).value.should eq 0
    (Mint.new(-1) * MOD).value.should eq 0
    (Mint.new(-1) * Int64::MAX).value.should eq Int64::MAX % MOD * (MOD - 1) % MOD
  end

  it "/(other)" do
    a = Mint.new(3)
    (a / 1).value.should eq 3
    (a / 2).value.should eq MOD // 2 + 2
    (a / 3).value.should eq 1
    expect_raises(DivisionByZeroError) { a / 0 }
    expect_raises(DivisionByZeroError) { a / MOD }
    expect_raises(DivisionByZeroError) { a / Mint.zero }
  end

  it "//(other)" do
    a = Mint.new(3)
    (a // 1).value.should eq 3
    (a // 2).value.should eq MOD // 2 + 2
    (a // 3).value.should eq 1
    expect_raises(DivisionByZeroError) { a // 0 }
    expect_raises(DivisionByZeroError) { a // MOD }
    expect_raises(DivisionByZeroError) { a // Mint.zero }
  end

  it "**(other)" do
    a = Mint.new(3)
    (a ** 0).value.should eq 1
    (a ** 1).value.should eq 3
    (a ** 2).value.should eq 9
    (a ** 20).value.should eq 486784380
    (a ** (10i64**18)).value.should eq 246336683
  end

  it "==(other)" do
    a = Mint.new(3)
    (a == a).should be_true
    (a == 3).should be_true
    (a == 2).should be_false
    (a == MOD + 3).should be_false
    (a == Mint.new(MOD + 3)).should be_true
  end

  it "!=(other)" do
    a = Mint.new(3)
    (a != a).should be_false
    (a != 3).should be_false
    (a != 2).should be_true
    (a != MOD + 3).should be_true
    (a != Mint.new(MOD + 3)).should be_false
  end

  it "succ" do
    Mint.new(0).succ.value.should eq 1
    Mint.new(3).succ.value.should eq 4
    Mint.new(MOD).succ.value.should eq 1
    Mint.new(MOD - 1).succ.value.should eq 0
  end

  it "pred" do
    Mint.new(0).pred.value.should eq MOD - 1
    Mint.new(3).pred.value.should eq 2
    Mint.new(MOD).pred.value.should eq MOD - 1
    Mint.new(MOD - 1).pred.value.should eq MOD - 2
  end

  it "abs" do
    Mint.new(0).abs.value.should eq 0
    Mint.new(3).abs.value.should eq 3
    Mint.new(MOD).abs.value.should eq 0
    Mint.new(MOD - 1).abs.value.should eq MOD - 1
  end

  it "value" do
    Mint.new(0).value.should eq 0
    Mint.new(3).value.should eq 3
    Mint.new(MOD).value.should eq 0
    Mint.new(MOD - 1).value.should eq MOD - 1
  end

  it "to_s" do
    Mint.new(0).to_s.should eq "0"
    Mint.new(3).to_s.should eq "3"
    Mint.new(MOD).to_s.should eq "0"
    Mint.new(MOD - 1).to_s.should eq (MOD - 1).to_s
  end

  it "inspect" do
    Mint.new(0).inspect.should eq "0"
    Mint.new(3).inspect.should eq "3"
    Mint.new(MOD).inspect.should eq "0"
    Mint.new(MOD - 1).inspect.should eq (MOD - 1).to_s
  end

  it "Int#to_m" do
    (-1).to_m.value.should eq MOD - 1
    (-1i8).to_m.value.should eq MOD - 1
    0.to_m.value.should eq 0
    1i64.to_m.value.should eq 1
    MOD.to_m.value.should eq 0
  end

  it "String#to_m" do
    "-1".to_m.value.should eq MOD - 1
    "0".to_m.value.should eq 0
    "1".to_m.value.should eq 1
    (MOD - 1).to_s.to_m.value.should eq MOD - 1
    MOD.to_s.to_m.value.should eq 0
  end
end
