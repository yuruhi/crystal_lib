struct Int
  private class CombinationIterator(T, U)
    include Iterator(T)

    @combination : T

    def initialize(@n : T, @k : U)
      @combination = (T.new(1) << @k) - 1
      @first = true
    end

    def next
      if @first
        @first = false
        @combination
      else
        x = @combination & -@combination
        y = @combination + x
        @combination = ((@combination & ~y) // x >> 1) | y
        @combination < (T.new(1) << @n) ? @combination : stop
      end
    end
  end

  def each_combination(k : Int)
    CombinationIterator.new(self, k)
  end

  def each_combination(k : Int, &)
    combination = (self.class.new(1) << k) - 1
    while combination < (self.class.new(1) << self)
      yield combination
      x = combination & (-combination)
      y = combination + x
      combination = ((combination & ~y) // x >> 1) | y
    end
  end
end
