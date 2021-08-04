# verification-helper: PROBLEM https://yukicoder.me/problems/no/416
require "../../src/datastructure/partially_persistent_union_find"
require "../../src/scanner"
n, m, q = read_line.split.map(&.to_i)
ab = input({i - 1, i - 1}[m])
cd = input({i - 1, i - 1}[q])

uf = PartiallyPersistentUnionFind.new(n)
(ab - cd).each { |a, b| uf.unite(a, b) }
begin_time = uf.now
cd.reverse_each { |c, d| uf.unite(c, d) }
end_time = uf.now

(1...n).each do |i|
  t = (begin_time..end_time).bsearch { |t| uf.same?(0, i, t) }
  if t.nil?
    puts 0
  elsif t == begin_time
    puts -1
  else
    puts end_time - t + 1
  end
end
