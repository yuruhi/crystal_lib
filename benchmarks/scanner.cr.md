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
  bundledCode: "# require \"../src/scanner\"\n# ### Specifications\n#\n# ```plain\n\
    # Inside input macro                     | Expanded code\n# ---------------------------------------+---------------------------------------\n\
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
    \ # => {[1, 2, 3], [2, 3, 1]}\n# ```\nmodule Scanner\n  extend self\n\n  private\
    \ def skip_to_not_space(io)\n    peek = io.peek\n    not_space = peek.index {\
    \ |x| x != 32 && x != 10 } || peek.size\n    io.skip(not_space)\n  end\n\n  def\
    \ c(io = STDIN)\n    skip_to_not_space(io)\n    io.read_char.not_nil!\n  end\n\
    \n  private def int(int_type : T.class, io = STDIN) : T forall T\n    skip_to_not_space(io)\n\
    \n    value = T.zero\n    signed = false\n    case x = io.read_byte\n    when\
    \ nil\n      raise IO::EOFError.new\n    when 45\n      signed = true\n    when\
    \ 48..57\n      value = T.new 48 &- x\n    else\n      raise \"Unexpected char:\
    \ #{x.chr}\"\n    end\n\n    loop do\n      peek = io.peek\n      return signed\
    \ ? value : -value if peek.empty?\n      i = 0\n      while i < peek.size\n  \
    \      c = peek.unsafe_fetch(i)\n        if 48 <= c <= 57\n          value = value\
    \ &* 10 &- c &+ 48\n          i &+= 1\n        elsif c == 32 || c == 10\n    \
    \      io.skip(i &+ 1)\n          return signed ? value : -value\n        else\n\
    \          raise \"Unexpected char: #{c.chr}\"\n        end\n      end\n     \
    \ io.skip(i)\n    end\n  end\n\n  private def uint(uint_type : T.class, io = STDIN)\
    \ : T forall T\n    skip_to_not_space(io)\n    value = T.zero\n    found_digit\
    \ = false\n    loop do\n      peek = io.peek\n      if peek.empty?\n        if\
    \ found_digit\n          return value\n        else\n          raise IO::EOFError.new\n\
    \        end\n      end\n      i = 0\n      while i < peek.size\n        c = peek.unsafe_fetch(i)\n\
    \        if 48 <= c <= 57\n          found_digit = true\n          value = value\
    \ &* 10 &+ c &- 48\n          i &+= 1\n        elsif c == 32 || c == 10\n    \
    \      io.skip(i &+ 1)\n          return value\n        else\n          raise\
    \ \"Unexpected char: #{c.chr}\"\n        end\n      end\n      io.skip(i)\n  \
    \  end\n  end\n\n  def i(io = STDIN)\n    int(Int32, io)\n  end\n\n  {% for n\
    \ in [8, 16, 32, 64, 128] %}\n    def i{{n}}(io = STDIN)\n      int(Int{{n}},\
    \ io)\n    end\n\n    def u{{n}}(io = STDIN)\n      uint(UInt{{n}}, io)\n    end\n\
    \  {% end %}\n\n  {% for method in [:f, :f32, :f64] %}\n    def {{method.id}}(io\
    \ = STDIN)\n      s(io).to_{{method.id}}\n    end\n  {% end %}\n\n  def s(io =\
    \ STDIN)\n    skip_to_not_space(io)\n\n    peek = io.peek\n    if peek.empty?\n\
    \      raise IO::EOFError.new\n    end\n    if index = peek.index { |x| x == 32\
    \ || x == 10 }\n      io.skip(index + 1)\n      return String.new(peek[0, index])\n\
    \    end\n\n    String.build do |buffer|\n      loop do\n        buffer.write\
    \ peek\n        io.skip(peek.size)\n        peek = io.peek\n        break if peek.empty?\n\
    \        if index = peek.index { |x| x == 32 || x == 10 }\n          buffer.write\
    \ peek[0, index]\n          io.skip(index + 1)\n          break\n        end\n\
    \      end\n    end\n  end\nend\n\nmacro internal_input(type, else_ast)\n  {%\
    \ if Scanner.class.has_method?(type.id) %}\n    Scanner.{{type.id}}\n  {% elsif\
    \ type.stringify == \"String\" %}\n    Scanner.s\n  {% elsif type.stringify ==\
    \ \"Char\" %}\n    Scanner.c\n  {% elsif type.is_a?(Path) %}\n    {% if type.resolve.class.has_method?(:scan)\
    \ %}\n      {{type}}.scan(Scanner)\n    {% else %}\n      {{type}}.new(Scanner.s)\n\
    \    {% end %}\n  {% elsif String.has_method?(\"to_#{type}\".id) %}\n    Scanner.s.to_{{type.id}}\n\
    \  {% else %}\n    {{else_ast}}\n  {% end %}\nend\n\nmacro internal_input_array(type,\
    \ args)\n  {% for i in 0...args.size %}\n    %size{i} = input({{args[i]}})\n \
    \ {% end %}\n  {% begin %}\n    {% for i in 0...args.size %} Array.new(%size{i})\
    \ { {% end %}\n      input({{type.id}})\n    {% for i in 0...args.size %} } {%\
    \ end %}\n  {% end %}\nend\n\nmacro input(ast)\n  {% if ast.is_a?(Call) %}\n \
    \   {% if ast.receiver.is_a?(Nop) %}\n      internal_input(\n        {{ast.name}},\
    \ {{ast.name}}(\n          {% for argument in ast.args %} input({{argument}}),\
    \ {% end %}\n        )\n      )\n    {% elsif ast.name.stringify == \"[]\" %}\n\
    \      internal_input_array({{ast.receiver}}, {{ast.args}})\n    {% else %}\n\
    \      input({{ast.receiver}}).{{ast.name}}(\n        {% for argument in ast.args\
    \ %} input({{argument}}), {% end %}\n      ) {{ast.block}}\n    {% end %}\n  {%\
    \ elsif ast.is_a?(TupleLiteral) %}\n    { {% for i in 0...ast.size %} input({{ast[i]}}),\
    \ {% end %} }\n  {% elsif ast.is_a?(ArrayLiteral) %}\n    [ {% for i in 0...ast.size\
    \ %} input({{ast[i]}}), {% end %} ]\n  {% elsif ast.is_a?(RangeLiteral) %}\n \
    \   Range.new(input({{ast.begin}}), input({{ast.end}}), {{ast.excludes_end?}})\n\
    \  {% elsif ast.is_a?(If) %}\n    {{ast.cond}} ? input({{ast.then}}) : input({{ast.else}})\n\
    \  {% elsif ast.is_a?(Assign) %}\n    {{ast.target}} = input({{ast.value}})\n\
    \  {% else %}\n    internal_input({{ast.id}}, {{ast.id}})\n  {% end %}\nend\n\n\
    macro input(*asts)\n  { {% for ast in asts %} input({{ast}}), {% end %} }\nend\n\
    \nmacro input_column(types, size)\n  {% for type, i in types %}\n    %array{i}\
    \ = Array({{type}}).new({{size}})\n  {% end %}\n  {{size}}.times do\n    {% for\
    \ type, i in types %}\n      %array{i} << input({{type}})\n    {% end %}\n  end\n\
    \  { {% for type, i in types %} %array{i}, {% end %} }\nend\n\nrequire \"benchmark\"\
    \n\n# TODO: benchmark Int128 and UInt128\n\nprivate N = 100000\n\n{% for signed\
    \ in [true, false] %}\n  {% for n in [8, 16, 32, 64] %}\n    {%\n      type =\
    \ signed ? \"Int#{n}\".id : \"UInt#{n}\".id\n      method = signed ? \"i#{n}\"\
    .id : \"u#{n}\".id\n    %}\n    a_{{method}} = Array.new(N) { rand({{type}}) }\n\
    \    tmp_{{method}} = File.tempfile { |file| a_{{method}}.join(' ', file) }\n\n\
    \    Benchmark.ips do |x|\n      x.report(\"Scanner.{{method}}\".rjust(16)) do\n\
    \        file = File.new tmp_{{method}}.path\n        b = Array.new(N) { Scanner.{{method}}(file)\
    \ }\n        raise \"\" unless a_{{method}} == b\n      end\n      x.report(\"\
    Scanner.s.to_{{method}}\") do\n        file = File.new tmp_{{method}}.path\n \
    \       b = Array.new(N) { Scanner.s(file).to_{{method}} }\n        raise \"\"\
    \ unless a_{{method}} == b\n      end\n    end\n\n    tmp_{{method}}.delete\n\
    \  {% end %}\n{% end %}\n"
  code: "require \"../src/scanner\"\nrequire \"benchmark\"\n\n# TODO: benchmark Int128\
    \ and UInt128\n\nprivate N = 100000\n\n{% for signed in [true, false] %}\n  {%\
    \ for n in [8, 16, 32, 64] %}\n    {%\n      type = signed ? \"Int#{n}\".id :\
    \ \"UInt#{n}\".id\n      method = signed ? \"i#{n}\".id : \"u#{n}\".id\n    %}\n\
    \    a_{{method}} = Array.new(N) { rand({{type}}) }\n    tmp_{{method}} = File.tempfile\
    \ { |file| a_{{method}}.join(' ', file) }\n\n    Benchmark.ips do |x|\n      x.report(\"\
    Scanner.{{method}}\".rjust(16)) do\n        file = File.new tmp_{{method}}.path\n\
    \        b = Array.new(N) { Scanner.{{method}}(file) }\n        raise \"\" unless\
    \ a_{{method}} == b\n      end\n      x.report(\"Scanner.s.to_{{method}}\") do\n\
    \        file = File.new tmp_{{method}}.path\n        b = Array.new(N) { Scanner.s(file).to_{{method}}\
    \ }\n        raise \"\" unless a_{{method}} == b\n      end\n    end\n\n    tmp_{{method}}.delete\n\
    \  {% end %}\n{% end %}\n"
  dependsOn:
  - src/scanner.cr
  isVerificationFile: false
  path: benchmarks/scanner.cr
  requiredBy: []
  timestamp: '2021-12-29 20:30:52+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: benchmarks/scanner.cr
layout: document
redirect_from:
- /library/benchmarks/scanner.cr
- /library/benchmarks/scanner.cr.html
title: benchmarks/scanner.cr
---
