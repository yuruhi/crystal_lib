class Array(T)
  def self.new(sizes : Tuple(*I), initial_value) forall I
    {% begin %}
      {% for i in 0...I.size %} Array.new(sizes[{{i}}]) { {% end %}
      initial_value
      {% for i in 0...I.size %} } {% end %}
    {% end %}
  end

  def self.new(sizes : Tuple(*I), &block) forall I
    {% begin %}
      {% for i in 0...I.size %} Array.new(sizes[{{i}}]) { |index{{i}}| {% end %}
      yield({% for i in 0...I.size %} index{{i}}, {% end %})
      {% for i in 0...I.size %} } {% end %}
    {% end %}
  end
end
