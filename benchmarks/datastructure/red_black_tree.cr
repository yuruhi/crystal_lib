require "benchmark"
require "../../src/datastructure/red_black_tree"

class Foo
  getter x
  include Comparable(Foo)

  def initialize(@x = 0)
  end

  def <=>(other : Foo)
    x <=> other.x
  end
end

R = Random.new(12345)
define_red_black_tree(RBT_Int32, Int32, 0)
define_red_black_tree(RBT_Array, Array(Int32), [] of Int32)
define_red_black_tree(RBT_Class, Foo, Foo.new)

def benchmark(label, type : T.class, values) forall T
  index = (0...values.size).to_a.shuffle Random.new(123)
  Benchmark.ips do |x|
    x.report(label) do
      a = T.new
      values.each { |x| a.add x }
      index.each { |i| a.delete values[i] }
    end
  end
end

benchmark "Int32 10^2 sparse", RBT_Int32, Array.new(10**2) { |i| i }.shuffle(R)
benchmark "Int32 10^2 dence ", RBT_Int32, Array.new(10**2) { |i| i % 10 }.shuffle(R)
benchmark "Int32 10^6 sparse", RBT_Int32, Array.new(10**6) { |i| i }.shuffle(R)
benchmark "Int32 10^6 dence ", RBT_Int32, Array.new(10**6) { |i| i % 100 }.shuffle(R)
benchmark "Array 10^6 * 10^2", RBT_Array, Array.new(10**6) { Array.new(10**2) { R.rand(100) } }
benchmark "class 10^6       ", RBT_Class, Array.new(10**6) { Foo.new R.rand(100) }
