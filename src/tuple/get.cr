struct Tuple
  macro method_missing(call)
    {% str = call.stringify %}
    {% if str =~ /_\d+/ %}
      self[{{ str[1...str.size].id }}]
    {% else %}
      {% raise call %}
    {% end %}
  end
end
