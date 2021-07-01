require "io/error"

class Scanner
  INSTANCE = new

  def initialize(@io : IO = STDIN)
  end

  def s
    peek = @io.peek.not_nil!
    if not_space = peek.index { |x| x != 32 && x != 10 }
      if index = peek.index(not_space) { |x| x == 32 || x == 10 }
        result = String.new(peek[not_space...index])
        @io.skip(index + 1)
        result
      else
        result = String.new(peek[not_space..])
        @io.skip_to_end
        result
      end
    else
      raise IO::EOFError.new
    end
  end

  def i
    s.to_i
  end
end

macro input_array(type, args)
  Array.new({{args.first}}) do
    {% if args.size == 1 %}
      input({{type.id}})
    {% else %}
      input_array({{type}}, {{args[1...args.size]}})
    {% end %}
  end
end

macro input(type)
  {% if type.is_a?(Path) %}
    {{type}}.new(Scanner::INSTANCE.s)
  {% elsif type.is_a?(Call) && type.args.size == 0 %}
    {% if Scanner.methods.includes?(type) %}
      Scanner::INSTANCE.{{type.id}}
    {% else %}
      Scanner::INSTANCE.s.to_{{type.id}}
    {% end %}
  {% else %}
    input_array("{{type.name}}", {{type.args}})
  {% end %}
end

macro input(*types)
  {
    {% for type in types %}
      input({{type}}),
    {% end %}
  }
end
