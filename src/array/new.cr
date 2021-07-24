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
      {% for i in 0...T.size %} Array.new(sizes[{{i}}]) { |%i{i}| {% end %}
      yield({% for i in 0...T.size %} %i{i}, {% end %})
      {% for i in 0...T.size %} } {% end %}
    {% end %}
  end
end
