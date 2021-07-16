module Enumerable(T)
  def scan(init : U) forall U
    scan(init) { |a, b| a + b }
  end

  def scan
    scan(T.zero)
  end

  def scan(init : U, &) forall U
    result = [init]
    each { |v| result << yield(result.last, v) }
    result
  end

  def inclusive_scan(&)
    first = true
    result = [] of T
    each do |v|
      if first
        result << v
        first = false
      else
        result << yield(result[-1], v)
      end
    end
    result
  end

  def inclusive_scan
    inclusive_scan { |x, y| x + y }
  end
end
