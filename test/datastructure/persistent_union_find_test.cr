# verification-helper: PROBLEM https://judge.yosupo.jp/problem/persistent_unionfind
require "../../src/datastructure/persistent_union_find"
n, q = read_line.split.map(&.to_i)
uf = {-1 => PersistentUnionFind.new(n)}
q.times do |i|
  t, k, u, v = read_line.split.map(&.to_i)
  case t
  when 0
    uf[i] = uf[k].unite(u, v)[1]
  when 1
    puts uf[k].same?(u, v) ? 1 : 0
  end
end
