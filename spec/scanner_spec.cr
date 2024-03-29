require "spec"
require "../src/scanner"

private IntTypes = [
  {Int8, :i8}, {Int16, :i16}, {Int32, :i32}, {Int64, :i64},
  {UInt8, :u8}, {UInt16, :u16}, {UInt32, :u32}, {UInt64, :u64},
]

private macro check(method, input, expect)
  %io = IO::Memory.new {{ input }}
  ({{ expect }}).each { |str| Scanner.{{ method.id }}(%io).should eq str }
  expect_raises(IO::EOFError) { Scanner.{{ method.id }}(%io) }
end

private macro check_raises(method, input, exception)
  %io = IO::Memory.new {{ input }}
  expect_raises({{ exception }}) { Scanner.{{ method.id }}(%io) }
end

private macro describe_scan_int(type, method)
  {% signed = type.stringify =~ /$Int\d+^/ %}
  describe ".{{ method.id }}" do
    it "read integer separated by spaces or new lines" do
      check {{ method }}, "0 1 2 3\n4 5 6\n7 08 009", 0..9
      {% if signed %}
        check {{ method }}, "-0 -1 -2 -3\n-4 -5 -6\n-7 -08 -009", 0.to(-9)
      {% end %}
      check {{ method }}, " \n\n1  2\n  \n\n 3\n\n ", 1..3
    end

    it "raise if read unexpected charactor" do
      check_raises {{ method }}, "", IO::EOFError
      check_raises {{ method }}, "@", Exception
      check_raises {{ method }}, " @", Exception
      check_raises {{ method }}, "123@", Exception
      check_raises {{ method }}, " 123@", Exception
    end

    it "read {{ type }}::MIN and {{ type }}::MAX" do
      min, max = {{ type }}::MIN, {{ type }}::MAX
      a = (min..min + 100).to_a + (max - 100..max).to_a
      check {{ method }}, a.join(' '), a
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

  {% for t in IntTypes %}
    describe_scan_int {{ t[0] }}, {{ t[1] }}
  {% end %}
  describe_scan_int Int32, :i
  describe_scan_int Int128, :i128
  describe_scan_int UInt128, :u128
end

private macro assert_input(ast, input, expect)
  %io = IO::Memory.new {{ input }}
  input({{ ast }}, io: %io).should eq({{ expect }})
end

private macro assert_input_column(types, size, input, expect)
  %io = IO::Memory.new {{ input }}
  input_column({{ types }}, {{ size }}, io: %io).should eq({{ expect }})
end

private struct Scannable
  getter x : Int32, y : Int32

  def initialize(@x, @y)
  end

  def self.scan(scanner, io)
    Scannable.new scanner.i(io), scanner.i(io)
  end

  def sum
    x + y
  end
end

describe "input" do
  {% for t in IntTypes %}
    it "reads {{ t[0] }}" do
      assert_input {{ t[0] }}, "42", 42
      assert_input {{ t[1].id }}, "42", 42
    end
  {% end %}

  it "reads string and char" do
    assert_input c, "abc\ndef", 'a'
    assert_input s, "abc\ndef", "abc"
    assert_input Char, "abc\ndef", 'a'
    assert_input [Char, Char, Char], "ab \n c", ['a', 'b', 'c']
    assert_input String, "abc\ndef", "abc"
    assert_input String, "abc def", "abc"
  end

  it "reads float" do
    assert_input f, "3.14", 3.14
    assert_input f32, "3.14", 3.14f32
    assert_input f64, "3.14", 3.14
    assert_input Float32, "3.14", 3.14f32
    assert_input Float64, "3.14", 3.14
  end

  it "reads literal" do
    assert_input 42, "", 42
    assert_input 3.14, "", 3.14
    assert_input nil, "", nil
    assert_input false, "", false
    assert_input true, "", true
    assert_input 'A', "", 'A'
    assert_input "String", "", "String"
    assert_input /regex/, "", /regex/
    assert_input({1, 2, 3}, "", {1, 2, 3})
    assert_input({i, i, i}, "1 2 3", {1, 2, 3})
    assert_input [1, 2, 3], "", [1, 2, 3]
    assert_input [i, i, i], "1 2 3", [1, 2, 3]
    assert_input({1 => 2, 3 => 4}, "11 2 22", {1 => 2, 3 => 4})
    assert_input({1 => i, i => i}, "11 2 22", {1 => 11, 2 => 22})
    assert_input({a: 'a', b: 'b'}, "1 abc", {a: 'a', b: 'b'})
    assert_input({a: i, b: s}, "1 abc", {a: 1, b: "abc"})
    assert_input 1..i, "3", 1..3
    assert_input i...i, "1 3", 1...3
  end

  it "reads if" do
    assert_input i == 1 ? i : i * 2, "1 2", 2
    assert_input i == 1 ? i : i * 2, "2 2", 4
  end

  it "reads assign" do
    assert_input (var = i; var * var), "12", 144
  end

  it "reads with local variable" do
    i, f = 1, 2
    assert_input i, "42", 42
    assert_input f, "42.0", 42.0
    assert_input :i, "", 1
    assert_input :f, "", 2
    assert_input i[:f], "1 2", [1, 2]
  end

  it "reads array" do
    assert_input i[3], "1 2 3", [1, 2, 3]
    assert_input (i * i)[3], "1 2 3 4 5 6", [2, 12, 30]
    assert_input String[i], "3 a b c d", %w[a b c]
    assert_input String[i], "3 a  \n \n b\nc d", %w[a b c]
    assert_input i[2, 3], "1 2 3 4 5 6", [[1, 2, 3], [4, 5, 6]]
    assert_input i[i, i], "2 3 1 2 3 4 5 6", [[1, 2, 3], [4, 5, 6]]
    assert_input i[i][i], "3 \n 2 1 2 \n 3 1 2 3 \n 4 1 2 3 4", [[1, 2], [1, 2, 3], [1, 2, 3, 4]]
    assert_input({i, i - 1}[2], "1 2 3 4", [{1, 1}, {3, 3}])
  end

  it "reads method" do
    assert_input i + i, "1 2", 3
    assert_input i.abs, "-2", 2
  end

  it "reads class method" do
    assert_input Int64.new(i), "42", 42
    assert_input Tuple(Int32, Int32).from(i[2]), "1 2", {1, 2}
  end

  it "reads scannable type" do
    assert_input Scannable, "1 2", Scannable.new(1, 2)
    assert_input Scannable.sum, "1 2", 3
  end
end

it "input_column" do
  assert_input_column [Int32], 3, "1 2 3", {[1, 2, 3]}
  assert_input_column [Int32, Int32], 3, "1 2\n3 4\n5 6", {[1, 3, 5], [2, 4, 6]}
  n = 3
  assert_input_column [Int32, Int32], n, "1 2\n3 4\n5 6", {[1, 3, 5], [2, 4, 6]}
  s = [Scannable.new(2, 3), Scannable.new(5, 6), Scannable.new(8, 9)]
  assert_input_column [Int32, Scannable], 3, "1 2 3\n4 5 6\n7 8 9", {[1, 4, 7], s}

  size = 2
  assert_input_column [Int32, Int32], (size += 1), "1 2\n3 4\n5 6", {[1, 3, 5], [2, 4, 6]}
  size.should eq 3
end
