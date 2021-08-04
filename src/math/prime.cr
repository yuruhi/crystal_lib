module Prime
  extend self
  include Indexable(Int32)

  @@primes = [
    2, 3, 5, 7, 11, 13, 17, 19, 23, 29,
    31, 37, 41, 43, 47, 53, 59, 61, 67, 71,
    73, 79, 83, 89, 97, 101, 103, 107, 109, 113,
    127, 131, 137, 139, 149, 151, 157, 163, 167, 173,
    179, 181, 191, 193, 197, 199, 211, 223, 227, 229,
    233, 239, 241, 251, 257, 263, 269, 271, 277, 281,
    283, 293, 307, 311, 313, 317, 331, 337, 347, 349,
    353, 359, 367, 373, 379, 383, 389, 397, 401, 409,
    419, 421, 431, 433, 439, 443, 449, 457, 461, 463,
    467, 479, 487, 491, 499, 503, 509, 521, 523, 541,
    547, 557, 563, 569, 571, 577, 587, 593, 599, 601,
    607, 613, 617, 619, 631, 641, 643, 647, 653, 659,
    661, 673, 677, 683, 691, 701, 709, 719, 727, 733,
    739, 743, 751, 757, 761, 769, 773, 787, 797, 809,
    811, 821, 823, 827, 829, 839, 853, 857, 859, 863,
    877, 881, 883, 887, 907, 911, 919, 929, 937, 941,
    947, 953, 967, 971, 977, 983, 991, 997,
  ]

  private def generate_primes
    size = @@primes.size
    primes = Array.new(size) { |i| @@primes.last + (i + 1) * 2 }
    last = primes.last

    @@primes.each do |prime|
      next if prime == 2
      break if prime * prime > last
      from = prime * ((@@primes.last // prime + 1) // 2 * 2 + 1)
      from.step(to: last, by: prime * 2) do |x|
        primes[~((last - x) // 2)] = 0
      end
    end

    @@primes.concat primes.reject(0)
  end

  private def generate_until(*, index : Int)
    while @@primes.size <= index
      generate_primes
    end
  end

  private def generate_until(*, value : Int)
    while @@primes.last < value
      generate_primes
    end
  end

  private def check_index_out_of_bounds(index)
    if 0 <= index < size
      index
    else
      yield
    end
  end

  # Returns the *index* th prime, without doing any bounds check.
  def unsafe_fetch(index : Int)
    generate_until(index: index)
    @@primes.unsafe_fetch(index)
  end

  # Returns the limit of size.
  def size
    10**9
  end

  def []?(start : Int, count : Int) : Array(Int32)?
    raise ArgumentError.new "Negative count: #{count}" if count < 0
    return [] of Int32 if start == size

    if 0 <= start <= size
      return [] of Int32 if count == 0

      count = Math.min(count, size - start)
      generate_until(index: start + count)

      Array(Int32).build(count) do |buffer|
        buffer.copy_from(@@primes.to_unsafe + start, count)
        count
      end
    end
  end

  def [](start : Int, count : Int) : Array(Int32)
    self[start, count]? || raise IndexError.new
  end

  private def self.range_to_index_and_count(range : Range, size : Int)
    end_index = range.end || raise ArgumentError.new
    end_index -= 1 if range.excludes_end?
    start_index = range.begin || 0
    raise IndexError.new unless start_index >= 0
    count = Math.max(end_index - start_index + 1, 0)
    {start_index, count}
  end

  def []?(range : Range) : Array(Int32)?
    self[*range_to_index_and_count(range, size)]?
  end

  def [](range : Range) : Array(Int32)
    self[*range_to_index_and_count(range, size)]
  end

  def includes?(x : Int)
    generate_until(value: x)
    @@primes.bsearch { |y| y >= x } == x
  end

  def index(x : Int)
    generate_until(value: x)
    i = @@primes.bsearch_index { |y| y >= x }.not_nil!
    @@primes[i] == x ? i : nil
  end

  def each(x : Int, &)
    i = 0
    loop do
      generate_primes if @@primes.size == i
      prime = @@primes.unsafe_fetch(i)
      break if prime > x
      yield prime
      i += 1
    end
  end

  def each(x : Int)
    each.take_while { |prime| prime <= x }
  end
end
