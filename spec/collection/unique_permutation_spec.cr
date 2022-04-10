require "spec"
require "../../src/collection/unique_permutation"

describe Array do
  rng = Random.new(42)
  arrays = [
    [] of Int32,
    [0],
    [0, 0],
    (0...8).to_a,
  ] + Array.new(100) {
    Array.new(8) { rng.rand(3) }
  }

  it "#next_unique_permutation, #each_unique_permutation" do
    arrays.each do |a|
      perms = a.sort.permutations.uniq!.skip_while(&.!= a)

      b, i = a.dup, 0
      while i + 1 < perms.size
        b.next_permutation!.should be_true
        b.should eq perms[i += 1]
      end
      b.next_permutation!.should be_false
      b.should eq perms.last

      b, i = a.dup, 0
      while i + 1 < perms.size
        (b = b.next_permutation?.not_nil!).should eq perms[i += 1]
      end
      b.next_permutation?.should be_nil

      a.unique_permutations.should eq perms

      a.each_unique_permutation.to_a.should eq perms
      i = 0
      a.each_unique_permutation(true).each do |b|
        b.should eq perms[i]
        i += 1
      end

      i = 0
      a.each_unique_permutation do |b|
        b.should eq perms[i]
        i += 1
      end
      i = 0
      a.each_unique_permutation(reuse: true) do |b|
        b.should eq perms[i]
        i += 1
      end
    end
  end
end
