require "benchmark"
require "../../src/datastructure/binary_heap"

class BinaryHeap(T)
  def each_clone
    heap = clone
    while v = heap.pop?
      yield v
    end
  end

  def each_sort
    @heap.sort.each do |x|
      yield x
    end
  end
end

def benchmark_each(label, a : Array)
  n = a.size
  heap = BinaryHeap.new a

  puts "#{label}: "
  Benchmark.ips do |x|
    x.report("each_clone") do
      heap.each_clone { }
    end
    x.report("each_sort") do
      heap.each_sort { }
    end
  end
  puts

  raise "" unless a.size == n
end

benchmark_each "Int32 10^2 sparse", Array.new(10**2) { |i| i }
benchmark_each "Int32 10^2 dence", Array.new(10**2) { |i| i % 10 }
benchmark_each "Int32 10^6 sparse", Array.new(10**6) { |i| i }
benchmark_each "Int32 10^6 dence", Array.new(10**6) { |i| i % 100 }

r = Random.new(12345)
benchmark_each "Array 10^6 * 10^2", Array.new(10**6) { Array.new(10**2) { r.rand(100) } }
benchmark_each "Array 10^5 * 10^3", Array.new(10**5) { Array.new(10**3) { r.rand(100) } }
benchmark_each "Array 10^4 * 10^4", Array.new(10**4) { Array.new(10**4) { r.rand(100) } }
