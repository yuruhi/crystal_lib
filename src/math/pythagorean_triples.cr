class PythagoreanTriples
  include Enumerable({Int32, Int32, Int32})
  include Iterable({Int32, Int32, Int32})

  getter limit : Int32

  def initialize(@limit : Int32)
  end

	# Enumerates all primitive Pythagorean triples not more than `#limit`.
  def each(&)
    (1...).each do |m|
      mm = m * m
      break if mm > limit
      (m % 2 + 1...m).step(2) do |n|
        nn = n * n
        break if mm + nn > limit
        next if m.gcd(n) != 1
        a, b, c = mm - nn, m * n * 2, mm + nn
        a, b = b, a if a > b
        yield({a, b, c})
      end
    end
  end

  # Returns an `Iterator` for all primitive Pythagorean triples not more than `#limit`.
  def each
    TriplesIterator.new(@limit)
  end

  private class TriplesIterator
    include Iterator({Int32, Int32, Int32})

    def initialize(@limit : Int32)
      @m, @n = 1, 2
    end

    def next
      loop do
        mm, nn = @m * @m, @n * @n
        if mm > @limit
          return stop
        elsif @n >= @m || mm + nn > @limit
          @m += 1
          @n = @m % 2 + 1
        elsif @m.gcd(@n) != 1
          @n += 2
        else
          a, b, c = mm - nn, @m * @n * 2, mm + nn
          a, b = b, a if a > b
          @n += 2
          return {a, b, c}
        end
      end
    end
  end
end
