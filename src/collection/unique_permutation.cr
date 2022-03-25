class Array(T)
  def next_permutation! : Bool
    i = (1...size).reverse_each.find { |i| self[i - 1] < self[i] } || return false
    j = (0...size).reverse_each.find { |j| self[i - 1] < self[j] }.not_nil!
    swap(i - 1, j)
    Slice.new(to_unsafe + i, size - i).reverse!
    true
  end

  private class UniquePermutationIterator(T)
    include Iterator(T)

    def initialize(@array : T)
      @first = true
    end

    def next
      if @first
        @first = false
        @array
      elsif @array.next_permutation!
        @array
      else
        stop
      end
    end
  end

  def each_unique_permutation
    UniquePermutationIterator.new(clone)
  end

  def each_unique_permutation(&block)
    perm = clone
    loop do
      yield perm
      break unless perm.next_permutation!
    end
  end

  def unique_permutations
    permutations = [] of Array(T)
    each_unique_permutation { |perm| permutations << perm }
    permutations
  end
end
