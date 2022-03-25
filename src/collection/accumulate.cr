module Enumerable(T)
  def accumulate(init : U) : Array(U) forall U
    accumulate(init) { |a, b| a + b }
  end

  def accumulate : Array(T)
    accumulate { |x, y| x + y }
  end

  def accumulate(init : U, &block : U, T -> U) : Array(U) forall U
    result = [init]
    each { |v| result << yield(result.last, v) }
    result
  end

  def accumulate(&block : T, T -> T) : Array(T)
    result = [] of T
    memo = uninitialized T
    each do |v|
      memo = result.empty? ? v : yield(memo, v)
      result << memo
    end
    result
  end
end
