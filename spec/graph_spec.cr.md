---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: src/graph.cr
    title: src/graph.cr
  - icon: ':question:'
    path: src/graph/edge.cr
    title: src/graph/edge.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../src/graph\"\n# require \"./graph/edge\"\
    \nstruct WeightedEdge(T)\n  include Comparable(WeightedEdge(T))\n\n  property\
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
    \  def inspect(io) : Nil\n    io << from << \"->\" << to\n  end\nend\n\nmodule\
    \ Graph(Edge, Edge2)\n  include Enumerable(Edge2)\n\n  getter graph : Array(Array(Edge))\n\
    \n  def initialize(size : Int)\n    @graph = Array(Array(Edge)).new(size) { []\
    \ of Edge }\n  end\n\n  def initialize(size : Int, edges : Enumerable)\n    initialize(size)\n\
    \    add_edges(edges)\n  end\n\n  # Add *edge*.\n  abstract def <<(edge : Edge2)\n\
    \n  # :ditto:\n  def <<(edge : Tuple)\n    self << Edge2.new(*edge)\n  end\n\n\
    \  def add_edges(edges : Enumerable)\n    edges.each { |edge| self << edge }\n\
    \  end\n\n  delegate size, to: @graph\n  delegate :[], to: @graph\n\n  # Yields\
    \ each edge of the graph, ans returns `nil`.\n  def each(&) : Nil\n    (0...size).each\
    \ do |v|\n      self[v].each do |edge|\n        yield Edge2.new(v, edge)\n   \
    \   end\n    end\n  end\n\n  def reverse\n    if self.class.directed?\n      each_with_object(self.class.new(size))\
    \ do |edge, reversed|\n        reversed << edge.reverse\n      end\n    else\n\
    \      dup\n    end\n  end\n\n  def to_undirected\n    if self.class.directed?\n\
    \      each_with_object(self.class.new(size)) do |edge, graph|\n        graph\
    \ << edge\n        graph << edge.reverse if self.class.directed?\n      end\n\
    \    else\n      dup\n    end\n  end\n\n  def to_s(io : IO) : Nil\n    io << '['\n\
    \    join(\", \", io) do |edge, io|\n      edge.inspect io\n    end\n    io <<\
    \ ']'\n  end\n\n  def inspect(io : IO) : Nil\n    io << \"[\\n\"\n    graph.each\
    \ do |edges|\n      io << \"  \" << edges << \",\\n\"\n    end\n    io << ']'\n\
    \  end\nend\n\nclass DirectedGraph(T)\n  include Graph(WeightedEdge(T), WeightedEdge2(T))\n\
    \n  def initialize(size : Int)\n    super\n  end\n\n  def initialize(size : Int,\
    \ edges : Enumerable(WeightedEdge2(T)))\n    super\n  end\n\n  def initialize(size\
    \ : Int, edges : Enumerable({Int32, Int32, T}))\n    super\n  end\n\n  def <<(edge\
    \ : WeightedEdge2(T))\n    raise IndexError.new unless 0 <= edge.from < size &&\
    \ 0 <= edge.to < size\n    @graph[edge.from] << WeightedEdge.new(edge.to, edge.cost)\n\
    \    self\n  end\n\n  def self.weighted?\n    true\n  end\n\n  def self.directed?\n\
    \    true\n  end\nend\n\nclass UndirectedGraph(T)\n  include Graph(WeightedEdge(T),\
    \ WeightedEdge2(T))\n\n  def initialize(size : Int)\n    super\n  end\n\n  def\
    \ initialize(size : Int, edges : Enumerable(WeightedEdge2(T)))\n    super\n  end\n\
    \n  def initialize(size : Int, edges : Enumerable({Int32, Int32, T}))\n    super\n\
    \  end\n\n  def <<(edge : WeightedEdge2(T))\n    raise IndexError.new unless 0\
    \ <= edge.from < size && 0 <= edge.to < size\n    @graph[edge.from] << WeightedEdge.new(edge.to,\
    \ edge.cost)\n    @graph[edge.to] << WeightedEdge.new(edge.from, edge.cost)\n\
    \    self\n  end\n\n  def self.weighted?\n    true\n  end\n\n  def self.directed?\n\
    \    false\n  end\nend\n\nclass UnweightedDirectedGraph\n  include Graph(UnweightedEdge,\
    \ UnweightedEdge2)\n\n  def initialize(size : Int)\n    super\n  end\n\n  def\
    \ initialize(size : Int, edges : Enumerable)\n    super\n  end\n\n  def <<(edge\
    \ : UnweightedEdge2)\n    raise IndexError.new unless 0 <= edge.from < size &&\
    \ 0 <= edge.to < size\n    @graph[edge.from] << UnweightedEdge.new(edge.to)\n\
    \    self\n  end\n\n  def self.weighted?\n    false\n  end\n\n  def self.directed?\n\
    \    true\n  end\nend\n\nclass UnweightedUndirectedGraph\n  include Graph(UnweightedEdge,\
    \ UnweightedEdge2)\n\n  def initialize(size : Int)\n    super\n  end\n\n  def\
    \ initialize(size : Int, edges : Enumerable)\n    super\n  end\n\n  def <<(edge\
    \ : UnweightedEdge2)\n    raise IndexError.new unless 0 <= edge.from < size &&\
    \ 0 <= edge.to < size\n    @graph[edge.from] << UnweightedEdge.new(edge.to)\n\
    \    @graph[edge.to] << UnweightedEdge.new(edge.from)\n    self\n  end\n\n  def\
    \ each_child(vertex : Int, parent, &block) : Nil\n    graph[vertex].each do |u|\n\
    \      yield u if u != parent\n    end\n  end\n\n  def each_child(vertex : Int,\
    \ parent)\n    graph[vertex].each.select { |u| u != parent }\n  end\n\n  def self.weighted?\n\
    \    false\n  end\n\n  def self.directed?\n    false\n  end\nend\n\ndescribe DirectedGraph\
    \ do\n  it \".weighted?, .directed?\" do\n    DirectedGraph.weighted?.should be_true\n\
    \    DirectedGraph.directed?.should be_true\n  end\n\n  it \".new(size)\" do\n\
    \    g = DirectedGraph(Int32).new(5)\n    g.size.should eq 5\n    g.to_a.should\
    \ eq [] of WeightedEdge2(Int32)\n    expect_raises(ArgumentError) { DirectedGraph(Int32).new(-2)\
    \ }\n  end\n\n  it \".new(n, edges)\" do\n    edges = [WeightedEdge2.new(0, 1,\
    \ 10), WeightedEdge2.new(1, 0, 11)]\n\n    g = DirectedGraph.new 2, edges\n  \
    \  g.to_a.should eq edges\n\n    g = DirectedGraph.new 2, edges.values_at(0, 1)\n\
    \    g.to_a.should eq edges\n\n    g = DirectedGraph.new 2, [{0, 1, 10}, {1, 0,\
    \ 11}]\n    g.to_a.should eq edges\n\n    expect_raises(IndexError) { DirectedGraph.new\
    \ 1, [WeightedEdge2.new(0, 1, 10)] }\n  end\n\n  it \"#add_edge, #add_edges\"\
    \ do\n    g = DirectedGraph(Int32).new(5)\n    edges = [\n      WeightedEdge2.new(0,\
    \ 1, 10), WeightedEdge2.new(0, 1, 11), WeightedEdge2.new(1, 2, 12),\n      WeightedEdge2.new(2,\
    \ 3, 13), WeightedEdge2.new(3, 4, 14),\n    ]\n    g << (edges[0])\n    g << {0,\
    \ 1, 11}\n    g << {1, 2, 12}\n    g.add_edges(edges[3..4])\n    expect_raises(IndexError)\
    \ { g << {4, 5, -1} }\n\n    g[0].should eq [WeightedEdge.new(1, 10), WeightedEdge.new(1,\
    \ 11)]\n    g[1].should eq [WeightedEdge.new(2, 12)]\n    g.to_a.should eq edges\n\
    \  end\n\n  it \"#reverse\" do\n    edges = [\n      WeightedEdge2.new(0, 1, 10),\
    \ WeightedEdge2.new(0, 1, 11), WeightedEdge2.new(1, 2, 12),\n      WeightedEdge2.new(2,\
    \ 3, 13), WeightedEdge2.new(3, 4, 14),\n    ]\n    g = DirectedGraph(Int32).new(5,\
    \ edges)\n    g.reverse.to_a.should eq edges.map(&.reverse)\n  end\n\n  it \"\
    #to_undirected\" do\n    edges = [\n      WeightedEdge2.new(0, 1, 10), WeightedEdge2.new(0,\
    \ 1, 11), WeightedEdge2.new(1, 2, 12),\n      WeightedEdge2.new(2, 3, 13), WeightedEdge2.new(3,\
    \ 4, 14),\n    ]\n    g = DirectedGraph(Int32).new(5, edges)\n    g.to_undirected.to_set.should\
    \ eq edges.flat_map { |e| [e, e.reverse] }.to_set\n  end\nend\n\ndescribe UndirectedGraph\
    \ do\n  it \".weighted?, .directed?\" do\n    UndirectedGraph.weighted?.should\
    \ be_true\n    UndirectedGraph.directed?.should be_false\n  end\n\n  it \"#.new(size)\"\
    \ do\n    g = UndirectedGraph(Int32).new(5)\n    g.size.should eq 5\n    g.to_a.should\
    \ eq [] of WeightedEdge2(Int32)\n    expect_raises(ArgumentError) { UndirectedGraph(Int32).new(-2)\
    \ }\n  end\n\n  it \".new(n, edges)\" do\n    edges = [WeightedEdge2.new(0, 1,\
    \ 10), WeightedEdge2.new(0, 1, 11), WeightedEdge2.new(1, 0, 10), WeightedEdge2.new(1,\
    \ 0, 11)]\n    g = UndirectedGraph.new 2, [edges[0], edges[3]]\n    g.to_a.should\
    \ eq edges\n\n    g = UndirectedGraph.new 2, edges.values_at(0, 3)\n    g.to_a.should\
    \ eq edges\n\n    g = UndirectedGraph.new 2, [{0, 1, 10}, {1, 0, 11}]\n    g.to_a.should\
    \ eq edges\n\n    expect_raises(IndexError) { UndirectedGraph.new 1, [WeightedEdge2.new(0,\
    \ 1, 10)] }\n  end\n\n  it \"#add_edge, #add_edges\" do\n    edges = [\n     \
    \ [WeightedEdge.new(1, 10)],\n      [WeightedEdge.new(0, 10), WeightedEdge.new(2,\
    \ 11)],\n      [WeightedEdge.new(1, 11), WeightedEdge.new(3, 12)],\n      [WeightedEdge.new(2,\
    \ 12)],\n    ]\n    all_edges = [\n      WeightedEdge2.new(0, 1, 10), WeightedEdge2.new(1,\
    \ 0, 10),\n      WeightedEdge2.new(1, 2, 11), WeightedEdge2.new(2, 1, 11),\n \
    \     WeightedEdge2.new(2, 3, 12), WeightedEdge2.new(3, 2, 12),\n    ]\n\n   \
    \ g = UndirectedGraph(Int32).new(4)\n    g << {0, 1, 10}\n    g << {1, 2, 11}\n\
    \    g << WeightedEdge2.new(2, 3, 12)\n    g[0].should eq edges[0]\n    g[1].should\
    \ eq edges[1]\n    g[2].should eq edges[2]\n    g[3].should eq edges[3]\n    g.to_a.should\
    \ eq all_edges\n\n    g = UndirectedGraph(Int32).new(4)\n    g.add_edges([{0,\
    \ 1, 10}])\n    g.add_edges({WeightedEdge2.new(1, 2, 11), WeightedEdge2.new(2,\
    \ 3, 12)})\n    g[0].should eq edges[0]\n    g[1].should eq edges[1]\n    g[2].should\
    \ eq edges[2]\n    g[3].should eq edges[3]\n    g.to_a.should eq all_edges\n \
    \ end\n\n  it \"#reverse\" do\n    all_edges = [\n      WeightedEdge2.new(0, 1,\
    \ 10), WeightedEdge2.new(1, 0, 10),\n      WeightedEdge2.new(1, 2, 11), WeightedEdge2.new(2,\
    \ 1, 11),\n      WeightedEdge2.new(2, 3, 12), WeightedEdge2.new(3, 2, 12),\n \
    \   ]\n\n    g = UndirectedGraph(Int32).new(4)\n    g << {0, 1, 10} << {1, 2,\
    \ 11} << {2, 3, 12}\n    g.reverse.to_set.should eq all_edges.map(&.reverse).to_set\n\
    \  end\n\n  it \"#to_undirected\" do\n    all_edges = [\n      WeightedEdge2.new(0,\
    \ 1, 10), WeightedEdge2.new(1, 0, 10),\n      WeightedEdge2.new(1, 2, 11), WeightedEdge2.new(2,\
    \ 1, 11),\n      WeightedEdge2.new(2, 3, 12), WeightedEdge2.new(3, 2, 12),\n \
    \   ]\n\n    g = UndirectedGraph(Int32).new(4)\n    g << {0, 1, 10} << {1, 2,\
    \ 11} << {2, 3, 12}\n    g.to_undirected.to_set.should eq all_edges.map(&.reverse).to_set\n\
    \  end\nend\n\ndescribe UnweightedDirectedGraph do\n  it \".weighted?, .directed?\"\
    \ do\n    UnweightedDirectedGraph.weighted?.should be_false\n    UnweightedDirectedGraph.directed?.should\
    \ be_true\n  end\n\n  it \".new(size)\" do\n    g = UnweightedDirectedGraph.new(5)\n\
    \    g.size.should eq 5\n    g.to_a.should eq [] of UnweightedEdge2\n    expect_raises(ArgumentError)\
    \ { UnweightedDirectedGraph.new(-2) }\n  end\n\n  it \".new(n, edges)\" do\n \
    \   edges = [UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1, 0)]\n\n    g =\
    \ UnweightedDirectedGraph.new 2, edges\n    g.to_a.should eq edges\n\n    g =\
    \ UnweightedDirectedGraph.new 2, edges.values_at(0, 1)\n    g.to_a.should eq edges\n\
    \n    g = UnweightedDirectedGraph.new 2, [{0, 1}, {1, 0}]\n    g.to_a.should eq\
    \ edges\n\n    expect_raises(IndexError) { UnweightedDirectedGraph.new 1, [UnweightedEdge2.new(0,\
    \ 1)] }\n  end\n\n  it \"#add_edge, #add_edges\" do\n    g = UnweightedDirectedGraph.new(5)\n\
    \    edges = [\n      UnweightedEdge2.new(0, 1), UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1,\
    \ 2),\n      UnweightedEdge2.new(2, 3), UnweightedEdge2.new(3, 4),\n    ]\n  \
    \  g << edges[0]\n    g << {0, 1}\n    g << {1, 2}\n    g.add_edges(edges[3..4])\n\
    \    expect_raises(IndexError) { g << {4, 5} }\n\n    g[0].should eq [UnweightedEdge.new(1),\
    \ UnweightedEdge.new(1)]\n    g[1].should eq [UnweightedEdge.new(2)]\n    g.to_a.should\
    \ eq edges\n  end\n\n  it \"#reverse\" do\n    edges = [\n      UnweightedEdge2.new(0,\
    \ 1), UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1, 2),\n      UnweightedEdge2.new(2,\
    \ 3), UnweightedEdge2.new(3, 4),\n    ]\n    g = UnweightedDirectedGraph.new(5,\
    \ edges)\n    g.reverse.to_a.should eq edges.map(&.reverse)\n  end\n\n  it \"\
    #to_undirected\" do\n    edges = [\n      UnweightedEdge2.new(0, 1), UnweightedEdge2.new(0,\
    \ 1), UnweightedEdge2.new(1, 2),\n      UnweightedEdge2.new(2, 3), UnweightedEdge2.new(3,\
    \ 4),\n    ]\n    g = UnweightedDirectedGraph.new(5, edges)\n    g.to_undirected.to_set.should\
    \ eq edges.flat_map { |e| [e, e.reverse] }.to_set\n  end\nend\n\ndescribe UnweightedUndirectedGraph\
    \ do\n  it \".weighted?, .directed?\" do\n    UnweightedUndirectedGraph.weighted?.should\
    \ be_false\n    UnweightedUndirectedGraph.directed?.should be_false\n  end\n\n\
    \  it \"#.new(size)\" do\n    g = UnweightedUndirectedGraph.new(5)\n    g.size.should\
    \ eq 5\n    g.to_a.should eq [] of UnweightedEdge2\n    expect_raises(ArgumentError)\
    \ { UnweightedUndirectedGraph.new(-2) }\n  end\n\n  it \".new(n, edges)\" do\n\
    \    edges = [UnweightedEdge2.new(0, 1), UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1,\
    \ 0), UnweightedEdge2.new(1, 0)]\n    g = UnweightedUndirectedGraph.new 2, [edges[0],\
    \ edges[3]]\n    g.to_a.should eq edges\n\n    g = UnweightedUndirectedGraph.new\
    \ 2, edges.values_at(0, 3)\n    g.to_a.should eq edges\n\n    g = UnweightedUndirectedGraph.new\
    \ 2, [{0, 1}, {1, 0}]\n    g.to_a.should eq edges\n\n    expect_raises(IndexError)\
    \ { UnweightedUndirectedGraph.new 1, [UnweightedEdge2.new(0, 1)] }\n  end\n\n\
    \  it \"#add_edge, #add_edges\" do\n    edges = [\n      [UnweightedEdge.new(1)],\n\
    \      [UnweightedEdge.new(0), UnweightedEdge.new(2)],\n      [UnweightedEdge.new(1),\
    \ UnweightedEdge.new(3)],\n      [UnweightedEdge.new(2)],\n    ]\n    all_edges\
    \ = [\n      UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1, 0),\n      UnweightedEdge2.new(1,\
    \ 2), UnweightedEdge2.new(2, 1),\n      UnweightedEdge2.new(2, 3), UnweightedEdge2.new(3,\
    \ 2),\n    ]\n\n    g = UnweightedUndirectedGraph.new(4)\n    g << {0, 1}\n  \
    \  g << {1, 2}\n    g << UnweightedEdge2.new(2, 3)\n    g[0].should eq edges[0]\n\
    \    g[1].should eq edges[1]\n    g[2].should eq edges[2]\n    g[3].should eq\
    \ edges[3]\n    g.to_a.should eq all_edges\n\n    g = UnweightedUndirectedGraph.new(4)\n\
    \    g.add_edges([{0, 1}])\n    g.add_edges({UnweightedEdge2.new(1, 2), UnweightedEdge2.new(2,\
    \ 3)})\n    g[0].should eq edges[0]\n    g[1].should eq edges[1]\n    g[2].should\
    \ eq edges[2]\n    g[3].should eq edges[3]\n    g.to_a.should eq all_edges\n \
    \ end\n\n  it \"#reverse\" do\n    all_edges = [\n      UnweightedEdge2.new(0,\
    \ 1), UnweightedEdge2.new(1, 0),\n      UnweightedEdge2.new(1, 2), UnweightedEdge2.new(2,\
    \ 1),\n      UnweightedEdge2.new(2, 3), UnweightedEdge2.new(3, 2),\n    ]\n\n\
    \    g = UnweightedUndirectedGraph.new(4)\n    g << {0, 1} << {1, 2} << {2, 3}\n\
    \    g.reverse.to_set.should eq all_edges.to_set\n  end\n\n  it \"#to_undirected\"\
    \ do\n    all_edges = [\n      UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1,\
    \ 0),\n      UnweightedEdge2.new(1, 2), UnweightedEdge2.new(2, 1),\n      UnweightedEdge2.new(2,\
    \ 3), UnweightedEdge2.new(3, 2),\n    ]\n\n    g = UnweightedUndirectedGraph.new(4)\n\
    \    g << {0, 1} << {1, 2} << {2, 3}\n    g.to_undirected.to_set.should eq all_edges.to_set\n\
    \  end\nend\n"
  code: "require \"spec\"\nrequire \"../src/graph\"\n\ndescribe DirectedGraph do\n\
    \  it \".weighted?, .directed?\" do\n    DirectedGraph.weighted?.should be_true\n\
    \    DirectedGraph.directed?.should be_true\n  end\n\n  it \".new(size)\" do\n\
    \    g = DirectedGraph(Int32).new(5)\n    g.size.should eq 5\n    g.to_a.should\
    \ eq [] of WeightedEdge2(Int32)\n    expect_raises(ArgumentError) { DirectedGraph(Int32).new(-2)\
    \ }\n  end\n\n  it \".new(n, edges)\" do\n    edges = [WeightedEdge2.new(0, 1,\
    \ 10), WeightedEdge2.new(1, 0, 11)]\n\n    g = DirectedGraph.new 2, edges\n  \
    \  g.to_a.should eq edges\n\n    g = DirectedGraph.new 2, edges.values_at(0, 1)\n\
    \    g.to_a.should eq edges\n\n    g = DirectedGraph.new 2, [{0, 1, 10}, {1, 0,\
    \ 11}]\n    g.to_a.should eq edges\n\n    expect_raises(IndexError) { DirectedGraph.new\
    \ 1, [WeightedEdge2.new(0, 1, 10)] }\n  end\n\n  it \"#add_edge, #add_edges\"\
    \ do\n    g = DirectedGraph(Int32).new(5)\n    edges = [\n      WeightedEdge2.new(0,\
    \ 1, 10), WeightedEdge2.new(0, 1, 11), WeightedEdge2.new(1, 2, 12),\n      WeightedEdge2.new(2,\
    \ 3, 13), WeightedEdge2.new(3, 4, 14),\n    ]\n    g << (edges[0])\n    g << {0,\
    \ 1, 11}\n    g << {1, 2, 12}\n    g.add_edges(edges[3..4])\n    expect_raises(IndexError)\
    \ { g << {4, 5, -1} }\n\n    g[0].should eq [WeightedEdge.new(1, 10), WeightedEdge.new(1,\
    \ 11)]\n    g[1].should eq [WeightedEdge.new(2, 12)]\n    g.to_a.should eq edges\n\
    \  end\n\n  it \"#reverse\" do\n    edges = [\n      WeightedEdge2.new(0, 1, 10),\
    \ WeightedEdge2.new(0, 1, 11), WeightedEdge2.new(1, 2, 12),\n      WeightedEdge2.new(2,\
    \ 3, 13), WeightedEdge2.new(3, 4, 14),\n    ]\n    g = DirectedGraph(Int32).new(5,\
    \ edges)\n    g.reverse.to_a.should eq edges.map(&.reverse)\n  end\n\n  it \"\
    #to_undirected\" do\n    edges = [\n      WeightedEdge2.new(0, 1, 10), WeightedEdge2.new(0,\
    \ 1, 11), WeightedEdge2.new(1, 2, 12),\n      WeightedEdge2.new(2, 3, 13), WeightedEdge2.new(3,\
    \ 4, 14),\n    ]\n    g = DirectedGraph(Int32).new(5, edges)\n    g.to_undirected.to_set.should\
    \ eq edges.flat_map { |e| [e, e.reverse] }.to_set\n  end\nend\n\ndescribe UndirectedGraph\
    \ do\n  it \".weighted?, .directed?\" do\n    UndirectedGraph.weighted?.should\
    \ be_true\n    UndirectedGraph.directed?.should be_false\n  end\n\n  it \"#.new(size)\"\
    \ do\n    g = UndirectedGraph(Int32).new(5)\n    g.size.should eq 5\n    g.to_a.should\
    \ eq [] of WeightedEdge2(Int32)\n    expect_raises(ArgumentError) { UndirectedGraph(Int32).new(-2)\
    \ }\n  end\n\n  it \".new(n, edges)\" do\n    edges = [WeightedEdge2.new(0, 1,\
    \ 10), WeightedEdge2.new(0, 1, 11), WeightedEdge2.new(1, 0, 10), WeightedEdge2.new(1,\
    \ 0, 11)]\n    g = UndirectedGraph.new 2, [edges[0], edges[3]]\n    g.to_a.should\
    \ eq edges\n\n    g = UndirectedGraph.new 2, edges.values_at(0, 3)\n    g.to_a.should\
    \ eq edges\n\n    g = UndirectedGraph.new 2, [{0, 1, 10}, {1, 0, 11}]\n    g.to_a.should\
    \ eq edges\n\n    expect_raises(IndexError) { UndirectedGraph.new 1, [WeightedEdge2.new(0,\
    \ 1, 10)] }\n  end\n\n  it \"#add_edge, #add_edges\" do\n    edges = [\n     \
    \ [WeightedEdge.new(1, 10)],\n      [WeightedEdge.new(0, 10), WeightedEdge.new(2,\
    \ 11)],\n      [WeightedEdge.new(1, 11), WeightedEdge.new(3, 12)],\n      [WeightedEdge.new(2,\
    \ 12)],\n    ]\n    all_edges = [\n      WeightedEdge2.new(0, 1, 10), WeightedEdge2.new(1,\
    \ 0, 10),\n      WeightedEdge2.new(1, 2, 11), WeightedEdge2.new(2, 1, 11),\n \
    \     WeightedEdge2.new(2, 3, 12), WeightedEdge2.new(3, 2, 12),\n    ]\n\n   \
    \ g = UndirectedGraph(Int32).new(4)\n    g << {0, 1, 10}\n    g << {1, 2, 11}\n\
    \    g << WeightedEdge2.new(2, 3, 12)\n    g[0].should eq edges[0]\n    g[1].should\
    \ eq edges[1]\n    g[2].should eq edges[2]\n    g[3].should eq edges[3]\n    g.to_a.should\
    \ eq all_edges\n\n    g = UndirectedGraph(Int32).new(4)\n    g.add_edges([{0,\
    \ 1, 10}])\n    g.add_edges({WeightedEdge2.new(1, 2, 11), WeightedEdge2.new(2,\
    \ 3, 12)})\n    g[0].should eq edges[0]\n    g[1].should eq edges[1]\n    g[2].should\
    \ eq edges[2]\n    g[3].should eq edges[3]\n    g.to_a.should eq all_edges\n \
    \ end\n\n  it \"#reverse\" do\n    all_edges = [\n      WeightedEdge2.new(0, 1,\
    \ 10), WeightedEdge2.new(1, 0, 10),\n      WeightedEdge2.new(1, 2, 11), WeightedEdge2.new(2,\
    \ 1, 11),\n      WeightedEdge2.new(2, 3, 12), WeightedEdge2.new(3, 2, 12),\n \
    \   ]\n\n    g = UndirectedGraph(Int32).new(4)\n    g << {0, 1, 10} << {1, 2,\
    \ 11} << {2, 3, 12}\n    g.reverse.to_set.should eq all_edges.map(&.reverse).to_set\n\
    \  end\n\n  it \"#to_undirected\" do\n    all_edges = [\n      WeightedEdge2.new(0,\
    \ 1, 10), WeightedEdge2.new(1, 0, 10),\n      WeightedEdge2.new(1, 2, 11), WeightedEdge2.new(2,\
    \ 1, 11),\n      WeightedEdge2.new(2, 3, 12), WeightedEdge2.new(3, 2, 12),\n \
    \   ]\n\n    g = UndirectedGraph(Int32).new(4)\n    g << {0, 1, 10} << {1, 2,\
    \ 11} << {2, 3, 12}\n    g.to_undirected.to_set.should eq all_edges.map(&.reverse).to_set\n\
    \  end\nend\n\ndescribe UnweightedDirectedGraph do\n  it \".weighted?, .directed?\"\
    \ do\n    UnweightedDirectedGraph.weighted?.should be_false\n    UnweightedDirectedGraph.directed?.should\
    \ be_true\n  end\n\n  it \".new(size)\" do\n    g = UnweightedDirectedGraph.new(5)\n\
    \    g.size.should eq 5\n    g.to_a.should eq [] of UnweightedEdge2\n    expect_raises(ArgumentError)\
    \ { UnweightedDirectedGraph.new(-2) }\n  end\n\n  it \".new(n, edges)\" do\n \
    \   edges = [UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1, 0)]\n\n    g =\
    \ UnweightedDirectedGraph.new 2, edges\n    g.to_a.should eq edges\n\n    g =\
    \ UnweightedDirectedGraph.new 2, edges.values_at(0, 1)\n    g.to_a.should eq edges\n\
    \n    g = UnweightedDirectedGraph.new 2, [{0, 1}, {1, 0}]\n    g.to_a.should eq\
    \ edges\n\n    expect_raises(IndexError) { UnweightedDirectedGraph.new 1, [UnweightedEdge2.new(0,\
    \ 1)] }\n  end\n\n  it \"#add_edge, #add_edges\" do\n    g = UnweightedDirectedGraph.new(5)\n\
    \    edges = [\n      UnweightedEdge2.new(0, 1), UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1,\
    \ 2),\n      UnweightedEdge2.new(2, 3), UnweightedEdge2.new(3, 4),\n    ]\n  \
    \  g << edges[0]\n    g << {0, 1}\n    g << {1, 2}\n    g.add_edges(edges[3..4])\n\
    \    expect_raises(IndexError) { g << {4, 5} }\n\n    g[0].should eq [UnweightedEdge.new(1),\
    \ UnweightedEdge.new(1)]\n    g[1].should eq [UnweightedEdge.new(2)]\n    g.to_a.should\
    \ eq edges\n  end\n\n  it \"#reverse\" do\n    edges = [\n      UnweightedEdge2.new(0,\
    \ 1), UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1, 2),\n      UnweightedEdge2.new(2,\
    \ 3), UnweightedEdge2.new(3, 4),\n    ]\n    g = UnweightedDirectedGraph.new(5,\
    \ edges)\n    g.reverse.to_a.should eq edges.map(&.reverse)\n  end\n\n  it \"\
    #to_undirected\" do\n    edges = [\n      UnweightedEdge2.new(0, 1), UnweightedEdge2.new(0,\
    \ 1), UnweightedEdge2.new(1, 2),\n      UnweightedEdge2.new(2, 3), UnweightedEdge2.new(3,\
    \ 4),\n    ]\n    g = UnweightedDirectedGraph.new(5, edges)\n    g.to_undirected.to_set.should\
    \ eq edges.flat_map { |e| [e, e.reverse] }.to_set\n  end\nend\n\ndescribe UnweightedUndirectedGraph\
    \ do\n  it \".weighted?, .directed?\" do\n    UnweightedUndirectedGraph.weighted?.should\
    \ be_false\n    UnweightedUndirectedGraph.directed?.should be_false\n  end\n\n\
    \  it \"#.new(size)\" do\n    g = UnweightedUndirectedGraph.new(5)\n    g.size.should\
    \ eq 5\n    g.to_a.should eq [] of UnweightedEdge2\n    expect_raises(ArgumentError)\
    \ { UnweightedUndirectedGraph.new(-2) }\n  end\n\n  it \".new(n, edges)\" do\n\
    \    edges = [UnweightedEdge2.new(0, 1), UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1,\
    \ 0), UnweightedEdge2.new(1, 0)]\n    g = UnweightedUndirectedGraph.new 2, [edges[0],\
    \ edges[3]]\n    g.to_a.should eq edges\n\n    g = UnweightedUndirectedGraph.new\
    \ 2, edges.values_at(0, 3)\n    g.to_a.should eq edges\n\n    g = UnweightedUndirectedGraph.new\
    \ 2, [{0, 1}, {1, 0}]\n    g.to_a.should eq edges\n\n    expect_raises(IndexError)\
    \ { UnweightedUndirectedGraph.new 1, [UnweightedEdge2.new(0, 1)] }\n  end\n\n\
    \  it \"#add_edge, #add_edges\" do\n    edges = [\n      [UnweightedEdge.new(1)],\n\
    \      [UnweightedEdge.new(0), UnweightedEdge.new(2)],\n      [UnweightedEdge.new(1),\
    \ UnweightedEdge.new(3)],\n      [UnweightedEdge.new(2)],\n    ]\n    all_edges\
    \ = [\n      UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1, 0),\n      UnweightedEdge2.new(1,\
    \ 2), UnweightedEdge2.new(2, 1),\n      UnweightedEdge2.new(2, 3), UnweightedEdge2.new(3,\
    \ 2),\n    ]\n\n    g = UnweightedUndirectedGraph.new(4)\n    g << {0, 1}\n  \
    \  g << {1, 2}\n    g << UnweightedEdge2.new(2, 3)\n    g[0].should eq edges[0]\n\
    \    g[1].should eq edges[1]\n    g[2].should eq edges[2]\n    g[3].should eq\
    \ edges[3]\n    g.to_a.should eq all_edges\n\n    g = UnweightedUndirectedGraph.new(4)\n\
    \    g.add_edges([{0, 1}])\n    g.add_edges({UnweightedEdge2.new(1, 2), UnweightedEdge2.new(2,\
    \ 3)})\n    g[0].should eq edges[0]\n    g[1].should eq edges[1]\n    g[2].should\
    \ eq edges[2]\n    g[3].should eq edges[3]\n    g.to_a.should eq all_edges\n \
    \ end\n\n  it \"#reverse\" do\n    all_edges = [\n      UnweightedEdge2.new(0,\
    \ 1), UnweightedEdge2.new(1, 0),\n      UnweightedEdge2.new(1, 2), UnweightedEdge2.new(2,\
    \ 1),\n      UnweightedEdge2.new(2, 3), UnweightedEdge2.new(3, 2),\n    ]\n\n\
    \    g = UnweightedUndirectedGraph.new(4)\n    g << {0, 1} << {1, 2} << {2, 3}\n\
    \    g.reverse.to_set.should eq all_edges.to_set\n  end\n\n  it \"#to_undirected\"\
    \ do\n    all_edges = [\n      UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1,\
    \ 0),\n      UnweightedEdge2.new(1, 2), UnweightedEdge2.new(2, 1),\n      UnweightedEdge2.new(2,\
    \ 3), UnweightedEdge2.new(3, 2),\n    ]\n\n    g = UnweightedUndirectedGraph.new(4)\n\
    \    g << {0, 1} << {1, 2} << {2, 3}\n    g.to_undirected.to_set.should eq all_edges.to_set\n\
    \  end\nend\n"
  dependsOn:
  - src/graph.cr
  - src/graph/edge.cr
  isVerificationFile: false
  path: spec/graph_spec.cr
  requiredBy: []
  timestamp: '2021-08-07 12:25:08+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/graph_spec.cr
layout: document
redirect_from:
- /library/spec/graph_spec.cr
- /library/spec/graph_spec.cr.html
title: spec/graph_spec.cr
---
