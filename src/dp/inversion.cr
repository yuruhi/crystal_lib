require "../datastructure/binary_indexed_tree"

module DP
  extend self

  def inversion(a : Array(T)) : Int64 forall T
    bit = BinaryIndexedTree(Int32).new(a.max + 1)
    a.sum(0i64) do |x|
      bit[x + 1..].tap { bit.add(x, 1) }
    end
  end
end
