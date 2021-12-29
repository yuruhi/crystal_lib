# ### Specifications
#
# ```plain
# Inside input macro                     | Expanded code
# ---------------------------------------+---------------------------------------
# Uppercase string: Int32, Int64, etc.   | {}.new(Scanner.s)
# s, c, i, iN, uN                        | Scanner.{}
# Other lowercase string: f, big_i, etc. | Scanner.s.to_{}
# operator[]: type[size]                 | Array.new(input(size)) { input(type) }
# Tuple literal: {t1, t2, t3}            | {input(t1), input(t2), input(t3)}
# Array literal: [t1, t2, t3]            | [input(t1), input(t2), input(t3)]
# Range literal: t1..t2                  | input(t1)..input(t2)
# If: cond ? t1 : t2                     | cond ? input(t1) : input(t2)
# Assign: target = value                 | target = input(value)
# ```
#
# ### Examples
#
# Input:
# ```plain
# 5 3
# foo bar
# 1 2 3 4 5
# ```
# ```
# n, m = input(Int32, Int64) # => {5, 5i64}
# input(String, Char[m])     # => {"foo", ['b', 'a', 'r']}
# input(Int32[n])            # => [1, 2, 3, 4, 5]
# ```
# ```
# n, m = input(i, i64) # => {5, 5i64}
# input(s, c[m])       # => {"foo", ['b', 'a', 'r']}
# input(i[n])          # => [1, 2, 3, 4, 5]
# ```
#
# Input:
# ```plain
# 2 3
# 1 2 3
# 4 5 6
# ```
#
# ```
# h, w = input(i, i) # => {2, 3}
# input(i[h, w])     # => [[1, 2, 3], [4, 5, 6]]
# ```
# ```
# input(i[i][i]) # => [[1, 2, 3], [4, 5, 6]]
# ```
#
# Input:
# ```plain
# 5 3
# 3 1 4 2 5
# 1 2
# 2 3
# 3 1
# ```
# ```
# n, m = input(i, i)       # => {5, 3}
# input(i.pred[n])         # => [2, 0, 3, 1, 4]
# input({i - 1, i - 1}[m]) # => [{0, 1}, {1, 2}, {2, 0}]
# ```
#
# Input:
# ```plain
# 3
# 1 2
# 2 2
# 3 2
# ```
# ```
# input({tmp = i, tmp == 1 ? i : i.pred}[i]) # => [{1, 2}, {2, 1}, {3, 1}]
# ```
#
# Input:
# ```plain
# 3
# 1 2
# 2 3
# 3 1
# ```
# ```
# n = input(i)
# input_column({Int32, Int32}, n) # => {[1, 2, 3], [2, 3, 1]}
# ```
module Scanner
  extend self

  private def skip_to_not_space(io)
    peek = io.peek
    not_space = peek.index { |x| x != 32 && x != 10 } || peek.size
    io.skip(not_space)
  end

  def c(io = STDIN)
    skip_to_not_space(io)
    io.read_char.not_nil!
  end

  private def int(int_type : T.class, io = STDIN) : T forall T
    skip_to_not_space(io)

    value = T.zero
    signed = false
    case x = io.read_byte
    when nil
      raise IO::EOFError.new
    when 45
      signed = true
    when 48..57
      value = T.new 48 &- x
    else
      raise "Unexpected char: #{x.chr}"
    end

    loop do
      peek = io.peek
      return signed ? value : -value if peek.empty?
      i = 0
      while i < peek.size
        c = peek.unsafe_fetch(i)
        if 48 <= c <= 57
          value = value &* 10 &- c &+ 48
          i &+= 1
        elsif c == 32 || c == 10
          io.skip(i &+ 1)
          return signed ? value : -value
        else
          raise "Unexpected char: #{c.chr}"
        end
      end
      io.skip(i)
    end
  end

  private def uint(uint_type : T.class, io = STDIN) : T forall T
    skip_to_not_space(io)
    value = T.zero
    found_digit = false
    loop do
      peek = io.peek
      if peek.empty?
        if found_digit
          return value
        else
          raise IO::EOFError.new
        end
      end
      i = 0
      while i < peek.size
        c = peek.unsafe_fetch(i)
        if 48 <= c <= 57
          found_digit = true
          value = value &* 10 &+ c &- 48
          i &+= 1
        elsif c == 32 || c == 10
          io.skip(i &+ 1)
          return value
        else
          raise "Unexpected char: #{c.chr}"
        end
      end
      io.skip(i)
    end
  end

  def i(io = STDIN)
    int(Int32, io)
  end

  {% for n in [8, 16, 32, 64, 128] %}
    def i{{n}}(io = STDIN)
      int(Int{{n}}, io)
    end

    def u{{n}}(io = STDIN)
      uint(UInt{{n}}, io)
    end
  {% end %}

  {% for method in [:f, :f32, :f64] %}
    def {{method.id}}(io = STDIN)
      s(io).to_{{method.id}}
    end
  {% end %}

  def s(io = STDIN)
    skip_to_not_space(io)

    peek = io.peek
    if peek.empty?
      raise IO::EOFError.new
    end
    if index = peek.index { |x| x == 32 || x == 10 }
      io.skip(index + 1)
      return String.new(peek[0, index])
    end

    String.build do |buffer|
      loop do
        buffer.write peek
        io.skip(peek.size)
        peek = io.peek
        break if peek.empty?
        if index = peek.index { |x| x == 32 || x == 10 }
          buffer.write peek[0, index]
          io.skip(index + 1)
          break
        end
      end
    end
  end
