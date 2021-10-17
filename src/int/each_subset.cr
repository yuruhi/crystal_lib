struct Int
  private class SubsetIterator(T)
    include Iterator(T)

    def initialize(@set : T)
      @subset = T.zero.as(T)
      @first = true
    end

    def next
      if @subset == 0 && !@first
        stop
      else
        @first = false
        @subset = ~-@subset & @set
      end
    end
  end

  # Returns an iterator that returns all subsets of `self`.
  #
  # ```
  # 0b101.each_subset.to_a # => [0b101, 0b100, 0b001, 0b000]
  # ```
  def each_subset
    SubsetIterator.new(self)
  end

  # Calls the given block for each subset of `self`.
  #
  # ```
  # # x = 0b101, 0b100, 0b001, 0b000
  # 0b101.each_subset { |x| }
  # ```
  def each_subset(&)
    yield self
    sub = ~-self & self
    loop do
      yield sub
      break if sub == 0
      sub = ~-sub & self
    end
  end
end
