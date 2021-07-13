require "spec"
require "../src/graph"

describe Edge do
  it "#to, #cost" do
    Edge.new(2, 10i64).to.should eq 2
    Edge.new(2, 10i64).cost.should eq 10i64
  end

  it "#<=>" do
    (Edge.new(2, 10) <=> Edge.new(3, 4)).should eq 1
    (Edge.new(2, 10) <=> Edge.new(2, 11)).should eq -1
    (Edge.new(2, 10) <=> Edge.new(3, 10)).should eq -1
    (Edge.new(2, 10) <=> Edge.new(0, 11)).should eq -1
    (Edge.new(2, 10) <=> Edge.new(2, 10)).should eq 0
  end

  it "#to_s" do
    Edge.new(2, 3).to_s.should eq "(2, 3)"
  end

  it "#inspect" do
    Edge.new(2, 3).inspect.should eq "->2(3)"
  end
end

describe Edge2 do
  it "#from, #to, #cost" do
    Edge2.new(2, 3, 4).from.should eq 2
    Edge2.new(2, 3, 4).to.should eq 3
    Edge2.new(2, 3, 4).cost.should eq 4
  end

  it "#reverse" do
    Edge2.new(2, 3, 4).reverse.should eq Edge2.new(3, 2, 4)
  end

  it "#sort" do
    Edge2.new(2, 3, 4).sort.should eq Edge2.new(2, 3, 4)
    Edge2.new(3, 2, 4).sort.should eq Edge2.new(2, 3, 4)
  end

  it "#to_s" do
    Edge2.new(2, 3, 4).to_s.should eq "(2, 3, 4)"
  end

  it "inspect" do
    Edge2.new(2, 3, 4).inspect.should eq "2->3(4)"
  end
end

describe UnweightedEdge2 do
  it "#from, #to" do
    UnweightedEdge2.new(2, 3).from.should eq 2
    UnweightedEdge2.new(2, 3).to.should eq 3
  end

  it "#reverse" do
    UnweightedEdge2.new(2, 3).reverse.should eq UnweightedEdge2.new(3, 2)
  end

  it "#sort" do
    UnweightedEdge2.new(2, 3).sort.should eq UnweightedEdge2.new(2, 3)
    UnweightedEdge2.new(3, 2).sort.should eq UnweightedEdge2.new(2, 3)
  end

  it "#to_s" do
    UnweightedEdge2.new(2, 3).to_s.should eq "(2, 3)"
  end

  it "inspect" do
    UnweightedEdge2.new(2, 3).inspect.should eq "2->3"
  end
end

describe DirectedGraph do
  it ".new(size)" do
    g = DirectedGraph(Int32).new(5)
    g.size.should eq 5
    g.edges.should eq [] of Edge2(Int32)
    expect_raises(ArgumentError) { DirectedGraph(Int32).new(-2) }
  end

  it ".new(n, edges)" do
    edges = [Edge2.new(0, 1, 10), Edge2.new(1, 0, 11)]

    g = DirectedGraph.new 2, edges
    g.edges.should eq edges

    g = DirectedGraph.new 2, edges.values_at(0, 1)
    g.edges.should eq edges

    g = DirectedGraph.new 2, [{0, 1, 10}, {1, 0, 11}]
    g.edges.should eq edges

    expect_raises(IndexError) { DirectedGraph.new 1, [Edge2.new(0, 1, 10)] }
  end

  it "#add_edge, #add_edges" do
    g = DirectedGraph(Int32).new(5)
    edges = [
      Edge2.new(0, 1, 10), Edge2.new(0, 1, 11), Edge2.new(1, 2, 12),
      Edge2.new(2, 3, 13), Edge2.new(3, 4, 14),
    ]
    g.add_edge(edges[0])
    g.add_edge(0, 1, 11)
    g.add_edge({1, 2, 12})
    g.add_edges(edges[3..4])
    expect_raises(IndexError) { g.add_edge(4, 5, -1) }

    g[0].should eq [Edge.new(1, 10), Edge.new(1, 11)]
    g[1].should eq [Edge.new(2, 12)]
    g.edges.should eq edges
  end
end

