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

def benchmark_add_delete(label, type : T.class, values) forall T
  index = (0...values.size).to_a.shuffle Random.new(123)
  Benchmark.ips do |x|
    x.report(label) do
      s = T.new
      values.each { |x| s.add x }
      index.each { |i| s.delete values[i] }
    end
  end
end

def benchmark_split(label, type : T.class, values, split_key) forall T
  Benchmark.ips do |x|
    x.report(label) do
      s = T.new values
      l, r = s.split(split_key)
    end
  end
end

SInt32 = Set::Treap(Int32)
SArray = Set::Treap(Array(Int32))
SClass = Set::Treap(Foo)

values3 = Array.new(10**3, &.itself)
values6 = Array.new(10**6, &.itself)

puts "-------- add, delete --------"
benchmark_add_delete "Int32 1e3 sorted", SInt32, values3
benchmark_add_delete "Int32 1e3       ", SInt32, values3.shuffle(R)
benchmark_add_delete "Int32 1e6 sorted", SInt32, values6
benchmark_add_delete "Int32 1e6       ", SInt32, values6.shuffle(R)
benchmark_add_delete "Int32 1e3 * 1e3 ", SInt32, values6.map { |x| x % 1000 }.shuffle(R)
benchmark_add_delete "Array 1e6 * 1e2 ", SArray, Array.new(10**6) { Array.new(10**2) { R.rand(100) } }
benchmark_add_delete "class 1e6       ", SClass, Array.new(10**6) { |i| Foo.new i }.shuffle(R)
puts

puts "-------- split --------"
benchmark_split "Int32 5e5+5e5", SInt32, values6, 5_000_000
benchmark_split "Int32 1e5+9e5", SInt32, values6, 1_000_000
