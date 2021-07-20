module DP
  extend self

  def lcs(s, t)
    n, m = s.size, t.size
    dp = Array.new(m + 1, 0)
    n.times do |i|
      dp2 = dp.dup
      m.times do |j|
        dp2[j + 1] = {dp2[j + 1], dp[j] + 1}.max if s[i] == t[j]
        dp2[j + 1] = {dp2[j + 1], dp2[j]}.max
      end
      dp = dp2
    end
    dp[m]
  end
end
