require "io/error"

class Scanner
  private def self.skip_to_not_space
    peek = STDIN.peek
    not_space = peek.index { |x| x != 32 && x != 10 } || peek.size
    STDIN.skip(not_space)
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
  {% elsif type.is_a?(Var) || (type.is_a?(Call) && type.args.size == 0) %}
    {% if Scanner.methods.includes?(type.id) %}
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
