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
end
