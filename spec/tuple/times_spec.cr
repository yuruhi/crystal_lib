require "spec"
require "../../src/tuple/times"

describe Tuple do
  describe "#times(&block)" do
    it "all types of tuple are Int32" do
      result = [] of {Int32, Int32, Int32}
      {1, 2, 3}.times do |i, j, k|
        result << {i, j, k}
      end
      result.should eq [
        {0, 0, 0}, {0, 0, 1}, {0, 0, 2},
        {0, 1, 0}, {0, 1, 1}, {0, 1, 2},
      ]
    end

    it "types of tuple are mixed" do
      result = [] of {Int32, Int32, Int64}
      {1, 2, 3i64}.times do |i, j, k|
        i.class.should eq Int32
        j.class.should eq Int32
        k.class.should eq Int64
        result << {i, j, k}
      end
      result.should eq [
        {0, 0, 0}, {0, 0, 1}, {0, 0, 2},
        {0, 1, 0}, {0, 1, 1}, {0, 1, 2},
      ]
    end
  end

  describe "#each" do
    it "all types of tuple are Int32" do
      {1, 2, 3}.times.to_a.should eq [
        {0, 0, 0}, {0, 0, 1}, {0, 0, 2},
        {0, 1, 0}, {0, 1, 1}, {0, 1, 2},
      ]
    end

    it "types of tuple are mixed" do
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
end
