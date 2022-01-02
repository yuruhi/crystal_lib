class SieveFast
  getter size : Int32, factor : Array(Int32), primes : Array(Int32)

  private def value(i)
    2 * i + 3
  end

  private def index(x)
    (x - 3) // 2
  end

  # index :  0  1  2  3  4  5  6  7  8  9 10 11
  # value :  3  5  7  9 11 13 15 17 19 21 23 25
  # factor:  3  5  7  3 11 13  3 17 19  3 23  5

  private def sift(n)
    # factor(i)       = value(i)          = 2i + 3
    # index_square(i) = index(value(i)^2) = 2i^2 + 6i + 3
    # factor(i + 1)       - factor(i)       = 2
    # index_square(i + 1) - index_square(i) = 4i + 8 = factor(i) + factor(i + 1)
    i, factor, index_square = 0, 3, 3
    while index_square < n
      if @factor[i] == 0
        @factor[i] = factor
        @primes << factor
        index_square.step(to: n - 1, by: factor) do |j|
          @factor[j] = factor if @factor[j] == 0
        end
      end
      i += 1
      index_square += factor
      factor += 2
      index_square += factor
    end
    while i < n
      if @factor[i] == 0
        @factor[i] = factor
        @primes << factor
      end
      i += 1
      factor += 2
    end
  end

  def initialize(@size)
    @primes = [2]
    n = (@size - 1) // 2
    @factor = Array(Int32).new(n, 0)
    sift(n)
  end

  def prime?(x : Int32)
    raise ArgumentError.new unless 1 <= x <= size
    if x.even?
      x == 2
    elsif x == 1
      false
    else
      @factor[index(x)] == x
    end
  end

  private class PrimeDivisionIterator
    include Iterator({Int32, Int32})

    @done2 : Bool

    def initialize(@current : Int32, @factor : Array(Int32))
      @done2 = @current.odd?
    end

    def next
      return stop if @current == 1

      unless @done2
        @current //= 2
        count = 1
        while @current.even?
          @current //= 2
          count += 1
        end
        @done2 = true
        return {2, count}
      end

      element = @factor[(@current - 3) // 2]
      @current //= element
      count = 1
      while @current != 1 && @factor[(@current - 3) // 2] == element
        count += 1
        @current //= element
      end
      {element, count}
    end
  end

  def prime_division(x : Int32)
    raise ArgumentError.new unless 1 <= x <= size
    PrimeDivisionIterator.new(x, @factor)
  end

  def each_factor(x : Int32, & : Int32, Int32 ->) : Nil
    raise ArgumentError.new unless 1 <= x <= size
    if x.even?
      count = 1
      x //= 2
      while x.even?
        count += 1
        x //= 2
      end
      yield 2, count
    end
    while x > 1
      element = @factor[index(x)]
      x //= element
      count = 1
      while x != 1 && @factor[index(x)] == element
        count += 1
        x //= element
      end
      yield element, count
    end
  end

  def number_of_divisors(x : Int) : Int32
    cnt = 1
    each_factor(x) do |_, c|
      cnt *= c + 1
    end
    cnt
  end

  def sum_of_divisors(x : Int) : Int64
    sum = 1i64
    each_factor(x) do |elem, cnt|
      sum *= (elem.to_i64 ** cnt.succ - 1) // (elem - 1)
    end
    sum
  end
end
