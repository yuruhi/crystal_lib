require "spec"
require "../../src/math/sieve"
require "../../src/math/sieve_fast"

private N = 10000
private P = (2..N).select { |x| (2..Math.sqrt(x)).none? { |f| x % f == 0 } }

private def check_prime_division(x : Int32, division : Array({Int32, Int32}))
  division.all? { |factor, count| P.includes?(factor) && count >= 1 } &&
    division.each_cons(2, reuse: true).all? { |(t1, t2)| t1[0] < t2[0] } &&
    division.reduce(1) { |acc, (factor, count)| acc * factor**count } == x
end

{% for klass in [Sieve, SieveFast] %}
  describe {{klass}} do
    sieve = {{klass}}.new N
    it "#prime?" do
      (1..20).each do |x|
        sieve.prime?(x).should eq P.includes?(x)
      end
      expect_raises(ArgumentError) { sieve.prime? 0 }
      expect_raises(ArgumentError) { sieve.prime? -1 }
      expect_raises(ArgumentError) { sieve.prime? N + 1 }
    end

    it "#primes" do
      sieve.primes.should eq P
    end

    it "#prime_division" do
      (1..N).each do |x|
        result = sieve.prime_division(x).to_a
        check_prime_division(x, result).should be_true
      end
      expect_raises(ArgumentError) { sieve.prime_division(0) }
      expect_raises(ArgumentError) { sieve.prime_division(-1) }
      expect_raises(ArgumentError) { sieve.prime_division(N + 1) }
    end

    it "#each_factor" do
      (1..N).each do |x|
        result = [] of {Int32, Int32}
        sieve.each_factor(x) do |factor, count|
          result << {factor, count}
        end
        check_prime_division(x, result).should be_true
      end
      expect_raises(ArgumentError) { sieve.each_factor(0) { } }
      expect_raises(ArgumentError) { sieve.each_factor(-1) { } }
      expect_raises(ArgumentError) { sieve.each_factor(N + 1) { } }
    end

    it "#number_of_divisors" do
      (1..N).each do |x|
        expect = (1..x).count { |i| x % i == 0 }
        sieve.number_of_divisors(x).should eq expect
      end
      expect_raises(ArgumentError) { sieve.number_of_divisors(0) }
      expect_raises(ArgumentError) { sieve.number_of_divisors(-1) }
      expect_raises(ArgumentError) { sieve.number_of_divisors(N + 1) }
    end

    it "#sum_of_divisors" do
      (1..N).each do |x|
        expect = (1..x).select { |i| x % i == 0 }.sum(0i64)
        sieve.sum_of_divisors(x).should eq expect
      end
      expect_raises(ArgumentError) { sieve.sum_of_divisors(0) }
      expect_raises(ArgumentError) { sieve.sum_of_divisors(-1) }
      expect_raises(ArgumentError) { sieve.sum_of_divisors(N + 1) }
    end
  end
{% end %}
