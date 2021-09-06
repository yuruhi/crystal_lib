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
      heap.each_clone { |x| }
    end
    x.report("each_sort") do
      heap.each_sort { |x| }
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
benchmark_each "Array 10^5 * 10^1", Array.new(10**5) { Array.new(10**1) { r.rand(Int32) } }
benchmark_each "Array 10^4 * 10^2", Array.new(10**4) { Array.new(10**2) { r.rand(Int32) } }
benchmark_each "Array 10^2 * 10^4", Array.new(10**2) { Array.new(10**4) { r.rand(Int32) } }
benchmark_each "Array 10^1 * 10^5", Array.new(10**1) { Array.new(10**5) { r.rand(Int32) } }

# Int32 10^2 sparse:
# each_clone 166.16k (  6.02µs) (± 2.98%)  528B/op   6.22× slower
#  each_sort   1.03M (967.15ns) (± 4.73%)  832B/op        fastest

# Int32 10^2 dence:
# each_clone 148.79k (  6.72µs) (±10.08%)  528B/op   5.01× slower
#  each_sort 745.52k (  1.34µs) (± 8.87%)  832B/op        fastest

# Int32 10^6 sparse:
# each_clone   3.91  (255.97ms) (± 6.17%)  3.81MB/op  23.58× slower
#  each_sort  92.14  ( 10.85ms) (± 6.50%)   6.0MB/op        fastest

# Int32 10^6 dence:
# each_clone   3.89  (257.24ms) (± 5.56%)  3.81MB/op   7.01× slower
#  each_sort  27.24  ( 36.71ms) (± 5.54%)   6.0MB/op        fastest

# Array 10^5 * 10^1:
# each_clone  13.36  ( 74.83ms) (± 5.50%)  8.39MB/op   3.09× slower
#  each_sort  41.34  ( 24.19ms) (± 7.81%)   1.5MB/op        fastest

# Array 10^4 * 10^2:
# each_clone  95.59  ( 10.46ms) (± 4.96%)  4.65MB/op   6.44× slower
#  each_sort 615.37  (  1.63ms) (± 5.48%)  96.1kB/op        fastest

# Array 10^2 * 10^4:
# each_clone 885.26  (  1.13ms) (± 5.04%)  3.82MB/op   7.80× slower
#  each_sort   6.90k (144.85µs) (± 7.93%)  2.03kB/op        fastest

# Array 10^1 * 10^5:
# each_clone 325.20  (  3.08ms) (± 8.73%)  3.81MB/op  13893.74× slower
#  each_sort   4.52M (221.33ns) (± 8.63%)    144B/op           fastest
