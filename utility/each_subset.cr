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

  def each_subset
    SubsetIterator.new(self)
  end

  def each_subset(&)
    yield self
    sub = ~-self & self
    loop do
      yield sub
      sub = ~-sub & self
      break if sub == 0
    end
  end
end
