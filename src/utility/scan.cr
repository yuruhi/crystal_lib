module Enumerable(T)
  def scan(init : U) forall U
    scan(init) { |a, b| a + b }
  end

  def scan(init : U, &) forall U
    result = [init]
    each { |v| result << yield(result.last, v) }
    result
  end

  def scan
    scan(T.zero)
  end
end
