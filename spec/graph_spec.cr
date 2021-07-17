require "spec"
require "../src/graph"

describe DirectedGraph do
  it ".weighted?, .directed?" do
    DirectedGraph.weighted?.should be_true
    DirectedGraph.directed?.should be_true
  end

  it ".new(size)" do
    g = DirectedGraph(Int32).new(5)
    g.size.should eq 5
    g.to_a.should eq [] of WeightedEdge2(Int32)
    expect_raises(ArgumentError) { DirectedGraph(Int32).new(-2) }
  end

  it ".new(n, edges)" do
    edges = [WeightedEdge2.new(0, 1, 10), WeightedEdge2.new(1, 0, 11)]

    g = DirectedGraph.new 2, edges
    g.to_a.should eq edges

    g = DirectedGraph.new 2, edges.values_at(0, 1)
    g.to_a.should eq edges

    g = DirectedGraph.new 2, [{0, 1, 10}, {1, 0, 11}]
    g.to_a.should eq edges

    expect_raises(IndexError) { DirectedGraph.new 1, [WeightedEdge2.new(0, 1, 10)] }
  end

  it "#add_edge, #add_edges" do
    g = DirectedGraph(Int32).new(5)
    edges = [
      WeightedEdge2.new(0, 1, 10), WeightedEdge2.new(0, 1, 11), WeightedEdge2.new(1, 2, 12),
      WeightedEdge2.new(2, 3, 13), WeightedEdge2.new(3, 4, 14),
    ]
    g << (edges[0])
    g << {0, 1, 11}
    g << {1, 2, 12}
    g.add_edges(edges[3..4])
    expect_raises(IndexError) { g << {4, 5, -1} }

    g[0].should eq [WeightedEdge.new(1, 10), WeightedEdge.new(1, 11)]
    g[1].should eq [WeightedEdge.new(2, 12)]
    g.to_a.should eq edges
  end

  it "#reverse" do
    edges = [
      WeightedEdge2.new(0, 1, 10), WeightedEdge2.new(0, 1, 11), WeightedEdge2.new(1, 2, 12),
      WeightedEdge2.new(2, 3, 13), WeightedEdge2.new(3, 4, 14),
    ]
    g = DirectedGraph(Int32).new(5, edges)
    g.reverse.to_a.should eq edges.map(&.reverse)
  end

  it "#to_undirected" do
    edges = [
      WeightedEdge2.new(0, 1, 10), WeightedEdge2.new(0, 1, 11), WeightedEdge2.new(1, 2, 12),
      WeightedEdge2.new(2, 3, 13), WeightedEdge2.new(3, 4, 14),
    ]
    g = DirectedGraph(Int32).new(5, edges)
    g.to_undirected.to_set.should eq edges.flat_map { |e| [e, e.reverse] }.to_set
  end
end

