# verification-helper: PROBLEM https://yukicoder.me/problems/no/416
require "../src/datastructure/partially_persistent_union_find"
n, m, q = read_line.split.map(&.to_i)
ab = Array.new(m) {
  {Int32, Int32}.from read_line.split.map(&.to_i.pred)
}
cd = Array.new(q) {
  {Int32, Int32}.from read_line.split.map(&.to_i.pred)
}
ab -= cd

uf = PartiallyPersistentUnionFind.new(n)
(ab - cd).each do |a, b|
  uf.unite(a, b)
end
begin_time = uf.now
cd.reverse_each do |c, d|
  uf.unite(c, d)
end
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
