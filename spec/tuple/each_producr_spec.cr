require "spec"
require "../../src/tuple/each_product"

describe Tuple do
  it "#product_each(&block)" do
    result = [] of {Int32, Int32, Int64}
    {1..2, [3, 4], {5i64, 6i64}}.each_product do |i, j, k|
      typeof(i).should eq Int32
      typeof(j).should eq Int32
      typeof(k).should eq Int64
      result << {i, j, k}
    end
    result.should eq [
      {1, 3, 5}, {1, 3, 6}, {1, 4, 5}, {1, 4, 6},
      {2, 3, 5}, {2, 3, 6}, {2, 4, 5}, {2, 4, 6},
    ]
  end

  it "#product_each" do
    {1..2, 3...5}.each_product.to_a.should eq [
      {1, 3}, {1, 4}, {2, 3}, {2, 4},
    ]
    typeof({1i32..2u32, 3i64...5u64}.each_product).should be < Iterator({Int32, Int64})
  end
end
