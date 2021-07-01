require "io/error"

class Scanner
  def self.s
    peek = STDIN.peek.not_nil!
    if not_space = peek.index { |x| x != 32 && x != 10 }
      if index = peek.index(not_space) { |x| x == 32 || x == 10 }
        result = String.new(peek[not_space...index])
        STDIN.skip(index + 1)
        result
      else
        result = String.new(peek[not_space..])
        STDIN.skip_to_end
        result
      end
    else
      raise IO::EOFError.new
    end
  end

  def self.i
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
    {{type}}.new(Scanner.s)
  {% elsif type.is_a?(Call) && type.args.size == 0 %}
    {% if Scanner.methods.includes?(type) %}
      Scanner.{{type.id}}
    {% else %}
      Scanner.s.to_{{type.id}}
    {% end %}
  {% elsif type.name == "[]" %}
    input_array("{{type.receiver}}", {{type.args}})
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
