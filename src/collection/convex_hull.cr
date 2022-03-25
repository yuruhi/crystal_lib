class Array(T)
  private def compare_slope(p1, p2, q1, q2)
    (p2[0] - p1[0]) * (q2[1] - q1[1]) > (q2[0] - q1[0]) * (p2[1] - p1[1])
  end

  # Returns convex hull of points that consist of `(value, index)`.
  #
  # ```
  # [4, 2, 3, 4, 1, 2, 1, 3, 2, 4].convex_hull_with_index # => [{4, 0}, {2, 1}, {1, 4}, {1, 6}, {2, 8}, {4, 9}]
  # ```
  #
  # ```palin
  #   | 0 1 2 3 4 5 6 7 8 9
  # --+---------------------
  # 4 | o     x           o
  # 3 |     x         x
  # 2 |   o       x     o
  # 1 |         o   o
  # ```
  def convex_hull_with_index : Array({T, Int32})
    res = [] of {T, Int32}
    each_with_index do |x, i|
      while res.size >= 2 && compare_slope(res[-2], res[-1], res[-2], {x, i})
        res.pop
      end
      res << {x, i}
    end
    res
  end

  # Returns convex hull of points that consist of `(value, index)`.
  #
  # ```
  # [4, 2, 3, 4, 1, 2, 1, 3, 2, 4].convex_hull # => [4, 2, 1, 1, 2, 4]
  # ```
  #
  # ```palin
  #   | 0 1 2 3 4 5 6 7 8 9
  # --+---------------------
  # 4 | o     x           o
  # 3 |     x         x
  # 2 |   o       x     o
  # 1 |         o   o
  # ```
  def convex_hull : Array(Int32)
    convex_hull_with_index.map(&.[0])
  end
end
