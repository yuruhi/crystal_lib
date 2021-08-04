# verification-helper: PROBLEM https://onlinejudge.u-aizu.ac.jp/problems/GRL_5_A
require "../../src/graph/tree"
require "../../src/scanner"
n = input(i)
g = UndirectedGraph.new n, input({i, i, i}[n - 1])
puts g.diameter[0]
