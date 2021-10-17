require "./binary_heap"

# reference: https://maspypy.com/slope-trick-1-解説編
class SlopeTrick(T)
  getter min : T, shift : T, left, right

  # Lets `f(x) = 0`
  def initialize
    @min = T.zero
    @shift = T.zero
    @left = BinaryHeap(T).new { |a, b| b <=> a }
    @right = BinaryHeap(T).new
  end

  # Calculates `f(x)`
  def f(x : T) : T
    min +
      @left.sum { |l| Math.max(l - x, T.zero) } +
      @right.sum { |r| Math.max(x - r, T.zero) }
  end

  def l0 : T?
    @left.top?.try &.+(shift)
  end

  def r0 : T?
    @right.top?.try &.+(shift)
  end

  # Adds constant function `a`
  def add(a : T) : self
    @min += a
    self
  end

  # Adds `max(x - a, 0)`
  def add_r(a : T) : self
    if @left.empty?
      @right << a - shift
    else
      @min += Math.max(l0.not_nil! - a, T.zero)
      @left << a - shift
      @right << @left.pop.not_nil!
    end
    self
  end

  # Adds `max(a - x, 0)`
  def add_l(a : T) : self
    if @right.empty?
      @left << a - shift
    else
      @min += Math.max(a - r0.not_nil!, T.zero)
      @right << a - shift
      @left << @right.pop.not_nil!
    end
    self
  end

  # Adds `|x - a|`
  def add_abs(a : T) : self
    add_r(a)
    add_l(a)
  end

  # `g(x) := min_{y <= x} f(y)`
  def accumulate_min : self
    @right.clear
    self
  end

  # `g(x) := min_{y >= x} f(y)`
  def accumulate_min_right : self
    @left.clear
    self
  end

  # `g(x) := f(x - a)`
  def slide(a : T) : self
    @shift += a
    self
  end
end
