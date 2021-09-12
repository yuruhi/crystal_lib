require "benchmark"

class Foo
  getter x
  include Comparable(Foo)

  def initialize(@x = 0)
  end

  def <=>(other : Foo)
    x <=> other.x
  end
end

class SlowCmp
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
      _, _ = s.split(split_key)
    end
  end
end

def benchmark_sset(type : S.class) forall S
  r = Random.new(12345)
  values3 = Array.new(10**3, &.itself)
  values6 = Array.new(10**6, &.itself)

  puts "-------- add, delete --------"
  benchmark_add_delete "Int32 1e3 sorted", S(Int32), values3
  benchmark_add_delete "Int32 1e3       ", S(Int32), values3.shuffle(r)
  benchmark_add_delete "Int32 1e6 sorted", S(Int32), values6
  benchmark_add_delete "Int32 1e6       ", S(Int32), values6.shuffle(r)
  benchmark_add_delete "Int32 1e3 * 1e3 ", S(Int32), values6.map { |x| x % 1000 }.shuffle!(r)
  benchmark_add_delete "Array 1e6 * 1e2 ", S(Array(Int32)), Array.new(10**6) { Array.new(10**2) { r.rand(100) } }
  benchmark_add_delete "class 1e6       ", S(Foo), Array.new(10**6) { Foo.new r.rand(100) }
  benchmark_add_delete "SlowC 1e6 * 1e2 ", S(SlowCmp), Array.new(10**6) { SlowCmp.new(100) { r.rand(100) } }
  puts

  puts "-------- split --------"
  benchmark_split "Int32 5e5+5e5", S(Int32), values6, 5_000_000
  benchmark_split "Int32 1e5+9e5", S(Int32), values6, 1_000_000
end
