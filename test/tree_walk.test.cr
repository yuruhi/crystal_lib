# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/courses/lesson/1/ALDS1/all/ALDS1_7_C
require "../graph/tree_walk"

def in_order(graph, v, result)
  if left = graph[v][0]
    in_order(graph, left, result)
  end
  result << v
  if right = graph[v][1]
    in_order(graph, right, result)
  end
end

n = read_line.to_i
graph = UnweightedUndirectedGraph.new(n)
graph2 = Array({Int32?, Int32?}).new(n, {nil, nil})
in_degree = [0] * n
n.times do
  v, left, right = read_line.split.map(&.to_i)
  if left != -1
    graph.add_edge(v, left)
    in_degree[left] += 1
  end
  if right != -1
    graph.add_edge(v, right)
    in_degree[right] += 1
  end
  graph2[v] = {left >= 0 ? left : nil, right >= 0 ? right : nil}
end
root = (0...n).find { |i| in_degree[i] == 0 }.not_nil!

in_ans = [] of Int32
in_order(graph2, root, in_ans)

puts "Preorder", graph.pre_order(root).join { |i| " #{i}" }
puts "Inorder", in_ans.join { |i| " #{i}" }
puts "Postorder", graph.post_order(root).join { |i| " #{i}" }
