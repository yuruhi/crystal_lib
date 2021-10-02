# ### Specifications
#
# ```plain
# Inside input macro                   | Expanded code
# -------------------------------------+---------------------------------------
# Uppercase string: Int32, Int64, etc. | {}.new(Scanner.s)
# s                                    | Scanner.s
# c                                    | Scanner.c
# Other lowercase string: i, i64, etc. | Scanner.s.to_{}
# operator[]: type[size]               | Array.new(input(size)) { input(type) }
# Tuple literal: {t1, t2, t3}          | {input(t1), input(t2), input(t3)}
# Array literal: [t1, t2, t3]          | [input(t1), input(t2), input(t3)]
# Range literal: t1..t2                | input(t1)..input(t2)
# If: cond ? t1 : t2                   | cond ? input(t1) : input(t2)
# Assign: target = value               | target = input(value)
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
# n, m = input(Int32, Int64) # => {5, 10i64}
# input(String, Char[m])     # => {"foo", ['b', 'a', 'r']}
# input(Int32[n])            # => [1, 2, 3, 4, 5]
# ```
# ```
# n, m = input(i, i64) # => {5, 10i64}
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
class Scanner
  private def self.skip_to_not_space(io)
    peek = io.peek
    not_space = peek.index { |x| x != 32 && x != 10 } || peek.size
    io.skip(not_space)
  end

  def self.c(io = STDIN)
    skip_to_not_space(io)
    io.read_char.not_nil!
  end

  private def self.int(int_type : T.class, io = STDIN) : T forall T
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
      return value
    end

    loop do
      peek = io.peek
      return signed ? value : -value if peek.empty?
      i = 0
      while i < peek.size
        c = peek.unsafe_fetch(i)
        unless 48 <= c <= 57
          io.skip(i &+ 1)
          return signed ? value : -value
        end
        value = value &* 10 &- c &+ 48
        i &+= 1
      end
      io.skip(i)
    end
  end

  private def self.uint(uint_type : T.class, io = STDIN) : T forall T
    skip_to_not_space(io)
    value = T.zero

    loop do
      peek = io.peek
      i = 0
      while i < peek.size
        c = peek.unsafe_fetch(i)
        unless 48 <= c <= 57
          io.skip(i &+ 1)
          return value
        end
        value = value &* 10 &+ c &- 48
        i &+= 1
      end
      io.skip(i)
    end
  end

  {% for name_type in [
                        {"i", Int32}, {"i8", Int8}, {"i16", Int16},
                        {"i32", Int32}, {"i64", Int64}, {"i128", Int128},
                      ] %}
     def self.{{name_type[0].id}}(io = STDIN)
       int({{name_type[1]}}, io)
     end
  {% end %}

  {% for name_type in [
                        {"u8", UInt8}, {"u16", UInt16},
                        {"u32", UInt32}, {"u64", UInt64}, {"u128", UInt128},
                      ] %}
     def self.{{name_type[0].id}}(io = STDIN)
       uint({{name_type[1]}}, io)
     end
  {% end %}

  def self.s(io = STDIN)
    skip_to_not_space(io)

    peek = io.peek
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
          io.skip(index)
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
  {% elsif type.stringify =~ /[A-Z][a-z0-9_]*/ %}
    {{type.id}}.new(Scanner.s)
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

macro input(type)
  {% if type.is_a?(Call) %}
    {% if type.receiver.is_a?(Nop) %}
      internal_input(
        {{type.name}}, {{type.name}}(
          {% for argument in type.args %} input({{argument}}), {% end %}
        )
      )
    {% elsif type.name.stringify == "[]" %}
      internal_input_array({{type.receiver}}, {{type.args}})
    {% else %}
      input({{type.receiver}}).{{type.name.id}}(
        {% for argument in type.args %} input({{argument}}), {% end %}
      ) {{type.block}}
    {% end %}
  {% elsif type.is_a?(TupleLiteral) %}
    { {% for i in 0...type.size %} input({{type[i]}}), {% end %} }
  {% elsif type.is_a?(ArrayLiteral) %}
    [ {% for i in 0...type.size %} input({{type[i]}}), {% end %} ]
  {% elsif type.is_a?(RangeLiteral) %}
    Range.new(input({{type.begin}}), input({{type.end}}), {{type.excludes_end?}})
  {% elsif type.is_a?(If) %}
    {{type.cond}} ? input({{type.then}}) : input({{type.else}})
  {% elsif type.is_a?(Assign) %}
    {{type.target}} = input({{type.value}})
  {% else %}
    internal_input({{type.id}}, {{type.id}})
  {% end %}
end

macro input(*types)
  { {% for type in types %} input({{type}}), {% end %} }
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
