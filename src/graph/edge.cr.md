---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/graph/edge_spec.cr
    title: spec/graph/edge_spec.cr
  - icon: ':warning:'
    path: spec/graph_spec.cr
    title: spec/graph_spec.cr
  - icon: ':heavy_check_mark:'
    path: src/graph.cr
    title: src/graph.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/bfs.cr
    title: src/graph/bfs.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/bfs01.cr
    title: src/graph/bfs01.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/bipartite_graph.cr
    title: src/graph/bipartite_graph.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/bipartite_matching.cr
    title: src/graph/bipartite_matching.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/components.cr
    title: src/graph/components.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/compress.cr
    title: src/graph/compress.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/decompose.cr
    title: src/graph/decompose.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/degree.cr
    title: src/graph/degree.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/detect_cycle.cr
    title: src/graph/detect_cycle.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/dijkstra.cr
    title: src/graph/dijkstra.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/euler_tour_for_vertex.cr
    title: src/graph/euler_tour_for_vertex.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/kruskal.cr
    title: src/graph/kruskal.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/lca.cr
    title: src/graph/lca.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/namori_decompose.cr
    title: src/graph/namori_decompose.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/re_rooting.cr
    title: src/graph/re_rooting.cr
  - icon: ':warning:'
    path: src/graph/topological_sort.cr
    title: src/graph/topological_sort.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/tree.cr
    title: src/graph/tree.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/tree_walk.cr
    title: src/graph/tree_walk.cr
  - icon: ':warning:'
    path: test/graph/namori_decompose_test_.cr
    title: test/graph/namori_decompose_test_.cr
  - icon: ':warning:'
    path: test/graph/topological_sort_test_.cr
    title: test/graph/topological_sort_test_.cr
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/graph/bfs01_test.cr
    title: test/graph/bfs01_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/bfs_test.cr
    title: test/graph/bfs_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/bipartite_graph_test.cr
    title: test/graph/bipartite_graph_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/bipartite_matching_edges_test.cr
    title: test/graph/bipartite_matching_edges_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/bipartite_matching_test.cr
    title: test/graph/bipartite_matching_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/components_test.cr
    title: test/graph/components_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/compress_degree_test.cr
    title: test/graph/compress_degree_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/decompose_test.cr
    title: test/graph/decompose_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/detect_cycle_for_directed_graph_test.cr
    title: test/graph/detect_cycle_for_directed_graph_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/detect_cycle_for_undirected_graph_test.cr
    title: test/graph/detect_cycle_for_undirected_graph_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/diameter_test.cr
    title: test/graph/diameter_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/dijkstra_path_test.cr
    title: test/graph/dijkstra_path_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/dijkstra_test.cr
    title: test/graph/dijkstra_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/euler_tour_for_vertex_test.cr
    title: test/graph/euler_tour_for_vertex_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/kruskal_test.cr
    title: test/graph/kruskal_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/lca_test.cr
    title: test/graph/lca_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/namori_decompose_test.cr
    title: test/graph/namori_decompose_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/re_rooting_test.cr
    title: test/graph/re_rooting_test.cr
  - icon: ':heavy_check_mark:'
    path: test/graph/tree_walk_test.cr
    title: test/graph/tree_walk_test.cr
  - icon: ':heavy_check_mark:'
    path: test/scanner/11_test.cr
    title: test/scanner/11_test.cr
  - icon: ':heavy_check_mark:'
    path: test/scanner/13_test.cr
    title: test/scanner/13_test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "struct WeightedEdge(T)\n  include Comparable(WeightedEdge(T))\n\n\
    \  property to : Int32, cost : T\n\n  def initialize(@to, @cost : T)\n  end\n\n\
    \  def <=>(other : WeightedEdge(T))\n    {cost, to} <=> {other.cost, other.to}\n\
    \  end\n\n  def to_s(io) : Nil\n    io << '(' << to << \", \" << cost << ')'\n\
    \  end\n\n  def inspect(io) : Nil\n    io << \"->#{to}(#{cost})\"\n  end\nend\n\
    \nstruct WeightedEdge2(T)\n  include Comparable(WeightedEdge2(T))\n\n  property\
    \ from : Int32, to : Int32, cost : T\n\n  def initialize(@from, @to, @cost : T)\n\
    \  end\n\n  def initialize(@from, edge : WeightedEdge(T))\n    @to, @cost = edge.to,\
    \ edge.cost\n  end\n\n  def <=>(other : WeightedEdge2(T))\n    {cost, from, to}\
    \ <=> {other.cost, other.from, other.to}\n  end\n\n  def reverse\n    WeightedEdge2(T).new(to,\
    \ from, cost)\n  end\n\n  def sort\n    WeightedEdge2(T).new(*{to, from}.minmax,\
    \ cost)\n  end\n\n  def to_s(io) : Nil\n    io << '(' << from << \", \" << to\
    \ << \", \" << cost << ')'\n  end\n\n  def inspect(io) : Nil\n    io << from <<\
    \ \"->\" << to << '(' << cost << ')'\n  end\nend\n\nstruct UnweightedEdge\n  property\
    \ to : Int32\n\n  def initialize(@to)\n  end\n\n  def initialize(@to, cost)\n\
    \  end\n\n  def cost\n    1\n  end\n\n  def to_s(io) : Nil\n    io << to\n  end\n\
    \n  def inspect(io) : Nil\n    io << \"->\" << to\n  end\nend\n\nstruct UnweightedEdge2\n\
    \  property from : Int32, to : Int32\n\n  def initialize(@from, @to)\n  end\n\n\
    \  def initialize(@from, @to, cost)\n  end\n\n  def initialize(@from, edge : UnweightedEdge)\n\
    \    @to = edge.to\n  end\n\n  def cost\n    1\n  end\n\n  def reverse\n    UnweightedEdge2.new(to,\
    \ from)\n  end\n\n  def sort\n    UnweightedEdge2.new(*{to, from}.minmax)\n  end\n\
    \n  def to_s(io) : Nil\n    io << '(' << from << \", \" << to << ')'\n  end\n\n\
    \  def inspect(io) : Nil\n    io << from << \"->\" << to\n  end\nend\n"
  code: "struct WeightedEdge(T)\n  include Comparable(WeightedEdge(T))\n\n  property\
    \ to : Int32, cost : T\n\n  def initialize(@to, @cost : T)\n  end\n\n  def <=>(other\
    \ : WeightedEdge(T))\n    {cost, to} <=> {other.cost, other.to}\n  end\n\n  def\
    \ to_s(io) : Nil\n    io << '(' << to << \", \" << cost << ')'\n  end\n\n  def\
    \ inspect(io) : Nil\n    io << \"->#{to}(#{cost})\"\n  end\nend\n\nstruct WeightedEdge2(T)\n\
    \  include Comparable(WeightedEdge2(T))\n\n  property from : Int32, to : Int32,\
    \ cost : T\n\n  def initialize(@from, @to, @cost : T)\n  end\n\n  def initialize(@from,\
    \ edge : WeightedEdge(T))\n    @to, @cost = edge.to, edge.cost\n  end\n\n  def\
    \ <=>(other : WeightedEdge2(T))\n    {cost, from, to} <=> {other.cost, other.from,\
    \ other.to}\n  end\n\n  def reverse\n    WeightedEdge2(T).new(to, from, cost)\n\
    \  end\n\n  def sort\n    WeightedEdge2(T).new(*{to, from}.minmax, cost)\n  end\n\
    \n  def to_s(io) : Nil\n    io << '(' << from << \", \" << to << \", \" << cost\
    \ << ')'\n  end\n\n  def inspect(io) : Nil\n    io << from << \"->\" << to <<\
    \ '(' << cost << ')'\n  end\nend\n\nstruct UnweightedEdge\n  property to : Int32\n\
    \n  def initialize(@to)\n  end\n\n  def initialize(@to, cost)\n  end\n\n  def\
    \ cost\n    1\n  end\n\n  def to_s(io) : Nil\n    io << to\n  end\n\n  def inspect(io)\
    \ : Nil\n    io << \"->\" << to\n  end\nend\n\nstruct UnweightedEdge2\n  property\
    \ from : Int32, to : Int32\n\n  def initialize(@from, @to)\n  end\n\n  def initialize(@from,\
    \ @to, cost)\n  end\n\n  def initialize(@from, edge : UnweightedEdge)\n    @to\
    \ = edge.to\n  end\n\n  def cost\n    1\n  end\n\n  def reverse\n    UnweightedEdge2.new(to,\
    \ from)\n  end\n\n  def sort\n    UnweightedEdge2.new(*{to, from}.minmax)\n  end\n\
    \n  def to_s(io) : Nil\n    io << '(' << from << \", \" << to << ')'\n  end\n\n\
    \  def inspect(io) : Nil\n    io << from << \"->\" << to\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/graph/edge.cr
  requiredBy:
  - src/graph.cr
  - src/graph/bipartite_matching.cr
  - src/graph/bipartite_graph.cr
  - src/graph/re_rooting.cr
  - src/graph/bfs01.cr
  - src/graph/namori_decompose.cr
  - src/graph/compress.cr
  - src/graph/decompose.cr
  - src/graph/detect_cycle.cr
  - src/graph/euler_tour_for_vertex.cr
  - src/graph/dijkstra.cr
  - src/graph/lca.cr
  - src/graph/degree.cr
  - src/graph/topological_sort.cr
  - src/graph/components.cr
  - src/graph/bfs.cr
  - src/graph/kruskal.cr
  - src/graph/tree_walk.cr
  - src/graph/tree.cr
  - spec/graph_spec.cr
  - spec/graph/edge_spec.cr
  - test/graph/namori_decompose_test_.cr
  - test/graph/topological_sort_test_.cr
  timestamp: '2021-11-14 01:52:04+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/scanner/11_test.cr
  - test/scanner/13_test.cr
  - test/graph/detect_cycle_for_directed_graph_test.cr
  - test/graph/bfs_test.cr
  - test/graph/diameter_test.cr
  - test/graph/components_test.cr
  - test/graph/compress_degree_test.cr
  - test/graph/dijkstra_path_test.cr
  - test/graph/bipartite_matching_test.cr
  - test/graph/dijkstra_test.cr
  - test/graph/namori_decompose_test.cr
  - test/graph/bipartite_matching_edges_test.cr
  - test/graph/detect_cycle_for_undirected_graph_test.cr
  - test/graph/tree_walk_test.cr
  - test/graph/re_rooting_test.cr
  - test/graph/bipartite_graph_test.cr
  - test/graph/kruskal_test.cr
  - test/graph/lca_test.cr
  - test/graph/bfs01_test.cr
  - test/graph/decompose_test.cr
  - test/graph/euler_tour_for_vertex_test.cr
documentation_of: src/graph/edge.cr
layout: document
redirect_from:
- /library/src/graph/edge.cr
- /library/src/graph/edge.cr.html
title: src/graph/edge.cr
---
