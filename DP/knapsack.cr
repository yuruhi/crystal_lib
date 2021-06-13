def knapsack(weight_limit : Int32, value : Array(Int), weight : Array(Int32))
  raise Argumenterror.new unless value.size == weight.size
  n = value.size
  (0...n).each_with_object([typeof(value.first).zero] * n) do |i, dp|
    (0..weight_limit - weight[i]).each do |j|
      dp[j + weight[i]] = Math.max(dp[j + weight[i]], dp[j] + value[i])
    end
  end
end

def knapsack01(weight_limit : Int32, value : Array(Int), weight : Array(Int32))
  raise Argumenterror.new unless value.size == weight.size
  n = value.size
  (0...n).each_with_object([typeof(value.first).zero] * n) do |i, dp|
    (0..weight_limit - weight[i]).reverse_each do |j|
      dp[j + weight[i]] = Math.max(dp[j + weight[i]], dp[j] + value[i])
    end
  end
end
