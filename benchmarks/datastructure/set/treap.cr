require "benchmark"
require "../../../src/datastructure/set/treap"

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

SInt32 = Set::Treap(Int32)
SArray = Set::Treap(Array(Int32))
SClass = Set::Treap(Foo)

benchmark "Int32 1..1e2 * 1e1", SInt32, Array.new(10**3) { |i| i % 100 }.shuffle(R)
benchmark "Int32 1..1e2 * 1e4", SInt32, Array.new(10**6) { |i| i % 100 }.shuffle(R)
benchmark "Int32 1..1e3      ", SInt32, Array.new(10**3) { |i| i }.shuffle(R)
benchmark "Int32 1..1e6      ", SInt32, Array.new(10**6) { |i| i }.shuffle(R)
benchmark "Array 1e6 * 1e2   ", SArray, Array.new(10**6) { Array.new(10**2) { R.rand(100) } }
benchmark "class 1..1e6      ", SClass, Array.new(10**6) { |i| Foo.new i }.shuffle(R)
