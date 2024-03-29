module Enumerable(T)
  # Returns the minimum value of the complement set.
  def mex_sorted : T
    reduce(T.zero) do |now, x|
      next now if x < T.zero
      return now if now < x
      x.succ
    end
  end

  # :ditto:
  def mex : T
    to_a.sort!.mex_sorted
  end
end
