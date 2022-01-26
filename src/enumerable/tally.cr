module Enumerable(T)
  def tally(*, default : Int32) : Hash(T, Int32)
    each_with_object(Hash(T, Int32).new default) do |value, hash|
      hash[value] += 1
    end
  end
end