end

macro internal_input(type, else_ast)
  {% if Scanner.class.has_method?(type.id) %}
    Scanner.{{type.id}}
  {% elsif type.stringify == "String" %}
    Scanner.s
  {% elsif type.stringify == "Char" %}
    Scanner.c
  {% elsif type.is_a?(Path) %}
    {% if type.resolve.class.has_method?(:scan) %}
      {{type}}.scan(Scanner)
    {% else %}
      {{type}}.new(Scanner.s)
    {% end %}
  {% elsif String.has_method?("to_#{type}".id) %}
    Scanner.s.to_{{type.id}}
  {% else %}
    {{else_ast}}
  {% end %}
end

macro internal_input_array(type, args)
  {% for i in 0...args.size %}
    %size{i} = input({{args[i]}})
  {% end %}
  {% begin %}
    {% for i in 0...args.size %} Array.new(%size{i}) { {% end %}
      input({{type.id}})
    {% for i in 0...args.size %} } {% end %}
  {% end %}
end

macro input(ast)
  {% if ast.is_a?(Call) %}
    {% if ast.receiver.is_a?(Nop) %}
      internal_input(
        {{ast.name}}, {{ast.name}}(
          {% for argument in ast.args %} input({{argument}}), {% end %}
        )
      )
    {% elsif ast.name.stringify == "[]" %}
      internal_input_array({{ast.receiver}}, {{ast.args}})
    {% else %}
      input({{ast.receiver}}).{{ast.name}}(
        {% for argument in ast.args %} input({{argument}}), {% end %}
      ) {{ast.block}}
    {% end %}
  {% elsif ast.is_a?(TupleLiteral) %}
    { {% for i in 0...ast.size %} input({{ast[i]}}), {% end %} }
  {% elsif ast.is_a?(ArrayLiteral) %}
    [ {% for i in 0...ast.size %} input({{ast[i]}}), {% end %} ]
  {% elsif ast.is_a?(RangeLiteral) %}
    Range.new(input({{ast.begin}}), input({{ast.end}}), {{ast.excludes_end?}})
  {% elsif ast.is_a?(If) %}
    {{ast.cond}} ? input({{ast.then}}) : input({{ast.else}})
  {% elsif ast.is_a?(Assign) %}
    {{ast.target}} = input({{ast.value}})
  {% else %}
    internal_input({{ast.id}}, {{ast.id}})
  {% end %}
end

macro input(*asts)
  { {% for ast in asts %} input({{ast}}), {% end %} }
end

macro input_column(types, size)
  {% for type, i in types %}
    %array{i} = Array({{type}}).new({{size}})
  {% end %}
  {{size}}.times do
    {% for type, i in types %}
      %array{i} << input({{type}})
    {% end %}
  end
  { {% for type, i in types %} %array{i}, {% end %} }
end
