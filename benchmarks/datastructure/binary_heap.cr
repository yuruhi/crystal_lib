require "benchmark"
require "../../src/datastructure/binary_heap"

def benchmark(label, values : Array(T)) forall T
  Benchmark.ips do |x|
    x.report(label) do
      a = BinaryHeap(T).new
      values.each { |x| a.add x }
      values.size.times { a.pop }
      raise "" unless a.empty?
    end
  end
end

benchmark "Int32 10^2 sparse", Array.new(10**2) { |i| i }
benchmark "Int32 10^2 dence", Array.new(10**2) { |i| i % 10 }
benchmark "Int32 10^6 sparse", Array.new(10**6) { |i| i }
benchmark "Int32 10^6 dence", Array.new(10**6) { |i| i % 100 }

r = Random.new(12345)
benchmark "Array 10^6 * 10^2", Array.new(10**6) { Array.new(10**2) { r.rand(100) } }
