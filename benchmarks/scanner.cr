require "../src/scanner"
require "benchmark"

# TODO: benchmark Int128 and UInt128

private N = 100000

{% for signed in [true, false] %}
  {% for n in [8, 16, 32, 64] %}
    {%
      type = signed ? "Int#{n}".id : "UInt#{n}".id
      method = signed ? "i#{n}".id : "u#{n}".id
    %}
    a_{{method}} = Array.new(N) { rand({{type}}) }
    tmp_{{method}} = File.tempfile { |file| a_{{method}}.join(' ', file) }

    Benchmark.ips do |x|
      x.report("Scanner.{{method}}".rjust(16)) do
        file = File.new tmp_{{method}}.path
        b = Array.new(N) { Scanner.{{method}}(file) }
        raise "" unless a_{{method}} == b
      end
      x.report("Scanner.s.to_{{method}}") do
        file = File.new tmp_{{method}}.path
        b = Array.new(N) { Scanner.s(file).to_{{method}} }
        raise "" unless a_{{method}} == b
      end
    end

    tmp_{{method}}.delete
  {% end %}
{% end %}
