---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/graph.cr
    title: src/graph.cr
  - icon: ':heavy_check_mark:'
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
    \ inspect(io) : Nil\n    io << \"->\" << to << '(' << cost << ')'\n  end\nend\n\
    \nstruct WeightedEdge2(T)\n  include Comparable(WeightedEdge2(T))\n\n  property\
    \ from : Int32, to : Int32, cost : T\n\n  def initialize(@from, @to, @cost : T)\n\
    \  end\n\n  def initialize(@from, edge : WeightedEdge(T))\n    @to, @cost = edge.to,\
    \ edge.cost\n  end\n\n  def <=>(other : WeightedEdge2(T))\n    {cost, from, to}\
    \ <=> {other.cost, other.from, other.to}\n  end\n\n  def reverse : self\n    WeightedEdge2(T).new(to,\
    \ from, cost)\n  end\n\n  def sort : self\n    WeightedEdge2(T).new(*{to, from}.minmax,\
    \ cost)\n  end\n\n  def to_s(io) : Nil\n    io << '(' << from << \", \" << to\
    \ << \", \" << cost << ')'\n  end\n\n  def inspect(io) : Nil\n    io << from <<\
    \ \"->\" << to << '(' << cost << ')'\n  end\nend\n\nstruct UnweightedEdge\n  property\
    \ to : Int32\n\n  def initialize(@to)\n  end\n\n  def initialize(@to, cost)\n\
    \  end\n\n  def cost : Int32\n    1\n  end\n\n  def to_s(io) : Nil\n    io <<\
    \ to\n  end\n\n  def inspect(io) : Nil\n    io << \"->\" << to\n  end\nend\n\n\
    struct UnweightedEdge2\n  property from : Int32, to : Int32\n\n  def initialize(@from,\
    \ @to)\n  end\n\n  def initialize(@from, @to, cost)\n  end\n\n  def initialize(@from,\
    \ edge : UnweightedEdge)\n    @to = edge.to\n  end\n\n  def cost : Int32\n   \
    \ 1\n  end\n\n  def reverse : self\n    UnweightedEdge2.new(to, from)\n  end\n\
    \n  def sort : self\n    UnweightedEdge2.new(*{to, from}.minmax)\n  end\n\n  def\
    \ to_s(io) : Nil\n    io << '(' << from << \", \" << to << ')'\n  end\n\n  def\
    \ inspect(io) : Nil\n    io << from << \"->\" << to\n  end\nend\n\nmodule Graph(Edge,\
    \ Edge2)\n  include Enumerable(Edge2)\n\n  getter graph : Array(Array(Edge))\n\
    \n  def initialize(size : Int)\n    @graph = Array(Array(Edge)).new(size) { []\
    \ of Edge }\n  end\n\n  def initialize(size : Int, edges : Enumerable)\n    initialize(size)\n\
    \    add_edges(edges)\n  end\n\n  # Add *edge*.\n  abstract def <<(edge : Edge2)\n\
    \n  # :ditto:\n  def <<(edge : Tuple) : self\n    self << Edge2.new(*edge)\n \
    \ end\n\n  def add_edges(edges : Enumerable) : self\n    edges.each { |edge| self\
    \ << edge }\n    self\n  end\n\n  delegate size, :[], to: @graph\n\n  # Yields\
    \ each edge of the graph, ans returns `nil`.\n  def each(&) : Nil\n    (0...size).each\
    \ do |v|\n      graph[v].each do |edge|\n        yield Edge2.new(v, edge)\n  \
    \    end\n    end\n  end\n\n  def each_child(vertex : Int, parent, &block) : Nil\n\
    \    graph[vertex].each do |edge|\n      yield edge if edge.to != parent\n   \
    \ end\n  end\n\n  def each_child(vertex : Int, parent)\n    graph[vertex].each.reject(&.to.==\
    \ parent)\n  end\n\n  def reverse : self\n    if self.class.directed?\n      each_with_object(self.class.new(size))\
    \ do |edge, reversed|\n        reversed << edge.reverse\n      end\n    else\n\
    \      dup\n    end\n  end\n\n  def to_undirected : self\n    if self.class.directed?\n\
    \      each_with_object(self.class.new(size)) do |edge, graph|\n        graph\
    \ << edge << edge.reverse\n      end\n    else\n      dup\n    end\n  end\n\n\
    \  def to_s(io : IO) : Nil\n    io << '['\n    join(\", \", io) do |edge, io|\n\
    \      edge.inspect io\n    end\n    io << ']'\n  end\n\n  def inspect(io : IO)\
    \ : Nil\n    io << \"[\\n\"\n    graph.each do |edges|\n      io << \"  \" <<\
    \ edges << \",\\n\"\n    end\n    io << ']'\n  end\nend\n\nclass DiGraph(T)\n\
    \  include Graph(WeightedEdge(T), WeightedEdge2(T))\n\n  def self.weighted?\n\
    \    true\n  end\n\n  def self.directed?\n    true\n  end\n\n  def initialize(size\
    \ : Int)\n    super\n  end\n\n  def initialize(size : Int, edges : Enumerable(WeightedEdge2(T)))\n\
    \    super\n  end\n\n  def initialize(size : Int, edges : Enumerable({Int32, Int32,\
    \ T}))\n    super\n  end\n\n  def <<(edge : WeightedEdge2(T)) : self\n    raise\
    \ IndexError.new unless 0 <= edge.from < size && 0 <= edge.to < size\n    @graph[edge.from]\
    \ << WeightedEdge.new(edge.to, edge.cost)\n    self\n  end\nend\n\nclass UnGraph(T)\n\
    \  include Graph(WeightedEdge(T), WeightedEdge2(T))\n\n  def self.weighted?\n\
    \    true\n  end\n\n  def self.directed?\n    false\n  end\n\n  def initialize(size\
    \ : Int)\n    super\n  end\n\n  def initialize(size : Int, edges : Enumerable(WeightedEdge2(T)))\n\
    \    super\n  end\n\n  def initialize(size : Int, edges : Enumerable({Int32, Int32,\
    \ T}))\n    super\n  end\n\n  def <<(edge : WeightedEdge2(T)) : self\n    raise\
    \ IndexError.new unless 0 <= edge.from < size && 0 <= edge.to < size\n    @graph[edge.from]\
    \ << WeightedEdge.new(edge.to, edge.cost)\n    @graph[edge.to] << WeightedEdge.new(edge.from,\
    \ edge.cost)\n    self\n  end\nend\n\nclass UnweightedDiGraph\n  include Graph(UnweightedEdge,\
    \ UnweightedEdge2)\n\n  def self.weighted?\n    false\n  end\n\n  def self.directed?\n\
    \    true\n  end\n\n  def initialize(size : Int)\n    super\n  end\n\n  def initialize(size\
    \ : Int, edges : Enumerable)\n    super\n  end\n\n  def <<(edge : UnweightedEdge2)\
    \ : self\n    raise IndexError.new unless 0 <= edge.from < size && 0 <= edge.to\
    \ < size\n    @graph[edge.from] << UnweightedEdge.new(edge.to)\n    self\n  end\n\
    end\n\nclass UnweightedUnGraph\n  include Graph(UnweightedEdge, UnweightedEdge2)\n\
    \n  def self.weighted?\n    false\n  end\n\n  def self.directed?\n    false\n\
    \  end\n\n  def initialize(size : Int)\n    super\n  end\n\n  def initialize(size\
    \ : Int, edges : Enumerable)\n    super\n  end\n\n  def <<(edge : UnweightedEdge2)\
    \ : self\n    raise IndexError.new unless 0 <= edge.from < size && 0 <= edge.to\
    \ < size\n    @graph[edge.from] << UnweightedEdge.new(edge.to)\n    @graph[edge.to]\
    \ << UnweightedEdge.new(edge.from)\n    self\n  end\nend\n\ndescribe DiGraph do\n\
    \  it \".weighted?, .directed?\" do\n    DiGraph.weighted?.should be_true\n  \
    \  DiGraph.directed?.should be_true\n  end\n\n  it \".new(size)\" do\n    g =\
    \ DiGraph(Int32).new(5)\n    g.size.should eq 5\n    g.to_a.should eq [] of WeightedEdge2(Int32)\n\
    \    expect_raises(ArgumentError) { DiGraph(Int32).new(-2) }\n  end\n\n  it \"\
    .new(n, edges)\" do\n    edges = [WeightedEdge2.new(0, 1, 10), WeightedEdge2.new(1,\
    \ 0, 11)]\n\n    g = DiGraph.new 2, edges\n    g.to_a.should eq edges\n\n    g\
    \ = DiGraph.new 2, edges.values_at(0, 1)\n    g.to_a.should eq edges\n\n    g\
    \ = DiGraph.new 2, [{0, 1, 10}, {1, 0, 11}]\n    g.to_a.should eq edges\n\n  \
    \  expect_raises(IndexError) { DiGraph.new 1, [WeightedEdge2.new(0, 1, 10)] }\n\
    \  end\n\n  it \"#<<, #add_edges\" do\n    g = DiGraph(Int32).new(5)\n    edges\
    \ = [\n      WeightedEdge2.new(0, 1, 10), WeightedEdge2.new(0, 1, 11), WeightedEdge2.new(1,\
    \ 2, 12),\n      WeightedEdge2.new(2, 3, 13), WeightedEdge2.new(3, 4, 14),\n \
    \   ]\n    (g << edges[0]).should be g\n    g << {0, 1, 11}\n    g << {1, 2, 12}\n\
    \    g.add_edges(edges[3..4]).should be g\n    expect_raises(IndexError) { g <<\
    \ {4, 5, -1} }\n\n    g[0].should eq [WeightedEdge.new(1, 10), WeightedEdge.new(1,\
    \ 11)]\n    g[1].should eq [WeightedEdge.new(2, 12)]\n    g.to_a.should eq edges\n\
    \  end\n\n  it \"#reverse\" do\n    edges = [\n      WeightedEdge2.new(0, 1, 10),\
    \ WeightedEdge2.new(0, 1, 11), WeightedEdge2.new(1, 2, 12),\n      WeightedEdge2.new(2,\
    \ 3, 13), WeightedEdge2.new(3, 4, 14),\n    ]\n    g = DiGraph(Int32).new(5, edges)\n\
    \    g.reverse.to_a.should eq edges.map(&.reverse)\n  end\n\n  it \"#to_undirected\"\
    \ do\n    edges = [\n      WeightedEdge2.new(0, 1, 10), WeightedEdge2.new(0, 1,\
    \ 11), WeightedEdge2.new(1, 2, 12),\n      WeightedEdge2.new(2, 3, 13), WeightedEdge2.new(3,\
    \ 4, 14),\n    ]\n    g = DiGraph(Int32).new(5, edges)\n    g.to_undirected.to_set.should\
    \ eq edges.flat_map { |e| [e, e.reverse] }.to_set\n  end\nend\n\ndescribe UnGraph\
    \ do\n  it \".weighted?, .directed?\" do\n    UnGraph.weighted?.should be_true\n\
    \    UnGraph.directed?.should be_false\n  end\n\n  it \"#.new(size)\" do\n   \
    \ g = UnGraph(Int32).new(5)\n    g.size.should eq 5\n    g.to_a.should eq [] of\
    \ WeightedEdge2(Int32)\n    expect_raises(ArgumentError) { UnGraph(Int32).new(-2)\
    \ }\n  end\n\n  it \".new(n, edges)\" do\n    edges = [WeightedEdge2.new(0, 1,\
    \ 10), WeightedEdge2.new(0, 1, 11), WeightedEdge2.new(1, 0, 10), WeightedEdge2.new(1,\
    \ 0, 11)]\n    g = UnGraph.new 2, [edges[0], edges[3]]\n    g.to_a.should eq edges\n\
    \n    g = UnGraph.new 2, edges.values_at(0, 3)\n    g.to_a.should eq edges\n\n\
    \    g = UnGraph.new 2, [{0, 1, 10}, {1, 0, 11}]\n    g.to_a.should eq edges\n\
    \n    expect_raises(IndexError) { UnGraph.new 1, [WeightedEdge2.new(0, 1, 10)]\
    \ }\n  end\n\n  it \"#<<, #add_edges\" do\n    edges = [\n      [WeightedEdge.new(1,\
    \ 10)],\n      [WeightedEdge.new(0, 10), WeightedEdge.new(2, 11)],\n      [WeightedEdge.new(1,\
    \ 11), WeightedEdge.new(3, 12)],\n      [WeightedEdge.new(2, 12)],\n    ]\n  \
    \  all_edges = [\n      WeightedEdge2.new(0, 1, 10), WeightedEdge2.new(1, 0, 10),\n\
    \      WeightedEdge2.new(1, 2, 11), WeightedEdge2.new(2, 1, 11),\n      WeightedEdge2.new(2,\
    \ 3, 12), WeightedEdge2.new(3, 2, 12),\n    ]\n\n    g = UnGraph(Int32).new(4)\n\
    \    (g << {0, 1, 10}).should be g\n    g << {1, 2, 11}\n    g << WeightedEdge2.new(2,\
    \ 3, 12)\n    g[0].should eq edges[0]\n    g[1].should eq edges[1]\n    g[2].should\
    \ eq edges[2]\n    g[3].should eq edges[3]\n    g.to_a.should eq all_edges\n\n\
    \    g = UnGraph(Int32).new(4)\n    g.add_edges([{0, 1, 10}]).should be g\n  \
    \  g.add_edges({WeightedEdge2.new(1, 2, 11), WeightedEdge2.new(2, 3, 12)})\n \
    \   g[0].should eq edges[0]\n    g[1].should eq edges[1]\n    g[2].should eq edges[2]\n\
    \    g[3].should eq edges[3]\n    g.to_a.should eq all_edges\n  end\n\n  it \"\
    #reverse\" do\n    all_edges = [\n      WeightedEdge2.new(0, 1, 10), WeightedEdge2.new(1,\
    \ 0, 10),\n      WeightedEdge2.new(1, 2, 11), WeightedEdge2.new(2, 1, 11),\n \
    \     WeightedEdge2.new(2, 3, 12), WeightedEdge2.new(3, 2, 12),\n    ]\n\n   \
    \ g = UnGraph(Int32).new(4)\n    g << {0, 1, 10} << {1, 2, 11} << {2, 3, 12}\n\
    \    g.reverse.to_set.should eq all_edges.map(&.reverse).to_set\n  end\n\n  it\
    \ \"#to_undirected\" do\n    all_edges = [\n      WeightedEdge2.new(0, 1, 10),\
    \ WeightedEdge2.new(1, 0, 10),\n      WeightedEdge2.new(1, 2, 11), WeightedEdge2.new(2,\
    \ 1, 11),\n      WeightedEdge2.new(2, 3, 12), WeightedEdge2.new(3, 2, 12),\n \
    \   ]\n\n    g = UnGraph(Int32).new(4)\n    g << {0, 1, 10} << {1, 2, 11} << {2,\
    \ 3, 12}\n    g.to_undirected.to_set.should eq all_edges.map(&.reverse).to_set\n\
    \  end\n\n  it \"#each_child\" do\n    g = UnGraph(Int32).new(6)\n    g << {0,\
    \ 1, 1} << {0, 2, 2} << {0, 3, 3} << {3, 4, 4} << {3, 5, 5}\n    v = [] of Int32\n\
    \    g.each_child(0, nil) { |e| v << e.to }\n    v.should eq [1, 2, 3]\n    v.clear\n\
    \    g.each_child(3, nil) { |e| v << e.to }\n    v.should eq [0, 4, 5]\n    v.clear\n\
    \    g.each_child(3, 0) { |e| v << e.to }\n    v.should eq [4, 5]\n    g.each_child(0,\
    \ nil).map(&.to).to_a.should eq [1, 2, 3]\n    g.each_child(3, nil).map(&.to).to_a.should\
    \ eq [0, 4, 5]\n    g.each_child(3, 0).map(&.to).to_a.should eq [4, 5]\n  end\n\
    end\n\ndescribe UnweightedDiGraph do\n  it \".weighted?, .directed?\" do\n   \
    \ UnweightedDiGraph.weighted?.should be_false\n    UnweightedDiGraph.directed?.should\
    \ be_true\n  end\n\n  it \".new(size)\" do\n    g = UnweightedDiGraph.new(5)\n\
    \    g.size.should eq 5\n    g.to_a.should eq [] of UnweightedEdge2\n    expect_raises(ArgumentError)\
    \ { UnweightedDiGraph.new(-2) }\n  end\n\n  it \".new(n, edges)\" do\n    edges\
    \ = [UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1, 0)]\n\n    g = UnweightedDiGraph.new\
    \ 2, edges\n    g.to_a.should eq edges\n\n    g = UnweightedDiGraph.new 2, edges.values_at(0,\
    \ 1)\n    g.to_a.should eq edges\n\n    g = UnweightedDiGraph.new 2, [{0, 1},\
    \ {1, 0}]\n    g.to_a.should eq edges\n\n    expect_raises(IndexError) { UnweightedDiGraph.new\
    \ 1, [UnweightedEdge2.new(0, 1)] }\n  end\n\n  it \"#<<, #add_edges\" do\n   \
    \ g = UnweightedDiGraph.new(5)\n    edges = [\n      UnweightedEdge2.new(0, 1),\
    \ UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1, 2),\n      UnweightedEdge2.new(2,\
    \ 3), UnweightedEdge2.new(3, 4),\n    ]\n    (g << edges[0]).should be g\n   \
    \ g << {0, 1}\n    g << {1, 2}\n    g.add_edges(edges[3..4]).should be g\n   \
    \ expect_raises(IndexError) { g << {4, 5} }\n\n    g[0].should eq [UnweightedEdge.new(1),\
    \ UnweightedEdge.new(1)]\n    g[1].should eq [UnweightedEdge.new(2)]\n    g.to_a.should\
    \ eq edges\n  end\n\n  it \"#reverse\" do\n    edges = [\n      UnweightedEdge2.new(0,\
    \ 1), UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1, 2),\n      UnweightedEdge2.new(2,\
    \ 3), UnweightedEdge2.new(3, 4),\n    ]\n    g = UnweightedDiGraph.new(5, edges)\n\
    \    g.reverse.to_a.should eq edges.map(&.reverse)\n  end\n\n  it \"#to_undirected\"\
    \ do\n    edges = [\n      UnweightedEdge2.new(0, 1), UnweightedEdge2.new(0, 1),\
    \ UnweightedEdge2.new(1, 2),\n      UnweightedEdge2.new(2, 3), UnweightedEdge2.new(3,\
    \ 4),\n    ]\n    g = UnweightedDiGraph.new(5, edges)\n    g.to_undirected.to_set.should\
    \ eq edges.flat_map { |e| [e, e.reverse] }.to_set\n  end\nend\n\ndescribe UnweightedUnGraph\
    \ do\n  it \".weighted?, .directed?\" do\n    UnweightedUnGraph.weighted?.should\
    \ be_false\n    UnweightedUnGraph.directed?.should be_false\n  end\n\n  it \"\
    #.new(size)\" do\n    g = UnweightedUnGraph.new(5)\n    g.size.should eq 5\n \
    \   g.to_a.should eq [] of UnweightedEdge2\n    expect_raises(ArgumentError) {\
    \ UnweightedUnGraph.new(-2) }\n  end\n\n  it \".new(n, edges)\" do\n    edges\
    \ = [UnweightedEdge2.new(0, 1), UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1,\
    \ 0), UnweightedEdge2.new(1, 0)]\n    g = UnweightedUnGraph.new 2, [edges[0],\
    \ edges[3]]\n    g.to_a.should eq edges\n\n    g = UnweightedUnGraph.new 2, edges.values_at(0,\
    \ 3)\n    g.to_a.should eq edges\n\n    g = UnweightedUnGraph.new 2, [{0, 1},\
    \ {1, 0}]\n    g.to_a.should eq edges\n\n    expect_raises(IndexError) { UnweightedUnGraph.new\
    \ 1, [UnweightedEdge2.new(0, 1)] }\n  end\n\n  it \"#<<, #add_edges\" do\n   \
    \ edges = [\n      [UnweightedEdge.new(1)],\n      [UnweightedEdge.new(0), UnweightedEdge.new(2)],\n\
    \      [UnweightedEdge.new(1), UnweightedEdge.new(3)],\n      [UnweightedEdge.new(2)],\n\
    \    ]\n    all_edges = [\n      UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1,\
    \ 0),\n      UnweightedEdge2.new(1, 2), UnweightedEdge2.new(2, 1),\n      UnweightedEdge2.new(2,\
    \ 3), UnweightedEdge2.new(3, 2),\n    ]\n\n    g = UnweightedUnGraph.new(4)\n\
    \    (g << {0, 1}).should be g\n    g << {1, 2}\n    g << UnweightedEdge2.new(2,\
    \ 3)\n    g[0].should eq edges[0]\n    g[1].should eq edges[1]\n    g[2].should\
    \ eq edges[2]\n    g[3].should eq edges[3]\n    g.to_a.should eq all_edges\n\n\
    \    g = UnweightedUnGraph.new(4)\n    g.add_edges([{0, 1}]).should be g\n   \
    \ g.add_edges({UnweightedEdge2.new(1, 2), UnweightedEdge2.new(2, 3)})\n    g[0].should\
    \ eq edges[0]\n    g[1].should eq edges[1]\n    g[2].should eq edges[2]\n    g[3].should\
    \ eq edges[3]\n    g.to_a.should eq all_edges\n  end\n\n  it \"#reverse\" do\n\
    \    all_edges = [\n      UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1, 0),\n\
    \      UnweightedEdge2.new(1, 2), UnweightedEdge2.new(2, 1),\n      UnweightedEdge2.new(2,\
    \ 3), UnweightedEdge2.new(3, 2),\n    ]\n\n    g = UnweightedUnGraph.new(4)\n\
    \    g << {0, 1} << {1, 2} << {2, 3}\n    g.reverse.to_set.should eq all_edges.to_set\n\
    \  end\n\n  it \"#to_undirected\" do\n    all_edges = [\n      UnweightedEdge2.new(0,\
    \ 1), UnweightedEdge2.new(1, 0),\n      UnweightedEdge2.new(1, 2), UnweightedEdge2.new(2,\
    \ 1),\n      UnweightedEdge2.new(2, 3), UnweightedEdge2.new(3, 2),\n    ]\n\n\
    \    g = UnweightedUnGraph.new(4)\n    g << {0, 1} << {1, 2} << {2, 3}\n    g.to_undirected.to_set.should\
    \ eq all_edges.to_set\n  end\n\n  it \"#each_child\" do\n    g = UnweightedUnGraph.new(6)\n\
    \    g << {0, 1} << {0, 2} << {0, 3} << {3, 4} << {3, 5}\n    v = [] of Int32\n\
    \    g.each_child(0, nil) { |e| v << e.to }\n    v.should eq [1, 2, 3]\n    v.clear\n\
    \    g.each_child(3, nil) { |e| v << e.to }\n    v.should eq [0, 4, 5]\n    v.clear\n\
    \    g.each_child(3, 0) { |e| v << e.to }\n    v.should eq [4, 5]\n    g.each_child(0,\
    \ nil).map(&.to).to_a.should eq [1, 2, 3]\n    g.each_child(3, nil).map(&.to).to_a.should\
    \ eq [0, 4, 5]\n    g.each_child(3, 0).map(&.to).to_a.should eq [4, 5]\n  end\n\
    end\n"
  code: "require \"spec\"\nrequire \"../src/graph\"\n\ndescribe DiGraph do\n  it \"\
    .weighted?, .directed?\" do\n    DiGraph.weighted?.should be_true\n    DiGraph.directed?.should\
    \ be_true\n  end\n\n  it \".new(size)\" do\n    g = DiGraph(Int32).new(5)\n  \
    \  g.size.should eq 5\n    g.to_a.should eq [] of WeightedEdge2(Int32)\n    expect_raises(ArgumentError)\
    \ { DiGraph(Int32).new(-2) }\n  end\n\n  it \".new(n, edges)\" do\n    edges =\
    \ [WeightedEdge2.new(0, 1, 10), WeightedEdge2.new(1, 0, 11)]\n\n    g = DiGraph.new\
    \ 2, edges\n    g.to_a.should eq edges\n\n    g = DiGraph.new 2, edges.values_at(0,\
    \ 1)\n    g.to_a.should eq edges\n\n    g = DiGraph.new 2, [{0, 1, 10}, {1, 0,\
    \ 11}]\n    g.to_a.should eq edges\n\n    expect_raises(IndexError) { DiGraph.new\
    \ 1, [WeightedEdge2.new(0, 1, 10)] }\n  end\n\n  it \"#<<, #add_edges\" do\n \
    \   g = DiGraph(Int32).new(5)\n    edges = [\n      WeightedEdge2.new(0, 1, 10),\
    \ WeightedEdge2.new(0, 1, 11), WeightedEdge2.new(1, 2, 12),\n      WeightedEdge2.new(2,\
    \ 3, 13), WeightedEdge2.new(3, 4, 14),\n    ]\n    (g << edges[0]).should be g\n\
    \    g << {0, 1, 11}\n    g << {1, 2, 12}\n    g.add_edges(edges[3..4]).should\
    \ be g\n    expect_raises(IndexError) { g << {4, 5, -1} }\n\n    g[0].should eq\
    \ [WeightedEdge.new(1, 10), WeightedEdge.new(1, 11)]\n    g[1].should eq [WeightedEdge.new(2,\
    \ 12)]\n    g.to_a.should eq edges\n  end\n\n  it \"#reverse\" do\n    edges =\
    \ [\n      WeightedEdge2.new(0, 1, 10), WeightedEdge2.new(0, 1, 11), WeightedEdge2.new(1,\
    \ 2, 12),\n      WeightedEdge2.new(2, 3, 13), WeightedEdge2.new(3, 4, 14),\n \
    \   ]\n    g = DiGraph(Int32).new(5, edges)\n    g.reverse.to_a.should eq edges.map(&.reverse)\n\
    \  end\n\n  it \"#to_undirected\" do\n    edges = [\n      WeightedEdge2.new(0,\
    \ 1, 10), WeightedEdge2.new(0, 1, 11), WeightedEdge2.new(1, 2, 12),\n      WeightedEdge2.new(2,\
    \ 3, 13), WeightedEdge2.new(3, 4, 14),\n    ]\n    g = DiGraph(Int32).new(5, edges)\n\
    \    g.to_undirected.to_set.should eq edges.flat_map { |e| [e, e.reverse] }.to_set\n\
    \  end\nend\n\ndescribe UnGraph do\n  it \".weighted?, .directed?\" do\n    UnGraph.weighted?.should\
    \ be_true\n    UnGraph.directed?.should be_false\n  end\n\n  it \"#.new(size)\"\
    \ do\n    g = UnGraph(Int32).new(5)\n    g.size.should eq 5\n    g.to_a.should\
    \ eq [] of WeightedEdge2(Int32)\n    expect_raises(ArgumentError) { UnGraph(Int32).new(-2)\
    \ }\n  end\n\n  it \".new(n, edges)\" do\n    edges = [WeightedEdge2.new(0, 1,\
    \ 10), WeightedEdge2.new(0, 1, 11), WeightedEdge2.new(1, 0, 10), WeightedEdge2.new(1,\
    \ 0, 11)]\n    g = UnGraph.new 2, [edges[0], edges[3]]\n    g.to_a.should eq edges\n\
    \n    g = UnGraph.new 2, edges.values_at(0, 3)\n    g.to_a.should eq edges\n\n\
    \    g = UnGraph.new 2, [{0, 1, 10}, {1, 0, 11}]\n    g.to_a.should eq edges\n\
    \n    expect_raises(IndexError) { UnGraph.new 1, [WeightedEdge2.new(0, 1, 10)]\
    \ }\n  end\n\n  it \"#<<, #add_edges\" do\n    edges = [\n      [WeightedEdge.new(1,\
    \ 10)],\n      [WeightedEdge.new(0, 10), WeightedEdge.new(2, 11)],\n      [WeightedEdge.new(1,\
    \ 11), WeightedEdge.new(3, 12)],\n      [WeightedEdge.new(2, 12)],\n    ]\n  \
    \  all_edges = [\n      WeightedEdge2.new(0, 1, 10), WeightedEdge2.new(1, 0, 10),\n\
    \      WeightedEdge2.new(1, 2, 11), WeightedEdge2.new(2, 1, 11),\n      WeightedEdge2.new(2,\
    \ 3, 12), WeightedEdge2.new(3, 2, 12),\n    ]\n\n    g = UnGraph(Int32).new(4)\n\
    \    (g << {0, 1, 10}).should be g\n    g << {1, 2, 11}\n    g << WeightedEdge2.new(2,\
    \ 3, 12)\n    g[0].should eq edges[0]\n    g[1].should eq edges[1]\n    g[2].should\
    \ eq edges[2]\n    g[3].should eq edges[3]\n    g.to_a.should eq all_edges\n\n\
    \    g = UnGraph(Int32).new(4)\n    g.add_edges([{0, 1, 10}]).should be g\n  \
    \  g.add_edges({WeightedEdge2.new(1, 2, 11), WeightedEdge2.new(2, 3, 12)})\n \
    \   g[0].should eq edges[0]\n    g[1].should eq edges[1]\n    g[2].should eq edges[2]\n\
    \    g[3].should eq edges[3]\n    g.to_a.should eq all_edges\n  end\n\n  it \"\
    #reverse\" do\n    all_edges = [\n      WeightedEdge2.new(0, 1, 10), WeightedEdge2.new(1,\
    \ 0, 10),\n      WeightedEdge2.new(1, 2, 11), WeightedEdge2.new(2, 1, 11),\n \
    \     WeightedEdge2.new(2, 3, 12), WeightedEdge2.new(3, 2, 12),\n    ]\n\n   \
    \ g = UnGraph(Int32).new(4)\n    g << {0, 1, 10} << {1, 2, 11} << {2, 3, 12}\n\
    \    g.reverse.to_set.should eq all_edges.map(&.reverse).to_set\n  end\n\n  it\
    \ \"#to_undirected\" do\n    all_edges = [\n      WeightedEdge2.new(0, 1, 10),\
    \ WeightedEdge2.new(1, 0, 10),\n      WeightedEdge2.new(1, 2, 11), WeightedEdge2.new(2,\
    \ 1, 11),\n      WeightedEdge2.new(2, 3, 12), WeightedEdge2.new(3, 2, 12),\n \
    \   ]\n\n    g = UnGraph(Int32).new(4)\n    g << {0, 1, 10} << {1, 2, 11} << {2,\
    \ 3, 12}\n    g.to_undirected.to_set.should eq all_edges.map(&.reverse).to_set\n\
    \  end\n\n  it \"#each_child\" do\n    g = UnGraph(Int32).new(6)\n    g << {0,\
    \ 1, 1} << {0, 2, 2} << {0, 3, 3} << {3, 4, 4} << {3, 5, 5}\n    v = [] of Int32\n\
    \    g.each_child(0, nil) { |e| v << e.to }\n    v.should eq [1, 2, 3]\n    v.clear\n\
    \    g.each_child(3, nil) { |e| v << e.to }\n    v.should eq [0, 4, 5]\n    v.clear\n\
    \    g.each_child(3, 0) { |e| v << e.to }\n    v.should eq [4, 5]\n    g.each_child(0,\
    \ nil).map(&.to).to_a.should eq [1, 2, 3]\n    g.each_child(3, nil).map(&.to).to_a.should\
    \ eq [0, 4, 5]\n    g.each_child(3, 0).map(&.to).to_a.should eq [4, 5]\n  end\n\
    end\n\ndescribe UnweightedDiGraph do\n  it \".weighted?, .directed?\" do\n   \
    \ UnweightedDiGraph.weighted?.should be_false\n    UnweightedDiGraph.directed?.should\
    \ be_true\n  end\n\n  it \".new(size)\" do\n    g = UnweightedDiGraph.new(5)\n\
    \    g.size.should eq 5\n    g.to_a.should eq [] of UnweightedEdge2\n    expect_raises(ArgumentError)\
    \ { UnweightedDiGraph.new(-2) }\n  end\n\n  it \".new(n, edges)\" do\n    edges\
    \ = [UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1, 0)]\n\n    g = UnweightedDiGraph.new\
    \ 2, edges\n    g.to_a.should eq edges\n\n    g = UnweightedDiGraph.new 2, edges.values_at(0,\
    \ 1)\n    g.to_a.should eq edges\n\n    g = UnweightedDiGraph.new 2, [{0, 1},\
    \ {1, 0}]\n    g.to_a.should eq edges\n\n    expect_raises(IndexError) { UnweightedDiGraph.new\
    \ 1, [UnweightedEdge2.new(0, 1)] }\n  end\n\n  it \"#<<, #add_edges\" do\n   \
    \ g = UnweightedDiGraph.new(5)\n    edges = [\n      UnweightedEdge2.new(0, 1),\
    \ UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1, 2),\n      UnweightedEdge2.new(2,\
    \ 3), UnweightedEdge2.new(3, 4),\n    ]\n    (g << edges[0]).should be g\n   \
    \ g << {0, 1}\n    g << {1, 2}\n    g.add_edges(edges[3..4]).should be g\n   \
    \ expect_raises(IndexError) { g << {4, 5} }\n\n    g[0].should eq [UnweightedEdge.new(1),\
    \ UnweightedEdge.new(1)]\n    g[1].should eq [UnweightedEdge.new(2)]\n    g.to_a.should\
    \ eq edges\n  end\n\n  it \"#reverse\" do\n    edges = [\n      UnweightedEdge2.new(0,\
    \ 1), UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1, 2),\n      UnweightedEdge2.new(2,\
    \ 3), UnweightedEdge2.new(3, 4),\n    ]\n    g = UnweightedDiGraph.new(5, edges)\n\
    \    g.reverse.to_a.should eq edges.map(&.reverse)\n  end\n\n  it \"#to_undirected\"\
    \ do\n    edges = [\n      UnweightedEdge2.new(0, 1), UnweightedEdge2.new(0, 1),\
    \ UnweightedEdge2.new(1, 2),\n      UnweightedEdge2.new(2, 3), UnweightedEdge2.new(3,\
    \ 4),\n    ]\n    g = UnweightedDiGraph.new(5, edges)\n    g.to_undirected.to_set.should\
    \ eq edges.flat_map { |e| [e, e.reverse] }.to_set\n  end\nend\n\ndescribe UnweightedUnGraph\
    \ do\n  it \".weighted?, .directed?\" do\n    UnweightedUnGraph.weighted?.should\
    \ be_false\n    UnweightedUnGraph.directed?.should be_false\n  end\n\n  it \"\
    #.new(size)\" do\n    g = UnweightedUnGraph.new(5)\n    g.size.should eq 5\n \
    \   g.to_a.should eq [] of UnweightedEdge2\n    expect_raises(ArgumentError) {\
    \ UnweightedUnGraph.new(-2) }\n  end\n\n  it \".new(n, edges)\" do\n    edges\
    \ = [UnweightedEdge2.new(0, 1), UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1,\
    \ 0), UnweightedEdge2.new(1, 0)]\n    g = UnweightedUnGraph.new 2, [edges[0],\
    \ edges[3]]\n    g.to_a.should eq edges\n\n    g = UnweightedUnGraph.new 2, edges.values_at(0,\
    \ 3)\n    g.to_a.should eq edges\n\n    g = UnweightedUnGraph.new 2, [{0, 1},\
    \ {1, 0}]\n    g.to_a.should eq edges\n\n    expect_raises(IndexError) { UnweightedUnGraph.new\
    \ 1, [UnweightedEdge2.new(0, 1)] }\n  end\n\n  it \"#<<, #add_edges\" do\n   \
    \ edges = [\n      [UnweightedEdge.new(1)],\n      [UnweightedEdge.new(0), UnweightedEdge.new(2)],\n\
    \      [UnweightedEdge.new(1), UnweightedEdge.new(3)],\n      [UnweightedEdge.new(2)],\n\
    \    ]\n    all_edges = [\n      UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1,\
    \ 0),\n      UnweightedEdge2.new(1, 2), UnweightedEdge2.new(2, 1),\n      UnweightedEdge2.new(2,\
    \ 3), UnweightedEdge2.new(3, 2),\n    ]\n\n    g = UnweightedUnGraph.new(4)\n\
    \    (g << {0, 1}).should be g\n    g << {1, 2}\n    g << UnweightedEdge2.new(2,\
    \ 3)\n    g[0].should eq edges[0]\n    g[1].should eq edges[1]\n    g[2].should\
    \ eq edges[2]\n    g[3].should eq edges[3]\n    g.to_a.should eq all_edges\n\n\
    \    g = UnweightedUnGraph.new(4)\n    g.add_edges([{0, 1}]).should be g\n   \
    \ g.add_edges({UnweightedEdge2.new(1, 2), UnweightedEdge2.new(2, 3)})\n    g[0].should\
    \ eq edges[0]\n    g[1].should eq edges[1]\n    g[2].should eq edges[2]\n    g[3].should\
    \ eq edges[3]\n    g.to_a.should eq all_edges\n  end\n\n  it \"#reverse\" do\n\
    \    all_edges = [\n      UnweightedEdge2.new(0, 1), UnweightedEdge2.new(1, 0),\n\
    \      UnweightedEdge2.new(1, 2), UnweightedEdge2.new(2, 1),\n      UnweightedEdge2.new(2,\
    \ 3), UnweightedEdge2.new(3, 2),\n    ]\n\n    g = UnweightedUnGraph.new(4)\n\
    \    g << {0, 1} << {1, 2} << {2, 3}\n    g.reverse.to_set.should eq all_edges.to_set\n\
    \  end\n\n  it \"#to_undirected\" do\n    all_edges = [\n      UnweightedEdge2.new(0,\
    \ 1), UnweightedEdge2.new(1, 0),\n      UnweightedEdge2.new(1, 2), UnweightedEdge2.new(2,\
    \ 1),\n      UnweightedEdge2.new(2, 3), UnweightedEdge2.new(3, 2),\n    ]\n\n\
    \    g = UnweightedUnGraph.new(4)\n    g << {0, 1} << {1, 2} << {2, 3}\n    g.to_undirected.to_set.should\
    \ eq all_edges.to_set\n  end\n\n  it \"#each_child\" do\n    g = UnweightedUnGraph.new(6)\n\
    \    g << {0, 1} << {0, 2} << {0, 3} << {3, 4} << {3, 5}\n    v = [] of Int32\n\
    \    g.each_child(0, nil) { |e| v << e.to }\n    v.should eq [1, 2, 3]\n    v.clear\n\
    \    g.each_child(3, nil) { |e| v << e.to }\n    v.should eq [0, 4, 5]\n    v.clear\n\
    \    g.each_child(3, 0) { |e| v << e.to }\n    v.should eq [4, 5]\n    g.each_child(0,\
    \ nil).map(&.to).to_a.should eq [1, 2, 3]\n    g.each_child(3, nil).map(&.to).to_a.should\
    \ eq [0, 4, 5]\n    g.each_child(3, 0).map(&.to).to_a.should eq [4, 5]\n  end\n\
    end\n"
  dependsOn:
  - src/graph.cr
  - src/graph/edge.cr
  isVerificationFile: false
  path: spec/graph_spec.cr
  requiredBy: []
  timestamp: '2022-04-16 16:23:13+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/graph_spec.cr
layout: document
redirect_from:
- /library/spec/graph_spec.cr
- /library/spec/graph_spec.cr.html
title: spec/graph_spec.cr
---
