class Array(T)
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
    hull = [] of {T, Int32}
    each_with_index do |x, i|
      while hull.size >= 2 && (hull[-1][0] - hull[-2][0]) * (i - hull[-2][1]) > (x - hull[-2][0]) * (hull[-1][1] - hull[-2][1])
        hull.pop
      end
      hull << {x, i}
    end
    hull
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
