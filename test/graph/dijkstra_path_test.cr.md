---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/datastructure/binary_heap.cr
    title: src/datastructure/binary_heap.cr
  - icon: ':question:'
    path: src/graph.cr
    title: src/graph.cr
  - icon: ':heavy_check_mark:'
    path: src/graph/dijkstra.cr
    title: src/graph/dijkstra.cr
  - icon: ':question:'
    path: src/graph/edge.cr
    title: src/graph/edge.cr
  - icon: ':question:'
    path: src/scanner.cr
    title: src/scanner.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/shortest_path
  bundledCode: "# verification-helper: PROBLEM https://judge.yosupo.jp/problem/shortest_path\n\
    # require \"../../src/graph/dijkstra\"\n# require \"../datastructure/binary_heap\"\
    \nclass BinaryHeap(T)\n  # Creates a new empty heap.\n  def initialize\n    @heap\
    \ = Array(T).new\n    @compare_proc = nil\n  end\n\n  # Creates a new empty heap\
    \ backed by a buffer that is initially *initial_capacity* big (default: `0`).\n\
    \  #\n  # ```\n  # a = BinaryHeap.new(3)\n  # a << 3 << 1 << 2\n  # a.pop # =>\
    \ 1\n  # a.pop # => 2\n  # a.pop # => 3\n  # ```\n  def initialize(initial_capacity\
    \ : Int = 0)\n    @heap = Array(T).new(initial_capacity)\n    @compare_proc =\
    \ nil\n  end\n\n  # Creates a new heap from the elements in *enumerable*.\n  #\n\
    \  # ```\n  # a = BinaryHeap.new [3, 1, 2]\n  # a.pop # => 1\n  # a.pop # => 2\n\
    \  # a.pop # => 3\n  # ```\n  def initialize(enumerable : Enumerable(T))\n   \
    \ initialize\n    enumerable.each { |x| add(x) }\n  end\n\n  # Creates a new empty\
    \ heap with the custom comperator.\n  #\n  # The block must implement a comparison\
    \ between two elements *a* and *b*, where `a < b` returns `-1`,\n  # `a == b`\
    \ returns `0`, and `a > b` returns `1`. The comparison operator `#<=>` can be\
    \ used for this.\n  #\n  # ```\n  # a = BinaryHeap.new [3, 1, 2]\n  # a.pop #\
    \ => 1\n  # b = BinaryHeap.new [3, 1, 2] { |a, b| b <=> a }\n  # b.pop # => 3\n\
    \  # ```\n  def initialize(initial_capacity : Int = 0, &block : T, T -> Int32?)\n\
    \    @heap = Array(T).new(initial_capacity)\n    @compare_proc = block\n  end\n\
    \n  # :ditto:\n  def initialize(enumerable : Enumerable(T), &block : T, T -> Int32?)\n\
    \    initialize &block\n    enumerable.each { |x| add(x) }\n  end\n\n  include\
    \ Enumerable(T)\n  include Iterable(T)\n\n  def_clone\n\n  # Returns true if both\
    \ heap have the same elements.\n  def ==(other : BinaryHeap(T)) : Bool\n    return\
    \ false if size != other.size\n    @heap.sort == other.@heap.sort\n  end\n\n \
    \ # Returns the number of elements in the heap.\n  def size : Int32\n    @heap.size\n\
    \  end\n\n  # Returns `true` if `self` is empty, `false` otherwise.\n  def empty?\
    \ : Bool\n    @heap.empty?\n  end\n\n  # Removes all elements from the heap and\
    \ returns `self`.\n  def clear : self\n    @heap.clear\n    self\n  end\n\n  #\
    \ Returns the lowest value in the `self`.\n  # If the `self` is empty, calls the\
    \ block and returns its value.\n  def top(&block)\n    @heap.first { yield }\n\
    \  end\n\n  # Returns the lowest value in the `self`.\n  # If the `self` is empty,\
    \ returns `nil`.\n  def top? : T?\n    top { nil }\n  end\n\n  # Returns the lowest\
    \ value in the `self`.\n  # If the `self` is empty, raises `IndexError`.\n  def\
    \ top : T\n    top { raise IndexError.new }\n  end\n\n  # Requires `0 <= i < size`,\
    \ `0 <= j < size`.\n  private def compare(i : Int32, j : Int32)\n    x, y = @heap.unsafe_fetch(i),\
    \ @heap.unsafe_fetch(j)\n    if @compare_proc\n      v = @compare_proc.not_nil!.call(x,\
    \ y)\n      raise ArgumentError.new(\"Comparison of #{x} and #{y} failed\") if\
    \ v.nil?\n      v > 0\n    else\n      x > y\n    end\n  end\n\n  # Adds *object*\
    \ to the heap and returns `self`.\n  def add(object : T) : self\n    @heap <<\
    \ object\n    i = size - 1\n    parent = i.pred // 2\n    while i > 0 && compare(parent,\
    \ i)\n      @heap.swap(parent, i)\n      i, parent = parent, parent.pred // 2\n\
    \    end\n    self\n  end\n\n  # :ditto:\n  def <<(object : T) : self\n    add(object)\n\
    \  end\n\n  # Removes the lowest value from `self` and returns the removed value.\n\
    \  # If the array is empty, the given block is called.\n  def pop(&block)\n  \
    \  case size\n    when 0\n      yield\n    when 1\n      @heap.pop\n    else\n\
    \      value = @heap.unsafe_fetch(0)\n      @heap[0] = @heap.pop\n      i = 0\n\
    \      loop do\n        left, right = i * 2 + 1, i * 2 + 2\n        j = if right\
    \ < size && compare(i, right)\n              compare(left, right) ? right : left\n\
    \            elsif left < size && compare(i, left)\n              left\n     \
    \       else\n              break\n            end\n        @heap.swap(i, j)\n\
    \        i = j\n      end\n      value\n    end\n  end\n\n  # Like `#pop`, but\
    \ returns `nil` if `self` is empty.\n  def pop? : T?\n    pop { nil }\n  end\n\
    \n  # Removes the lowest value from `self` and returns the removed value.\n  #\
    \ Raises `IndexError` if heap is of 0 size.\n  def pop : T\n    pop { raise IndexError.new\
    \ }\n  end\n\n  # Removes the last *n* values from `self` ahd returns the removed\
    \ values.\n  def pop(n : Int) : Array(T)\n    raise ArgumentError.new unless n\
    \ >= 0\n    n = Math.min(n, size)\n    Array.new(n) { pop }\n  end\n\n  # Yields\
    \ each element of the heap, and returns `nil`.\n  def each(&) : Nil\n    @heap.each\
    \ { |elem| yield elem }\n  end\n\n  # Returns an iterator for each element of\
    \ the heap.\n  def each\n    @heap.each\n  end\n\n  # Returns a new array with\
    \ all elements sorted.\n  #\n  # ```\n  # a = BinaryHeap.new [3, 1, 2]\n  # a.sort\
    \ # => [1, 2, 3]\n  # b = BinaryHeap.new [3, 1, 2] { |a, b| b <=> a }\n  # b.sort\
    \ # => [3, 2, 1]\n  # ```\n  def sort : Array(T)\n    if @compare_proc\n     \
    \ @heap.sort { |a, b| @compare_proc.not_nil!.call(a, b) }\n    else\n      @heap.sort\n\
    \    end\n  end\n\n  # Returns the elements as an Array.\n  #\n  # ```\n  # BinaryHeap{3,\
    \ 1, 2}.to_a # => [1, 3, 2]\n  # ```\n  def to_a : Array(T)\n    @heap.dup\n \
    \ end\n\n  # Writes a string representation of the heap to `io`.\n  #\n  # ```\n\
    \  # BinaryHeap{1, 2}.to_s # => \"BinaryHeap{1, 2}\"\n  # ```\n  def to_s(io :\
    \ IO) : Nil\n    io << \"BinaryHeap{\"\n    # TODO: use join\n    each_with_index\
    \ do |x, i|\n      io << \", \" if i > 0\n      io << x\n    end\n    io << '}'\n\
    \  end\n\n  # Writes a string representation of the heap to `io`.\n  #\n  # ```\n\
    \  # BinaryHeap{1, 2}.inspect # => \"BinaryHeap{1, 2}\"\n  # ```\n  def inspect(io\
    \ : IO) : Nil\n    to_s(io)\n  end\nend\n\n# require \"../graph\"\n# require \"\
    ./graph/edge\"\nstruct WeightedEdge(T)\n  include Comparable(WeightedEdge(T))\n\
    \n  property to : Int32, cost : T\n\n  def initialize(@to, @cost : T)\n  end\n\
    \n  def <=>(other : WeightedEdge(T))\n    {cost, to} <=> {other.cost, other.to}\n\
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
    \    false\n  end\n\n  def self.directed?\n    false\n  end\nend\n\nmodule Graph(Edge,\
    \ Edge2)\n  # Returns the array of distance of each node from *start* or `nil`.\n\
    \  def dijkstra(start : Int)\n    raise ArgumentError.new unless 0 <= start <\
    \ size\n    que = BinaryHeap({Int32, typeof(first.cost)}).new { |(v1, d1), (v2,\
    \ d2)| d1 <=> d2 }\n    que << {start, typeof(first.cost).zero}\n    dist = Array(typeof(first.cost)?).new(size,\
    \ nil)\n    dist[start] = typeof(first.cost).zero\n\n    until que.empty?\n  \
    \    v, d = que.pop\n      next if dist[v].try { |dist_v| dist_v < d }\n     \
    \ current_dist = dist[v].not_nil!\n      graph[v].each do |edge|\n        next_dist\
    \ = current_dist + edge.cost\n        if dist[edge.to].nil? || dist[edge.to].not_nil!\
    \ > next_dist\n          dist[edge.to] = next_dist\n          que << {edge.to,\
    \ next_dist}\n        end\n      end\n    end\n    dist\n  end\n\n  # Returns\
    \ the array of distance of each node from *start*.\n  def dijkstra!(start : Int)\n\
    \    dijkstra(start).map(&.not_nil!)\n  end\n\n  # Returns the distance of *start*\
    \ to *goal* or `nil`.\n  def dijkstra(start : Int, goal : Int)\n    raise ArgumentError.new\
    \ unless 0 <= start < size && 0 <= goal < size\n    que = BinaryHeap({Int32, typeof(first.cost)}).new\
    \ { |(v1, d1), (v2, d2)| d1 <=> d2 }\n    que << {start, typeof(first.cost).zero}\n\
    \    dist = Array(typeof(first.cost)?).new(size, nil)\n    dist[start] = typeof(first.cost).zero\n\
    \n    until que.empty?\n      v, d = que.pop\n      return d if v == goal\n  \
    \    next if dist[v].try { |dist_v| dist_v < d }\n      current_dist = dist[v].not_nil!\n\
    \      graph[v].each do |edge|\n        next_dist = current_dist + edge.cost\n\
    \        if dist[edge.to].nil? || dist[edge.to].not_nil! > next_dist\n       \
    \   dist[edge.to] = next_dist\n          que << {edge.to, next_dist}\n       \
    \ end\n      end\n    end\n  end\n\n  # Returns the distance of *start* to *goal*.\n\
    \  def dijkstra!(start : Int, goal : Int)\n    dijkstra(start, goal).not_nil!\n\
    \  end\n\n  def dijkstra_with_prev(start : Int)\n    raise ArgumentError.new unless\
    \ 0 <= start < size\n    que = BinaryHeap({Int32, typeof(first.cost)}).new { |(v1,\
    \ d1), (v2, d2)| d1 <=> d2 }\n    que << {start, typeof(first.cost).zero}\n  \
    \  dist = Array(typeof(first.cost)?).new(size, nil)\n    dist[start] = typeof(first.cost).zero\n\
    \    prev = Array(Int32?).new(size, nil)\n\n    until que.empty?\n      v, d =\
    \ que.pop\n      next if dist[v].try { |dist_v| dist_v < d }\n      current_dist\
    \ = dist[v].not_nil!\n      graph[v].each do |edge|\n        next_dist = current_dist\
    \ + edge.cost\n        if dist[edge.to].nil? || dist[edge.to].not_nil! > next_dist\n\
    \          dist[edge.to] = next_dist\n          prev[edge.to] = v\n          que\
    \ << {edge.to, next_dist}\n        end\n      end\n    end\n    {dist, prev}\n\
    \  end\n\n  def dijkstra_with_path(start : Int, goal : Int)\n    dist, prev =\
    \ dijkstra_with_prev(start)\n    if d = dist[goal]\n      {d, Graph.restore_path(prev,\
    \ goal)}\n    end\n  end\n\n  def self.restore_path(prev : Array(Int32?), v :\
    \ Int) : Array(Int32)\n    v = v.to_i\n    path = [v]\n    while v = prev[v]\n\
    \      path << v\n    end\n    path.reverse\n  end\nend\n\n# require \"../../src/scanner\"\
    \n# ### Specifications\n#\n# ```plain\n# Inside input macro                  \
    \   | Expanded code\n# ---------------------------------------+---------------------------------------\n\
    # Uppercase string: Int32, Int64, etc.   | {}.new(Scanner.s)\n# s, c, i, iN, uN\
    \                        | Scanner.{}\n# Other lowercase string: f, big_i, etc.\
    \ | Scanner.s.to_{}\n# operator[]: type[size]                 | Array.new(input(size))\
    \ { input(type) }\n# Tuple literal: {t1, t2, t3}            | {input(t1), input(t2),\
    \ input(t3)}\n# Array literal: [t1, t2, t3]            | [input(t1), input(t2),\
    \ input(t3)]\n# Range literal: t1..t2                  | input(t1)..input(t2)\n\
    # If: cond ? t1 : t2                     | cond ? input(t1) : input(t2)\n# Assign:\
    \ target = value                 | target = input(value)\n# ```\n#\n# ### Examples\n\
    #\n# Input:\n# ```plain\n# 5 3\n# foo bar\n# 1 2 3 4 5\n# ```\n# ```\n# n, m =\
    \ input(Int32, Int64) # => {5, 5i64}\n# input(String, Char[m])     # => {\"foo\"\
    , ['b', 'a', 'r']}\n# input(Int32[n])            # => [1, 2, 3, 4, 5]\n# ```\n\
    # ```\n# n, m = input(i, i64) # => {5, 5i64}\n# input(s, c[m])       # => {\"\
    foo\", ['b', 'a', 'r']}\n# input(i[n])          # => [1, 2, 3, 4, 5]\n# ```\n\
    #\n# Input:\n# ```plain\n# 2 3\n# 1 2 3\n# 4 5 6\n# ```\n#\n# ```\n# h, w = input(i,\
    \ i) # => {2, 3}\n# input(i[h, w])     # => [[1, 2, 3], [4, 5, 6]]\n# ```\n# ```\n\
    # input(i[i][i]) # => [[1, 2, 3], [4, 5, 6]]\n# ```\n#\n# Input:\n# ```plain\n\
    # 5 3\n# 3 1 4 2 5\n# 1 2\n# 2 3\n# 3 1\n# ```\n# ```\n# n, m = input(i, i)  \
    \     # => {5, 3}\n# input(i.pred[n])         # => [2, 0, 3, 1, 4]\n# input({i\
    \ - 1, i - 1}[m]) # => [{0, 1}, {1, 2}, {2, 0}]\n# ```\n#\n# Input:\n# ```plain\n\
    # 3\n# 1 2\n# 2 2\n# 3 2\n# ```\n# ```\n# input({tmp = i, tmp == 1 ? i : i.pred}[i])\
    \ # => [{1, 2}, {2, 1}, {3, 1}]\n# ```\n#\n# Input:\n# ```plain\n# 3\n# 1 2\n\
    # 2 3\n# 3 1\n# ```\n# ```\n# n = input(i)\n# input_column({Int32, Int32}, n)\
    \ # => {[1, 2, 3], [2, 3, 1]}\n# ```\nmodule Scanner\n  extend self\n\n  private\
    \ def skip_to_not_space(io)\n    peek = io.peek\n    not_space = peek.index {\
    \ |x| x != 32 && x != 10 } || peek.size\n    io.skip(not_space)\n  end\n\n  def\
    \ c(io = STDIN)\n    skip_to_not_space(io)\n    io.read_char.not_nil!\n  end\n\
    \n  private def int(int_type : T.class, io = STDIN) : T forall T\n    skip_to_not_space(io)\n\
    \n    value = T.zero\n    signed = false\n    case x = io.read_byte\n    when\
    \ nil\n      raise IO::EOFError.new\n    when 45\n      signed = true\n    when\
    \ 48..57\n      value = T.new 48 &- x\n    else\n      raise \"Unexpected char:\
    \ #{x.chr}\"\n    end\n\n    loop do\n      peek = io.peek\n      return signed\
    \ ? value : -value if peek.empty?\n      i = 0\n      while i < peek.size\n  \
    \      c = peek.unsafe_fetch(i)\n        if 48 <= c <= 57\n          value = value\
    \ &* 10 &- c &+ 48\n          i &+= 1\n        elsif c == 32 || c == 10\n    \
    \      io.skip(i &+ 1)\n          return signed ? value : -value\n        else\n\
    \          raise \"Unexpected char: #{c.chr}\"\n        end\n      end\n     \
    \ io.skip(i)\n    end\n  end\n\n  private def uint(uint_type : T.class, io = STDIN)\
    \ : T forall T\n    skip_to_not_space(io)\n    value = T.zero\n    found_digit\
    \ = false\n    loop do\n      peek = io.peek\n      if peek.empty?\n        if\
    \ found_digit\n          return value\n        else\n          raise IO::EOFError.new\n\
    \        end\n      end\n      i = 0\n      while i < peek.size\n        c = peek.unsafe_fetch(i)\n\
    \        if 48 <= c <= 57\n          found_digit = true\n          value = value\
    \ &* 10 &+ c &- 48\n          i &+= 1\n        elsif c == 32 || c == 10\n    \
    \      io.skip(i &+ 1)\n          return value\n        else\n          raise\
    \ \"Unexpected char: #{c.chr}\"\n        end\n      end\n      io.skip(i)\n  \
    \  end\n  end\n\n  def i(io = STDIN)\n    int(Int32, io)\n  end\n\n  {% for n\
    \ in [8, 16, 32, 64, 128] %}\n    def i{{n}}(io = STDIN)\n      int(Int{{n}},\
    \ io)\n    end\n\n    def u{{n}}(io = STDIN)\n      uint(UInt{{n}}, io)\n    end\n\
    \  {% end %}\n\n  {% for method in [:f, :f32, :f64] %}\n    def {{method.id}}(io\
    \ = STDIN)\n      s(io).to_{{method.id}}\n    end\n  {% end %}\n\n  def s(io =\
    \ STDIN)\n    skip_to_not_space(io)\n\n    peek = io.peek\n    if peek.empty?\n\
    \      raise IO::EOFError.new\n    end\n    if index = peek.index { |x| x == 32\
    \ || x == 10 }\n      io.skip(index + 1)\n      return String.new(peek[0, index])\n\
    \    end\n\n    String.build do |buffer|\n      loop do\n        buffer.write\
    \ peek\n        io.skip(peek.size)\n        peek = io.peek\n        break if peek.empty?\n\
    \        if index = peek.index { |x| x == 32 || x == 10 }\n          buffer.write\
    \ peek[0, index]\n          io.skip(index + 1)\n          break\n        end\n\
    \      end\n    end\n  end\nend\n\nmacro internal_input(type, else_ast, io)\n\
    \  {% if Scanner.class.has_method?(type.id) %}\n    Scanner.{{type.id}}({{io}})\n\
    \  {% elsif type.stringify == \"String\" %}\n    Scanner.s({{io}})\n  {% elsif\
    \ type.stringify == \"Char\" %}\n    Scanner.c({{io}})\n  {% elsif type.is_a?(Path)\
    \ %}\n    {% if type.resolve.class.has_method?(:scan) %}\n      {{type}}.scan(Scanner)\n\
    \    {% else %}\n      {{type}}.new(Scanner.s({{io}}))\n    {% end %}\n  {% elsif\
    \ String.has_method?(\"to_#{type}\".id) %}\n    Scanner.s({{io}}).to_{{type.id}}\n\
    \  {% else %}\n    {{else_ast}}\n  {% end %}\nend\n\nmacro internal_input_array(type,\
    \ args)\n  {% for i in 0...args.size %}\n    %size{i} = input({{args[i]}})\n \
    \ {% end %}\n  {% begin %}\n    {% for i in 0...args.size %} Array.new(%size{i})\
    \ { {% end %}\n      input({{type.id}})\n    {% for i in 0...args.size %} } {%\
    \ end %}\n  {% end %}\nend\n\nmacro input(ast, *, io = STDIN)\n  {% if ast.is_a?(Call)\
    \ %}\n    {% if ast.receiver.is_a?(Nop) %}\n      internal_input(\n        {{ast.name}},\n\
    \        {{ast.name}}({% for argument in ast.args %} input({{argument}}), {% end\
    \ %}),\n        {{io}},\n      )\n    {% elsif ast.name.stringify == \"[]\" %}\n\
    \      internal_input_array({{ast.receiver}}, {{ast.args}})\n    {% else %}\n\
    \      input({{ast.receiver}}, io: {{io}}).{{ast.name}}(\n        {% for argument\
    \ in ast.args %} input({{argument}}), {% end %}\n      ) {{ast.block}}\n    {%\
    \ end %}\n  {% elsif ast.is_a?(TupleLiteral) %}\n    { {% for i in 0...ast.size\
    \ %} input({{ast[i]}}, io: {{io}}), {% end %} }\n  {% elsif ast.is_a?(ArrayLiteral)\
    \ %}\n    [ {% for i in 0...ast.size %} input({{ast[i]}}, io: {{io}}), {% end\
    \ %} ]\n  {% elsif ast.is_a?(RangeLiteral) %}\n    Range.new(\n      input({{ast.begin}},\
    \ io: {{io}}),\n      input({{ast.end}}, io: {{io}}),\n      {{ast.excludes_end?}},\n\
    \    )\n  {% elsif ast.is_a?(If) %}\n    {{ast.cond}} ? input({{ast.then}}, io:\
    \ {{io}}) : input({{ast.else}}, io: {{io}})\n  {% elsif ast.is_a?(Assign) %}\n\
    \    {{ast.target}} = input({{ast.value}}, io: {{io}})\n  {% else %}\n    internal_input({{ast}},\
    \ {{ast}}, io: {{io}})\n  {% end %}\nend\n\nmacro input(*asts, io = STDIN)\n \
    \ { {% for ast in asts %} input({{ast}}, io: {{io}}), {% end %} }\nend\n\nmacro\
    \ input_column(types, size)\n  {% for type, i in types %}\n    %array{i} = Array({{type}}).new({{size}})\n\
    \  {% end %}\n  {{size}}.times do\n    {% for type, i in types %}\n      %array{i}\
    \ << input({{type}})\n    {% end %}\n  end\n  { {% for type, i in types %} %array{i},\
    \ {% end %} }\nend\n\nn, m, s, t = input(i, i, i, i)\ngraph = DirectedGraph.new\
    \ n, input({i, i, i64}[m])\nif dist_path = graph.dijkstra_with_path(s, t)\n  d,\
    \ path = dist_path\n  puts \"#{d} #{path.size - 1}\"\n  path.each_cons_pair do\
    \ |u, v|\n    puts \"#{u} #{v}\"\n  end\nelse\n  puts -1\nend\n"
  code: "# verification-helper: PROBLEM https://judge.yosupo.jp/problem/shortest_path\n\
    require \"../../src/graph/dijkstra\"\nrequire \"../../src/scanner\"\nn, m, s,\
    \ t = input(i, i, i, i)\ngraph = DirectedGraph.new n, input({i, i, i64}[m])\n\
    if dist_path = graph.dijkstra_with_path(s, t)\n  d, path = dist_path\n  puts \"\
    #{d} #{path.size - 1}\"\n  path.each_cons_pair do |u, v|\n    puts \"#{u} #{v}\"\
    \n  end\nelse\n  puts -1\nend\n"
  dependsOn:
  - src/graph/dijkstra.cr
  - src/datastructure/binary_heap.cr
  - src/graph.cr
  - src/graph/edge.cr
  - src/scanner.cr
  isVerificationFile: true
  path: test/graph/dijkstra_path_test.cr
  requiredBy: []
  timestamp: '2022-01-02 17:14:17+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/graph/dijkstra_path_test.cr
layout: document
redirect_from:
- /verify/test/graph/dijkstra_path_test.cr
- /verify/test/graph/dijkstra_path_test.cr.html
title: test/graph/dijkstra_path_test.cr
---
