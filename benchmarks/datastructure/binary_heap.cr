require "benchmark"
require "../../src/datastructure/binary_heap"

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

private def benchmark(label, values : Array(T)) forall T
  Benchmark.ips do |x|
    x.report(label) do
      a = BinaryHeap(T).new
      values.each { |x| a.add x }
      values.size.times { a.pop }
      raise "" unless a.empty?
    end
  end
end

private def benchmark_reverse(label, values : Array(T)) forall T
  Benchmark.ips do |x|
    x.report(label) do
      a = BinaryHeap(T).new { |a, b| b <=> a }
      values.each { |x| a.add x }
      values.size.times { a.pop }
      raise "" unless a.empty?
    end
  end
end

r = Random.new(12345)

benchmark "Int32 10^2 sparse  ", Array.new(10**2) { |i| i }
benchmark "Int32 10^2 dence   ", Array.new(10**2) { |i| i % 10 }
benchmark "Int32 10^6 sparse  ", Array.new(10**6) { |i| i }
benchmark "Int32 10^6 dence   ", Array.new(10**6) { |i| i % 100 }
benchmark_reverse "Int32 10^6 sparse R", Array.new(10**6) { |i| i }
benchmark_reverse "Int32 10^6 dence  R", Array.new(10**6) { |i| i % 100 }
benchmark "SlowC 10^6 * 10^2  ", Array.new(10**6) { SlowCmp.new(10**2) { r.rand(100) } }