describe UndirectedGraph do
  it "#.new(size)" do
    g = UndirectedGraph(Int32).new(5)
    g.size.should eq 5
    g.edges.should eq [] of Edge2(Int32)
    expect_raises(ArgumentError) { UndirectedGraph(Int32).new(-2) }
  end

  it ".new(n, edges)" do
    edges = [Edge2.new(0, 1, 10), Edge2.new(0, 1, 11), Edge2.new(1, 0, 10), Edge2.new(1, 0, 11)]
    g = UndirectedGraph.new 2, [edges[0], edges[3]]
    g.edges.should eq edges

    g = UndirectedGraph.new 2, edges.values_at(0, 3)
    g.edges.should eq edges

    g = UndirectedGraph.new 2, [{0, 1, 10}, {1, 0, 11}]
    g.edges.should eq edges

    expect_raises(IndexError) { UndirectedGraph.new 1, [Edge2.new(0, 1, 10)] }
  end

  it "#add_edge, #add_edges" do
    edges = [
      [Edge.new(1, 10)],
      [Edge.new(0, 10), Edge.new(2, 11)],
      [Edge.new(1, 11), Edge.new(3, 12)],
      [Edge.new(2, 12)],
    ]
    all_edges = [
      Edge2.new(0, 1, 10), Edge2.new(1, 0, 10),
      Edge2.new(1, 2, 11), Edge2.new(2, 1, 11),
      Edge2.new(2, 3, 12), Edge2.new(3, 2, 12),
    ]

    g = UndirectedGraph(Int32).new(4)
    g.add_edge(0, 1, 10)
    g.add_edge({1, 2, 11})
    g.add_edge(Edge2.new(2, 3, 12))
    g[0].should eq edges[0]
    g[1].should eq edges[1]
    g[2].should eq edges[2]
    g[3].should eq edges[3]
    g.edges.should eq all_edges

    g = UndirectedGraph(Int32).new(4)
    g.add_edges([{0, 1, 10}])
    g.add_edges({Edge2.new(1, 2, 11), Edge2.new(2, 3, 12)})
    g[0].should eq edges[0]
    g[1].should eq edges[1]
    g[2].should eq edges[2]
    g[3].should eq edges[3]
    g.edges.should eq all_edges
  end
end

describe UnweightedDirectedGraph do
  it ".new(size)" do
    g = UnweightedDirectedGraph.new(5)
    g.size.should eq 5
    g.edges.should eq [] of UnweightedEdge2
    expect_raises(ArgumentError) { UnweightedDirectedGraph.new(-2) }
  end

  it ".new(n, edges)" do
    edges = [UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1, 0)]

    g = UnweightedDirectedGraph.new 2, edges
    g.edges.should eq edges

    g = UnweightedDirectedGraph.new 2, edges.values_at(0, 1)
    g.edges.should eq edges

    g = UnweightedDirectedGraph.new 2, [{0, 1}, {1, 0}]
    g.edges.should eq edges

    expect_raises(IndexError) { UnweightedDirectedGraph.new 1, [UnweightedEdge2.new(0, 1)] }
  end

  it "#add_edge, #add_edges" do
    g = UnweightedDirectedGraph.new(5)
    edges = [
      UnweightedEdge2.new(0, 1), UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1, 2),
      UnweightedEdge2.new(2, 3), UnweightedEdge2.new(3, 4),
    ]
    g.add_edge(edges[0])
    g.add_edge(0, 1)
    g.add_edge({1, 2})
    g.add_edges(edges[3..4])
    expect_raises(IndexError) { g.add_edge(4, 5) }

    g[0].should eq [1, 1]
    g[1].should eq [2]
    g.edges.should eq edges
  end
end

describe UnweightedUndirectedGraph do
  it "#.new(size)" do
    g = UnweightedUndirectedGraph.new(5)
    g.size.should eq 5
    g.edges.should eq [] of UnweightedEdge2
    expect_raises(ArgumentError) { UnweightedUndirectedGraph.new(-2) }
  end

  it ".new(n, edges)" do
    edges = [UnweightedEdge2.new(0, 1), UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1, 0), UnweightedEdge2.new(1, 0)]
    g = UnweightedUndirectedGraph.new 2, [edges[0], edges[3]]
    g.edges.should eq edges

    g = UnweightedUndirectedGraph.new 2, edges.values_at(0, 3)
    g.edges.should eq edges

    g = UnweightedUndirectedGraph.new 2, [{0, 1}, {1, 0}]
    g.edges.should eq edges

    expect_raises(IndexError) { UnweightedUndirectedGraph.new 1, [UnweightedEdge2.new(0, 1)] }
  end

  it "#add_edge, #add_edges" do
    edges = [
      [1],
      [0, 2],
      [1, 3],
      [2],
    ]
    all_edges = [
      UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1, 0),
      UnweightedEdge2.new(1, 2), UnweightedEdge2.new(2, 1),
      UnweightedEdge2.new(2, 3), UnweightedEdge2.new(3, 2),
    ]

    g = UnweightedUndirectedGraph.new(4)
    g.add_edge(0, 1)
    g.add_edge({1, 2})
    g.add_edge(UnweightedEdge2.new(2, 3))
    g[0].should eq edges[0]
    g[1].should eq edges[1]
    g[2].should eq edges[2]
    g[3].should eq edges[3]
    g.edges.should eq all_edges

    g = UnweightedUndirectedGraph.new(4)
    g.add_edges([{0, 1}])
    g.add_edges({UnweightedEdge2.new(1, 2), UnweightedEdge2.new(2, 3)})
    g[0].should eq edges[0]
    g[1].should eq edges[1]
    g[2].should eq edges[2]
    g[3].should eq edges[3]
    g.edges.should eq all_edges
  end
end
