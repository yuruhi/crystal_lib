class CulSum(T)
  @n : Int32
  @s : Array(T)

  def initialize(a : Array(T))
    @n = a.size
    @s = Array(T).new(@n + 1, 0)
    @n.times do |i|
      @s[i + 1] = @s[i] + a[i]
    end
  end

  def initialize(@n : Int32, &f : Int32 -> T)
    @s = Array(T).new(@n + 1, 0)
    @n.times do |i|
      @s[i + 1] = @s[i] + yield(i)
    end
  end

  def initialize(a : Indexable, &f)
    @n = a.size
    @s = Array.new(@n + 1, 0)
    @n.times do |i|
      @s[i + 1] = @s[i] + f(a[i])
    end
  end

  def [](l : Int32, r : Int32)
    l < r ? @s[r] - @s[l] : 0
  end

  def [](i : Int32)
    @s[i]
  end

  def [](r : Range(Int32, Int32))
    @s[r.exclusive? ? r.end : r.end + 1] - @s[r.begin]
  end

  def to_a
    @n.times.to_a.map { |i| self[i..i] }
  end
end
