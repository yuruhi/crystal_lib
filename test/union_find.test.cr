# verification-helper: PROBLEM https://judge.yosupo.jp/problem/unionfind
require "../src/datastructure/union_find"
n, q = read_line.split.map(&.to_i)
uf = UnionFind.new(n)
q.times do
  t, u, v = read_line.split.map(&.to_i)
  if t == 0
    uf.unite(u, v)
  else
    puts uf.same?(u, v) ? 1 : 0
  end
end
