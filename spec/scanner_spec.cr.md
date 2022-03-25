---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: src/scanner.cr
    title: src/scanner.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../src/scanner\"\nmodule Scanner\n\
    \  extend self\n\n  private def skip_to_not_space(io)\n    peek = io.peek\n  \
    \  not_space = peek.index { |x| x != 32 && x != 10 } || peek.size\n    io.skip(not_space)\n\
    \  end\n\n  def c(io = STDIN)\n    skip_to_not_space(io)\n    io.read_char.not_nil!\n\
    \  end\n\n  private def int(int_type : T.class, io = STDIN) : T forall T\n   \
    \ skip_to_not_space(io)\n\n    value = T.zero\n    signed = false\n    case x\
    \ = io.read_byte\n    when nil\n      raise IO::EOFError.new\n    when 45\n  \
    \    signed = true\n    when 48..57\n      value = T.new 48 &- x\n    else\n \
    \     raise \"Unexpected char: #{x.chr}\"\n    end\n\n    loop do\n      peek\
    \ = io.peek\n      return signed ? value : -value if peek.empty?\n      i = 0\n\
    \      while i < peek.size\n        c = peek.unsafe_fetch(i)\n        if 48 <=\
    \ c <= 57\n          value = value &* 10 &- c &+ 48\n          i &+= 1\n     \
    \   elsif c == 32 || c == 10\n          io.skip(i &+ 1)\n          return signed\
    \ ? value : -value\n        else\n          raise \"Unexpected char: #{c.chr}\"\
    \n        end\n      end\n      io.skip(i)\n    end\n  end\n\n  private def uint(uint_type\
    \ : T.class, io = STDIN) : T forall T\n    skip_to_not_space(io)\n    value =\
    \ T.zero\n    found_digit = false\n    loop do\n      peek = io.peek\n      if\
    \ peek.empty?\n        if found_digit\n          return value\n        else\n\
    \          raise IO::EOFError.new\n        end\n      end\n      i = 0\n     \
    \ while i < peek.size\n        c = peek.unsafe_fetch(i)\n        if 48 <= c <=\
    \ 57\n          found_digit = true\n          value = value &* 10 &+ c &- 48\n\
    \          i &+= 1\n        elsif c == 32 || c == 10\n          io.skip(i &+ 1)\n\
    \          return value\n        else\n          raise \"Unexpected char: #{c.chr}\"\
    \n        end\n      end\n      io.skip(i)\n    end\n  end\n\n  def i(io = STDIN)\n\
    \    int(Int32, io)\n  end\n\n  {% for n in [8, 16, 32, 64, 128] %}\n    def i{{n}}(io\
    \ = STDIN)\n      int(Int{{n}}, io)\n    end\n\n    def u{{n}}(io = STDIN)\n \
    \     uint(UInt{{n}}, io)\n    end\n  {% end %}\n\n  {% for method in [:f, :f32,\
    \ :f64] %}\n    def {{method.id}}(io = STDIN)\n      s(io).to_{{method.id}}\n\
    \    end\n  {% end %}\n\n  def s(io = STDIN)\n    skip_to_not_space(io)\n\n  \
    \  peek = io.peek\n    if peek.empty?\n      raise IO::EOFError.new\n    end\n\
    \    if index = peek.index { |x| x == 32 || x == 10 }\n      io.skip(index + 1)\n\
    \      return String.new(peek[0, index])\n    end\n\n    String.build do |buffer|\n\
    \      loop do\n        buffer.write peek\n        io.skip(peek.size)\n      \
    \  peek = io.peek\n        break if peek.empty?\n        if index = peek.index\
    \ { |x| x == 32 || x == 10 }\n          buffer.write peek[0, index]\n        \
    \  io.skip(index + 1)\n          break\n        end\n      end\n    end\n  end\n\
    end\n\nmacro internal_input(type, else_ast, io)\n  {% if Scanner.class.has_method?(type.id)\
    \ %}\n    Scanner.{{type.id}}({{io}})\n  {% elsif type.stringify == \"String\"\
    \ %}\n    Scanner.s({{io}})\n  {% elsif type.stringify == \"Char\" %}\n    Scanner.c({{io}})\n\
    \  {% elsif type.is_a?(Path) %}\n    {% if type.resolve.class.has_method?(:scan)\
    \ %}\n      {{type}}.scan(Scanner, {{io}})\n    {% else %}\n      {{type}}.new(Scanner.s({{io}}))\n\
    \    {% end %}\n  {% elsif String.has_method?(\"to_#{type}\".id) %}\n    Scanner.s({{io}}).to_{{type.id}}\n\
    \  {% else %}\n    {{else_ast}}\n  {% end %}\nend\n\nmacro internal_input_array(type,\
    \ args, io)\n  {% for i in 0...args.size %}\n    %size{i} = input({{args[i]}},\
    \ io: {{io}})\n  {% end %}\n  {% begin %}\n    {% for i in 0...args.size %} Array.new(%size{i})\
    \ { {% end %}\n      input({{type.id}}, io: {{io}})\n    {% for i in 0...args.size\
    \ %} } {% end %}\n  {% end %}\nend\n\n# Inputs from *io*.\n#\n# ### Specifications\n\
    #\n# ```plain\n# AST               | Example             | Expanded code\n# ------------------+---------------------+---------------------------------------\n\
    # Uppercase string  | Int32, Int64, etc.  | {}.new(Scanner.s)\n#             \
    \      | s, c, i, iN, uN     | Scanner.{}\n#                   | f, big_i, etc.\
    \      | Scanner.s.to_{}\n# Call []           | type[size]          | Array.new(input(size))\
    \ { input(type) }\n# TupleLiteral      | {t1, t2, t3}        | {input(t1), input(t2),\
    \ input(t3)}\n# ArrayLiteral      | [t1, t2, t3]        | [input(t1), input(t2),\
    \ input(t3)]\n# HashLiteral       | {t1 => t2}          | {input(t1) => input(t2)}\n\
    # NamedTupleLiteral | {a: t1, b: t2}      | {a: input(t1), b: input(t2)}\n# RangeLiteral\
    \      | t1..t2              | input(t1)..input(t2)\n# Expressions       | (exp1;\
    \ exp2)        | (input(exp1); input(exp2);)\n# If                | cond ? t1\
    \ : t2      | input(cond) ? input(t1) : input(t2)\n# Assign            | target\
    \ = value      | target = input(value)\n# ```\n#\n# ### Examples\n#\n# Input:\n\
    # ```plain\n# 5 3\n# foo bar\n# 1 2 3 4 5\n# ```\n# ```\n# n, m = input(Int32,\
    \ Int64) # => {5, 5i64}\n# input(String, Char[m])     # => {\"foo\", ['b', 'a',\
    \ 'r']}\n# input(Int32[n])            # => [1, 2, 3, 4, 5]\n# ```\n# ```\n# n,\
    \ m = input(i, i64) # => {5, 5i64}\n# input(s, c[m])       # => {\"foo\", ['b',\
    \ 'a', 'r']}\n# input(i[n])          # => [1, 2, 3, 4, 5]\n# ```\n#\n# Input:\n\
    # ```plain\n# 2 3\n# 1 2 3\n# 4 5 6\n# ```\n#\n# ```\n# h, w = input(i, i) # =>\
    \ {2, 3}\n# input(i[h, w])     # => [[1, 2, 3], [4, 5, 6]]\n# ```\n# ```\n# input(i[i,\
    \ i]) # => [[1, 2, 3], [4, 5, 6]]\n# ```\n#\n# Input:\n# ```plain\n# 5 3\n# 3\
    \ 1 4 2 5\n# 1 2\n# 2 3\n# 3 1\n# ```\n# ```\n# n, m = input(i, i)       # =>\
    \ {5, 3}\n# input(i.pred[n])         # => [2, 0, 3, 1, 4]\n# input({i - 1, i -\
    \ 1}[m]) # => [{0, 1}, {1, 2}, {2, 0}]\n# ```\n#\n# Input:\n# ```plain\n# 3\n\
    # 1 2\n# 2 2\n# 3 2\n# ```\n# ```\n# input({tmp = i, tmp == 1 ? i : i.pred}[i])\
    \ # => [{1, 2}, {2, 1}, {3, 1}]\n# ```\n#\n# Input:\n# ```plain\n# 3\n# 1 1\n\
    # 2 1 2\n# 5 1 2 3 4 5\n# ```\n# ```\n# n = input(i)   # => 3\n# input(i[i][n])\
    \ # => [[1], [1, 2], [1, 2, 3, 4, 5]]\n# ```\n#\n# Input:\n# ```plain\n# 3\n#\
    \ 1 2\n# 2 3\n# 3 1\n# ```\n# ```\n# n = input(i)\n# input_column({Int32, Int32},\
    \ n) # => {[1, 2, 3], [2, 3, 1]}\n# ```\nmacro input(ast, *, io = STDIN)\n  {%\
    \ if ast.is_a?(Call) %}\n    {% if ast.receiver.is_a?(Nop) %}\n      internal_input(\n\
    \        {{ast.name}},\n        {{ast.name}}({% for argument in ast.args %} input({{argument}},\
    \ io: {{io}}), {% end %}),\n        {{io}},\n      )\n    {% elsif ast.receiver.is_a?(Path)\
    \ && ast.receiver.resolve.class.has_method?(ast.name.symbolize) %}\n      {{ast.receiver}}.{{ast.name}}(\n\
    \        {% for argument in ast.args %} input({{argument}}, io: {{io}}) {% end\
    \ %}\n      ) {{ast.block}}\n    {% elsif ast.name.stringify == \"[]\" %}\n  \
    \    internal_input_array({{ast.receiver}}, {{ast.args}}, {{io}})\n    {% else\
    \ %}\n      input({{ast.receiver}}, io: {{io}}).{{ast.name}}(\n        {% for\
    \ argument in ast.args %} input({{argument}}, io: {{io}}), {% end %}\n      )\
    \ {{ast.block}}\n    {% end %}\n  {% elsif ast.is_a?(TupleLiteral) %}\n    { {%\
    \ for i in 0...ast.size %} input({{ast[i]}}, io: {{io}}), {% end %} }\n  {% elsif\
    \ ast.is_a?(ArrayLiteral) %}\n    [ {% for i in 0...ast.size %} input({{ast[i]}},\
    \ io: {{io}}), {% end %} ]\n  {% elsif ast.is_a?(HashLiteral) %}\n    { {% for\
    \ key, value in ast %} input({{key}}, io: {{io}}) => input({{value}}, io: {{io}}),\
    \ {% end %} }\n  {% elsif ast.is_a?(NamedTupleLiteral) %}\n    { {% for key, value\
    \ in ast %} {{key}}: input({{value}}, io: {{io}}), {% end %} }\n  {% elsif ast.is_a?(RangeLiteral)\
    \ %}\n    Range.new(\n      input({{ast.begin}}, io: {{io}}),\n      input({{ast.end}},\
    \ io: {{io}}),\n      {{ast.excludes_end?}},\n    )\n  {% elsif ast.is_a?(SymbolLiteral)\
    \ %}\n    {{ast.id}}\n  {% elsif ast.is_a?(Expressions) %}\n    ( {% for exp in\
    \ ast.expressions %} input({{exp}}, io: {{io}}); {% end %} )\n  {% elsif ast.is_a?(If)\
    \ %}\n    input({{ast.cond}}, io: {{io}}) ? input({{ast.then}}, io: {{io}}) :\
    \ input({{ast.else}}, io: {{io}})\n  {% elsif ast.is_a?(Assign) %}\n    {{ast.target}}\
    \ = input({{ast.value}}, io: {{io}})\n  {% else %}\n    internal_input({{ast}},\
    \ {{ast}}, io: {{io}})\n  {% end %}\nend\n\nmacro input(*asts, io = STDIN)\n \
    \ { {% for ast in asts %} input({{ast}}, io: {{io}}), {% end %} }\nend\n\nmacro\
    \ input_column(types, size, *, io = STDIN)\n  %size = {{size}}\n  {% for type,\
    \ i in types %}\n    %array{i} = Array({{type}}).new(%size)\n  {% end %}\n  %size.times\
    \ do\n    {% for type, i in types %}\n      %array{i} << input({{type}}, io: {{io}})\n\
    \    {% end %}\n  end\n  { {% for type, i in types %} %array{i}, {% end %} }\n\
    end\n\nprivate macro check(method, input, expect)\n  %io = IO::Memory.new {{input}}\n\
    \  ({{expect}}).each { |str| Scanner.{{method.id}}(%io).should eq str }\n  expect_raises(IO::EOFError)\
    \ { Scanner.{{method.id}}(%io) }\nend\n\nprivate macro check_raises(method, input,\
    \ exception)\n  %io = IO::Memory.new {{input}}\n  expect_raises({{exception}})\
    \ { Scanner.{{method.id}}(%io) }\nend\n\nprivate macro describe_scan_int(type,\
    \ method)\n  {% signed = type.stringify =~ /$Int\\d+^/ %}\n  describe \".{{method.id}}\"\
    \ do\n    it \"read integer separated by spaces or new lines\" do\n      check\
    \ {{method}}, \"0 1 2 3\\n4 5 6\\n7 08 009\", 0..9\n      {% if signed %}\n  \
    \      check {{method}}, \"-0 -1 -2 -3\\n-4 -5 -6\\n-7 -08 -009\", 0.to(-9)\n\
    \      {% end %}\n      check {{method}}, \" \\n\\n1  2\\n  \\n\\n 3\\n\\n \"\
    , 1..3\n    end\n\n    it \"raise if read unexpected charactor\" do\n      check_raises\
    \ {{method}}, \"\", IO::EOFError\n      check_raises {{method}}, \"@\", Exception\n\
    \      check_raises {{method}}, \" @\", Exception\n      check_raises {{method}},\
    \ \"123@\", Exception\n      check_raises {{method}}, \" 123@\", Exception\n \
    \   end\n\n    it \"read {{type}}::MIN and {{type}}::MAX\" do\n      min, max\
    \ = {{type}}::MIN, {{type}}::MAX\n      a = (min..min + 100).to_a + (max - 100..max).to_a\n\
    \      check {{method}}, a.join(' '), a\n    end\n  end\nend\n\ndescribe Scanner\
    \ do\n  describe \".s\" do\n    it \"read string separated by spaces or new lines\"\
    \ do\n      check :s, \"a b\\nc d\", %w[a b c d]\n      check :s, \"  \\na  b\
    \ \\n c  \\n\\n  d  \\n\", %w[a b c d]\n      check :s, \"aaabbbccc\", [\"aaabbbccc\"\
    ]\n    end\n\n    it \"read long string\" do\n      str = ('a'..'z').join * 1000\n\
    \      check :s, \"#{str} #{str}\\n#{str}\", [str, str, str]\n    end\n  end\n\
    \n  describe_scan_int Int32, :i\n  describe_scan_int Int8, :i8\n  describe_scan_int\
    \ Int16, :i16\n  describe_scan_int Int32, :i32\n  describe_scan_int Int64, :i64\n\
    \  describe_scan_int Int128, :i128\n  describe_scan_int UInt8, :u8\n  describe_scan_int\
    \ UInt16, :u16\n  describe_scan_int UInt32, :u32\n  describe_scan_int UInt64,\
    \ :u64\n  describe_scan_int UInt128, :u128\nend\n\nprivate macro assert_input(ast,\
    \ input, expect)\n  %io = IO::Memory.new {{input}}\n  input({{ast}}, io: %io).should\
    \ eq({{expect}})\nend\n\nprivate macro assert_input_column(types, size, input,\
    \ expect)\n  %io = IO::Memory.new {{input}}\n  input_column({{types}}, {{size}},\
    \ io: %io).should eq({{expect}})\nend\n\nprivate struct Scannable\n  getter x\
    \ : Int32, y : Int32\n\n  def initialize(@x, @y)\n  end\n\n  def self.scan(scanner,\
    \ io)\n    Scannable.new scanner.i(io), scanner.i(io)\n  end\n\n  def sum\n  \
    \  x + y\n  end\nend\n\ndescribe \"input\" do\n  it \"reads integer\" do\n   \
    \ {% for iu in %i[i u] %} {% for n in %w[8 16 32 64] %}\n      assert_input {{((iu\
    \ == :i ? \"Int\" : \"UInt\") + n).id}}, \"42\", 42\n      assert_input {{(iu\
    \ + n).id}}, \"42\", 42\n    {% end %} {% end %}\n  end\n\n  it \"reads string\
    \ and char\" do\n    assert_input c, \"abc\\ndef\", 'a'\n    assert_input s, \"\
    abc\\ndef\", \"abc\"\n    assert_input Char, \"abc\\ndef\", 'a'\n    assert_input\
    \ [Char, Char, Char], \"ab \\n c\", ['a', 'b', 'c']\n    assert_input String,\
    \ \"abc\\ndef\", \"abc\"\n    assert_input String, \"abc def\", \"abc\"\n  end\n\
    \n  it \"reads float\" do\n    assert_input f, \"3.14\", 3.14\n    assert_input\
    \ f32, \"3.14\", 3.14f32\n    assert_input f64, \"3.14\", 3.14\n    assert_input\
    \ Float32, \"3.14\", 3.14f32\n    assert_input Float64, \"3.14\", 3.14\n  end\n\
    \n  it \"reads literal\" do\n    assert_input 42, \"\", 42\n    assert_input 3.14,\
    \ \"\", 3.14\n    assert_input nil, \"\", nil\n    assert_input false, \"\", false\n\
    \    assert_input true, \"\", true\n    assert_input 'A', \"\", 'A'\n    assert_input\
    \ \"String\", \"\", \"String\"\n    assert_input /regex/, \"\", /regex/\n    assert_input({1,\
    \ 2, 3}, \"\", {1, 2, 3})\n    assert_input({i, i, i}, \"1 2 3\", {1, 2, 3})\n\
    \    assert_input [1, 2, 3], \"\", [1, 2, 3]\n    assert_input [i, i, i], \"1\
    \ 2 3\", [1, 2, 3]\n    assert_input({1 => 2, 3 => 4}, \"11 2 22\", {1 => 2, 3\
    \ => 4})\n    assert_input({1 => i, i => i}, \"11 2 22\", {1 => 11, 2 => 22})\n\
    \    assert_input({a: 'a', b: 'b'}, \"1 abc\", {a: 'a', b: 'b'})\n    assert_input({a:\
    \ i, b: s}, \"1 abc\", {a: 1, b: \"abc\"})\n    assert_input 1..i, \"3\", 1..3\n\
    \    assert_input i...i, \"1 3\", 1...3\n  end\n\n  it \"reads if\" do\n    assert_input\
    \ i == 1 ? i : i * 2, \"1 2\", 2\n    assert_input i == 1 ? i : i * 2, \"2 2\"\
    , 4\n  end\n\n  it \"reads assign\" do\n    assert_input (var = i; var * var),\
    \ \"12\", 144\n  end\n\n  it \"reads with local variable\" do\n    i, f = 1, 2\n\
    \    assert_input i, \"42\", 42\n    assert_input f, \"42.0\", 42.0\n    assert_input\
    \ :i, \"\", 1\n    assert_input :f, \"\", 2\n    assert_input i[:f], \"1 2\",\
    \ [1, 2]\n  end\n\n  it \"reads array\" do\n    assert_input i[3], \"1 2 3\",\
    \ [1, 2, 3]\n    assert_input (i * i)[3], \"1 2 3 4 5 6\", [2, 12, 30]\n    assert_input\
    \ String[i], \"3 a b c d\", %w[a b c]\n    assert_input String[i], \"3 a  \\n\
    \ \\n b\\nc d\", %w[a b c]\n    assert_input i[2, 3], \"1 2 3 4 5 6\", [[1, 2,\
    \ 3], [4, 5, 6]]\n    assert_input i[i, i], \"2 3 1 2 3 4 5 6\", [[1, 2, 3], [4,\
    \ 5, 6]]\n    assert_input i[i][i], \"3 \\n 2 1 2 \\n 3 1 2 3 \\n 4 1 2 3 4\"\
    , [[1, 2], [1, 2, 3], [1, 2, 3, 4]]\n    assert_input({i, i - 1}[2], \"1 2 3 4\"\
    , [{1, 1}, {3, 3}])\n  end\n\n  it \"reads method\" do\n    assert_input i + i,\
    \ \"1 2\", 3\n  end\n\n  it \"reads class method\" do\n    assert_input Int64.new(i),\
    \ \"42\", 42\n    assert_input Tuple(Int32, Int32).from(i[2]), \"1 2\", {1, 2}\n\
    \  end\n\n  it \"reads scannable type\" do\n    assert_input Scannable, \"1 2\"\
    , Scannable.new(1, 2)\n    assert_input Scannable.sum, \"1 2\", 3\n  end\nend\n\
    \nit \"input_column\" do\n  assert_input_column [Int32], 3, \"1 2 3\", {[1, 2,\
    \ 3]}\n  assert_input_column [Int32, Int32], 3, \"1 2\\n3 4\\n5 6\", {[1, 3, 5],\
    \ [2, 4, 6]}\n  n = 3\n  assert_input_column [Int32, Int32], n, \"1 2\\n3 4\\\
    n5 6\", {[1, 3, 5], [2, 4, 6]}\n  s = [Scannable.new(2, 3), Scannable.new(5, 6),\
    \ Scannable.new(8, 9)]\n  assert_input_column [Int32, Scannable], 3, \"1 2 3\\\
    n4 5 6\\n7 8 9\", {[1, 4, 7], s}\n\n  size = 2\n  assert_input_column [Int32,\
    \ Int32], (size += 1), \"1 2\\n3 4\\n5 6\", {[1, 3, 5], [2, 4, 6]}\n  size.should\
    \ eq 3\nend\n"
  code: "require \"spec\"\nrequire \"../src/scanner\"\n\nprivate macro check(method,\
    \ input, expect)\n  %io = IO::Memory.new {{input}}\n  ({{expect}}).each { |str|\
    \ Scanner.{{method.id}}(%io).should eq str }\n  expect_raises(IO::EOFError) {\
    \ Scanner.{{method.id}}(%io) }\nend\n\nprivate macro check_raises(method, input,\
    \ exception)\n  %io = IO::Memory.new {{input}}\n  expect_raises({{exception}})\
    \ { Scanner.{{method.id}}(%io) }\nend\n\nprivate macro describe_scan_int(type,\
    \ method)\n  {% signed = type.stringify =~ /$Int\\d+^/ %}\n  describe \".{{method.id}}\"\
    \ do\n    it \"read integer separated by spaces or new lines\" do\n      check\
    \ {{method}}, \"0 1 2 3\\n4 5 6\\n7 08 009\", 0..9\n      {% if signed %}\n  \
    \      check {{method}}, \"-0 -1 -2 -3\\n-4 -5 -6\\n-7 -08 -009\", 0.to(-9)\n\
    \      {% end %}\n      check {{method}}, \" \\n\\n1  2\\n  \\n\\n 3\\n\\n \"\
    , 1..3\n    end\n\n    it \"raise if read unexpected charactor\" do\n      check_raises\
    \ {{method}}, \"\", IO::EOFError\n      check_raises {{method}}, \"@\", Exception\n\
    \      check_raises {{method}}, \" @\", Exception\n      check_raises {{method}},\
    \ \"123@\", Exception\n      check_raises {{method}}, \" 123@\", Exception\n \
    \   end\n\n    it \"read {{type}}::MIN and {{type}}::MAX\" do\n      min, max\
    \ = {{type}}::MIN, {{type}}::MAX\n      a = (min..min + 100).to_a + (max - 100..max).to_a\n\
    \      check {{method}}, a.join(' '), a\n    end\n  end\nend\n\ndescribe Scanner\
    \ do\n  describe \".s\" do\n    it \"read string separated by spaces or new lines\"\
    \ do\n      check :s, \"a b\\nc d\", %w[a b c d]\n      check :s, \"  \\na  b\
    \ \\n c  \\n\\n  d  \\n\", %w[a b c d]\n      check :s, \"aaabbbccc\", [\"aaabbbccc\"\
    ]\n    end\n\n    it \"read long string\" do\n      str = ('a'..'z').join * 1000\n\
    \      check :s, \"#{str} #{str}\\n#{str}\", [str, str, str]\n    end\n  end\n\
    \n  describe_scan_int Int32, :i\n  describe_scan_int Int8, :i8\n  describe_scan_int\
    \ Int16, :i16\n  describe_scan_int Int32, :i32\n  describe_scan_int Int64, :i64\n\
    \  describe_scan_int Int128, :i128\n  describe_scan_int UInt8, :u8\n  describe_scan_int\
    \ UInt16, :u16\n  describe_scan_int UInt32, :u32\n  describe_scan_int UInt64,\
    \ :u64\n  describe_scan_int UInt128, :u128\nend\n\nprivate macro assert_input(ast,\
    \ input, expect)\n  %io = IO::Memory.new {{input}}\n  input({{ast}}, io: %io).should\
    \ eq({{expect}})\nend\n\nprivate macro assert_input_column(types, size, input,\
    \ expect)\n  %io = IO::Memory.new {{input}}\n  input_column({{types}}, {{size}},\
    \ io: %io).should eq({{expect}})\nend\n\nprivate struct Scannable\n  getter x\
    \ : Int32, y : Int32\n\n  def initialize(@x, @y)\n  end\n\n  def self.scan(scanner,\
    \ io)\n    Scannable.new scanner.i(io), scanner.i(io)\n  end\n\n  def sum\n  \
    \  x + y\n  end\nend\n\ndescribe \"input\" do\n  it \"reads integer\" do\n   \
    \ {% for iu in %i[i u] %} {% for n in %w[8 16 32 64] %}\n      assert_input {{((iu\
    \ == :i ? \"Int\" : \"UInt\") + n).id}}, \"42\", 42\n      assert_input {{(iu\
    \ + n).id}}, \"42\", 42\n    {% end %} {% end %}\n  end\n\n  it \"reads string\
    \ and char\" do\n    assert_input c, \"abc\\ndef\", 'a'\n    assert_input s, \"\
    abc\\ndef\", \"abc\"\n    assert_input Char, \"abc\\ndef\", 'a'\n    assert_input\
    \ [Char, Char, Char], \"ab \\n c\", ['a', 'b', 'c']\n    assert_input String,\
    \ \"abc\\ndef\", \"abc\"\n    assert_input String, \"abc def\", \"abc\"\n  end\n\
    \n  it \"reads float\" do\n    assert_input f, \"3.14\", 3.14\n    assert_input\
    \ f32, \"3.14\", 3.14f32\n    assert_input f64, \"3.14\", 3.14\n    assert_input\
    \ Float32, \"3.14\", 3.14f32\n    assert_input Float64, \"3.14\", 3.14\n  end\n\
    \n  it \"reads literal\" do\n    assert_input 42, \"\", 42\n    assert_input 3.14,\
    \ \"\", 3.14\n    assert_input nil, \"\", nil\n    assert_input false, \"\", false\n\
    \    assert_input true, \"\", true\n    assert_input 'A', \"\", 'A'\n    assert_input\
    \ \"String\", \"\", \"String\"\n    assert_input /regex/, \"\", /regex/\n    assert_input({1,\
    \ 2, 3}, \"\", {1, 2, 3})\n    assert_input({i, i, i}, \"1 2 3\", {1, 2, 3})\n\
    \    assert_input [1, 2, 3], \"\", [1, 2, 3]\n    assert_input [i, i, i], \"1\
    \ 2 3\", [1, 2, 3]\n    assert_input({1 => 2, 3 => 4}, \"11 2 22\", {1 => 2, 3\
    \ => 4})\n    assert_input({1 => i, i => i}, \"11 2 22\", {1 => 11, 2 => 22})\n\
    \    assert_input({a: 'a', b: 'b'}, \"1 abc\", {a: 'a', b: 'b'})\n    assert_input({a:\
    \ i, b: s}, \"1 abc\", {a: 1, b: \"abc\"})\n    assert_input 1..i, \"3\", 1..3\n\
    \    assert_input i...i, \"1 3\", 1...3\n  end\n\n  it \"reads if\" do\n    assert_input\
    \ i == 1 ? i : i * 2, \"1 2\", 2\n    assert_input i == 1 ? i : i * 2, \"2 2\"\
    , 4\n  end\n\n  it \"reads assign\" do\n    assert_input (var = i; var * var),\
    \ \"12\", 144\n  end\n\n  it \"reads with local variable\" do\n    i, f = 1, 2\n\
    \    assert_input i, \"42\", 42\n    assert_input f, \"42.0\", 42.0\n    assert_input\
    \ :i, \"\", 1\n    assert_input :f, \"\", 2\n    assert_input i[:f], \"1 2\",\
    \ [1, 2]\n  end\n\n  it \"reads array\" do\n    assert_input i[3], \"1 2 3\",\
    \ [1, 2, 3]\n    assert_input (i * i)[3], \"1 2 3 4 5 6\", [2, 12, 30]\n    assert_input\
    \ String[i], \"3 a b c d\", %w[a b c]\n    assert_input String[i], \"3 a  \\n\
    \ \\n b\\nc d\", %w[a b c]\n    assert_input i[2, 3], \"1 2 3 4 5 6\", [[1, 2,\
    \ 3], [4, 5, 6]]\n    assert_input i[i, i], \"2 3 1 2 3 4 5 6\", [[1, 2, 3], [4,\
    \ 5, 6]]\n    assert_input i[i][i], \"3 \\n 2 1 2 \\n 3 1 2 3 \\n 4 1 2 3 4\"\
    , [[1, 2], [1, 2, 3], [1, 2, 3, 4]]\n    assert_input({i, i - 1}[2], \"1 2 3 4\"\
    , [{1, 1}, {3, 3}])\n  end\n\n  it \"reads method\" do\n    assert_input i + i,\
    \ \"1 2\", 3\n  end\n\n  it \"reads class method\" do\n    assert_input Int64.new(i),\
    \ \"42\", 42\n    assert_input Tuple(Int32, Int32).from(i[2]), \"1 2\", {1, 2}\n\
    \  end\n\n  it \"reads scannable type\" do\n    assert_input Scannable, \"1 2\"\
    , Scannable.new(1, 2)\n    assert_input Scannable.sum, \"1 2\", 3\n  end\nend\n\
    \nit \"input_column\" do\n  assert_input_column [Int32], 3, \"1 2 3\", {[1, 2,\
    \ 3]}\n  assert_input_column [Int32, Int32], 3, \"1 2\\n3 4\\n5 6\", {[1, 3, 5],\
    \ [2, 4, 6]}\n  n = 3\n  assert_input_column [Int32, Int32], n, \"1 2\\n3 4\\\
    n5 6\", {[1, 3, 5], [2, 4, 6]}\n  s = [Scannable.new(2, 3), Scannable.new(5, 6),\
    \ Scannable.new(8, 9)]\n  assert_input_column [Int32, Scannable], 3, \"1 2 3\\\
    n4 5 6\\n7 8 9\", {[1, 4, 7], s}\n\n  size = 2\n  assert_input_column [Int32,\
    \ Int32], (size += 1), \"1 2\\n3 4\\n5 6\", {[1, 3, 5], [2, 4, 6]}\n  size.should\
    \ eq 3\nend\n"
  dependsOn:
  - src/scanner.cr
  isVerificationFile: false
  path: spec/scanner_spec.cr
  requiredBy: []
  timestamp: '2022-03-25 19:21:11+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/scanner_spec.cr
layout: document
redirect_from:
- /library/spec/scanner_spec.cr
- /library/spec/scanner_spec.cr.html
title: spec/scanner_spec.cr
---
