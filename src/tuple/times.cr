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

  def each_product(&block) : Nil
    {% begin %}
      {% for i in 0...@type.size %}
        self[{{i}}].each do |i{{i}}|
      {% end %}
      yield({% for i in 0...@type.size %} i{{i}}, {% end %})
      {% for i in 0...@type.size %}
        end
      {% end %}
    {% end %}
  end

  private class ProductIterator(T, Begin, End)
    include Iterator(Begin)

    def initialize(@n : T)
      @index = {% begin %}
        { {% for i in 0...T.size %} @n[{{i}}].begin, {% end %} }
      {% end %}.as(Begin)
      @end = {% begin %}
        { {% for i in 0...T.size %} @n[{{i}}].exclusive? ? @n[{{i}}].end.pred : @n[{{i}}].end, {% end %} }
      {% end %}.as(End)
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
          if @index[{{size - i}}] < @end[{{size - i}}]
            @index = {
              {% for j in 0...size %}
                {% if j < size - i %}
                  @index[{{j}}],
                {% elsif j == size - i %}
                  @index[{{j}}] + 1,
                {% else %}
                  @n[{{j}}].begin,
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

  def each_product
    {% for type in T %}
      {% raise "Can't product for not Range" unless type < Range %}
      {% raise "Can't product for open Range" if type.type_vars[0].nilable? %}
      {% raise "Can't product for open Range" if type.type_vars[1].nilable? %}
    {% end %}
    ProductIterator(self, typeof({% begin %}
      { {% for i in 0...@type.size %} self[{{i}}].begin,{% end %} }
    {% end %}), typeof({% begin %}
      { {% for i in 0...@type.size %} self[{{i}}].end, {% end %} }
    {% end %})).new(self)
  end
end
