require "spec"
require "../../src/math/dynamic_mint"

private alias M = DynamicMint
private Init = 998244353

private macro check_binary_operator(mod, op)
  %mod = {{mod}}
  M.mod = %mod
  (0...%mod).each do |x|
    (0...%mod).each do |y|
      v = M.new(x) {{ op.id }} M.new(y)
      e = (x {{ op.id }} y) % %mod
      v.should eq e
    end
  end
end

private macro check_method(mod, method)
  %mod = {{mod}}
  M.mod = %mod
  (0...%mod).each do |x|
    M.new(x).{{ method.id }}.should eq x.{{ method.id }}
  end
end

private macro check_method_mod(mod, method)
  %mod = {{mod}}
  M.mod = %mod
  (0...%mod).each do |x|
    M.new(x).{{ method.id }}.should eq x.{{ method.id }} % %mod
  end
end

describe "DynamicModint" do
  it ".mod and .setmod" do
    M.mod.should eq Init
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
    M.mod = Init
    (+M.new(1)).should eq 1
    (+M.new(Init)).should eq 0
  end

  it "#-" do
    M.mod = Init
    (-M.new(1)).should eq Init - 1
    (-M.new(0)).should eq 0

    M.mod = 3
    (-M.new(1)).should eq 2
  end

  {% for op in [:+, :-, :*] %}
    it "##{{{ op }}}" do
      check_binary_operator(1, {{ op }})
      check_binary_operator(60, {{ op }})
      check_binary_operator(1009, {{ op }})
    end
  {% end %}

  {% for op in [:/, ://] %}
    it "##{{{ op }}}" do
      {1, 60, 1009}.each do |mod|
        M.mod = mod
        (0...mod).each do |x|
          (0...mod).each do |y|
            next unless y.gcd(mod) == 1
            z = M.new(x) {{ op.id }} y
            (z * y).should eq x
          end
        end
      end
    end
  {% end %}

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

  {% for method in [:succ, :pred, :abs, :to_i64] %}
    it "##{{{ method }}}" do
      check_method_mod(1, {{ method }})
      check_method_mod(60, {{ method }})
      check_method_mod(1009, {{ method }})
      check_method_mod(1000003, {{ method }})
    end
  {% end %}

  {% for method in [:to_s, :inspect] %}
    it "##{{{ method }}}" do
      check_method(1, {{ method }})
      check_method(60, {{ method }})
      check_method(1009, {{ method }})
      check_method(1000003, {{ method }})
    end
  {% end %}

  it "compares" do
    expect_raises(NotImplementedError) { M.new(0) < 0 }
    expect_raises(NotImplementedError) { M.new(0) <= 0 }
    expect_raises(NotImplementedError) { M.new(0) > 0 }
    expect_raises(NotImplementedError) { M.new(0) >= 0 }
  end
end
