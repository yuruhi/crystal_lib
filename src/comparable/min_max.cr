module Comparable(T)
  def min(x : T)
    self > x ? x : self
  end

  def max(x : T)
    self < x ? x : self
  end
end
