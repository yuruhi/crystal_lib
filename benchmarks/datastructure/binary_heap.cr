require "benchmark"
require "../../src/datastructure/binary_heap"

def benchmark(label, values : Array(T)) forall T
  Benchmark.ips do |x|
    x.report(label) do
      a = BinaryHeap(T).new
      values.each { |x| a.add x }
      values.size.times { a.pop }
    end
  end
end

benchmark "Int32 10^2 sparse", Array.new(10**2) { |i| i }
benchmark "Int32 10^2 dence ", Array.new(10**2) { |i| i % 10 }
benchmark "Int32 10^6 sparse", Array.new(10**6) { |i| i }
benchmark "Int32 10^6 dence ", Array.new(10**6) { |i| i % 100 }

r = Random.new(12345)
benchmark "Array 10^5 * 10^2", Array.new(10**5) { Array.new(10**2) { r.rand(100) } }

# Int32 10^2 sparse 140.81k (  7.10µs) (± 8.12%)  1.72kB/op  fastest
# Int32 10^2 dence  117.27k (  8.53µs) (± 6.83%)  1.72kB/op  fastest
# Int32 10^6 sparse   5.34  (187.41ms) (± 3.53%)  12.0MB/op  fastest
# Int32 10^6 dence    5.03  (198.89ms) (± 3.56%)  12.0MB/op  fastest
# Array 10^5 * 10^2   8.29  (120.57ms) (± 4.51%)  3.0MB/op  fastest
