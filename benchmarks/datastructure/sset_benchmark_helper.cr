require "benchmark"

private class Foo
  getter x
  include Comparable(Foo)

  def initialize(@x = 0)
  end

  def <=>(other : Foo)
    x <=> other.x
  end
end

private class SlowCmp
  include Comparable(SlowCmp)

  def initialize(size)
    @array = Array(Int32).new(size) { yield }
  end

  def initialize
    @array = [] of Int32
  end

  def <=>(other : SlowCmp)
    @array.sum <=> other.@array.sum
  end
end

private def add_delete(x, type : S.class, label, values) forall S
  index = (0...values.size).to_a.shuffle Random.new(123)
  x.report(label) do
    s = S(typeof(values.first)).new
    values.each { |x| s.add x }
    index.each { |i| s.delete values[i] }
  end
end

private def split(x, type : T.class, label, values, split_key) forall T
  x.report(label) do
    s = T.new values
    _, _ = s.split(split_key)
  end
end

def benchmark_sset_add_delete(type : S.class) forall S
  r = Random.new(12345)
  values3 = Array.new(10**3, &.itself)
  values6 = Array.new(10**6, &.itself)

  puts "-------- add, delete --------"
  Benchmark.ips do |x|
    add_delete x, S, "Int32 1e3 sorted", values3
    add_delete x, S, "Int32 1e3       ", values3.shuffle(r)
    add_delete x, S, "Int32 1e6 sorted", values6
    add_delete x, S, "Int32 1e6       ", values6.shuffle(r)
    add_delete x, S, "Int32 1e3 * 1e3 ", values6.map { |x| x % 1000 }.shuffle!(r)
    add_delete x, S, "Array 1e6 * 1e2 ", Array.new(10**6) { Array.new(10**2) { r.rand(100) } }
    add_delete x, S, "class 1e6       ", Array.new(10**6) { Foo.new r.rand(100) }
    add_delete x, S, "SlowC 1e6 * 1e2 ", Array.new(10**6) { SlowCmp.new(100) { r.rand(100) } }
  end
end

def benchmark_sset_split(type : S.class) forall S
  values6 = Array.new(10**6, &.itself)

  puts "-------- split --------"
  Benchmark.ips do |x|
    split x, S, "Int32 5e5+5e5", values6, 5_000_000
    split x, S, "Int32 1e5+9e5", values6, 1_000_000
  end
end
