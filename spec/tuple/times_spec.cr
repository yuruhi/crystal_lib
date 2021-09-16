require "spec"
require "../../src/tuple/times"

describe Tuple do
  it "#times(&block)" do
    result = [] of {Int32, Int32, Int32}
    {1, 2, 3}.times do |i, j, k|
      result << {i, j, k}
    end
    result.should eq [
      {0, 0, 0}, {0, 0, 1}, {0, 0, 2},
      {0, 1, 0}, {0, 1, 1}, {0, 1, 2},
    ]

    result = [] of {Int32, Int32, Int64}
    {1, 2, 3i64}.times do |i, j, k|
      result << {i, j, k}
    end
    result.should eq [
      {0, 0, 0}, {0, 0, 1}, {0, 0, 2},
      {0, 1, 0}, {0, 1, 1}, {0, 1, 2},
    ]
  end

  it "#times" do
    {1, 2, 3}.times.to_a.should eq [
      {0, 0, 0}, {0, 0, 1}, {0, 0, 2},
      {0, 1, 0}, {0, 1, 1}, {0, 1, 2},
    ]

    {1, 2u8, 3i64}.times.to_a.should eq [
      {0, 0, 0}, {0, 0, 1}, {0, 0, 2},
      {0, 1, 0}, {0, 1, 1}, {0, 1, 2},
    ]
    {1, 2u8, 3i64}.times.each do |i, j, k|
      typeof(i).should eq Int32
      typeof(j).should eq UInt8
      typeof(k).should eq Int64
    end
  end

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
