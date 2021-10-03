---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/datastructure/partially_persistent_union_find.cr
    title: src/datastructure/partially_persistent_union_find.cr
  - icon: ':heavy_check_mark:'
    path: src/scanner.cr
    title: src/scanner.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://yukicoder.me/problems/no/416
  bundledCode: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/416\n\
    # require \"../../src/datastructure/partially_persistent_union_find\"\nclass PartiallyPersistentUnionFind\n\
    \  getter size : Int32, now : Int32\n\n  def initialize(size : Int)\n    @size\
    \ = size.to_i\n    @now = 0\n    @parent = Array(Int32).new(size, &.itself)\n\
    \    @rank = Array(Int32).new(size, 0)\n    @time = Array(Int32).new(size, Int32::MAX)\n\
    \    @num = Array(Array({Int32, Int32})).new(size) { [{0, 1}] }\n  end\n\n  def\
    \ root(x : Int, time : Int) : Int32\n    time < @time[x] ? x : root(@parent[x],\
    \ time)\n  end\n\n  def same?(x : Int, y : Int, time : Int) : Bool\n    root(x,\
    \ time) == root(y, time)\n  end\n\n  def unite(x : Int, y : Int) : Bool\n    @now\
    \ += 1\n    x, y = root(x, now), root(y, now)\n    return false if x == y\n  \
    \  x, y = y, x if @rank[x] < @rank[y]\n    @num[x] << {now, size(x, now) + size(y,\
    \ now)}\n    @parent[y] = x\n    @time[y] = now\n    @rank[x] += 1 if @rank[x]\
    \ == @rank[y]\n    true\n  end\n\n  def size(x : Int, time : Int) : Int\n    x\
    \ = root(x, time)\n    pos = @num[x].bsearch_index { |(t, s), _| t > time } ||\
    \ @num[x].size\n    @num[x][pos - 1][1]\n  end\nend\n\n# require \"../../src/scanner\"\
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
    \ input(Int32, Int64) # => {5, 10i64}\n# input(String, Char[m])     # => {\"foo\"\
    , ['b', 'a', 'r']}\n# input(Int32[n])            # => [1, 2, 3, 4, 5]\n# ```\n\
    # ```\n# n, m = input(i, i64) # => {5, 10i64}\n# input(s, c[m])       # => {\"\
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
    \ # => {[1, 2, 3], [2, 3, 1]}\n# ```\nclass Scanner\n  private def self.skip_to_not_space(io)\n\
    \    peek = io.peek\n    not_space = peek.index { |x| x != 32 && x != 10 } ||\
    \ peek.size\n    io.skip(not_space)\n  end\n\n  def self.c(io = STDIN)\n    skip_to_not_space(io)\n\
    \    io.read_char.not_nil!\n  end\n\n  private def self.int(int_type : T.class,\
    \ io = STDIN) : T forall T\n    skip_to_not_space(io)\n\n    value = T.zero\n\
    \    signed = false\n    case x = io.read_byte\n    when nil\n      raise IO::EOFError.new\n\
    \    when 45\n      signed = true\n    when 48..57\n      value = T.new 48 &-\
    \ x\n    else\n      return value\n    end\n\n    loop do\n      peek = io.peek\n\
    \      return signed ? value : -value if peek.empty?\n      i = 0\n      while\
    \ i < peek.size\n        c = peek.unsafe_fetch(i)\n        unless 48 <= c <= 57\n\
    \          io.skip(i &+ 1)\n          return signed ? value : -value\n       \
    \ end\n        value = value &* 10 &- c &+ 48\n        i &+= 1\n      end\n  \
    \    io.skip(i)\n    end\n  end\n\n  private def self.uint(uint_type : T.class,\
    \ io = STDIN) : T forall T\n    skip_to_not_space(io)\n    value = T.zero\n\n\
    \    loop do\n      peek = io.peek\n      return value if peek.empty?\n      i\
    \ = 0\n      while i < peek.size\n        c = peek.unsafe_fetch(i)\n        unless\
    \ 48 <= c <= 57\n          io.skip(i &+ 1)\n          return value\n        end\n\
    \        value = value &* 10 &+ c &- 48\n        i &+= 1\n      end\n      io.skip(i)\n\
    \    end\n  end\n\n  def i(io = STDIN)\n    int(Int32, io)\n  end\n\n  {% for\
    \ signed in [true, false] %}\n    {% for n in [8, 16, 32, 64, 128] %}\n      {%\n\
    \        name = signed ? \"i#{n}\".id : \"u#{n}\".id\n        type = signed ?\
    \ \"Int#{n}\".id : \"UInt#{n}\".id\n        method = signed ? \"int\".id : \"\
    uint\".id\n      %}\n      def self.{{name}}(io = STDIN)\n        {{method}}({{type}},\
    \ io)\n      end\n    {% end %}\n  {% end %}\n\n  def self.s(io = STDIN)\n   \
    \ skip_to_not_space(io)\n\n    peek = io.peek\n    if index = peek.index { |x|\
    \ x == 32 || x == 10 }\n      io.skip(index + 1)\n      return String.new(peek[0,\
    \ index])\n    end\n\n    String.build do |buffer|\n      loop do\n        buffer.write\
    \ peek\n        io.skip(peek.size)\n        peek = io.peek\n        break if peek.empty?\n\
    \        if index = peek.index { |x| x == 32 || x == 10 }\n          buffer.write\
    \ peek[0, index]\n          io.skip(index)\n          break\n        end\n   \
    \   end\n    end\n  end\nend\n\nmacro internal_input(type, else_ast)\n  {% if\
    \ Scanner.class.has_method?(type.id) %}\n    Scanner.{{type.id}}\n  {% elsif type.stringify\
    \ == \"String\" %}\n    Scanner.s\n  {% elsif type.stringify == \"Char\" %}\n\
    \    Scanner.c\n  {% elsif type.stringify =~ /[A-Z][a-z0-9_]*/ %}\n    {{type.id}}.new(Scanner.s)\n\
    \  {% elsif String.has_method?(\"to_#{type}\".id) %}\n    Scanner.s.to_{{type.id}}\n\
    \  {% else %}\n    {{else_ast}}\n  {% end %}\nend\n\nmacro internal_input_array(type,\
    \ args)\n  {% for i in 0...args.size %}\n    %size{i} = input({{args[i]}})\n \
    \ {% end %}\n  {% begin %}\n    {% for i in 0...args.size %} Array.new(%size{i})\
    \ { {% end %}\n      input({{type.id}})\n    {% for i in 0...args.size %} } {%\
    \ end %}\n  {% end %}\nend\n\nmacro input(type)\n  {% if type.is_a?(Call) %}\n\
    \    {% if type.receiver.is_a?(Nop) %}\n      internal_input(\n        {{type.name}},\
    \ {{type.name}}(\n          {% for argument in type.args %} input({{argument}}),\
    \ {% end %}\n        )\n      )\n    {% elsif type.name.stringify == \"[]\" %}\n\
    \      internal_input_array({{type.receiver}}, {{type.args}})\n    {% else %}\n\
    \      input({{type.receiver}}).{{type.name.id}}(\n        {% for argument in\
    \ type.args %} input({{argument}}), {% end %}\n      ) {{type.block}}\n    {%\
    \ end %}\n  {% elsif type.is_a?(TupleLiteral) %}\n    { {% for i in 0...type.size\
    \ %} input({{type[i]}}), {% end %} }\n  {% elsif type.is_a?(ArrayLiteral) %}\n\
    \    [ {% for i in 0...type.size %} input({{type[i]}}), {% end %} ]\n  {% elsif\
    \ type.is_a?(RangeLiteral) %}\n    Range.new(input({{type.begin}}), input({{type.end}}),\
    \ {{type.excludes_end?}})\n  {% elsif type.is_a?(If) %}\n    {{type.cond}} ? input({{type.then}})\
    \ : input({{type.else}})\n  {% elsif type.is_a?(Assign) %}\n    {{type.target}}\
    \ = input({{type.value}})\n  {% else %}\n    internal_input({{type.id}}, {{type.id}})\n\
    \  {% end %}\nend\n\nmacro input(*types)\n  { {% for type in types %} input({{type}}),\
    \ {% end %} }\nend\n\nmacro input_column(types, size)\n  {% for type, i in types\
    \ %}\n    %array{i} = Array({{type}}).new({{size}})\n  {% end %}\n  {{size}}.times\
    \ do\n    {% for type, i in types %}\n      %array{i} << input({{type}})\n   \
    \ {% end %}\n  end\n  { {% for type, i in types %} %array{i}, {% end %} }\nend\n\
    \nn, m, q = read_line.split.map(&.to_i)\nab = input({i - 1, i - 1}[m])\ncd = input({i\
    \ - 1, i - 1}[q])\n\nuf = PartiallyPersistentUnionFind.new(n)\n(ab - cd).each\
    \ { |a, b| uf.unite(a, b) }\nbegin_time = uf.now\ncd.reverse_each { |c, d| uf.unite(c,\
    \ d) }\nend_time = uf.now\n\n(1...n).each do |i|\n  t = (begin_time..end_time).bsearch\
    \ { |t| uf.same?(0, i, t) }\n  if t.nil?\n    puts 0\n  elsif t == begin_time\n\
    \    puts -1\n  else\n    puts end_time - t + 1\n  end\nend\n"
  code: "# verification-helper: PROBLEM https://yukicoder.me/problems/no/416\nrequire\
    \ \"../../src/datastructure/partially_persistent_union_find\"\nrequire \"../../src/scanner\"\
    \nn, m, q = read_line.split.map(&.to_i)\nab = input({i - 1, i - 1}[m])\ncd = input({i\
    \ - 1, i - 1}[q])\n\nuf = PartiallyPersistentUnionFind.new(n)\n(ab - cd).each\
    \ { |a, b| uf.unite(a, b) }\nbegin_time = uf.now\ncd.reverse_each { |c, d| uf.unite(c,\
    \ d) }\nend_time = uf.now\n\n(1...n).each do |i|\n  t = (begin_time..end_time).bsearch\
    \ { |t| uf.same?(0, i, t) }\n  if t.nil?\n    puts 0\n  elsif t == begin_time\n\
    \    puts -1\n  else\n    puts end_time - t + 1\n  end\nend\n"
  dependsOn:
  - src/datastructure/partially_persistent_union_find.cr
  - src/scanner.cr
  isVerificationFile: true
  path: test/datastructure/partially_persistent_union_find_test.cr
  requiredBy: []
  timestamp: '2021-10-03 16:36:21+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: test/datastructure/partially_persistent_union_find_test.cr
layout: document
redirect_from:
- /verify/test/datastructure/partially_persistent_union_find_test.cr
- /verify/test/datastructure/partially_persistent_union_find_test.cr.html
title: test/datastructure/partially_persistent_union_find_test.cr
---
