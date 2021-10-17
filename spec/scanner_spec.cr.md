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
  bundledCode: "require \"spec\"\n\n# require \"../src/scanner\"\n# ### Specifications\n\
    #\n# ```plain\n# Inside input macro                     | Expanded code\n# ---------------------------------------+---------------------------------------\n\
    # Uppercase string: Int32, Int64, etc.   | {}.new(Scanner.s)\n# s, c, i, iN, uN\
    \                        | Scanner.{}\n# Other lowercase string: f, big_i, etc.\
    \ | Scanner.s.to_{}\n# operator[]: type[size]                 | Array.new(input(size))\
    \ { input(type) }\n# Tuple literal: {t1, t2, t3}            | {input(t1), input(t2),\
    \ input(t3)}\n# Array literal: [t1, t2, t3]            | [input(t1), input(t2),\
    \ input(t3)]\n# Range literal: t1..t2                  | input(t1)..input(t2)\n\
    # If: cond ? t1 : t2                     | cond ? input(t1) : input(t2)\n# Assign:\
    \ target = value                 | target = input(value)\n# ```\n#\n# ### Examples\n\
    #\n# Input:\n# ```plain\n# 5 3\n# foo bar\n# 1 2 3 4 5\n# ```\n# ```\n# n, m =\
    \ input(Int32, Int64) # => {5, 5i64}\n# input(String, Char[m])     # => {\"foo\"\
    , ['b', 'a', 'r']}\n# input(Int32[n])            # => [1, 2, 3, 4, 5]\n# ```\n\
    # ```\n# n, m = input(i, i64) # => {5, 5i64}\n# input(s, c[m])       # => {\"\
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
    \ x\n    else\n      raise \"Unexpected char: #{x.chr}\"\n    end\n\n    loop\
    \ do\n      peek = io.peek\n      return signed ? value : -value if peek.empty?\n\
    \      i = 0\n      while i < peek.size\n        c = peek.unsafe_fetch(i)\n  \
    \      if 48 <= c <= 57\n          value = value &* 10 &- c &+ 48\n          i\
    \ &+= 1\n        elsif c == 32 || c == 10\n          io.skip(i &+ 1)\n       \
    \   return signed ? value : -value\n        else\n          raise \"Unexpected\
    \ char: #{c.chr}\"\n        end\n      end\n      io.skip(i)\n    end\n  end\n\
    \n  private def self.uint(uint_type : T.class, io = STDIN) : T forall T\n    skip_to_not_space(io)\n\
    \    value = T.zero\n    found_digit = false\n    loop do\n      peek = io.peek\n\
    \      if peek.empty?\n        if found_digit\n          return value\n      \
    \  else\n          raise IO::EOFError.new\n        end\n      end\n      i = 0\n\
    \      while i < peek.size\n        c = peek.unsafe_fetch(i)\n        if 48 <=\
    \ c <= 57\n          found_digit = true\n          value = value &* 10 &+ c &-\
    \ 48\n          i &+= 1\n        elsif c == 32 || c == 10\n          io.skip(i\
    \ &+ 1)\n          return value\n        else\n          raise \"Unexpected char:\
    \ #{c.chr}\"\n        end\n      end\n      io.skip(i)\n    end\n  end\n\n  def\
    \ self.i(io = STDIN)\n    int(Int32, io)\n  end\n\n  {% for n in [8, 16, 32, 64,\
    \ 128] %}\n    def self.i{{n}}(io = STDIN)\n      int(Int{{n}}, io)\n    end\n\
    \n    def self.u{{n}}(io = STDIN)\n      uint(UInt{{n}}, io)\n    end\n  {% end\
    \ %}\n\n  def self.s(io = STDIN)\n    skip_to_not_space(io)\n\n    peek = io.peek\n\
    \    if peek.empty?\n      raise IO::EOFError.new\n    end\n    if index = peek.index\
    \ { |x| x == 32 || x == 10 }\n      io.skip(index + 1)\n      return String.new(peek[0,\
    \ index])\n    end\n\n    String.build do |buffer|\n      loop do\n        buffer.write\
    \ peek\n        io.skip(peek.size)\n        peek = io.peek\n        break if peek.empty?\n\
    \        if index = peek.index { |x| x == 32 || x == 10 }\n          buffer.write\
    \ peek[0, index]\n          io.skip(index + 1)\n          break\n        end\n\
    \      end\n    end\n  end\nend\n\nmacro internal_input(type, else_ast)\n  {%\
    \ if Scanner.class.has_method?(type.id) %}\n    Scanner.{{type.id}}\n  {% elsif\
    \ type.stringify == \"String\" %}\n    Scanner.s\n  {% elsif type.stringify ==\
    \ \"Char\" %}\n    Scanner.c\n  {% elsif type.stringify =~ /[A-Z][a-z0-9_]*/ %}\n\
    \    {{type.id}}.new(Scanner.s)\n  {% elsif String.has_method?(\"to_#{type}\"\
    .id) %}\n    Scanner.s.to_{{type.id}}\n  {% else %}\n    {{else_ast}}\n  {% end\
    \ %}\nend\n\nmacro internal_input_array(type, args)\n  {% for i in 0...args.size\
    \ %}\n    %size{i} = input({{args[i]}})\n  {% end %}\n  {% begin %}\n    {% for\
    \ i in 0...args.size %} Array.new(%size{i}) { {% end %}\n      input({{type.id}})\n\
    \    {% for i in 0...args.size %} } {% end %}\n  {% end %}\nend\n\nmacro input(type)\n\
    \  {% if type.is_a?(Call) %}\n    {% if type.receiver.is_a?(Nop) %}\n      internal_input(\n\
    \        {{type.name}}, {{type.name}}(\n          {% for argument in type.args\
    \ %} input({{argument}}), {% end %}\n        )\n      )\n    {% elsif type.name.stringify\
    \ == \"[]\" %}\n      internal_input_array({{type.receiver}}, {{type.args}})\n\
    \    {% else %}\n      input({{type.receiver}}).{{type.name.id}}(\n        {%\
    \ for argument in type.args %} input({{argument}}), {% end %}\n      ) {{type.block}}\n\
    \    {% end %}\n  {% elsif type.is_a?(TupleLiteral) %}\n    { {% for i in 0...type.size\
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
    \nprivate macro check(method, input, expect)\n  %io = IO::Memory.new {{input}}\n\
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
    \ :u64\n  describe_scan_int UInt128, :u128\nend\n"
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
    \ :u64\n  describe_scan_int UInt128, :u128\nend\n"
  dependsOn:
  - src/scanner.cr
  isVerificationFile: false
  path: spec/scanner_spec.cr
  requiredBy: []
  timestamp: '2021-10-16 21:23:44+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/scanner_spec.cr
layout: document
redirect_from:
- /library/spec/scanner_spec.cr
- /library/spec/scanner_spec.cr.html
title: spec/scanner_spec.cr
---
