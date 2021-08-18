# verification-helper: PROBLEM https://yukicoder.me/problems/no/1640
# verification-helper: IGNORE
require "../../src/graph/namori_decompose"
require "../../src/graph/decompose"
require "../../src/scanner"

def dfs(graph, v, p, dist, a)
  a[v] = dist
  graph[v].each do |edge|
    next if edge.to == p
    dfs(graph, edge.to, v, dist + 1, a)
  end
end

n = input(i)
edges = input({i - 1, i - 1}[n])
ans = Array(Int32?).new(n, nil)
g = UndirectedGraph.new n, edges.each_with_index.map { |(e, i)| {e[0], e[1], i} }
graphs, _, normalize = g.decompose

graphs.zip(normalize) do |graph, normalize|
  if graph.size != graph.graph.sum(&.size) // 2
    puts "No"; exit
  end
  forest, cycle = graph.namori_decompose

  dist = [0] * graph.size
  cycle_index = [nil.as Int32?] * graph.size
  cycle.each_with_index do |v, i|
    cycle_index[v] = i
    dfs(forest, v, -1, 0, dist)
  end

  flag = false
  graph.each do |edge|
    d_from, d_to = dist[edge.from], dist[edge.to]
    c_from, c_to = cycle_index[edge.from], cycle_index[edge.to]
    if d_from < d_to
      ans[edge.cost] = normalize[edge.to]
    elsif d_from == d_to && c_from.not_nil! <= c_to.not_nil!
      if {edge.from, edge.to} == {cycle.first, cycle.last}
        if cycle.size == 2
          ans[edge.cost] = normalize[flag ? edge.to : edge.from]
          flag = true
        else
          ans[edge.cost] = normalize[edge.to]
        end
      else
        ans[edge.cost] = normalize[edge.from]
      end
    end
  end
end

puts "Yes", ans.join('\n', &.not_nil!.succ)
