# ### Specifications
#
# ```plain
# Inside input macro                             | Expanded code
# -----------------------------------------------+---------------------------------------
# uppercase string (Int32, Int64, Float64, etc.) | {}.new(Scanner.s)
# s                                              | Scanner.s
# c                                              | Scanner.c
# other lowercase string (i, i64, f, etc.)       | Scanner.s.to_{}
# tuple literal {t1, t2, t3}                     | {input(t1), input(t2), input(t3)}
# array literal [t1, t2, t3]                     | [input(t1), input(t2), input(t3)]
# type[size]                                     | Array.new(input(size)) { input(type) }
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
class Scanner
  private def self.skip_to_not_space
    peek = STDIN.peek
    not_space = peek.index { |x| x != 32 && x != 10 } || peek.size
    STDIN.skip(not_space)
  end

  def self.c
    skip_to_not_space
    STDIN.read_char.not_nil!
  end

  def self.s
    skip_to_not_space

    peek = STDIN.peek
    if index = peek.index { |x| x == 32 || x == 10 }
      STDIN.skip(index + 1)
      return String.new(peek[0, index])
    end

    String.build do |buffer|
      loop do
        buffer.write peek
        STDIN.skip(peek.size)
        peek = STDIN.peek
        break if peek.empty?
        if index = peek.index { |x| x == 32 || x == 10 }
          buffer.write peek[0, index]
          STDIN.skip(index)
          break
        end
      end
    end
  end
end

macro internal_input(s, else_ast)
  {% if Scanner.class.has_method?(s.id) %}
    Scanner.{{s.id}}
  {% elsif s.stringify == "String" %}
    Scanner.s
  {% elsif s.stringify == "Char" %}
    Scanner.c
  {% elsif s.stringify =~ /[A-Z][a-z0-9_]*/ %}
    {{s.id}}.new(Scanner.s)
  {% elsif String.has_method?("to_#{s}".id) %}
    Scanner.s.to_{{s.id}}
  {% else %}
    {{else_ast}}
  {% end %}
end

macro internal_input_array(s, args)
  {% for i in 0...args.size %}
    %size{i} = input({{args[i]}})
  {% end %}
  {% begin %}
    {% for i in 0...args.size %} Array.new(%size{i}) { {% end %}
      input({{s.id}})
    {% for i in 0...args.size %} } {% end %}
  {% end %}
end

macro input(s)
  {% if s.is_a?(Call) %}
    {% if s.receiver.is_a?(Nop) %}
      internal_input(
        {{s.name}}, {{s.name}}(
          {% for argument in s.args %} input({{argument}}), {% end %}
        )
      )
    {% elsif s.name.stringify == "[]" %}
      internal_input_array({{s.receiver}}, {{s.args}})
    {% else %}
      input({{s.receiver}}).{{s.name.id}}(
        {% for argument in s.args %} input({{argument}}), {% end %}
      ) {{s.block}}
    {% end %}
  {% elsif s.is_a?(TupleLiteral) %}
    { {% for i in 0...s.size %} input({{s[i]}}), {% end %} }
  {% elsif s.is_a?(ArrayLiteral) %}
    [ {% for i in 0...s.size %} input({{s[i]}}), {% end %} ]
  {% else %}
    internal_input({{s.id}}, {{s.id}})
  {% end %}
end

macro input(*s)
  { {% for s in s %} input({{s}}), {% end %} }
end