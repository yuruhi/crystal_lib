require "spec"
require "../ProconIO"

describe ProconIO do
  it ".read_until_space" do
    io = IO::Memory.new "3 4\nabc\ndef"
    ProconIO.read_until_space(io).should eq "3"
    ProconIO.read_until_space(io).should eq "4"
    ProconIO.read_until_space(io).should eq "abc"
    ProconIO.read_until_space(io).should eq "def"
		expect_raises(IO::EOFError) { ProconIO.read_until_space(io) }
		
		io = IO::Memory.new " \n text  \n"
    ProconIO.read_until_space(io).should eq "text"
		expect_raises(IO::EOFError) { ProconIO.read_until_space(io) }
  end
end
