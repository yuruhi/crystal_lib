require "spec"
require "../../src/math/pythagorean_triples"

triples = [{3, 4, 5}, {5, 12, 13}, {8, 15, 17}, {7, 24, 25}, {20, 21, 29}]

describe PythagoreanTriples do
  it "#each(&)" do
    a = [] of {Int32, Int32, Int32}
    PythagoreanTriples.new(29).each { |tuple| a << tuple }
    a.should eq triples
  end

  it "#each" do
    PythagoreanTriples.new(29).each.to_a.should eq triples
  end

  it "includes Enumerable({Int32, Int32, Int32})" do
    PythagoreanTriples.new(29).to_a.should eq triples
    PythagoreanTriples.new(30).to_a.should eq triples
  end

  it "includes Iterable({Int32, Int32, Int32})" do
    PythagoreanTriples.new(29).cycle(2).to_a.should eq triples * 2
  end
end
