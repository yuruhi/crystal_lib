require "benchmark"
require "../../src/math/barrett"

N = 1000000

private macro benchmark(mod)
  mod = {{mod}}u32

  b = rand(mod)
  expect = N.times.reduce(1u64) { |acc| acc * b % {{mod}} }

  puts "-------- mod: {{mod}} --------"
  Benchmark.ips do |x|
    x.report("a * b % mod") do
      a = 1u64
      N.times { a = a * b % mod }
      raise "" unless expect == a
    end

    x.report("a &* b % mod") do
      a = 1u64
      N.times { a = a * b % mod }
      raise "" unless expect == a
    end

    x.report("a * b % MOD") do
      a = 1u64
      N.times { a = a * b % {{mod}} }
      raise "" unless expect == a
    end

    x.report("a &* b % MOD") do
      a = 1u64
      N.times { a = a * b % {{mod}} }
      raise "" unless expect == a
    end

    x.report("bt.mul(a, b)") do
      bt = Barrett.new(mod)
      a = 1u32
      N.times { a = bt.mul(a, b) }
      raise "" unless expect == a
    end
  end
  puts
end

benchmark 1
benchmark 100000
benchmark 1000000000
benchmark 1000000007
benchmark 2147483647
