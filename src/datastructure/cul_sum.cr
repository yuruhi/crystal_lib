class CulSum(T)
  def self.build(a : Enumerable(T))
    result = [T.zero]
    a.each do |x|
      result << result[-1] + x
    end
    result
  end

  def initialize(a : Array(T))
    @n = a.size
    @s = Array(T).new(@n + 1, T.zero)
    @n.times do |i|
      @s[i + 1] = @s[i] + a[i]
    end
  end

  def initialize(@n : Int32, &f : Int32 -> T)
    @s = Array(T).new(@n + 1, T.zero)
    @n.times do |i|
      @s[i + 1] = @s[i] + yield(i)
    end
  end

  def initialize(a, &f)
    @n = a.size
    @s = Array(T).new(@n + 1, T.zero)
    @n.times do |i|
      @s[i + 1] = @s[i] + yield(a[i])
    end
  end

  def [](left : Int32, count : Int32) : T
    @s[left + count] - @s[left]
  end

  def [](range : Range) : T
    self[*Indexable.range_to_index_and_count(range, @n) || raise IndexError.new]
  end

  def to_a : Array(T)
    (0...@n).map { |i| self[i..i] }
  end
end
