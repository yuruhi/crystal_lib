require "spec"
require "../../src/array/new"

describe Array do
  it ".new(sizes, initial_value)" do
    Array.new({2, 2}, 42).should eq [[42, 42], [42, 42]]
    Array.new({2, 3}, 42).should eq [[42, 42, 42], [42, 42, 42]]
  end

  it ".new(sizes, &block)" do
    Array.new({2, 2}) { |i, j| i + j }.should eq [[0, 1], [1, 2]]
    Array.new({3, 3, 3}) { |i, j, k| i*j*k }.should eq [
      [[0, 0, 0], [0, 0, 0], [0, 0, 0]],
      [[0, 0, 0], [0, 1, 2], [0, 2, 4]],
      [[0, 0, 0], [0, 2, 4], [0, 4, 8]],
    ]
  end
end
