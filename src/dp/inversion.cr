require "../datastructure/BinaryIndexedTree"

module DP
  extend self

  def inversion(a : Array(T)) : Int64 forall T
    bit = BinaryIndexedTree(Int32).new(a.max + 1)
    a.each_with_index.sum(0i64) do |x, i|
      bit[x + 1..].tap { bit.add(x, 1) }
    end
  end
end
