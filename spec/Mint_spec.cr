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
    expect_raises(DivisionByZeroError) { a / MOD }
    expect_raises(DivisionByZeroError) { a / Mint.zero }
  end

  it "//(other)" do
    a = Mint.new(3)
    (a // 1).value.should eq 3
    (a // 2).value.should eq MOD // 2 + 2
    (a // 3).value.should eq 1
    expect_raises(DivisionByZeroError) { a // MOD }
    expect_raises(DivisionByZeroError) { a // Mint.zero }
  end

  it "**(other)" do
    a = Mint.new(3)
    (a ** 0).value.should eq 1
    (a ** 1).value.should eq 3
    (a ** 2).value.should eq 9
  end
end
