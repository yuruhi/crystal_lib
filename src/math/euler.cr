require "../../atcoder/src/Prime"

module Math
  def euler(x : Int)
    AtCoder::Prime.prime_division(x).reduce(x) do |euler, (p, e)|
      euler // p * (p - 1)
    end
  end

  def euler_table(x : Int)
    euler = (0..x).to_a
    (2..x).each do |i|
      i.step(to: x, by: i) do |j|
        euler[j] = euler[j] // i * i.pred
      end if euler[i] == i
    end
    euler
  end
end
