module Math
  def enumerate_combination(n : Int)
    res = Array.new(n + 1) { Array.new(n + 1, 0i64) }
    (0..n).each do |i|
      res[i][0] = res[i][i] = 1
    end
    (1..n).each do |i|
      (1...i).each do |j|
        res[i][j] = res[i - 1][j - 1] + res[i - 1][j]
      end
    end
    res
  end
end
