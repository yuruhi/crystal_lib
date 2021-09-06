# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/ALDS1_9_C
require "../../src/datastructure/binary_heap"

a = BinaryHeap(Int32).new { |a, b| b <=> a }
loop do
  case gets
  when .=~ /insert (\d+)/
    a << $1.to_i
  when "extract"
    puts a.pop
  else
    break
  end
end
