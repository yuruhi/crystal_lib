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

  # Returns an iterator that returns all integers whose bit_length is *n* and popcount is *k*.
  #
  # ```
  # Int.each_combination(3, 2).to_a # => [0b011, 0b101, 0b110]
  # ```
  def self.each_combination(n : Int, k : Int)
    CombinationIterator.new(n, k)
  end

  # Calls the given block for each integer whose bit_length is *n* and popcount is *k*.
  #
  # ```
  # # x = 0b011, 0b101, 0b110
  # Int.each_combination(3, 2) { |x| }
  # ```
  def self.each_combination(n : Int, k : Int, &) : Nil
    combination = (n.class.new(1) << k) - 1
    while combination < (n.class.new(1) << n)
      yield combination
      x = combination & (-combination)
      y = combination + x
      combination = ((combination & ~y) // x >> 1) | y
    end
  end
end