describe UndirectedGraph do
  it ".weighted?, .directed?" do
    UndirectedGraph.weighted?.should be_true
    UndirectedGraph.directed?.should be_false
  end

  it "#.new(size)" do
    g = UndirectedGraph(Int32).new(5)
    g.size.should eq 5
    g.to_a.should eq [] of WeightedEdge2(Int32)
    expect_raises(ArgumentError) { UndirectedGraph(Int32).new(-2) }
  end

  it ".new(n, edges)" do
    edges = [WeightedEdge2.new(0, 1, 10), WeightedEdge2.new(0, 1, 11), WeightedEdge2.new(1, 0, 10), WeightedEdge2.new(1, 0, 11)]
    g = UndirectedGraph.new 2, [edges[0], edges[3]]
    g.to_a.should eq edges

    g = UndirectedGraph.new 2, edges.values_at(0, 3)
    g.to_a.should eq edges

    g = UndirectedGraph.new 2, [{0, 1, 10}, {1, 0, 11}]
    g.to_a.should eq edges

    expect_raises(IndexError) { UndirectedGraph.new 1, [WeightedEdge2.new(0, 1, 10)] }
  end

  it "#add_edge, #add_edges" do
    edges = [
      [WeightedEdge.new(1, 10)],
      [WeightedEdge.new(0, 10), WeightedEdge.new(2, 11)],
      [WeightedEdge.new(1, 11), WeightedEdge.new(3, 12)],
      [WeightedEdge.new(2, 12)],
    ]
    all_edges = [
      WeightedEdge2.new(0, 1, 10), WeightedEdge2.new(1, 0, 10),
      WeightedEdge2.new(1, 2, 11), WeightedEdge2.new(2, 1, 11),
      WeightedEdge2.new(2, 3, 12), WeightedEdge2.new(3, 2, 12),
    ]

    g = UndirectedGraph(Int32).new(4)
    g << {0, 1, 10}
    g << {1, 2, 11}
    g << WeightedEdge2.new(2, 3, 12)
    g[0].should eq edges[0]
    g[1].should eq edges[1]
    g[2].should eq edges[2]
    g[3].should eq edges[3]
    g.to_a.should eq all_edges

    g = UndirectedGraph(Int32).new(4)
    g.add_edges([{0, 1, 10}])
    g.add_edges({WeightedEdge2.new(1, 2, 11), WeightedEdge2.new(2, 3, 12)})
    g[0].should eq edges[0]
    g[1].should eq edges[1]
    g[2].should eq edges[2]
    g[3].should eq edges[3]
    g.to_a.should eq all_edges
  end

  it "#reverse" do
    all_edges = [
      WeightedEdge2.new(0, 1, 10), WeightedEdge2.new(1, 0, 10),
      WeightedEdge2.new(1, 2, 11), WeightedEdge2.new(2, 1, 11),
      WeightedEdge2.new(2, 3, 12), WeightedEdge2.new(3, 2, 12),
    ]

    g = UndirectedGraph(Int32).new(4)
    g << {0, 1, 10} << {1, 2, 11} << {2, 3, 12}
    g.reverse.to_set.should eq all_edges.map(&.reverse).to_set
  end

  it "#to_undirected" do
    all_edges = [
      WeightedEdge2.new(0, 1, 10), WeightedEdge2.new(1, 0, 10),
      WeightedEdge2.new(1, 2, 11), WeightedEdge2.new(2, 1, 11),
      WeightedEdge2.new(2, 3, 12), WeightedEdge2.new(3, 2, 12),
    ]

    g = UndirectedGraph(Int32).new(4)
    g << {0, 1, 10} << {1, 2, 11} << {2, 3, 12}
    g.to_undirected.to_set.should eq all_edges.map(&.reverse).to_set
  end
end

describe UnweightedDirectedGraph do
  it ".weighted?, .directed?" do
    UnweightedDirectedGraph.weighted?.should be_false
    UnweightedDirectedGraph.directed?.should be_true
  end

  it ".new(size)" do
    g = UnweightedDirectedGraph.new(5)
    g.size.should eq 5
    g.to_a.should eq [] of UnweightedEdge2
    expect_raises(ArgumentError) { UnweightedDirectedGraph.new(-2) }
  end

  it ".new(n, edges)" do
    edges = [UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1, 0)]

    g = UnweightedDirectedGraph.new 2, edges
    g.to_a.should eq edges

    g = UnweightedDirectedGraph.new 2, edges.values_at(0, 1)
    g.to_a.should eq edges

    g = UnweightedDirectedGraph.new 2, [{0, 1}, {1, 0}]
    g.to_a.should eq edges

    expect_raises(IndexError) { UnweightedDirectedGraph.new 1, [UnweightedEdge2.new(0, 1)] }
  end

  it "#add_edge, #add_edges" do
    g = UnweightedDirectedGraph.new(5)
    edges = [
      UnweightedEdge2.new(0, 1), UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1, 2),
      UnweightedEdge2.new(2, 3), UnweightedEdge2.new(3, 4),
    ]
    g << edges[0]
    g << {0, 1}
    g << {1, 2}
    g.add_edges(edges[3..4])
    expect_raises(IndexError) { g << {4, 5} }

    g[0].should eq [UnweightedEdge.new(1), UnweightedEdge.new(1)]
    g[1].should eq [UnweightedEdge.new(2)]
    g.to_a.should eq edges
  end

  it "#reverse" do
    edges = [
      UnweightedEdge2.new(0, 1), UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1, 2),
      UnweightedEdge2.new(2, 3), UnweightedEdge2.new(3, 4),
    ]
    g = UnweightedDirectedGraph.new(5, edges)
    g.reverse.to_a.should eq edges.map(&.reverse)
  end

  it "#to_undirected" do
    edges = [
      UnweightedEdge2.new(0, 1), UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1, 2),
      UnweightedEdge2.new(2, 3), UnweightedEdge2.new(3, 4),
    ]
    g = UnweightedDirectedGraph.new(5, edges)
    g.to_undirected.to_set.should eq edges.flat_map { |e| [e, e.reverse] }.to_set
  end
