# verification-helper: PROBLEM https://yukicoder.me/problems/no/1370
# verification-helper: IGNORE
require "../../src/graph/topological_sort"
n, m = read_line.split.map(&.to_i)
a = read_line.split.map(&.to_i.pred)
if a.each_cons(3).any? { |(x, y, z)| x == y || x == z || y == z }
  puts "No"
else
  graph = UnweightedDirectedGraph.new(m)
  (0...n - 1).each do |i|
    if i.even?
      graph << {a[i], a[i + 1]}
    else
      graph << {a[i + 1], a[i]}
    end
  end
  if order = graph.topological_sort
    ans = [-1] * m
    order.each_with_index { |x, i| ans[x] = i }
    puts "Yes", ans.join(' ', &.succ)
  else
    puts "No"
  end
end
