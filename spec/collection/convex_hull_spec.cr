require "spec"
require "../../src/collection/convex_hull"

describe Array do
  it "#convex_hull" do
    [4, 2, 3, 4, 1, 2, 1, 3, 2, 4].convex_hull.should eq [4, 2, 1, 1, 2, 4]
  end

  it "#convex_hull_with_index" do
    [4, 2, 3, 4, 1, 2, 1, 3, 2, 4].convex_hull_with_index.should eq [{4, 0}, {2, 1}, {1, 4}, {1, 6}, {2, 8}, {4, 9}]
  end
end
