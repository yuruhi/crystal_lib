---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/graph/edge.cr
    title: src/graph/edge.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../src/graph/edge\"\nstruct WeightedEdge(T)\n\
    \  include Comparable(WeightedEdge(T))\n\n  property to : Int32, cost : T\n\n\
    \  def initialize(@to, @cost : T)\n  end\n\n  def <=>(other : WeightedEdge(T))\n\
    \    {cost, to} <=> {other.cost, other.to}\n  end\n\n  def to_s(io) : Nil\n  \
    \  io << '(' << to << \", \" << cost << ')'\n  end\n\n  def inspect(io) : Nil\n\
    \    io << \"->\" << to << '(' << cost << ')'\n  end\nend\n\nstruct WeightedEdge2(T)\n\
    \  include Comparable(WeightedEdge2(T))\n\n  property from : Int32, to : Int32,\
    \ cost : T\n\n  def initialize(@from, @to, @cost : T)\n  end\n\n  def initialize(@from,\
    \ edge : WeightedEdge(T))\n    @to, @cost = edge.to, edge.cost\n  end\n\n  def\
    \ <=>(other : WeightedEdge2(T))\n    {cost, from, to} <=> {other.cost, other.from,\
    \ other.to}\n  end\n\n  def reverse : self\n    WeightedEdge2(T).new(to, from,\
    \ cost)\n  end\n\n  def sort : self\n    WeightedEdge2(T).new(*{to, from}.minmax,\
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
    \ inspect(io) : Nil\n    io << from << \"->\" << to\n  end\nend\n\ndescribe WeightedEdge\
    \ do\n  it \"#to, #cost\" do\n    WeightedEdge.new(2, 10i64).to.should eq 2\n\
    \    WeightedEdge.new(2, 10i64).cost.should eq 10i64\n  end\n\n  it \"#<=>\" do\n\
    \    (WeightedEdge.new(2, 10) <=> WeightedEdge.new(3, 4)).should eq 1\n    (WeightedEdge.new(2,\
    \ 10) <=> WeightedEdge.new(2, 11)).should eq -1\n    (WeightedEdge.new(2, 10)\
    \ <=> WeightedEdge.new(3, 10)).should eq -1\n    (WeightedEdge.new(2, 10) <=>\
    \ WeightedEdge.new(0, 11)).should eq -1\n    (WeightedEdge.new(2, 10) <=> WeightedEdge.new(2,\
    \ 10)).should eq 0\n  end\n\n  it \"#to_s\" do\n    WeightedEdge.new(2, 3).to_s.should\
    \ eq \"(2, 3)\"\n  end\n\n  it \"#inspect\" do\n    WeightedEdge.new(2, 3).inspect.should\
    \ eq \"->2(3)\"\n  end\nend\n\ndescribe WeightedEdge2 do\n  it \"#from, #to, #cost\"\
    \ do\n    WeightedEdge2.new(2, 3, 4).from.should eq 2\n    WeightedEdge2.new(2,\
    \ 3, 4).to.should eq 3\n    WeightedEdge2.new(2, 3, 4).cost.should eq 4\n  end\n\
    \n  it \"#<=>\" do\n    (WeightedEdge2.new(2, 42, 10) <=> WeightedEdge2.new(3,\
    \ 42, 4)).should eq 1\n    (WeightedEdge2.new(2, 42, 10) <=> WeightedEdge2.new(2,\
    \ 42, 11)).should eq -1\n    (WeightedEdge2.new(2, 42, 10) <=> WeightedEdge2.new(3,\
    \ 42, 10)).should eq -1\n    (WeightedEdge2.new(2, 42, 10) <=> WeightedEdge2.new(0,\
    \ 42, 11)).should eq -1\n    (WeightedEdge2.new(2, 42, 10) <=> WeightedEdge2.new(2,\
    \ 42, 10)).should eq 0\n    (WeightedEdge2.new(2, 42, 10) <=> WeightedEdge2.new(2,\
    \ 43, 10)).should eq -1\n  end\n\n  it \"#reverse\" do\n    WeightedEdge2.new(2,\
    \ 3, 4).reverse.should eq WeightedEdge2.new(3, 2, 4)\n  end\n\n  it \"#sort\"\
    \ do\n    WeightedEdge2.new(2, 3, 4).sort.should eq WeightedEdge2.new(2, 3, 4)\n\
    \    WeightedEdge2.new(3, 2, 4).sort.should eq WeightedEdge2.new(2, 3, 4)\n  end\n\
    \n  it \"#to_s\" do\n    WeightedEdge2.new(2, 3, 4).to_s.should eq \"(2, 3, 4)\"\
    \n  end\n\n  it \"inspect\" do\n    WeightedEdge2.new(2, 3, 4).inspect.should\
    \ eq \"2->3(4)\"\n  end\nend\n\ndescribe UnweightedEdge do\n  it \"#to, #cost\"\
    \ do\n    UnweightedEdge.new(2).to.should eq 2\n    UnweightedEdge.new(2).cost.should\
    \ eq 1\n  end\n\n  it \"#to_s\" do\n    UnweightedEdge.new(2).to_s.should eq \"\
    2\"\n  end\n\n  it \"inspect\" do\n    UnweightedEdge.new(2).inspect.should eq\
    \ \"->2\"\n  end\nend\n\ndescribe UnweightedEdge2 do\n  it \"#from, #to, #cost\"\
    \ do\n    UnweightedEdge2.new(2, 3).from.should eq 2\n    UnweightedEdge2.new(2,\
    \ 3).to.should eq 3\n    UnweightedEdge2.new(2, 3).cost.should eq 1\n  end\n\n\
    \  it \"#reverse\" do\n    UnweightedEdge2.new(2, 3).reverse.should eq UnweightedEdge2.new(3,\
    \ 2)\n  end\n\n  it \"#sort\" do\n    UnweightedEdge2.new(2, 3).sort.should eq\
    \ UnweightedEdge2.new(2, 3)\n    UnweightedEdge2.new(3, 2).sort.should eq UnweightedEdge2.new(2,\
    \ 3)\n  end\n\n  it \"#to_s\" do\n    UnweightedEdge2.new(2, 3).to_s.should eq\
    \ \"(2, 3)\"\n  end\n\n  it \"inspect\" do\n    UnweightedEdge2.new(2, 3).inspect.should\
    \ eq \"2->3\"\n  end\nend\n"
  code: "require \"spec\"\nrequire \"../../src/graph/edge\"\n\ndescribe WeightedEdge\
    \ do\n  it \"#to, #cost\" do\n    WeightedEdge.new(2, 10i64).to.should eq 2\n\
    \    WeightedEdge.new(2, 10i64).cost.should eq 10i64\n  end\n\n  it \"#<=>\" do\n\
    \    (WeightedEdge.new(2, 10) <=> WeightedEdge.new(3, 4)).should eq 1\n    (WeightedEdge.new(2,\
    \ 10) <=> WeightedEdge.new(2, 11)).should eq -1\n    (WeightedEdge.new(2, 10)\
    \ <=> WeightedEdge.new(3, 10)).should eq -1\n    (WeightedEdge.new(2, 10) <=>\
    \ WeightedEdge.new(0, 11)).should eq -1\n    (WeightedEdge.new(2, 10) <=> WeightedEdge.new(2,\
    \ 10)).should eq 0\n  end\n\n  it \"#to_s\" do\n    WeightedEdge.new(2, 3).to_s.should\
    \ eq \"(2, 3)\"\n  end\n\n  it \"#inspect\" do\n    WeightedEdge.new(2, 3).inspect.should\
    \ eq \"->2(3)\"\n  end\nend\n\ndescribe WeightedEdge2 do\n  it \"#from, #to, #cost\"\
    \ do\n    WeightedEdge2.new(2, 3, 4).from.should eq 2\n    WeightedEdge2.new(2,\
    \ 3, 4).to.should eq 3\n    WeightedEdge2.new(2, 3, 4).cost.should eq 4\n  end\n\
    \n  it \"#<=>\" do\n    (WeightedEdge2.new(2, 42, 10) <=> WeightedEdge2.new(3,\
    \ 42, 4)).should eq 1\n    (WeightedEdge2.new(2, 42, 10) <=> WeightedEdge2.new(2,\
    \ 42, 11)).should eq -1\n    (WeightedEdge2.new(2, 42, 10) <=> WeightedEdge2.new(3,\
    \ 42, 10)).should eq -1\n    (WeightedEdge2.new(2, 42, 10) <=> WeightedEdge2.new(0,\
    \ 42, 11)).should eq -1\n    (WeightedEdge2.new(2, 42, 10) <=> WeightedEdge2.new(2,\
    \ 42, 10)).should eq 0\n    (WeightedEdge2.new(2, 42, 10) <=> WeightedEdge2.new(2,\
    \ 43, 10)).should eq -1\n  end\n\n  it \"#reverse\" do\n    WeightedEdge2.new(2,\
    \ 3, 4).reverse.should eq WeightedEdge2.new(3, 2, 4)\n  end\n\n  it \"#sort\"\
    \ do\n    WeightedEdge2.new(2, 3, 4).sort.should eq WeightedEdge2.new(2, 3, 4)\n\
    \    WeightedEdge2.new(3, 2, 4).sort.should eq WeightedEdge2.new(2, 3, 4)\n  end\n\
    \n  it \"#to_s\" do\n    WeightedEdge2.new(2, 3, 4).to_s.should eq \"(2, 3, 4)\"\
    \n  end\n\n  it \"inspect\" do\n    WeightedEdge2.new(2, 3, 4).inspect.should\
    \ eq \"2->3(4)\"\n  end\nend\n\ndescribe UnweightedEdge do\n  it \"#to, #cost\"\
    \ do\n    UnweightedEdge.new(2).to.should eq 2\n    UnweightedEdge.new(2).cost.should\
    \ eq 1\n  end\n\n  it \"#to_s\" do\n    UnweightedEdge.new(2).to_s.should eq \"\
    2\"\n  end\n\n  it \"inspect\" do\n    UnweightedEdge.new(2).inspect.should eq\
    \ \"->2\"\n  end\nend\n\ndescribe UnweightedEdge2 do\n  it \"#from, #to, #cost\"\
    \ do\n    UnweightedEdge2.new(2, 3).from.should eq 2\n    UnweightedEdge2.new(2,\
    \ 3).to.should eq 3\n    UnweightedEdge2.new(2, 3).cost.should eq 1\n  end\n\n\
    \  it \"#reverse\" do\n    UnweightedEdge2.new(2, 3).reverse.should eq UnweightedEdge2.new(3,\
    \ 2)\n  end\n\n  it \"#sort\" do\n    UnweightedEdge2.new(2, 3).sort.should eq\
    \ UnweightedEdge2.new(2, 3)\n    UnweightedEdge2.new(3, 2).sort.should eq UnweightedEdge2.new(2,\
    \ 3)\n  end\n\n  it \"#to_s\" do\n    UnweightedEdge2.new(2, 3).to_s.should eq\
    \ \"(2, 3)\"\n  end\n\n  it \"inspect\" do\n    UnweightedEdge2.new(2, 3).inspect.should\
    \ eq \"2->3\"\n  end\nend\n"
  dependsOn:
  - src/graph/edge.cr
  isVerificationFile: false
  path: spec/graph/edge_spec.cr
  requiredBy: []
  timestamp: '2022-04-16 16:03:43+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/graph/edge_spec.cr
layout: document
redirect_from:
- /library/spec/graph/edge_spec.cr
- /library/spec/graph/edge_spec.cr.html
title: spec/graph/edge_spec.cr
---
