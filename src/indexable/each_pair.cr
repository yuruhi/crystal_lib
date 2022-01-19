module Indexable(T)
  def each_pair(&)
    each_with_index do |x, i|
      (i + 1...size).each do |j|
        yield x, unsafe_fetch(j)
      end
    end
  end

  def each_pair
    PairIterator(self, T).new(self)
  end

  private class PairIterator(A, T)
    include Iterator({T, T})

    def initialize(@array : A)
      @i, @j = 0, 1
    end

    def next : {T, T} | Iterator::Stop
      if @j >= @array.size
        @i += 1
        @j = @i + 1
      end
      if @j >= @array.size
        stop
      else
        {@array[@i], @array[@j]}.tap { @j += 1 }
      end
    end
  end
end
