require "benchmark"
require "../../src/math/sieve"
require "../../src/math/sieve_fast"

Benchmark.ips do |x|
  x.report("Sieve#new") do
    Sieve.new(10000000)
  end
  x.report("SieveFast#new") do
    SieveFast.new(10000000)
  end
end
