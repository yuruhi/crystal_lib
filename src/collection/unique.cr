module Enumerable(T)
  def unique : self
    unique(&.itself)
  end

  def unique(&) : self
    last = uninitialized T
    each_with_object([] of T) do |v, ary|
      now = yield v
      if ary.empty? || last != now
        last = now
        ary << v
      end
    end
  end
end

module Iterator(T)
  def unique
    unique &.itself
  end

  def unique(&func : T -> U) forall U
    Unique(typeof(self), T, U).new(self, func)
  end

  private struct Unique(I, T, U)
    include Iterator(T)
    include IteratorWrapper

    def initialize(@iterator : I, @func : T -> U)
      @first = true
      @prev_func_value = uninitialized U
    end

    def next
      loop do
        value = wrapped_next
        func_value = @func.call value
        if @first || func_value != @prev_func_value
          @first = false
          @prev_func_value = func_value
          return value
        end
      end
    end
  end
end
