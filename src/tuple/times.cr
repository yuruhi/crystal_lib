struct Tuple
  def times(&block) : Nil
    {% begin %}
      {% for i in 0...@type.size %}
        self[{{i}}].times do |i{{i}}|
      {% end %}
      yield({% for i in 0...@type.size %} i{{i}}, {% end %})
      {% for i in 0...@type.size %}
        end
      {% end %}
    {% end %}
  end

  private class TimesIterator(T)
    include Iterator(T)

    def initialize(@n : T)
      tuple = {% begin %} { {% for type in T %} {{type}}.zero, {% end %} } {% end %}
      @index = tuple.as(T)
      @first = true
    end

    def next
      if @first
        @first = false
        return @index
      end
      {% begin %}
        {%
          type = @type.type_vars[0]
          size = type.size
        %}
        {% for i in 1..size %}
          if @index[{{size - i}}] < @n[{{size - i}}] - 1
            @index = {
              {% for j in 0...size %}
                {% if j < size - i %}
                  @index[{{j}}],
                {% elsif j == size - i %}
                  @index[{{j}}] + 1,
                {% else %}
                  {{type[j]}}.zero,
                {% end %}
              {% end %}
            }
            return @index
          end
        {% end %}
        stop
      {% end %}
    end
  end

  def times
    TimesIterator(self).new(self)
  end
end