end

describe UnweightedUndirectedGraph do
  it ".weighted?, .directed?" do
    UnweightedUndirectedGraph.weighted?.should be_false
    UnweightedUndirectedGraph.directed?.should be_false
  end

  it "#.new(size)" do
    g = UnweightedUndirectedGraph.new(5)
    g.size.should eq 5
    g.to_a.should eq [] of UnweightedEdge2
    expect_raises(ArgumentError) { UnweightedUndirectedGraph.new(-2) }
  end

  it ".new(n, edges)" do
    edges = [UnweightedEdge2.new(0, 1), UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1, 0), UnweightedEdge2.new(1, 0)]
    g = UnweightedUndirectedGraph.new 2, [edges[0], edges[3]]
    g.to_a.should eq edges

    g = UnweightedUndirectedGraph.new 2, edges.values_at(0, 3)
    g.to_a.should eq edges

    g = UnweightedUndirectedGraph.new 2, [{0, 1}, {1, 0}]
    g.to_a.should eq edges

    expect_raises(IndexError) { UnweightedUndirectedGraph.new 1, [UnweightedEdge2.new(0, 1)] }
  end

  it "#add_edge, #add_edges" do
    edges = [
      [UnweightedEdge.new(1)],
      [UnweightedEdge.new(0), UnweightedEdge.new(2)],
      [UnweightedEdge.new(1), UnweightedEdge.new(3)],
      [UnweightedEdge.new(2)],
    ]
    all_edges = [
      UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1, 0),
      UnweightedEdge2.new(1, 2), UnweightedEdge2.new(2, 1),
      UnweightedEdge2.new(2, 3), UnweightedEdge2.new(3, 2),
    ]

    g = UnweightedUndirectedGraph.new(4)
    g << {0, 1}
    g << {1, 2}
    g << UnweightedEdge2.new(2, 3)
    g[0].should eq edges[0]
    g[1].should eq edges[1]
    g[2].should eq edges[2]
    g[3].should eq edges[3]
    g.to_a.should eq all_edges

    g = UnweightedUndirectedGraph.new(4)
    g.add_edges([{0, 1}])
    g.add_edges({UnweightedEdge2.new(1, 2), UnweightedEdge2.new(2, 3)})
    g[0].should eq edges[0]
    g[1].should eq edges[1]
    g[2].should eq edges[2]
    g[3].should eq edges[3]
    g.to_a.should eq all_edges
  end

  it "#reverse" do
    all_edges = [
      UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1, 0),
      UnweightedEdge2.new(1, 2), UnweightedEdge2.new(2, 1),
      UnweightedEdge2.new(2, 3), UnweightedEdge2.new(3, 2),
    ]

    g = UnweightedUndirectedGraph.new(4)
    g << {0, 1} << {1, 2} << {2, 3}
    g.reverse.to_set.should eq all_edges.to_set
  end

  it "#to_undirected" do
    all_edges = [
      UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1, 0),
      UnweightedEdge2.new(1, 2), UnweightedEdge2.new(2, 1),
      UnweightedEdge2.new(2, 3), UnweightedEdge2.new(3, 2),
    ]

    g = UnweightedUndirectedGraph.new(4)
    g << {0, 1} << {1, 2} << {2, 3}
    g.to_undirected.to_set.should eq all_edges.to_set
  end
end
