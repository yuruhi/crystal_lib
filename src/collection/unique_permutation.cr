class Array(T)
  def next_permutation! : Bool
    i = (1...size).reverse_each.find { |i| self[i - 1] < self[i] } || return false
    j = (0...size).reverse_each.find { |j| self[i - 1] < self[j] }.not_nil!
    swap(i - 1, j)
    Slice.new(to_unsafe + i, size - i).reverse!
    true
  end

  def next_permutation? : Array(T)?
    arr = dup
    arr.next_permutation! ? arr : nil
  end

  def each_unique_permutation(reuse : Bool = false, &block) : Nil
    pool = dup
    loop do
      yield reuse ? pool : pool.dup
      break unless pool.next_permutation!
    end
  end

  def each_unique_permutation(reuse : Bool = false)
    UniquePermutationIterator.new(clone, reuse)
  end

  def unique_permutations : Array(Array(T))
    permutations = [] of Array(T)
    each_unique_permutation { |perm| permutations << perm.dup }
    permutations
  end

  private class UniquePermutationIterator(T)
    include Iterator(T)

    @pool : T

    def initialize(a : T, @reuse : Bool)
      @pool = a.dup
      @first = true
    end

    def next
      if @first
        @first = false
        @reuse ? @pool : @pool.dup
      elsif @pool.next_permutation!
        @reuse ? @pool : @pool.dup
      else
        stop
      end
    end
  end
end
