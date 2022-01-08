require "big"

alias Real = BigFloat
EPS = Real.new(1e-12)

struct Real
  def <=>(other : Real)
    {% if Real == BigFloat %}
      if previous_def(other - EPS) < 0
        -1
      elsif previous_def(other + EPS) > 0
        1
      else
        0
      end
    {% else %}
      if self < other - EPS
        -1
      elsif self > other + EPS
        1
      else
        0
      end
    {% end %}
  end

  def sign : Int32
    self < -EPS ? -1 : self > EPS ? 1 : 0
  end

  def to_radian
    self * Math::PI / 180
  end

  def to_degree
    self * 180 / Math::PI
  end

  def self.scan(scanner, io : IO) : self
    Real.new scanner.s(io)
  end
end
