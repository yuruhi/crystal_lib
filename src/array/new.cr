class Array
  def self.new(sizes : Tuple(*T), initial_value) forall T
    {% begin %}
      {% for i in 0...T.size %} Array.new(sizes[{{i}}]) { {% end %}
      initial_value
      {% for i in 0...T.size %} } {% end %}
    {% end %}
  end

  def self.new(sizes : Tuple(*T), &block) forall T
    {% begin %}
      {% for i in 0...T.size %} Array.new(sizes[{{i}}]) { |index{{i}}| {% end %}
      yield({% for i in 0...T.size %} index{{i}}, {% end %})
      {% for i in 0...T.size %} } {% end %}
    {% end %}
  end
end
