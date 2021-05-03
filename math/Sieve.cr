class Sieve
  getter size : Int32
  getter factor : Array(Int32)
  getter primes : Array(Int32)

  def initialize(@size)
    @factor = Array(Int32).new(@size + 1, 0)
    @primes = [] of Int32
    sqrt_size = Math.sqrt(@size).to_i + 1
    (2..size).each do |x|
      next unless @factor[x] == 0
      @factor[x] = x
      @primes << x
      next if sqrt_size < x
      (x * x).step(to: size, by: x) { |y|
        @factor[y] = x if @factor[y] == 0
      }
    end
  end

  def prime?(x)
    factor[x] == x
  end

  private class PrimeDivisionIterator
    include Iterator({Int32, Int32})

    def initialize(@current : Int32, @factor : Array(Int32))
    end

    def next
      return stop if @current == 1
      element = @factor[@current]
      count = 0
      while @current != 1 && @factor[@current] == element
        count += 1
        @current //= element
      end
      {element, count}
    end
  end

  def prime_division(x)
    PrimeDivisionIterator.new(x, factor)
  end
end
