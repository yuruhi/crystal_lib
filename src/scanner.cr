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

macro internal_input_array(s, args, else_ast)
  {% if Scanner.class.has_method?(s.id) ||
          s.stringify =~ /[A-Z][a-z0-9_]*/ ||
          String.has_method?("to_#{s}".id) %}
    Array.new({{args.first}}) do
      {% if args.size == 1 %}
        input({{s.id}})
      {% else %}
        internal_input_array({{s}}, {{args[1...args.size]}}, else_ast)
      {% end %}
    end
  {% else %}
    {{else_ast}}
  {% end %}
end

macro input(s)
  {% if s.is_a?(Call) %}
    {% if s.receiver.is_a?(Nop) %}
      internal_input(
        {{s.name}}, {{s.name}}(
          {% for argument in s.args %}
            input({{argument}}),
          {% end %}
        )
      )
    {% elsif s.name.stringify == "[]" %}
      internal_input_array(
        {{s.receiver}}, {{s.args}}, {{s.receiver}}[
          {% for argument in s.args %}
            input({{argument}}),
          {% end %}
        ] {{s.block}}
      )
    {% else %}
      input({{s.receiver}}).{{s.name.id}}(
        {% for argument in s.args %}
          input({{argument}}),
        {% end %}
      ) {{s.block}}
    {% end %}
  {% else %}
    internal_input({{s.id}}, {{s.id}})
  {% end %}
end

macro input(*s)
  {
    {% for s in s %}
      input({{s}}),
    {% end %}
  }
end
