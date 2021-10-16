require "spec"
require "../src/scanner"

private macro check(method, input, expect)
  %io = IO::Memory.new {{input}}
  ({{expect}}).each { |str| Scanner.{{method.id}}(%io).should eq str }
  expect_raises(IO::EOFError) { Scanner.{{method.id}}(%io) }
end

private macro check_raises(method, input, exception)
  %io = IO::Memory.new {{input}}
  expect_raises({{exception}}) { Scanner.{{method.id}}(%io) }
end

private macro describe_scan_int(type, method)
  {% signed = type.stringify =~ /$Int\d+^/ %}
  describe ".{{method.id}}" do
    it "read integer separated by spaces or new lines" do
      check {{method}}, "0 1 2 3\n4 5 6\n7 08 009", 0..9
      {% if signed %}
        check {{method}}, "-0 -1 -2 -3\n-4 -5 -6\n-7 -08 -009", 0.to(-9)
      {% end %}
      check {{method}}, " \n\n1  2\n  \n\n 3\n\n ", 1..3
    end

    it "raise if read unexpected charactor" do
      check_raises {{method}}, "", IO::EOFError
      check_raises {{method}}, "@", Exception
      check_raises {{method}}, " @", Exception
      check_raises {{method}}, "123@", Exception
      check_raises {{method}}, " 123@", Exception
    end

    it "read {{type}}::MIN and {{type}}::MAX" do
      min, max = {{type}}::MIN, {{type}}::MAX
      a = (min..min + 100).to_a + (max - 100..max).to_a
      check {{method}}, a.join(' '), a
    end
  end
end

describe Scanner do
  describe ".s" do
    it "read string separated by spaces or new lines" do
      check :s, "a b\nc d", %w[a b c d]
      check :s, "  \na  b \n c  \n\n  d  \n", %w[a b c d]
      check :s, "aaabbbccc", ["aaabbbccc"]
    end

    it "read long string" do
      str = ('a'..'z').join * 1000
      check :s, "#{str} #{str}\n#{str}", [str, str, str]
    end
  end

  describe_scan_int Int32, :i
  describe_scan_int Int8, :i8
  describe_scan_int Int16, :i16
  describe_scan_int Int32, :i32
  describe_scan_int Int64, :i64
  describe_scan_int Int128, :i128
  describe_scan_int UInt8, :u8
  describe_scan_int UInt16, :u16
  describe_scan_int UInt32, :u32
  describe_scan_int UInt64, :u64
  describe_scan_int UInt128, :u128
end
