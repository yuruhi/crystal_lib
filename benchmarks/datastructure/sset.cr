require "benchmark"
require "../../src/datastructure/sset/red_black_tree"
require "../../src/datastructure/sset/treap"
require "../../src/datastructure/sset/bucket"

private def add(type : T.class, x, label, values) forall T
  x.report(label) do
    set = T.new
    values.each { |x| set.add x }
  end
end

private def add_delete(type : T.class, x, label, values) forall T
  x.report(label) do
    set = T.new
    values.each { |x| set.add x }
    values.each { |x| set.delete x }
  end
end

private def each(type : T.class, x, label, n) forall T
  set = T.new 0...n
  x.report(label) do
    s = 0i64
    set.each { |x| s += x }
  end
end

private def includes?(type : T.class, x, label, n) forall T
  set = T.new (0...n).step(by: 2)
  x.report(label) do
    (0...n).each { |x| set.includes?(x) }
  end
end

private def add_includes?(type : T.class, x, label, values, n) forall T
  x.report(label) do
    set = T.new
    values.each { |x| set << x }
    (0...n).each { |x| set.includes?(x) }
  end
end

private def ge(type : T.class, x, label, n) forall T
  set = T.new (0...n).step(by: 2)
  x.report(label) do
    (0...n).each { |x| set.ge(x) }
  end
end

R = Random.new(42)
values5 = (0...10**5).to_a.shuffle(R)
values6 = (0...10**6).to_a.shuffle(R)
{% begin %}
  {% hash = {
       "SSet::RedBlackTree"              => "RBT",
       "SSet::Treap"                     => "Treap",
       "SSet::Bucket(Int32, 1, 170, 0)"  => "Bucket( 1, false)",
       "SSet::Bucket(Int32, 30, 170, 0)" => "Bucket(30, false)",
       "SSet::Bucket(Int32, 60, 170, 0)" => "Bucket(60, false)",
       "SSet::Bucket(Int32, 90, 170, 0)" => "Bucket(90, false)",
       "SSet::Bucket(Int32, 1, 170, 1)"  => "Bucket( 1,  true)",
       "SSet::Bucket(Int32, 30, 170, 1)" => "Bucket(30,  true)",
       "SSet::Bucket(Int32, 60, 170, 1)" => "Bucket(60,  true)",
       "SSet::Bucket(Int32, 90, 170, 1)" => "Bucket(90,  true)",
     } %}

  puts "#add (1e5 times)"
  Benchmark.ips do |x|
    {% for type, label in hash %} add({{type.id}}, x, {{label}}, values5); {% end %}
  end

  puts "\n#add and #delete (1e5 times)"
  Benchmark.ips do |x|
    {% for type, label in hash %} add_delete({{type.id}}, x, {{label}}, values5); {% end %}
  end

  puts "\n#add (1e6 times)"
  Benchmark.ips do |x|
    {% for type, label in hash %} add({{type.id}}, x, {{label}}, values6); {% end %}
  end

  puts "\n#add (1e6 times) and #delete (1e6 times)"
  Benchmark.ips do |x|
    {% for type, label in hash %} add_delete({{type.id}}, x, {{label}}, values6); {% end %}
  end

  puts "\n#add (1e6 times) and #includes? (1e6 times)"
  Benchmark.ips do |x|
    {% for type, label in hash %} add_includes?({{type.id}}, x, {{label}}, values6, 10**6); {% end %}
  end

  puts "\n#each (1e6 elements)"
  Benchmark.ips do |x|
    {% for type, label in hash %} each({{type.id}}, x, {{label}}, 10**6); {% end %}
  end

  puts "\n#includes? (1e6 times with 5e5 elements)"
  Benchmark.ips do |x|
    {% for type, label in hash %} includes?({{type.id}}, x, {{label}}, 10**6); {% end %}
  end

  puts "\n#ge (1e6 times with 5e5 elements)"
  Benchmark.ips do |x|
    {% for type, label in hash %} ge({{type.id}}, x, {{label}}, 10**6); {% end %}
  end
{% end %}
