---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/graph/edge_spec.cr
    title: spec/graph/edge_spec.cr
  - icon: ':warning:'
    path: src/graph.cr
    title: src/graph.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
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
    \ to : Int32\n\n  def initialize(@to)\n  end\n\n  def cost\n    1\n  end\n\n \
    \ def to_s(io) : Nil\n    io << to\n  end\n\n  def inspect(io) : Nil\n    io <<\
    \ \"->\" << to\n  end\nend\n\nstruct UnweightedEdge2\n  property from : Int32,\
    \ to : Int32\n\n  def initialize(@from, @to)\n  end\n\n  def initialize(@from,\
    \ edge : UnweightedEdge)\n    @to = edge.to\n  end\n\n  def cost\n    1\n  end\n\
    \n  def reverse\n    UnweightedEdge2.new(to, from)\n  end\n\n  def sort\n    UnweightedEdge2.new(*{to,\
    \ from}.minmax)\n  end\n\n  def to_s(io) : Nil\n    io << '(' << from << \", \"\
    \ << to << ')'\n  end\n\n  def inspect(io) : Nil\n    io << from << \"->\" <<\
    \ to\n  end\nend\n"
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
    \n  def initialize(@to)\n  end\n\n  def cost\n    1\n  end\n\n  def to_s(io) :\
    \ Nil\n    io << to\n  end\n\n  def inspect(io) : Nil\n    io << \"->\" << to\n\
    \  end\nend\n\nstruct UnweightedEdge2\n  property from : Int32, to : Int32\n\n\
    \  def initialize(@from, @to)\n  end\n\n  def initialize(@from, edge : UnweightedEdge)\n\
    \    @to = edge.to\n  end\n\n  def cost\n    1\n  end\n\n  def reverse\n    UnweightedEdge2.new(to,\
    \ from)\n  end\n\n  def sort\n    UnweightedEdge2.new(*{to, from}.minmax)\n  end\n\
    \n  def to_s(io) : Nil\n    io << '(' << from << \", \" << to << ')'\n  end\n\n\
    \  def inspect(io) : Nil\n    io << from << \"->\" << to\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/graph/edge.cr
  requiredBy:
  - src/graph.cr
  - spec/graph/edge_spec.cr
  timestamp: '2021-08-04 09:23:20+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/graph/edge.cr
layout: document
redirect_from:
- /library/src/graph/edge.cr
- /library/src/graph/edge.cr.html
title: src/graph/edge.cr
---
